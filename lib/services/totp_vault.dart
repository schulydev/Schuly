import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'totp_service.dart';

/// One saved authenticator entry: a TOTP secret plus display metadata. The
/// [secretOrUri] is what [TotpService] consumes - a bare base32 secret or a full
/// `otpauth://` URI (as encoded in an authenticator QR code). Provider-agnostic:
/// any service's 2FA can live here. Held only in the device keystore, never
/// synced to a Schuly account.
class TotpEntry {
  final String id;
  final String secretOrUri;
  final String? issuer;
  final String? account;

  const TotpEntry({required this.id, required this.secretOrUri, this.issuer, this.account});

  /// The normalized base32 secret (what a backend `/login` expects), or null if
  /// [secretOrUri] can't be parsed.
  String? get secret => TotpService.secretOf(secretOrUri);

  /// Primary display line - issuer if known, else the account, else a fallback.
  String get title {
    if (issuer != null && issuer!.isNotEmpty) return issuer!;
    if (account != null && account!.isNotEmpty) return account!;
    return 'Account';
  }

  /// Secondary display line - the account when a distinct issuer is shown.
  String? get subtitle => (issuer != null && issuer!.isNotEmpty && account != null && account!.isNotEmpty) ? account : null;

  Map<String, dynamic> toJson() => {'id': id, 'secretOrUri': secretOrUri, 'issuer': issuer, 'account': account};

  factory TotpEntry.fromJson(Map<String, dynamic> json) => TotpEntry(
        id: json['id'] as String,
        secretOrUri: json['secretOrUri'] as String? ?? '',
        issuer: json['issuer'] as String?,
        account: json['account'] as String?,
      );

  /// Builds an entry from a raw scanned/typed [payload] (an `otpauth://` URI or
  /// bare secret), pulling issuer/account from the URI when present. Returns null
  /// when no usable TOTP secret can be extracted. [id] is caller-supplied so the
  /// factory stays deterministic; pass a fresh unique value.
  static TotpEntry? fromPayload(String id, String payload, {String? issuer, String? account}) {
    final config = TotpConfig.tryParse(payload);
    if (config == null) return null;
    return TotpEntry(
      id: id,
      secretOrUri: payload.trim(),
      issuer: (issuer != null && issuer.isNotEmpty) ? issuer : config.issuer,
      account: (account != null && account.isNotEmpty) ? account : config.account,
    );
  }
}

/// Persists the list of authenticator entries in the platform keystore
/// (Android EncryptedSharedPreferences / iOS Keychain). Secrets never leave the
/// device.
class TotpVault {
  TotpVault._();
  static final TotpVault instance = TotpVault._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  static const _key = 'authenticator.entries';

  Future<List<TotpEntry>> load() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => TotpEntry.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveAll(List<TotpEntry> entries) =>
      _storage.write(key: _key, value: jsonEncode(entries.map((e) => e.toJson()).toList()));

  /// Adds [entry], replacing any existing one with the same id, and returns it.
  Future<TotpEntry> add(TotpEntry entry) async {
    final entries = await load();
    entries.removeWhere((e) => e.id == entry.id);
    entries.add(entry);
    await _saveAll(entries);
    return entry;
  }

  Future<void> remove(String id) async {
    final entries = await load();
    entries.removeWhere((e) => e.id == id);
    await _saveAll(entries);
  }
}
