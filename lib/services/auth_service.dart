import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/oidc_config.dart';

class AuthTokens {
  final String accessToken;
  final String? idToken;
  final String? refreshToken;
  final DateTime? accessTokenExpiry;

  AuthTokens({required this.accessToken, this.idToken, this.refreshToken, this.accessTokenExpiry});
}

/// Why a token refresh failed.
enum AuthFailure {
  /// The provider rejected the refresh token (`invalid_grant` and the other
  /// OAuth error codes) - the session is over and the user has to sign in again.
  auth,

  /// The provider couldn't be reached (no network, timeout, 5xx, a malformed
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

/// OIDC Authorization Code + PKCE login backed by [FlutterAppAuth], which drives
/// the flow through ASWebAuthenticationSession (iOS) / Chrome Custom Tabs
/// (Android) - the system browser, never a WebView, and never an in-app
/// credential form. The client is public (no secret); PKCE (S256) replaces it.
class AuthService {
  // Only the refresh token and id token are persisted. The access token is kept
  // in memory (per OAuth mobile best practice) and re-minted from the refresh
  // token on cold start.
  static const _kRefreshTokenKey = 'auth.refresh_token';
  static const _kIdTokenKey = 'auth.id_token';
  // Legacy key from the old hand-rolled flow that persisted the access token.
  static const _kLegacyAccessTokenKey = 'auth.access_token';

  static const _appAuth = FlutterAppAuth();

  /// Refresh/id tokens live in the platform keystore (Android
  /// EncryptedSharedPrefs / iOS Keychain), not plaintext SharedPreferences.
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static String? _accessToken;
  static DateTime? _accessTokenExpiry;

  /// One-shot migration of tokens written by older builds into SharedPreferences.
  /// Memoised so it runs at most once per process.
  static Future<void>? _migration;
  static Future<void> _ensureMigrated() => _migration ??= _migrate();

  static Future<void> _migrate() async {
    await _storage.delete(key: _kLegacyAccessTokenKey);

    if (await _storage.containsKey(key: _kRefreshTokenKey)) return;

    final prefs = await SharedPreferences.getInstance();
    final refresh = prefs.getString(_kRefreshTokenKey);
    if (refresh == null) return; // fresh install or already migrated + signed out

    final idToken = prefs.getString(_kIdTokenKey);
    await _storage.write(key: _kRefreshTokenKey, value: refresh);
    if (idToken != null) await _storage.write(key: _kIdTokenKey, value: idToken);

    await prefs.remove(_kLegacyAccessTokenKey);
    await prefs.remove(_kIdTokenKey);
    await prefs.remove(_kRefreshTokenKey);
  }

  static final ValueNotifier<int> sessionEpoch = ValueNotifier<int>(0);

  static AuthorizationServiceConfiguration _serviceConfig(OidcSettings cfg) => AuthorizationServiceConfiguration(authorizationEndpoint: cfg.authorizationEndpoint, tokenEndpoint: cfg.tokenEndpoint, endSessionEndpoint: cfg.endSessionEndpoint);

  /// The standard OAuth 2.0 error codes. The provider reporting any of them
  /// means it looked at the grant and refused it; everything else that can come
  /// out of the token call (no network, a timeout, a 5xx, a parse failure) is
  /// transport trouble and must not cost the user their session.
  static const _oauthErrors = {
    FlutterAppAuthOAuthError.invalidRequest,
    FlutterAppAuthOAuthError.invalidClient,
    FlutterAppAuthOAuthError.invalidGrant,
    FlutterAppAuthOAuthError.unauthorizedClient,
    FlutterAppAuthOAuthError.unsupportedGrantType,
    FlutterAppAuthOAuthError.invalidScope,
  };

  @visibleForTesting
  static AuthFailure classifyRefreshError(Object error) {
    final oauthError = error is FlutterAppAuthPlatformException ? error.platformErrorDetails.error : null;
    return _oauthErrors.contains(oauthError) ? AuthFailure.auth : AuthFailure.transport;
  }

  /// Runs the OIDC Authorization Code + PKCE flow in the system browser and
  /// exchanges the code for tokens. flutter_appauth applies PKCE (S256)
  /// automatically. When [register] is true the authorize request carries
  /// `prompt=create` (the OIDC registration hint) so Keycloak opens the
  /// registration screen first.
  static Future<AuthTokens> signIn({bool register = false}) async {
    final cfg = await OidcConfig.settings();
    if (!cfg.schemeIsRegistered) {
      throw Exception('This backend redirects to ${cfg.callbackScheme}://, which this app build cannot receive. Configure its redirect URI as ${OidcConfig.redirectScheme}://callback.');
    }
    final result = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        cfg.clientId,
        cfg.redirectUri,
        serviceConfiguration: _serviceConfig(cfg),
        scopes: cfg.scopes,
        promptValues: register ? const ['create'] : null,
        allowInsecureConnections: cfg.allowInsecureConnections,
      ),
    );
    return _persist(result);
  }

  static Future<AuthTokens> _persist(TokenResponse r) async {
    await _ensureMigrated();
    final tokens = AuthTokens(accessToken: r.accessToken!, idToken: r.idToken, refreshToken: r.refreshToken, accessTokenExpiry: r.accessTokenExpirationDateTime);
    _accessToken = tokens.accessToken;
    _accessTokenExpiry = tokens.accessTokenExpiry;
    if (tokens.refreshToken != null) {
      await _storage.write(key: _kRefreshTokenKey, value: tokens.refreshToken!);
    }
    if (tokens.idToken != null) {
      await _storage.write(key: _kIdTokenKey, value: tokens.idToken!);
    }
    return tokens;
  }

  /// Returns a usable access token: the in-memory one if still valid, otherwise
  /// a freshly refreshed one. Null when there's no session (no refresh token or
  /// the refresh failed) - the caller should treat that as signed-out.
  static Future<String?> getAccessToken() async {
    final token = _accessToken;
    final expiry = _accessTokenExpiry;
    if (token != null && expiry != null && expiry.isAfter(DateTime.now().add(const Duration(seconds: 30)))) {
      return token;
    }
    return (await refreshAccessToken()).accessToken;
  }

  static Future<String?> getRefreshToken() async {
    await _ensureMigrated();
    return _storage.read(key: _kRefreshTokenKey);
  }

  /// Whether a refresh token is stored - the app has a session it can re-mint an
  /// access token from, even while it can't reach the provider.
  static Future<bool> hasSession() async => await getRefreshToken() != null;

  static Future<AuthRefresh>? _refreshing;

  static Future<AuthRefresh> refreshAccessToken() => _refreshing ??= _refresh().whenComplete(() => _refreshing = null);

  static Future<AuthRefresh> _refresh() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return const AuthRefresh.failed(AuthFailure.auth);
    try {
      final cfg = await OidcConfig.settings();
      final result = await _appAuth.token(
        TokenRequest(
          cfg.clientId,
          cfg.redirectUri,
          serviceConfiguration: _serviceConfig(cfg),
          refreshToken: refreshToken,
          scopes: cfg.scopes,
          allowInsecureConnections: cfg.allowInsecureConnections,
        ),
      );
      final tokens = await _persist(result);
      return AuthRefresh.token(tokens.accessToken);
    } catch (e) {
      return AuthRefresh.failed(classifyRefreshError(e));
    }
  }

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

  static Future<bool>? _signingOut;

  /// Ends the session. [endSession] drives the provider's logout page in the
  /// system browser; pass false for a silent local sign-out (an expired session
  /// has nothing left to log out of). Memoised, because N requests failing at
  /// once must not open N browser tabs. Returns true only for the call that
  /// actually ended a live session, so exactly one caller reports it.
  static Future<bool> signOut({bool endSession = true}) {
    final pending = _signingOut;
    if (pending != null) return pending.then((_) => false);
    return _signingOut = _signOut(endSession: endSession).whenComplete(() => _signingOut = null);
  }

  static Future<bool> _signOut({required bool endSession}) async {
    await _ensureMigrated();
    final idToken = await _storage.read(key: _kIdTokenKey);
    final hadSession = idToken != null || _accessToken != null || await _storage.read(key: _kRefreshTokenKey) != null;
    // No id token means there is no provider session to end - private mode, or
    // one already dropped - and endSession would just strand the user on a
    // logout page for an account they never signed into.
    if (endSession && idToken != null) {
      try {
        final cfg = await OidcConfig.settings();
        if (cfg.endSessionEndpoint != null) {
          await _appAuth.endSession(
            EndSessionRequest(
              idTokenHint: idToken,
              postLogoutRedirectUrl: cfg.redirectUri,
              serviceConfiguration: _serviceConfig(cfg),
              allowInsecureConnections: cfg.allowInsecureConnections,
            ),
          );
        }
      } catch (_) {
      }
    }
    _accessToken = null;
    _accessTokenExpiry = null;
    await _storage.delete(key: _kRefreshTokenKey);
    await _storage.delete(key: _kIdTokenKey);
    await _storage.delete(key: _kLegacyAccessTokenKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kLegacyAccessTokenKey);
    await prefs.remove(_kIdTokenKey);
    await prefs.remove(_kRefreshTokenKey);
    sessionEpoch.value++;
    return hadSession;
  }
}
