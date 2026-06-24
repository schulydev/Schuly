import 'dart:convert';

import 'package:http/http.dart' as http;

/// Resolved OIDC settings for the active backend. Everything except the backend
/// base URL is discovered at runtime - the backend's `/api/app` provides the
/// authority, client id, scope and redirect uri, and the provider's OIDC
/// discovery document provides the authorize/token endpoints. Nothing
/// provider-specific (Keycloak vs Pocket ID vs …) is hardcoded.
class OidcSettings {
  final String authority;
  final String clientId;
  final String scope;
  final String redirectUri;
  final String authorizationEndpoint;
  final String tokenEndpoint;

  const OidcSettings({
    required this.authority,
    required this.clientId,
    required this.scope,
    required this.redirectUri,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
  });

  /// Deep-link scheme the provider redirects back to (e.g. `schulytest`),
  /// derived from [redirectUri] so the app never hardcodes it.
  String get callbackScheme => Uri.parse(redirectUri).scheme;
}

class OidcConfig {
  // Backend base URL. Override per build - never hardcode a machine IP here:
  //   flutter build apk --dart-define=BACKEND_BASE_URL=http://<dev-box-lan-ip>:5033
  // Defaults to localhost: use `adb reverse tcp:5033 tcp:5033` over USB, or
  // `http://10.0.2.2:5033` on the emulator.
  static const backendBaseUrl = String.fromEnvironment(
    'BACKEND_BASE_URL',
    defaultValue: 'http://localhost:5033',
  );

  static OidcSettings? _settings;
  static Future<OidcSettings>? _loading;

  /// Loads (once) and caches the OIDC settings from the backend. Safe to call
  /// from multiple places concurrently - the in-flight load is shared, and a
  /// failed load is not cached so the next call retries.
  static Future<OidcSettings> settings() {
    final cached = _settings;
    if (cached != null) return Future<OidcSettings>.value(cached);
    return _loading ??= _load().then((s) {
      _settings = s;
      _loading = null;
      return s;
    }, onError: (Object e) {
      _loading = null;
      throw e;
    });
  }

  static Future<OidcSettings> _load() async {
    final app = await _getJson('$backendBaseUrl/api/app');
    final authority =
        (app['authority'] as String).replaceAll(RegExp(r'/+$'), '');
    final disco = await _getJson('$authority/.well-known/openid-configuration');
    return OidcSettings(
      authority: authority,
      clientId: app['clientId'] as String,
      scope: (app['scope'] as String?) ??
          'openid profile email groups picture offline_access',
      redirectUri: (app['redirectUri'] as String?) ?? 'schulytest://callback',
      authorizationEndpoint: disco['authorization_endpoint'] as String,
      tokenEndpoint: disco['token_endpoint'] as String,
    );
  }

  static Future<Map<String, dynamic>> _getJson(String url) async {
    final r = await http.get(Uri.parse(url));
    if (r.statusCode != 200) {
      throw Exception('GET $url failed (${r.statusCode})');
    }
    return jsonDecode(r.body) as Map<String, dynamic>;
  }

  /// Resolves a backend-supplied URL: absolute (http…) is used as-is, a
  /// root-relative path (/api/avatars/…) is prefixed with [backendBaseUrl],
  /// null/empty returns null. Signed capability URLs need no auth header.
  static String? resolveUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    if (url.startsWith('http')) return url;
    if (url.startsWith('/')) return '$backendBaseUrl$url';
    return url;
  }
}
