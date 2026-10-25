import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A Microsoft account linked in private mode: its sign-in session stays on this device.
class PrivateMicrosoftLink {
  final String email;
  final String? displayName;

  /// The Microsoft sign-in session as a JSON array of `{domain, name, path, value}` cookies.
  final String sessionCookies;

  const PrivateMicrosoftLink({required this.email, required this.sessionCookies, this.displayName});

  String get id => email.toLowerCase();

  Map<String, dynamic> toJson() => {'email': email, 'displayName': displayName, 'sessionCookies': sessionCookies};

  factory PrivateMicrosoftLink.fromJson(Map<String, dynamic> j) => PrivateMicrosoftLink(
        email: j['email'] as String? ?? '',
        displayName: j['displayName'] as String?,
        sessionCookies: j['sessionCookies'] as String? ?? '[]',
      );
}

/// Private mode's linked Microsoft accounts, in the platform keystore next to the private account.
class PrivateMicrosoftStore {
  PrivateMicrosoftStore._();
  static final PrivateMicrosoftStore instance = PrivateMicrosoftStore._();

  static const _storage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
  static const _key = 'private.microsoft';

  Future<List<PrivateMicrosoftLink>> list() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>).map((e) => PrivateMicrosoftLink.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<PrivateMicrosoftLink?> get(String id) async {
    for (final link in await list()) {
      if (link.id == id) return link;
    }
    return null;
  }

  /// Adds the link, or replaces the one for the same email.
  Future<void> save(PrivateMicrosoftLink link) async {
    final links = (await list()).where((l) => l.id != link.id).toList()..add(link);
    await _write(links);
  }

  Future<void> updateSession(String id, String sessionCookies) async {
    final link = await get(id);
    if (link != null) await save(PrivateMicrosoftLink(email: link.email, displayName: link.displayName, sessionCookies: sessionCookies));
  }

  Future<void> remove(String id) async => _write((await list()).where((l) => l.id != id).toList());

  Future<void> clear() => _storage.delete(key: _key);

  Future<void> _write(List<PrivateMicrosoftLink> links) => _storage.write(key: _key, value: jsonEncode(links.map((l) => l.toJson()).toList()));
}
