import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The raw key/value calls [SecureStore] makes. Swapped for a fake in tests.
abstract class SecureKeyValue {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
  Future<void> deleteAll();
}

class _PlatformSecureKeyValue implements SecureKeyValue {
  const _PlatformSecureKeyValue();

  // resetOnError: when the encrypted prefs no longer match their Keystore key
  // (reinstall, backup restore, key change) the plugin wipes them instead of
  // failing every call.
  static const _storage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true, resetOnError: true));

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();
}

/// The one way the app touches the platform keystore. Every call is bounded by
/// [timeout], and a store that throws is wiped and treated as empty, so a
/// corrupted keystore costs the user a sign-in instead of a dead app.
///
/// When the store does not answer at all, it is marked unavailable for the rest
/// of the session and an in-memory map stands in, so sign-in still works.
class SecureStore {
  SecureStore._();

  static SecureKeyValue _backend = const _PlatformSecureKeyValue();

  /// How long one keystore call may take before it counts as hung.
  static Duration timeout = const Duration(seconds: 5);

  /// Set once the store had to be wiped or abandoned this session; RootScreen
  /// turns it into the "Please sign in again" notice.
  static final ValueNotifier<bool> wasReset = ValueNotifier<bool>(false);

  /// What flutter_secure_storage 9.x returns from `read` after resetOnError wiped the store.
  static const _resetSentinel = 'Data has been reset';

  static bool _unavailable = false;
  static final Map<String, String> _memory = {};

  @visibleForTesting
  static void useBackend(SecureKeyValue backend, {Duration timeout = const Duration(seconds: 5)}) {
    _backend = backend;
    SecureStore.timeout = timeout;
    _unavailable = false;
    _memory.clear();
    wasReset.value = false;
  }

  @visibleForTesting
  static bool get unavailable => _unavailable;

  static Future<String?> read(String key) async {
    if (_unavailable) return _memory[key];
    try {
      final value = await _backend.read(key).timeout(timeout);
      if (value == _resetSentinel) {
        _markReset('read', 'the plugin reset the store');
        return null;
      }
      return value;
    } catch (e) {
      await _recover('read', e);
      return _unavailable ? _memory[key] : null;
    }
  }

  static Future<void> write(String key, String value) async {
    if (_unavailable) {
      _memory[key] = value;
      return;
    }
    try {
      await _backend.write(key, value).timeout(timeout);
      return;
    } catch (e) {
      await _recover('write', e);
    }
    if (_unavailable) {
      _memory[key] = value;
      return;
    }
    // The store was wiped and answers again: one retry, then let the caller see the failure.
    await _backend.write(key, value).timeout(timeout);
  }

  static Future<void> delete(String key) async {
    _memory.remove(key);
    if (_unavailable) return;
    try {
      await _backend.delete(key).timeout(timeout);
    } catch (e) {
      await _recover('delete', e);
    }
  }

  /// A thrown error means the stored data cannot be decrypted: wipe it. A
  /// timeout means the keystore is not answering: stop calling it this session.
  static Future<void> _recover(String op, Object error) async {
    if (error is TimeoutException) {
      _unavailable = true;
      _markReset(op, 'no answer within $timeout');
      return;
    }
    _markReset(op, error);
    try {
      await _backend.deleteAll().timeout(timeout);
    } catch (e) {
      debugPrint('SecureStore: wiping the store failed too ($e); using memory for this session');
      _unavailable = true;
    }
  }

  static void _markReset(String op, Object reason) {
    debugPrint('SecureStore: $op failed ($reason); secure storage was reset');
    wasReset.value = true;
  }
}
