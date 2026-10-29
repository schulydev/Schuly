import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/backend_config.dart';
import 'email_verification.dart';

export 'email_verification.dart';

/// Why a token refresh failed.
enum AuthFailure {
  /// The server rejected the refresh token - the session is over and the user
  /// has to sign in again.
  auth,

  /// The server couldn't be reached (no network, timeout, 5xx, a malformed
  /// response). The stored tokens are still good: retry, don't sign out.
  transport,
}

/// Outcome of [AuthService.refreshAccessToken]: either a fresh access token or
/// the reason it couldn't be minted.
class AuthRefresh {
  const AuthRefresh.token(String this.accessToken) : failure = null;
  const AuthRefresh.failed(AuthFailure this.failure) : accessToken = null;

  final String? accessToken;
  final AuthFailure? failure;
}

/// A sign-in the server answered with a second-factor challenge instead of tokens.
class TwoFactorChallenge {
  const TwoFactorChallenge(this.challenge);

  final String challenge;
}

/// What a sign-in step still needs before the user is in: a second-factor code
/// or a confirmed email address. A null [AuthNext] means the account is signed in.
class AuthNext {
  const AuthNext({this.twoFactor, this.emailVerification});

  final TwoFactorChallenge? twoFactor;
  final EmailVerificationChallenge? emailVerification;
}

/// A single sign-on provider the server offers next to the password.
class SignInProvider {
  const SignInProvider(this.key, this.displayName, this.iconUrl);

  final String key;
  final String displayName;
  final String? iconUrl;
}

/// A refusal from the server, worded for the user.
class AuthException implements Exception {
  const AuthException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

/// Password sign-in against the Schuly server's own `/auth` endpoints. The
/// refresh token and the remembered-device token live in the platform keystore.
class AuthService {
  static const _kRefreshTokenKey = 'auth.refresh_token';
  static const _kAccessTokenKey = 'auth.access_token.v2';
  static const _kAccessTokenExpiryKey = 'auth.access_token_expiry';
  static const _kDeviceTokenKey = 'auth.device_token';
  static const _kLegacyKeys = ['auth.access_token', 'auth.id_token'];

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static String? _accessToken;
  static DateTime? _accessTokenExpiry;

  static final ValueNotifier<int> sessionEpoch = ValueNotifier<int>(0);

  static Uri _uri(String path) => Uri.parse('${BackendConfig.url}$path');

  static Future<http.Response> _post(String path, Map<String, Object?> body, {String? accessToken}) {
    return http.post(
      _uri(path),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        if (accessToken != null) HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 20));
  }

  static AuthException _refusal(http.Response response, String fallback) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map) {
        final errors = body['errors'];
        if (errors is List && errors.isNotEmpty) return AuthException(errors.join(' '), statusCode: response.statusCode);
        final description = body['error_description'];
        if (description is String && description.isNotEmpty) return AuthException(description, statusCode: response.statusCode);
      }
    } catch (_) {}
    if (response.statusCode == 429) return AuthException('Too many attempts. Wait a minute and try again.', statusCode: response.statusCode);
    return AuthException(fallback, statusCode: response.statusCode);
  }

  /// Signs in with a username or email and a password. Returns null when the
  /// account is signed in, or a [TwoFactorChallenge] when a code is needed.
  static Future<AuthNext?> signIn(String identifier, String password) async {
    final deviceToken = await _storage.read(key: _kDeviceTokenKey);
    final response = await _post('/auth/login', {'identifier': identifier, 'password': password, 'deviceToken': ?deviceToken});
    if (response.statusCode != 200) throw _refusal(response, "That didn't match. Check your username and password.");
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return _next(body);
  }

  /// Turns a token-or-challenge response into the next step, persisting tokens
  /// when the account is signed in.
  static Future<AuthNext?> _next(Map<String, dynamic> body) async {
    final verification = EmailVerificationChallenge.tryParse(body);
    if (verification != null) return AuthNext(emailVerification: verification);
    if (body['two_factor_required'] == true) return AuthNext(twoFactor: TwoFactorChallenge(body['challenge'] as String));
    await _persist(body);
    return null;
  }

  static const _externalErrors = {
    'access_denied': 'You cancelled the sign-in.',
    'account_not_found': 'No Schuly account uses that sign-in yet. Create an account first, then link it on the web.',
    'account_exists': 'An account with that email already exists. Sign in with your password, then link this provider on the web.',
    'external_login_failed': 'Signing in with that provider did not work. Try again.',
  };

  static String get _callbackScheme => appFlavor == 'dev' ? 'schuly-dev' : 'schuly';

  /// The single sign-on providers the server offers; empty when it offers none.
  static Future<List<SignInProvider>> providers() async {
    try {
      final response = await http.get(_uri('/auth/providers')).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return const [];
      return [
        for (final entry in jsonDecode(response.body) as List)
          SignInProvider(entry['key'] as String, (entry['display_name'] as String?) ?? entry['key'] as String, BackendConfig.resolveUrl(entry['icon_url'] as String?)),
      ];
    } catch (_) {
      return const [];
    }
  }

  /// Signs in through a provider in the system browser. Returns null when the
  /// account is signed in, or a [TwoFactorChallenge] when a code is needed.
  static Future<AuthNext?> signInWithProvider(String provider) async {
    final verifier = _randomToken();
    final state = _randomToken();
    final challenge = base64Url.encode(sha256.convert(utf8.encode(verifier)).bytes).replaceAll('=', '');
    final start = _uri('/auth/external/${Uri.encodeComponent(provider)}/start').replace(queryParameters: {
      'returnUrl': '$_callbackScheme://auth/callback',
      'codeChallenge': challenge,
      'codeChallengeMethod': 'S256',
      'state': state,
    });

    final String result;
    try {
      result = await FlutterWebAuth2.authenticate(url: start.toString(), callbackUrlScheme: _callbackScheme);
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') throw AuthException(_externalErrors['access_denied']!);
      rethrow;
    }

    final query = Uri.parse(result).queryParameters;
    final error = query['error'];
    if (error != null) throw AuthException(_externalErrors[error] ?? _externalErrors['external_login_failed']!);
    final code = query['code'];
    if (code == null || query['state'] != state) throw AuthException(_externalErrors['external_login_failed']!);

    final response = await _post('/auth/external/exchange', {'code': code, 'codeVerifier': verifier});
    if (response.statusCode != 200) throw _refusal(response, _externalErrors['external_login_failed']!);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return _next(body);
  }

  static String _randomToken() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(32, (_) => random.nextInt(256))).replaceAll('=', '');
  }

  /// Finishes a sign-in with a code from the authenticator app or a recovery code.
  static Future<void> verifyCode(TwoFactorChallenge challenge, String code, {bool rememberDevice = false}) async {
    final response = await _post('/auth/2fa/verify', {'challenge': challenge.challenge, 'code': code, 'rememberDevice': rememberDevice, 'deviceLabel': _deviceLabel()});
    if (response.statusCode != 200) throw _refusal(response, "That code didn't work. Wait for the next code in your app and enter that one.");
    await _persist(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Creates an account. Returns the email confirmation step when the server
  /// wants the address confirmed first; otherwise signs in, mails a link to
  /// confirm the address, and returns null.
  static Future<EmailVerificationChallenge?> register(String userName, String email, String password) async {
    final response = await _post('/auth/register', {'userName': userName, 'email': email, 'password': password});
    if (response.statusCode != 201) throw _refusal(response, 'That username or email is already taken.');
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final verification = EmailVerificationChallenge.tryParse(body);
    if (verification != null) return verification;
    final tokens = await _persist(body);
    try {
      await _post('/auth/email', {'newEmail': email, 'currentPassword': password}, accessToken: tokens);
    } catch (_) {}
    return null;
  }

  /// Finishes the email confirmation with the mailed code. Returns null when
  /// signed in, or the second-factor step. Throws [EmailCodeException].
  static Future<AuthNext?> verifyEmailCode(EmailVerificationChallenge pending, String code) async {
    final http.Response response;
    try {
      response = await _post('/auth/email/verify-code', {'challenge': pending.challenge, 'code': code});
    } on TimeoutException {
      throw const EmailCodeException(EmailCodeErrorKind.other);
    }
    if (response.statusCode != 200) throw mapEmailCodeError(response.statusCode, response.body, retryAfterHeader: response.headers['retry-after']);
    return _next(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Mails a fresh code for the pending confirmation. Throws [EmailCodeException];
  /// a rate limit carries the seconds to wait.
  static Future<void> resendEmailCode(EmailVerificationChallenge pending) async {
    final http.Response response;
    try {
      response = await _post('/auth/email/resend-code', {'challenge': pending.challenge});
    } on TimeoutException {
      throw const EmailCodeException(EmailCodeErrorKind.other);
    }
    if (response.statusCode != 204 && response.statusCode != 200) throw mapEmailCodeError(response.statusCode, response.body, retryAfterHeader: response.headers['retry-after']);
  }

  /// Mails a password reset link when the address belongs to a confirmed account.
  static Future<void> requestPasswordReset(String email) async {
    final response = await _post('/auth/password/forgot', {'email': email});
    if (response.statusCode != 204) throw _refusal(response, 'That did not work. Try again in a moment.');
  }

  static Future<String> _persist(Map<String, dynamic> body) async {
    final accessToken = body['access_token'] as String;
    final expiresIn = (body['expires_in'] as num?)?.toInt() ?? 900;
    _accessToken = accessToken;
    _accessTokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
    await _storage.write(key: _kAccessTokenKey, value: accessToken);
    await _storage.write(key: _kAccessTokenExpiryKey, value: _accessTokenExpiry!.toIso8601String());
    final refreshToken = body['refresh_token'] as String?;
    if (refreshToken != null) await _storage.write(key: _kRefreshTokenKey, value: refreshToken);
    final deviceToken = body['device_token'] as String?;
    if (deviceToken != null) await _storage.write(key: _kDeviceTokenKey, value: deviceToken);
    sessionEpoch.value++;
    return accessToken;
  }

  static Future<void>? _restore;
  static Future<void> _ensureRestored() => _restore ??= _restoreAccessToken();

  static Future<void> _restoreAccessToken() async {
    for (final key in _kLegacyKeys) {
      await _storage.delete(key: key);
    }
    final token = await _storage.read(key: _kAccessTokenKey);
    final expiry = DateTime.tryParse(await _storage.read(key: _kAccessTokenExpiryKey) ?? '');
    if (token != null && expiry != null && _accessToken == null) {
      _accessToken = token;
      _accessTokenExpiry = expiry;
    }
  }

  /// Returns a usable access token: the cached one if still valid, otherwise a
  /// freshly refreshed one. Null when there's no session.
  static Future<String?> getAccessToken() async {
    await _ensureRestored();
    final token = _accessToken;
    final expiry = _accessTokenExpiry;
    if (token != null && expiry != null && expiry.isAfter(DateTime.now().add(const Duration(seconds: 30)))) {
      return token;
    }
    return (await refreshAccessToken()).accessToken;
  }

  /// Whether a refresh token is stored - the app has a session it can re-mint an
  /// access token from, even while it can't reach the server.
  static Future<bool> hasSession() async => await _storage.read(key: _kRefreshTokenKey) != null;

  static Future<AuthRefresh>? _refreshing;

  static Future<AuthRefresh> refreshAccessToken() => _refreshing ??= _refresh().whenComplete(() => _refreshing = null);

  static Future<AuthRefresh> _refresh() async {
    final refreshToken = await _storage.read(key: _kRefreshTokenKey);
    if (refreshToken == null) return const AuthRefresh.failed(AuthFailure.auth);
    try {
      final response = await _post('/auth/refresh', {'refreshToken': refreshToken});
      if (response.statusCode == 400 || response.statusCode == 401) return const AuthRefresh.failed(AuthFailure.auth);
      if (response.statusCode != 200) return const AuthRefresh.failed(AuthFailure.transport);
      return AuthRefresh.token(await _persist(jsonDecode(response.body) as Map<String, dynamic>));
    } catch (_) {
      return const AuthRefresh.failed(AuthFailure.transport);
    }
  }

  static Future<bool>? _signingOut;

  /// Ends the session. Memoised, because N requests failing at once must sign
  /// out once. Returns true only for the call that actually ended a live session.
  static Future<bool> signOut() {
    final pending = _signingOut;
    if (pending != null) return pending.then((_) => false);
    return _signingOut = _signOut().whenComplete(() => _signingOut = null);
  }

  static Future<bool> _signOut() async {
    final refreshToken = await _storage.read(key: _kRefreshTokenKey);
    final hadSession = refreshToken != null || _accessToken != null;
    if (refreshToken != null) {
      try {
        await _post('/auth/logout', {'refreshToken': refreshToken});
      } catch (_) {}
    }
    _accessToken = null;
    _accessTokenExpiry = null;
    await _storage.delete(key: _kRefreshTokenKey);
    await _storage.delete(key: _kAccessTokenKey);
    await _storage.delete(key: _kAccessTokenExpiryKey);
    final prefs = await SharedPreferences.getInstance();
    for (final key in [..._kLegacyKeys, _kRefreshTokenKey]) {
      await prefs.remove(key);
    }
    _restore = null;
    sessionEpoch.value++;
    return hadSession;
  }

  static String _deviceLabel() {
    if (kIsWeb) return 'Schuly app';
    return 'Schuly app on ${Platform.isIOS ? 'iOS' : Platform.isAndroid ? 'Android' : Platform.operatingSystem}';
  }
}
