import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// On-device credentials for a private-mode (account-free) Schulnetz connection.
/// Held only in the device keystore — never sent to or stored on a Schuly account.
class PrivateAccount {
  final String schulnetzBaseUrl;
  final String displayName;
  final String accessToken;
  final String? refreshToken;

  /// Opaque Playwright storage_state blob (JSON string) used for passwordless refresh.
  final String contextState;

  /// Exact WebView user-agent captured at login (Microsoft pins cookies to UA).
  final String userAgent;

  const PrivateAccount({
    required this.schulnetzBaseUrl,
    required this.displayName,
    required this.accessToken,
    required this.contextState,
    required this.userAgent,
    this.refreshToken,
  });

  PrivateAccount copyWith({
    String? accessToken,
    String? refreshToken,
    String? contextState,
  }) =>
      PrivateAccount(
        schulnetzBaseUrl: schulnetzBaseUrl,
        displayName: displayName,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        contextState: contextState ?? this.contextState,
        userAgent: userAgent,
      );

  Map<String, dynamic> toJson() => {
        'schulnetzBaseUrl': schulnetzBaseUrl,
        'displayName': displayName,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'contextState': contextState,
        'userAgent': userAgent,
      };

  factory PrivateAccount.fromJson(Map<String, dynamic> json) => PrivateAccount(
        schulnetzBaseUrl: json['schulnetzBaseUrl'] as String,
        displayName: json['displayName'] as String? ?? 'Schulnetz',
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String?,
        contextState: json['contextState'] as String,
        userAgent: json['userAgent'] as String,
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
