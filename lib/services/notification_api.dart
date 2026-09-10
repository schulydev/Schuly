import 'package:schuly_api/schuly_api.dart';

import 'api_client.dart';

const _handled = <String, dynamic>{ApiClient.handlesErrors: true};

/// Typed seam over the generated [NotificationsApi] so [PushService] (and its
/// tests) can depend on a small interface instead of the full generated
/// client.
class NotificationApi {
  const NotificationApi();

  /// Default preferences used before the server has ever been asked, and as
  /// the fallback after sign-out.
  static final NotificationPreferencesDto defaults = NotificationPreferencesDto(
    (b) => b
      ..grades = true
      ..absences = true
      ..agenda = true
      ..includeGradeValue = false,
  );

  Future<void> registerDevice({required String token, required String platform, required String locale}) async {
    await ApiClient.instance.api.getNotificationsApi().apiNotificationsDevicesPost(
      registerDeviceTokenCommand: RegisterDeviceTokenCommand((b) => b
        ..token = token
        ..platform = platform
        ..locale = locale),
      extra: _handled,
    );
  }

  Future<void> deleteDevice(String token) async {
    await ApiClient.instance.api.getNotificationsApi().apiNotificationsDevicesTokenDelete(token: token, extra: _handled);
  }

  Future<NotificationPreferencesDto> getPreferences() async {
    final res = await ApiClient.instance.api.getNotificationsApi().apiNotificationsPreferencesGet(extra: _handled);
    final data = res.data;
    if (data == null) throw StateError('Notification preferences response had no body');
    return data;
  }

  Future<void> putPreferences(NotificationPreferencesDto preferences) async {
    await ApiClient.instance.api.getNotificationsApi().apiNotificationsPreferencesPut(
      updateNotificationPreferencesCommand: UpdateNotificationPreferencesCommand((b) => b
        ..grades = preferences.grades
        ..absences = preferences.absences
        ..agenda = preferences.agenda
        ..includeGradeValue = preferences.includeGradeValue),
      extra: _handled,
    );
  }
}
