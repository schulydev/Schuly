import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../config/firebase_config.dart';
import 'push_messaging.dart';
import 'push_service.dart';

/// Registered with `FirebaseMessaging.onBackgroundMessage`. The system tray
/// already shows the notification for a background/terminated message, so
/// this isolate has nothing left to do - it only needs to exist so FCM has a
/// handler to call.
@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {}

class _FirebasePushMessaging implements PushMessaging {
  final _messaging = FirebaseMessaging.instance;

  @override
  Future<PushPermission> permission() async => _map(await _messaging.getNotificationSettings());

  @override
  Future<PushPermission> requestPermission() async => _map(await _messaging.requestPermission());

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  Future<void> deleteToken() => _messaging.deleteToken();

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  @override
  Stream<Map<String, dynamic>> get onMessageOpenedApp => FirebaseMessaging.onMessageOpenedApp.map((message) => message.data);

  @override
  Future<Map<String, dynamic>?> initialMessage() async => (await _messaging.getInitialMessage())?.data;

  PushPermission _map(NotificationSettings settings) => switch (settings.authorizationStatus) {
    AuthorizationStatus.authorized || AuthorizationStatus.provisional => PushPermission.granted,
    AuthorizationStatus.denied || AuthorizationStatus.deniedPermanently => PushPermission.denied,
    AuthorizationStatus.notDetermined => PushPermission.notDetermined,
  };
}

/// Called from `main()` after the first frame. Does nothing when the
/// `FIREBASE_*` dart-defines are missing, and a failed `initializeApp` leaves
/// push unavailable rather than crashing the app.
Future<void> startPush() async {
  if (!FirebaseConfig.isConfigured) return;
  try {
    await Firebase.initializeApp(options: FirebaseConfig.options);
  } catch (_) {
    return;
  }
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  await PushService.instance.attach(_FirebasePushMessaging());
}
