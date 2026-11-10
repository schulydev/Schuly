import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/domain/my_school.dart';
import 'package:schuly/services/private_account_store.dart';
import 'package:schuly/services/secure_store.dart';
import 'package:schuly/services/student_id_card_service.dart';
import 'package:schuly/ui/account/student_id_page.dart';

class _MapStore implements SecureKeyValue {
  final Map<String, String> values = {};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);

  @override
  Future<void> deleteAll() async => values.clear();
}

class MemoryCardCache implements StudentIdCardCache {
  final Map<String, StudentIdCard> cards = {};

  @override
  Future<StudentIdCard?> read(String key) async => cards[key];

  @override
  Future<void> write(String key, StudentIdCard card) async => cards[key] = card;

  @override
  Future<void> delete(String key) async => cards.remove(key);

  @override
  Future<void> clear() async => cards.clear();
}

const _html = '<div style="position:absolute"><img src="data:image/png;base64,QR-FAKE"></div>';
const _account = StudentIdCardTarget.account(path: '/api/plugins/schulware/accounts/a1/student-id-card', accountId: 'a1');

Map<String, dynamic> _body([String html = _html]) => {'html': html, 'fetchedAt': '2026-11-10T08:30:00Z', 'source': 'mobile'};

DioException _http(int status, [Object? data]) {
  final options = RequestOptions(path: '/x');
  return DioException(requestOptions: options, response: Response(requestOptions: options, statusCode: status, data: data));
}

void main() {
  group('StudentIdCardService', () {
    test('a fetched card becomes the offline copy of that account', () async {
      final cache = MemoryCardCache();
      final service = StudentIdCardService.withDeps(get: (_) async => _body(), cache: cache);

      final card = await service.fetch(_account);

      expect(card.html, _html);
      expect(card.source, 'mobile');
      expect((await service.cached(_account))!.html, _html);
      expect(cache.cards.keys, ['account:a1']);
    });

    test('not offered drops the old copy', () async {
      final cache = MemoryCardCache()..cards['account:a1'] = StudentIdCard.fromJson(_body());
      final service = StudentIdCardService.withDeps(get: (_) async => throw _http(404, {'code': 'not_offered'}), cache: cache);

      await expectLater(service.fetch(_account), throwsA(isA<StudentIdCardException>().having((e) => e.kind, 'kind', StudentIdCardFailure.notOffered)));
      expect(cache.cards, isEmpty);
    });

    test('an expired sign-in keeps the copy to show', () async {
      final cache = MemoryCardCache()..cards['account:a1'] = StudentIdCard.fromJson(_body());
      final service = StudentIdCardService.withDeps(get: (_) async => throw _http(409, {'code': 'signin_expired'}), cache: cache);

      await expectLater(service.fetch(_account), throwsA(isA<StudentIdCardException>().having((e) => e.kind, 'kind', StudentIdCardFailure.signInExpired)));
      expect(cache.cards, isNotEmpty);
    });

    test('errors map to what the page shows', () {
      expect(StudentIdCardException.fromDio(_http(404), isPrivate: false).kind, StudentIdCardFailure.notOffered);
      expect(StudentIdCardException.fromDio(_http(502, {'code': 'school_unavailable'}), isPrivate: false).kind, StudentIdCardFailure.unavailable);
      expect(StudentIdCardException.fromDio(_http(401), isPrivate: true).kind, StudentIdCardFailure.notOffered);
      expect(StudentIdCardException.fromDio(_http(401), isPrivate: false).kind, StudentIdCardFailure.unavailable);
      final offline = DioException(requestOptions: RequestOptions(path: '/x'), type: DioExceptionType.connectionError);
      expect(StudentIdCardException.fromDio(offline, isPrivate: false).kind, StudentIdCardFailure.unavailable);
    });

    test('an empty card is not kept', () async {
      final cache = MemoryCardCache();
      final service = StudentIdCardService.withDeps(get: (_) async => _body(' '), cache: cache);

      await expectLater(service.fetch(_account), throwsA(isA<StudentIdCardException>()));
      expect(cache.cards, isEmpty);
    });

    test('targets: the active school account, or the private account at its catalog path', () async {
      final service = StudentIdCardService.withDeps(get: (_) async => null, cache: MemoryCardCache());
      const school = MySchool(id: 's1', name: 'BBB', provider: 'schulware', pluginBasePath: '/api/plugins/schulware', pluginAccountId: 'acc-1');

      final target = await service.resolveTarget(isPrivate: false, active: school);

      expect(target!.path, '/api/plugins/schulware/accounts/acc-1/student-id-card');
      expect(target.cacheKey, 'account:acc-1');
      expect(await service.resolveTarget(isPrivate: false, active: const MySchool(id: 's2', name: 'X', provider: '')), isNull);

      final private = StudentIdCardTarget.private(const PrivateAccount(systemKey: 'schulnetz', loginMethod: 'oauth-webview', baseUrl: 'https://schulnetz.example.ch', displayName: 'X', statelessBasePath: '/api/plugins/schulware/stateless', accessToken: 'fake'));
      expect(private.path, '/api/plugins/schulware/stateless/student-id-card');
      expect(private.isPrivate, isTrue);
    });
  });

  group('EncryptedFileStudentIdCardCache', () {
    late Directory dir;
    late _MapStore store;
    late EncryptedFileStudentIdCardCache cache;

    setUp(() async {
      store = _MapStore();
      SecureStore.useBackend(store);
      dir = await Directory.systemTemp.createTemp('student_id_card_test');
      cache = EncryptedFileStudentIdCardCache(directory: () async => Directory('${dir.path}/cards'));
    });

    tearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });

    test('round-trips per account and never writes the card in clear', () async {
      await cache.write('account:a1', StudentIdCard.fromJson(_body()));
      await cache.write('account:a2', StudentIdCard.fromJson(_body('<p>other</p>')));

      expect((await cache.read('account:a1'))!.html, _html);
      expect((await cache.read('account:a2'))!.html, '<p>other</p>');
      final files = Directory('${dir.path}/cards').listSync().whereType<File>().toList();
      expect(files, hasLength(2));
      for (final f in files) {
        expect(latin1.decode(f.readAsBytesSync()).contains('QR-FAKE'), isFalse);
        expect(f.path.contains('a1'), isFalse);
      }
      expect(store.values.keys, ['student_id_card.key']);
    });

    test('clear removes every copy and the key', () async {
      await cache.write('account:a1', StudentIdCard.fromJson(_body()));

      await cache.clear();

      expect(await Directory('${dir.path}/cards').exists(), isFalse);
      expect(store.values, isEmpty);
      expect(await cache.read('account:a1'), isNull);
    });

    test('a copy whose key is gone is dropped instead of failing', () async {
      await cache.write('account:a1', StudentIdCard.fromJson(_body()));
      store.values.clear();

      expect(await cache.read('account:a1'), isNull);
      expect(Directory('${dir.path}/cards').listSync(), isEmpty);
    });
  });

  test('the card WebView only allows data: and about: navigation', () {
    expect(studentIdCardAllowsNavigation('about:blank'), isTrue);
    expect(studentIdCardAllowsNavigation('data:text/html;base64,AAAA'), isTrue);
    expect(studentIdCardAllowsNavigation('https://schulnetz.example.ch'), isFalse);
    expect(studentIdCardAllowsNavigation('http://evil.example'), isFalse);
    expect(studentIdCardAllowsNavigation('javascript:alert(1)'), isFalse);
    expect(studentIdCardAllowsNavigation('file:///etc/passwd'), isFalse);
    expect(studentIdCardAllowsNavigation('intent://x'), isFalse);
  });
}
