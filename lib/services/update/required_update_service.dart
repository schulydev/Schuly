import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../backend_dio.dart';
import 'app_version.dart';
import 'update_service.dart';

/// The header that tells the Schuly server which app version sends a request.
const appVersionHeader = 'X-Schuly-App-Version';

/// The `code` of the server's 426 answer to an app that is too old.
const appUpdateRequiredCode = 'app_update_required';

/// True when [installed] is older than [minimum]. An unknown or unreadable version on either side never blocks.
bool isBelowMinimum(String? installed, String? minimum) {
  final app = AppVersion.tryParse(installed);
  final min = AppVersion.tryParse(minimum);
  return app != null && min != null && app.compareTo(min) < 0;
}

/// The required version when [status] and [body] are the server's "update required" answer (426 with
/// `{code: app_update_required}`), else null. The version is an empty string when the answer names none.
String? requiredVersionOf(int? status, Object? body) {
  if (status != 426 || body is! Map || body['code'] != appUpdateRequiredCode) return null;
  final min = body['minAppVersion'];
  return min is String ? min.trim() : '';
}

/// The oldest app the server still works with, read from `/api/app`, and whether this app is below it. Checked on
/// launch and on resume, and set by any backend answer of 426. A failed check (offline, server down) never blocks.
class RequiredUpdateService extends ChangeNotifier with WidgetsBindingObserver {
  RequiredUpdateService({Future<String?> Function()? fetchMinimum, String Function()? installed, DateTime Function()? clock})
      : _fetchMinimum = fetchMinimum ?? _fetchFromServer,
        _installed = installed ?? (() => UpdateService.instance.installedVersion),
        _now = clock ?? DateTime.now;

  static final RequiredUpdateService instance = RequiredUpdateService();

  /// Least time between two automatic checks; asking again by hand is always allowed.
  static const checkInterval = Duration(minutes: 15);

  final Future<String?> Function() _fetchMinimum;
  final String Function() _installed;
  final DateTime Function() _now;

  DateTime? _lastCheck;
  bool _checking = false;
  bool get checking => _checking;

  String? _required;

  /// The version this app has to be updated to, or null when it may be used.
  String? get requiredVersion => _required;
  bool get blocked => _required != null;

  String get installedVersion => _installed();

  /// The version to send in [appVersionHeader]; empty while the installed version is not known.
  String get headerValue => _installed();

  void start() {
    WidgetsBinding.instance.addObserver(this);
    unawaited(check());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(checkIfDue());
  }

  Future<void> checkIfDue() async {
    final last = _lastCheck;
    if (!blocked && last != null && _now().difference(last) < checkInterval) return;
    await check();
  }

  /// Asks the server for its minimum. Returns whether the app may be used, or null when the server gave no answer:
  /// then the state stays as it was, so being offline neither blocks the app nor lets a blocked one in.
  Future<bool?> check() async {
    if (_checking) return null;
    _checking = true;
    notifyListeners();
    try {
      final String? minimum;
      try {
        minimum = await _fetchMinimum();
      } catch (_) {
        return null;
      }
      _lastCheck = _now();
      _set(isBelowMinimum(_installed(), minimum) ? minimum : null);
      return !blocked;
    } finally {
      _checking = false;
      notifyListeners();
    }
  }

  /// Called with every backend answer: a 426 "update required" blocks the app.
  void report(int? status, Object? body) {
    final min = requiredVersionOf(status, body);
    if (min != null) _set(min);
  }

  void _set(String? required) {
    if (_required == required) return;
    _required = required;
    notifyListeners();
  }

  @visibleForTesting
  void reset() {
    _required = null;
    _lastCheck = null;
  }

  static final Dio _dio = backendDio(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 15));

  static Future<String?> _fetchFromServer() async {
    final app = (await _dio.get<Map<String, dynamic>>('/api/app')).data;
    final min = app?['minAppVersion'];
    return min is String ? min : null;
  }
}
