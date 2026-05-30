class OidcConfig {
  static const authority = 'https://auth.gaggao.com';
  static const clientId = 'fe2e0db0-69e3-48e3-845c-561f7a36d280';
  static const scope = 'openid profile email groups picture';

  // Custom scheme deep link. Pocket ID redirects here after login; Android
  // routes it back to the app via the schulytest:// intent filter, so the
  // user lands in the real Chrome (full passkey support) and returns to the
  // app on success. Scheme intentionally does NOT mirror the package id so
  // dev and prod flavors can coexist.
  static const redirectUri = 'schulytest://callback';
  static const callbackScheme = 'schulytest';

  // Backend base URL. Override per build — never hardcode a machine IP here:
  //   flutter build apk --dart-define=BACKEND_BASE_URL=http://<dev-box-lan-ip>:5033
  // Defaults to localhost: use `adb reverse tcp:5033 tcp:5033` over USB, or
  // `http://10.0.2.2:5033` on the emulator.
  static const backendBaseUrl = String.fromEnvironment(
    'BACKEND_BASE_URL',
    defaultValue: 'http://localhost:5033',
  );

  static const tokenEndpoint = '$authority/api/oidc/token';
  static const authorizationEndpoint = '$authority/authorize';

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
