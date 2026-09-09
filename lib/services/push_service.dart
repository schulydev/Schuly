import 'dart:async';

import 'package:flutter/foundation.dart';

import '../config/firebase_config.dart';
import '../ui/dashboard/tab_requests.dart';
import 'app_mode_service.dart';
import 'notification_api.dart';
import 'push_messaging.dart';
import 'toast_service.dart';

enum PushStatus { unavailable, off, denied, on }

/// Owns push enablement, the registered device token and notification
/// preferences. Talks to FCM only through [PushMessaging], so it (and its
/// tests) never touch platform channels - `lib/services/firebase_push.dart`
/// is the only place that wires a real [PushMessaging] in.
class PushService extends ChangeNotifier {
  PushService._() : _api = const NotificationApi(), _supported = FirebaseConfig.isConfigured;

  static final PushService instance = PushService._();

  @visibleForTesting
  PushService.forTest({required PushMessaging messaging, required NotificationApi api, bool supported = true})
    : _api = api,
      _supported = supported;

  final NotificationApi _api;
  final bool _supported;

  PushMessaging? _messaging;
  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<Map<String, dynamic>>? _messageOpenedSub;

  PushStatus _status = PushStatus.unavailable;
  NotificationPreferences _preferences = const NotificationPreferences();
  bool _busy = false;
  String? _registeredToken;

  bool get supported => _supported;
  PushStatus get status => _status;
  NotificationPreferences get preferences => _preferences;
  bool get busy => _busy;

  String get _platform => defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
  String get _locale => PlatformDispatcher.instance.locale.languageCode == 'de' ? 'de' : 'en';

  Future<void> attach(PushMessaging messaging) async {
    if (identical(_messaging, messaging)) return;
    await _tokenRefreshSub?.cancel();
    await _messageOpenedSub?.cancel();
    _messaging = messaging;
    _tokenRefreshSub = messaging.onTokenRefresh.listen(_onTokenRefresh);
    _messageOpenedSub = messaging.onMessageOpenedApp.listen(_handleTap);
    final initial = await messaging.initialMessage();
    if (initial != null) _handleTap(initial);
    if (_supported && _status == PushStatus.unavailable) {
      _status = PushStatus.off;
      notifyListeners();
    }
  }

  Future<void> onSignedIn() async {
    final messaging = _messaging;
    if (messaging == null || !_supported || AppModeService.instance.isPrivate || _busy) return;
    _busy = true;
    notifyListeners();
    try {
      switch (await messaging.permission()) {
        case PushPermission.granted:
          await _registerAndLoad(messaging);
        case PushPermission.denied:
          _status = PushStatus.denied;
        case PushPermission.notDetermined:
          _status = PushStatus.off;
      }
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<bool> enable() async {
    final messaging = _messaging;
    if (messaging == null || !_supported || _busy) return false;
    _busy = true;
    notifyListeners();
    try {
      switch (await messaging.requestPermission()) {
        case PushPermission.granted:
          await _registerAndLoad(messaging);
          return _status == PushStatus.on;
        case PushPermission.denied:
          _status = PushStatus.denied;
          return false;
        case PushPermission.notDetermined:
          _status = PushStatus.off;
          return false;
      }
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> disable() async {
    if (_busy) return;
    _busy = true;
    notifyListeners();
    try {
      final token = _registeredToken;
      if (token != null) {
        try {
          await _api.deleteDevice(token);
        } catch (_) {
          // The backend didn't hear about it, but the device is dropping the
          // token below regardless - it just won't receive pushes any more.
        }
        try {
          await _messaging?.deleteToken();
        } catch (_) {
          // Local cleanup is best-effort too; nothing the user can act on.
        }
        _registeredToken = null;
      }
      _status = PushStatus.off;
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> setPreferences(NotificationPreferences preferences) async {
    final previous = _preferences;
    _preferences = preferences;
    notifyListeners();
    try {
      await _api.putPreferences(preferences);
    } catch (e) {
      _preferences = previous;
      notifyListeners();
      ToastService.error('Could not save notification settings', e);
    }
  }

  Future<void> onSignOut() async {
    final token = _registeredToken;
    if (token != null) {
      try {
        await _api.deleteDevice(token);
      } catch (_) {
        // The session is going away either way; the backend row is stale but harmless.
      }
    }
    _registeredToken = null;
    _preferences = const NotificationPreferences();
    _status = _messaging != null ? PushStatus.off : PushStatus.unavailable;
    notifyListeners();
  }

  Future<void> _registerAndLoad(PushMessaging messaging) async {
    final token = await messaging.getToken();
    if (token == null || !await _registerToken(token)) {
      _status = PushStatus.off;
      return;
    }
    await _loadPreferences();
    _status = PushStatus.on;
  }

  Future<bool> _registerToken(String token) async {
    try {
      await _api.registerDevice(token: token, platform: _platform, locale: _locale);
      _registeredToken = token;
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _loadPreferences() async {
    try {
      _preferences = await _api.getPreferences();
    } catch (_) {
      // Keep whatever preferences are already held; a failed read shouldn't block sign-in.
    }
  }

  void _onTokenRefresh(String token) {
    if (_status != PushStatus.on) return;
    unawaited(_registerToken(token));
  }

  void _handleTap(Map<String, dynamic> data) {
    final tab = TabRequests.tabForType(data['type']?.toString());
    if (tab != null) TabRequests.request(tab);
  }

  @override
  void dispose() {
    _tokenRefreshSub?.cancel();
    _messageOpenedSub?.cancel();
    super.dispose();
  }
}
