enum PushPermission { notDetermined, denied, granted }

/// The slice of FCM that [PushService] needs, behind an interface so the service
/// can be unit-tested without the plugin's platform channels.
abstract class PushMessaging {
  Future<PushPermission> permission();
  Future<PushPermission> requestPermission();
  Future<String?> getToken();
  Future<void> deleteToken();
  Stream<String> get onTokenRefresh;
  Stream<Map<String, dynamic>> get onMessageOpenedApp;
  Future<Map<String, dynamic>?> initialMessage();
}
