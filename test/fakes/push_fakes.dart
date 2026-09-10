import 'dart:async';

import 'package:schuly/services/notification_api.dart';
import 'package:schuly/services/push_messaging.dart';
import 'package:schuly_api/schuly_api.dart';

/// A controllable [PushMessaging] fake: permission / token results are set
/// directly on the instance, and refresh / tap events are pushed through the
/// stream controllers.
class FakePushMessaging implements PushMessaging {
  PushPermission permissionResult = PushPermission.notDetermined;
  PushPermission requestPermissionResult = PushPermission.granted;
  String? token = 'initial-token';
  Map<String, dynamic>? initial;
  bool tokenDeleted = false;

  final _tokenRefreshController = StreamController<String>.broadcast();
  final _messageOpenedController = StreamController<Map<String, dynamic>>.broadcast();

  @override
  Future<PushPermission> permission() async => permissionResult;

  @override
  Future<PushPermission> requestPermission() async {
    permissionResult = requestPermissionResult;
    return requestPermissionResult;
  }

  @override
  Future<String?> getToken() async => token;

  @override
  Future<void> deleteToken() async => tokenDeleted = true;

  @override
  Stream<String> get onTokenRefresh => _tokenRefreshController.stream;

  @override
  Stream<Map<String, dynamic>> get onMessageOpenedApp => _messageOpenedController.stream;

  @override
  Future<Map<String, dynamic>?> initialMessage() async => initial;

  void emitTokenRefresh(String newToken) => _tokenRefreshController.add(newToken);

  void emitMessageOpened(Map<String, dynamic> data) => _messageOpenedController.add(data);

  void dispose() {
    _tokenRefreshController.close();
    _messageOpenedController.close();
  }
}

/// A [NotificationApi] fake that records calls and can be told to throw.
class FakeNotificationApi implements NotificationApi {
  NotificationPreferencesDto preferences = NotificationApi.defaults;
  bool throwOnPutPreferences = false;
  bool throwOnRegisterDevice = false;
  bool throwOnDeleteDevice = false;

  String? registeredToken;
  String? registeredPlatform;
  String? registeredLocale;
  final deletedTokens = <String>[];
  final putPreferencesCalls = <NotificationPreferencesDto>[];

  @override
  Future<void> registerDevice({required String token, required String platform, required String locale}) async {
    if (throwOnRegisterDevice) throw Exception('register failed');
    registeredToken = token;
    registeredPlatform = platform;
    registeredLocale = locale;
  }

  @override
  Future<void> deleteDevice(String token) async {
    deletedTokens.add(token);
    if (throwOnDeleteDevice) throw Exception('delete failed');
  }

  @override
  Future<NotificationPreferencesDto> getPreferences() async => preferences;

  @override
  Future<void> putPreferences(NotificationPreferencesDto preferences) async {
    putPreferencesCalls.add(preferences);
    if (throwOnPutPreferences) throw Exception('put failed');
    this.preferences = preferences;
  }
}
