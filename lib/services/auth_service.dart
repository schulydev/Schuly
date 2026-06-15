import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:app_links/app_links.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/oidc_config.dart';

class AuthTokens {
  final String accessToken;
  final String? idToken;
  final String? refreshToken;
  final int? expiresIn;

  AuthTokens({
    required this.accessToken,
    this.idToken,
    this.refreshToken,
    this.expiresIn,
  });
}

class AuthService {
  static const _kAccessTokenKey = 'auth.access_token';
  static const _kIdTokenKey = 'auth.id_token';
  static const _kRefreshTokenKey = 'auth.refresh_token';

  /// OIDC tokens live in the platform keystore (Android EncryptedSharedPrefs /
  /// iOS Keychain), not plaintext SharedPreferences.
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  /// One-shot migration of tokens written by older builds into SharedPreferences.
  /// Memoised so it runs at most once per process.
  static Future<void>? _migration;
  static Future<void> _ensureMigrated() => _migration ??= _migrate();

  static Future<void> _migrate() async {
    // Already in secure storage → nothing to carry over.
    if (await _storage.containsKey(key: _kAccessTokenKey)) return;

    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString(_kAccessTokenKey);
    if (access == null) return; // fresh install or already migrated + signed out

    final idToken = prefs.getString(_kIdTokenKey);
    final refresh = prefs.getString(_kRefreshTokenKey);
    await _storage.write(key: _kAccessTokenKey, value: access);
    if (idToken != null) await _storage.write(key: _kIdTokenKey, value: idToken);
    if (refresh != null) await _storage.write(key: _kRefreshTokenKey, value: refresh);

    await prefs.remove(_kAccessTokenKey);
    await prefs.remove(_kIdTokenKey);
    await prefs.remove(_kRefreshTokenKey);
  }

  static final AppLinks _appLinks = AppLinks();

  /// Bumped whenever the session changes (sign-out / expiry). The auth gate
  /// listens to re-evaluate whether to show the sign-in screen.
  static final ValueNotifier<int> sessionEpoch = ValueNotifier<int>(0);

  /// Full OIDC PKCE flow via the external browser:
  /// 1. Build authorize URL + PKCE pair.
  /// 2. Subscribe to deep links *before* launching the browser so we cannot
  ///    miss the callback if the user returns instantly.
  /// 3. Open the URL in Chrome (external, supports passkeys).
  /// 4. Await the first incoming [OidcConfig.redirectUri] deep link.
  /// 5. Exchange the auth code for tokens.
  static Future<AuthTokens> signIn() async {
    final (verifier, challenge) = _generatePkce();
    final state = DateTime.now().microsecondsSinceEpoch.toString();
    final authorizeUrl = Uri.parse(OidcConfig.authorizationEndpoint).replace(
      queryParameters: {
        'response_type': 'code',
        'client_id': OidcConfig.clientId,
        'redirect_uri': OidcConfig.redirectUri,
        'scope': OidcConfig.scope,
        'state': state,
        'code_challenge': challenge,
        'code_challenge_method': 'S256',
      },
    );

    final completer = Completer<Uri>();
    late final StreamSubscription<Uri> sub;
    sub = _appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme == OidcConfig.callbackScheme && !completer.isCompleted) {
        completer.complete(uri);
      }
    });

    try {
      final launched = await launchUrl(authorizeUrl, mode: LaunchMode.externalApplication);
      if (!launched) throw Exception('Could not launch browser');

      final callback = await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () => throw Exception('Login timed out'),
      );

      final error = callback.queryParameters['error'];
      if (error != null) throw Exception('OIDC error: $error');
      final code = callback.queryParameters['code'];
      final returnedState = callback.queryParameters['state'];
      if (code == null) throw Exception('Callback missing code');
      if (returnedState != state) throw Exception('State mismatch');

      return await _exchangeCode(code: code, codeVerifier: verifier);
    } finally {
      await sub.cancel();
    }
  }

  static (String, String) _generatePkce() {
    final rand = Random.secure();
    final bytes = List<int>.generate(32, (_) => rand.nextInt(256));
    final verifier = base64UrlEncode(bytes).replaceAll('=', '');
    final challenge = base64UrlEncode(sha256.convert(utf8.encode(verifier)).bytes)
        .replaceAll('=', '');
    return (verifier, challenge);
  }

  static Future<AuthTokens> _exchangeCode({
    required String code,
    required String codeVerifier,
  }) async {
    final response = await http.post(
      Uri.parse(OidcConfig.tokenEndpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'client_id': OidcConfig.clientId,
        'redirect_uri': OidcConfig.redirectUri,
        'code_verifier': codeVerifier,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Token exchange failed (${response.statusCode}): ${response.body}');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final tokens = AuthTokens(
      accessToken: data['access_token'] as String,
      idToken: data['id_token'] as String?,
      refreshToken: data['refresh_token'] as String?,
      expiresIn: data['expires_in'] as int?,
    );
    await _persist(tokens);
    return tokens;
  }

  static Future<void> _persist(AuthTokens tokens) async {
    await _ensureMigrated();
    await _storage.write(key: _kAccessTokenKey, value: tokens.accessToken);
    if (tokens.idToken != null) {
      await _storage.write(key: _kIdTokenKey, value: tokens.idToken!);
    }
    if (tokens.refreshToken != null) {
      await _storage.write(key: _kRefreshTokenKey, value: tokens.refreshToken!);
    }
  }

  static Future<String?> getAccessToken() async {
    await _ensureMigrated();
    return _storage.read(key: _kAccessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    await _ensureMigrated();
    return _storage.read(key: _kRefreshTokenKey);
  }

  /// Exchanges the stored refresh token for a fresh access token and persists
  /// the result. Returns the new access token, or null if there's no refresh
  /// token or the exchange failed — in which case the caller should treat the
  /// session as expired.
  static Future<String?> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return null;
    try {
      final response = await http.post(
        Uri.parse(OidcConfig.tokenEndpoint),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': OidcConfig.clientId,
        },
      );
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final tokens = AuthTokens(
        accessToken: data['access_token'] as String,
        idToken: data['id_token'] as String?,
        // Pocket ID rotates refresh tokens; fall back to the old one if the
        // response omits a new one.
        refreshToken: (data['refresh_token'] as String?) ?? refreshToken,
        expiresIn: data['expires_in'] as int?,
      );
      await _persist(tokens);
      return tokens.accessToken;
    } catch (_) {
      return null;
    }
  }

  /// Decodes the persisted OIDC ID token's payload. Returns its claims
  /// (`name`, `email`, `picture`, …) or null if there's no token / it's
  /// malformed. Pure local decode — no signature verification, which is fine
  /// since the token was already validated at exchange time.
  static Future<Map<String, dynamic>?> getIdTokenClaims() async {
    await _ensureMigrated();
    final idToken = await _storage.read(key: _kIdTokenKey);
    if (idToken == null) return null;
    final parts = idToken.split('.');
    if (parts.length != 3) return null;
    try {
      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      return jsonDecode(payload) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> signOut() async {
    await _storage.delete(key: _kAccessTokenKey);
    await _storage.delete(key: _kIdTokenKey);
    await _storage.delete(key: _kRefreshTokenKey);
    // Clear any tokens an older build may have left in SharedPreferences too.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAccessTokenKey);
    await prefs.remove(_kIdTokenKey);
    await prefs.remove(_kRefreshTokenKey);
    sessionEpoch.value++;
  }
}
