import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrivateAccount {
  final String systemKey;

  final String loginMethod;
  final String baseUrl;
  final String displayName;

  final String statelessBasePath;

  final String? accessToken;
  final String? refreshToken;

  final String? contextState;

  final String? userAgent;

  final String? username;
  final String? password;

  final String? totpSecret;

  const PrivateAccount({
    required this.systemKey,
    required this.loginMethod,
    required this.baseUrl,
    required this.displayName,
    required this.statelessBasePath,
    this.accessToken,
    this.refreshToken,
    this.contextState,
    this.userAgent,
    this.username,
    this.password,
    this.totpSecret,
  });

  Map<String, dynamic> toJson() => {
        'systemKey': systemKey,
        'loginMethod': loginMethod,
        'baseUrl': baseUrl,
        'displayName': displayName,
        'statelessBasePath': statelessBasePath,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'contextState': contextState,
        'userAgent': userAgent,
        'username': username,
        'password': password,
        'totpSecret': totpSecret,
      };

  factory PrivateAccount.fromJson(Map<String, dynamic> json) => PrivateAccount(
        systemKey: json['systemKey'] as String? ?? '',
        loginMethod: json['loginMethod'] as String? ?? 'oauth-webview',
        baseUrl: json['baseUrl'] as String? ?? '',
        displayName: json['displayName'] as String? ?? 'School',
        statelessBasePath: json['statelessBasePath'] as String? ?? '',
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
        contextState: json['contextState'] as String?,
        userAgent: json['userAgent'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        totpSecret: json['totpSecret'] as String?,
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
