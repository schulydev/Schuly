import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// An account linked in private mode: its sign-in session stays on this device.
class PrivateLinkedAccount {
  final String email;
  final String? displayName;

  /// The sign-in session as a JSON array of `{domain, name, path, value}` cookies.
  final String sessionCookies;

  const PrivateLinkedAccount({required this.email, required this.sessionCookies, this.displayName});

  String get id => email.toLowerCase();

  Map<String, dynamic> toJson() => {'email': email, 'displayName': displayName, 'sessionCookies': sessionCookies};

  factory PrivateLinkedAccount.fromJson(Map<String, dynamic> j) => PrivateLinkedAccount(
        email: j['email'] as String? ?? '',
        displayName: j['displayName'] as String?,
        sessionCookies: j['sessionCookies'] as String? ?? '[]',
      );
}

/// Private mode's linked accounts, in the platform keystore next to the private account.
class PrivateLinkedAccountStore {
  PrivateLinkedAccountStore._();
  static final PrivateLinkedAccountStore instance = PrivateLinkedAccountStore._();

  static const _storage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
  static const _key = 'private.microsoft';

  Future<List<PrivateLinkedAccount>> list() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>).map((e) => PrivateLinkedAccount.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<PrivateLinkedAccount?> get(String id) async {
    for (final link in await list()) {
      if (link.id == id) return link;
    }
    return null;
  }

  /// Adds the link, or replaces the one for the same email.
  Future<void> save(PrivateLinkedAccount link) async {
    final links = (await list()).where((l) => l.id != link.id).toList()..add(link);
    await _write(links);
  }

  Future<void> updateSession(String id, String sessionCookies) async {
    final link = await get(id);
    if (link != null) await save(PrivateLinkedAccount(email: link.email, displayName: link.displayName, sessionCookies: sessionCookies));
  }

  Future<void> remove(String id) async => _write((await list()).where((l) => l.id != id).toList());

  Future<void> clear() => _storage.delete(key: _key);

  Future<void> _write(List<PrivateLinkedAccount> links) => _storage.write(key: _key, value: jsonEncode(links.map((l) => l.toJson()).toList()));
}
