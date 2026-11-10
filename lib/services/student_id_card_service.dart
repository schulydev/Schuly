import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart' show sha256;
import 'package:cryptography/cryptography.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/my_school.dart';
import 'api_client.dart';
import 'backend_dio.dart';
import 'private_account_store.dart';
import 'secure_store.dart';

/// The official Lernendenausweis as Schulnetz renders it: sanitized HTML with inline CSS and `data:` images.
class StudentIdCard {
  const StudentIdCard({required this.html, required this.fetchedAt, required this.source});

  final String html;
  final DateTime fetchedAt;

  /// `mobile` or `web`: where the backend read the card.
  final String source;

  factory StudentIdCard.fromJson(Map<String, dynamic> j) => StudentIdCard(
        html: j['html'] as String? ?? '',
        fetchedAt: DateTime.tryParse(j['fetchedAt'] as String? ?? '')?.toLocal() ?? DateTime.now(),
        source: j['source'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {'html': html, 'fetchedAt': fetchedAt.toUtc().toIso8601String(), 'source': source};
}

enum StudentIdCardFailure { notOffered, signInExpired, unavailable }

class StudentIdCardException implements Exception {
  const StudentIdCardException(this.kind);

  final StudentIdCardFailure kind;

  /// Reads the backend's `{ "code" }` body. A 404 without a code (another provider, or a plugin without the route) and a
  /// 401 in private mode (the route needs a Schuly sign-in that private mode does not have) mean there is no official card.
  factory StudentIdCardException.fromDio(DioException e, {required bool isPrivate}) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final code = data is Map ? data['code'] as String? : null;
    if (code == 'not_offered' || status == 404 || (isPrivate && status == 401)) return const StudentIdCardException(StudentIdCardFailure.notOffered);
    if (code == 'signin_expired' || code == 'schulnetz_signin_expired') return const StudentIdCardException(StudentIdCardFailure.signInExpired);
    return const StudentIdCardException(StudentIdCardFailure.unavailable);
  }

  @override
  String toString() => 'StudentIdCardException($kind)';
}

/// Where the card of the current school connection comes from.
class StudentIdCardTarget {
  const StudentIdCardTarget.account({required this.path, required String accountId})
      : privateAccount = null,
        cacheKey = 'account:$accountId';

  StudentIdCardTarget.private(PrivateAccount this.privateAccount)
      : path = '${privateAccount.statelessBasePath}/student-id-card',
        cacheKey = 'private:${privateAccount.baseUrl}';

  final String path;
  final PrivateAccount? privateAccount;

  /// One offline copy per account.
  final String cacheKey;

  bool get isPrivate => privateAccount != null;
}

/// The offline copy of the card, one per account.
abstract class StudentIdCardCache {
  Future<StudentIdCard?> read(String key);
  Future<void> write(String key, StudentIdCard card);
  Future<void> delete(String key);
  Future<void> clear();
}

/// Keeps each account's card as an AES-GCM encrypted file; the key lives in the platform keystore ([SecureStore]).
/// The card is too large for the keystore itself, and it never goes to plain SharedPreferences.
class EncryptedFileStudentIdCardCache implements StudentIdCardCache {
  EncryptedFileStudentIdCardCache({Future<Directory> Function()? directory}) : _directory = directory ?? _defaultDirectory;

  static const _keyName = 'student_id_card.key';
  static final _cipher = AesGcm.with256bits();

  final Future<Directory> Function() _directory;

  static Future<Directory> _defaultDirectory() async => Directory('${(await getApplicationSupportDirectory()).path}${Platform.pathSeparator}student_id_card');

  Future<File> _file(String key) async {
    final dir = await _directory();
    return File('${dir.path}${Platform.pathSeparator}${sha256.convert(utf8.encode(key))}.bin');
  }

  Future<SecretKey?> _key({required bool create}) async {
    final stored = await SecureStore.read(_keyName);
    if (stored != null) return SecretKey(base64Decode(stored));
    if (!create) return null;
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    await SecureStore.write(_keyName, base64Encode(bytes));
    return SecretKey(bytes);
  }

  @override
  Future<StudentIdCard?> read(String key) async {
    try {
      final file = await _file(key);
      if (!await file.exists()) return null;
      final secret = await _key(create: false);
      if (secret == null) {
        await delete(key);
        return null;
      }
      final box = SecretBox.fromConcatenation(await file.readAsBytes(), nonceLength: _cipher.nonceLength, macLength: _cipher.macAlgorithm.macLength);
      final clear = await _cipher.decrypt(box, secretKey: secret);
      return StudentIdCard.fromJson(jsonDecode(utf8.decode(clear)) as Map<String, dynamic>);
    } catch (e) {
      // A copy that no longer decrypts (new key after a keystore reset) is just gone.
      debugPrint('StudentIdCardCache: unreadable offline copy dropped (${e.runtimeType})');
      await delete(key);
      return null;
    }
  }

  @override
  Future<void> write(String key, StudentIdCard card) async {
    try {
      final secret = await _key(create: true);
      final box = await _cipher.encrypt(utf8.encode(jsonEncode(card.toJson())), secretKey: secret!);
      final file = await _file(key);
      await file.parent.create(recursive: true);
      final temp = File('${file.path}.tmp');
      await temp.writeAsBytes(box.concatenation(), flush: true);
      await temp.rename(file.path);
    } catch (e) {
      debugPrint('StudentIdCardCache: could not keep an offline copy (${e.runtimeType})');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      final file = await _file(key);
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }

  @override
  Future<void> clear() async {
    try {
      final dir = await _directory();
      if (await dir.exists()) await dir.delete(recursive: true);
    } catch (_) {}
    await SecureStore.delete(_keyName);
  }
}

/// Fetches the official card through the backend and keeps an encrypted offline copy per account.
class StudentIdCardService {
  StudentIdCardService._()
      : _get = null,
        _cache = EncryptedFileStudentIdCardCache();
  static final StudentIdCardService instance = StudentIdCardService._();

  @visibleForTesting
  StudentIdCardService.withDeps({required Future<Map<String, dynamic>?> Function(StudentIdCardTarget target) get, required StudentIdCardCache cache})
      : _get = get,
        _cache = cache;

  final Future<Map<String, dynamic>?> Function(StudentIdCardTarget target)? _get;
  final StudentIdCardCache _cache;

  final Dio _privateDio = backendDio(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 60));

  /// Account mode: the active school's plugin account. Private mode: the device-held account, at its catalog stateless path.
  Future<StudentIdCardTarget?> resolveTarget({required bool isPrivate, MySchool? active}) async {
    if (isPrivate) {
      final account = await PrivateAccountStore.instance.load();
      if (account == null || account.accessToken == null || account.statelessBasePath.isEmpty) return null;
      return StudentIdCardTarget.private(account);
    }
    final base = active?.pluginBasePath;
    final accountId = active?.pluginAccountId;
    if (base == null || base.isEmpty || accountId == null || accountId.isEmpty) return null;
    return StudentIdCardTarget.account(path: '$base/accounts/$accountId/student-id-card', accountId: accountId);
  }

  /// The offline copy, for showing something at once.
  Future<StudentIdCard?> cached(StudentIdCardTarget target) => _cache.read(target.cacheKey);

  /// Always asks the backend (which always asks Schulnetz). Keeps the result as the new offline copy; a card the school
  /// no longer offers also drops the old copy.
  Future<StudentIdCard> fetch(StudentIdCardTarget target) async {
    Map<String, dynamic>? data;
    try {
      data = await (_get ?? _send)(target);
    } on DioException catch (e) {
      final failure = StudentIdCardException.fromDio(e, isPrivate: target.isPrivate);
      if (failure.kind == StudentIdCardFailure.notOffered) await _cache.delete(target.cacheKey);
      throw failure;
    }
    final card = data == null ? null : StudentIdCard.fromJson(data);
    if (card == null || card.html.trim().isEmpty) throw const StudentIdCardException(StudentIdCardFailure.unavailable);
    await _cache.write(target.cacheKey, card);
    return card;
  }

  /// Drops every offline copy and its key; on sign-out and when an account is unlinked.
  Future<void> clearCache() => _cache.clear();

  Future<Map<String, dynamic>?> _send(StudentIdCardTarget target) async {
    final options = Options(headers: {'Cache-Control': 'no-cache'});
    final account = target.privateAccount;
    if (account != null) {
      final res = await _privateDio.get<Map<String, dynamic>>(target.path, options: options.copyWith(headers: {...?options.headers, 'X-Plugin-Token': account.accessToken ?? '', 'X-Provider-Base-Url': account.baseUrl}));
      return res.data;
    }
    final res = await ApiClient.instance.dio.get<Map<String, dynamic>>(target.path, options: ApiClient.handled(options));
    return res.data;
  }
}
