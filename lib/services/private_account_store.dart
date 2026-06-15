import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// On-device credentials for a private-mode (account-free) connection.
/// Held only in the device keystore — never sent to or stored on a Schuly
/// account. Supports both providers: Schulnetz (OAuth tokens + context_state)
/// and OdAOrg (username/password).
class PrivateAccount {
  /// `'schulnetz'` or `'odaorg'`.
  final String provider;
  final String baseUrl;
  final String displayName;

  // Schulnetz (OAuth):
  final String? accessToken;
  final String? refreshToken;

  /// Opaque Playwright storage_state blob (JSON string) for passwordless refresh.
  final String? contextState;

  /// Exact WebView user-agent captured at login (Microsoft pins cookies to UA).
  final String? userAgent;

  // OdAOrg (credentials):
  final String? username;
  final String? password;

  const PrivateAccount({
    required this.provider,
    required this.baseUrl,
    required this.displayName,
    this.accessToken,
    this.refreshToken,
    this.contextState,
    this.userAgent,
    this.username,
    this.password,
  });

  bool get isSchulnetz => provider == 'schulnetz';
  bool get isOdaorg => provider == 'odaorg';

  factory PrivateAccount.schulnetz({
    required String baseUrl,
    required String displayName,
    required String accessToken,
    String? refreshToken,
    required String contextState,
    required String userAgent,
  }) =>
      PrivateAccount(
        provider: 'schulnetz',
        baseUrl: baseUrl,
        displayName: displayName,
        accessToken: accessToken,
        refreshToken: refreshToken,
        contextState: contextState,
        userAgent: userAgent,
      );

  factory PrivateAccount.odaorg({
    required String baseUrl,
    required String displayName,
    required String username,
    required String password,
  }) =>
      PrivateAccount(
        provider: 'odaorg',
        baseUrl: baseUrl,
        displayName: displayName,
        username: username,
        password: password,
      );

  Map<String, dynamic> toJson() => {
        'provider': provider,
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
        provider: json['provider'] as String? ?? 'schulnetz',
        baseUrl:
            (json['baseUrl'] ?? json['schulnetzBaseUrl']) as String? ?? '',
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
