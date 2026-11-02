import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/auth_service.dart';
import 'package:schuly/services/secure_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Every call throws, like EncryptedSharedPreferences after its Keystore key changed.
class _ThrowingStore implements SecureKeyValue {
  int deleteAllCalls = 0;
  bool healAfterWipe = false;
  final Map<String, String> data = {};

  bool get _broken => !(healAfterWipe && deleteAllCalls > 0);

  Exception get _error => Exception('javax.crypto.AEADBadTagException: Signature/MAC verification failed');

  @override
  Future<String?> read(String key) async => _broken ? throw _error : data[key];

  @override
  Future<void> write(String key, String value) async => _broken ? throw _error : data[key] = value;

  @override
  Future<void> delete(String key) async => _broken ? throw _error : data.remove(key);

  @override
  Future<void> deleteAll() async {
    deleteAllCalls++;
    data.clear();
  }
}

/// Never answers, like a platform channel call that is never completed.
class _HangingStore implements SecureKeyValue {
  int calls = 0;

  Future<T> _never<T>() {
    calls++;
    return Completer<T>().future;
  }

  @override
  Future<String?> read(String key) => _never();

  @override
  Future<void> write(String key, String value) => _never();

  @override
  Future<void> delete(String key) => _never();

  @override
  Future<void> deleteAll() => _never();
}

/// What flutter_secure_storage 9.x answers after resetOnError wiped the store.
class _ResetSentinelStore implements SecureKeyValue {
  @override
  Future<String?> read(String key) async => 'Data has been reset';

  @override
  Future<void> write(String key, String value) async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<void> deleteAll() async {}
}

const _short = Duration(milliseconds: 50);

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('SecureStore with a store that throws', () {
    test('read wipes the store and returns null', () async {
      final store = _ThrowingStore();
      SecureStore.useBackend(store, timeout: _short);

      expect(await SecureStore.read('auth.refresh_token'), isNull);
      expect(store.deleteAllCalls, 1);
      expect(SecureStore.wasReset.value, isTrue);
      expect(SecureStore.unavailable, isFalse);
    });

    test('write succeeds once the wiped store works again', () async {
      final store = _ThrowingStore()..healAfterWipe = true;
      SecureStore.useBackend(store, timeout: _short);

      await SecureStore.write('k', 'v');
      expect(store.data['k'], 'v');
      expect(await SecureStore.read('k'), 'v');
    });

    test('delete never throws', () async {
      SecureStore.useBackend(_ThrowingStore(), timeout: _short);
      await expectLater(SecureStore.delete('k'), completes);
    });
  });

  group('SecureStore with a store that hangs', () {
    test('read gives up after the timeout and later calls skip the store', () async {
      final store = _HangingStore();
      SecureStore.useBackend(store, timeout: _short);

      expect(await SecureStore.read('a'), isNull);
      expect(SecureStore.unavailable, isTrue);
      expect(SecureStore.wasReset.value, isTrue);

      final calls = store.calls;
      final watch = Stopwatch()..start();
      expect(await SecureStore.read('b'), isNull);
      await SecureStore.delete('b');
      expect(store.calls, calls);
      expect(watch.elapsed, lessThan(_short));
    });

    test('writes fall back to memory so sign-in still works', () async {
      SecureStore.useBackend(_HangingStore(), timeout: _short);

      await SecureStore.write('k', 'v');
      expect(await SecureStore.read('k'), 'v');
      await SecureStore.delete('k');
      expect(await SecureStore.read('k'), isNull);
    });
  });

  test('the resetOnError sentinel reads as an empty value', () async {
    SecureStore.useBackend(_ResetSentinelStore(), timeout: _short);
    expect(await SecureStore.read('auth.refresh_token'), isNull);
    expect(SecureStore.wasReset.value, isTrue);
  });

  group('AuthService startup', () {
    test('a throwing store means signed out, not an exception', () async {
      AuthService.resetForTest();
      SecureStore.useBackend(_ThrowingStore(), timeout: _short);

      expect(await AuthService.getAccessToken(), isNull);
      expect(await AuthService.hasSession(), isFalse);
    });

    test('a hanging store means signed out within a few timeouts', () async {
      AuthService.resetForTest();
      SecureStore.useBackend(_HangingStore(), timeout: _short);

      final watch = Stopwatch()..start();
      expect(await AuthService.getAccessToken(), isNull);
      expect(await AuthService.hasSession(), isFalse);
      expect(watch.elapsed, lessThan(const Duration(seconds: 2)));
    });
  });
}
