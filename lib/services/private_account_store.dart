import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// On-device credentials for a private-mode (account-free) connection.
/// Held only in the device keystore — never sent to or stored on a Schuly
/// account. Provider-agnostic: [loginMethod] (from the backend catalog) drives
/// how the connection authenticates and where its data is fetched.
class PrivateAccount {
  /// The catalog system key this connection belongs to (e.g. `schulnetz`).
  final String systemKey;

  /// Backend-provided discriminator: `oauth-webview` or `credentials`.
  final String loginMethod;
  final String baseUrl;
  final String displayName;

  // oauth-webview:
  final String? accessToken;
  final String? refreshToken;

  /// Opaque Playwright storage_state blob (JSON string) for passwordless refresh.
  final String? contextState;

  /// Exact WebView user-agent captured at login (Microsoft pins cookies to UA).
  final String? userAgent;

  // credentials:
  final String? username;
  final String? password;

  const PrivateAccount({
    required this.systemKey,
    required this.loginMethod,
    required this.baseUrl,
    required this.displayName,
    this.accessToken,
    this.refreshToken,
    this.contextState,
    this.userAgent,
    this.username,
    this.password,
  });

  bool get isOauth => loginMethod == 'oauth-webview';

  Map<String, dynamic> toJson() => {
        'systemKey': systemKey,
        'loginMethod': loginMethod,
        'baseUrl': baseUrl,
        'displayName': displayName,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'contextState': contextState,
        'userAgent': userAgent,
        'username': username,
        'password': password,
      };

  factory PrivateAccount.fromJson(Map<String, dynamic> json) => PrivateAccount(
        systemKey: json['systemKey'] as String? ?? 'schulnetz',
        loginMethod: json['loginMethod'] as String? ?? 'oauth-webview',
        baseUrl: json['baseUrl'] as String? ?? '',
        displayName: json['displayName'] as String? ?? 'School',
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
        contextState: json['contextState'] as String?,
        userAgent: json['userAgent'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
      );
}

/// Persists the single private-mode account in the platform keystore
/// (Android EncryptedSharedPreferences / iOS Keychain).
class PrivateAccountStore {
  PrivateAccountStore._();
  static final PrivateAccountStore instance = PrivateAccountStore._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  static const _key = 'private.account';

  Future<PrivateAccount?> load() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return null;
    try {
      return PrivateAccount.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> save(PrivateAccount account) =>
      _storage.write(key: _key, value: jsonEncode(account.toJson()));

  Future<void> clear() => _storage.delete(key: _key);
}
