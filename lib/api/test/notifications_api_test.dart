import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for NotificationsApi
void main() {
  final instance = SchulyApi().getNotificationsApi();

  group(NotificationsApi, () {
    //Future apiNotificationsDevicesPost(RegisterDeviceTokenCommand registerDeviceTokenCommand) async
    test('test apiNotificationsDevicesPost', () async {
      // TODO
    });

    //Future apiNotificationsDevicesTokenDelete(String token) async
    test('test apiNotificationsDevicesTokenDelete', () async {
      // TODO
    });

    //Future<NotificationPreferencesDto> apiNotificationsPreferencesGet() async
    test('test apiNotificationsPreferencesGet', () async {
      // TODO
    });

    //Future apiNotificationsPreferencesPut(UpdateNotificationPreferencesCommand updateNotificationPreferencesCommand) async
    test('test apiNotificationsPreferencesPut', () async {
      // TODO
    });

  });
}
