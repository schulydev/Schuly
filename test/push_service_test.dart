import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/push_messaging.dart';
import 'package:schuly/services/push_service.dart';
import 'package:schuly/ui/dashboard/tab_requests.dart';
import 'package:schuly_api/schuly_api.dart';

import 'fakes/push_fakes.dart';

void main() {
  // A failed preferences save toasts, and ToastService reaches for the root
  // navigator's context - which needs a binding even in a pure unit test.
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TabRequests.pending.value = null;
  });

  group('PushService.onSignedIn', () {
    test('registers the device token and loads preferences when permission is granted', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi()
        ..preferences = NotificationPreferencesDto((b) => b
          ..grades = false
          ..absences = true
          ..agenda = true
          ..includeGradeValue = false);
      final service = PushService.forTest(messaging: messaging, api: api);

      await service.attach(messaging);
      await service.onSignedIn();

      expect(service.status, PushStatus.on);
      expect(api.registeredToken, 'initial-token');
      expect(service.preferences.grades, isFalse);
    });

    test('does not register when permission is denied', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.denied;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);

      await service.attach(messaging);
      await service.onSignedIn();

      expect(service.status, PushStatus.denied);
      expect(api.registeredToken, isNull);
    });

    test('leaves status off and does not register when permission is not determined', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.notDetermined;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);

      await service.attach(messaging);
      await service.onSignedIn();

      expect(service.status, PushStatus.off);
      expect(api.registeredToken, isNull);
    });
  });

  group('PushService.enable', () {
    test('registers and turns status on when permission is granted', () async {
      final messaging = FakePushMessaging()
        ..permissionResult = PushPermission.notDetermined
        ..requestPermissionResult = PushPermission.granted;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);

      final result = await service.enable();

      expect(result, isTrue);
      expect(service.status, PushStatus.on);
      expect(api.registeredToken, 'initial-token');
    });

    test('returns false and reports denied when permission is refused', () async {
      final messaging = FakePushMessaging()
        ..permissionResult = PushPermission.notDetermined
        ..requestPermissionResult = PushPermission.denied;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);

      final result = await service.enable();

      expect(result, isFalse);
      expect(service.status, PushStatus.denied);
    });
  });

  group('PushService.disable', () {
    test('deletes the registered device, then the local token, and goes off', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);
      await service.onSignedIn();

      await service.disable();

      expect(api.deletedTokens, ['initial-token']);
      expect(messaging.tokenDeleted, isTrue);
      expect(service.status, PushStatus.off);
    });
  });

  test('a token refresh while on re-registers with the new token', () async {
    final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
    final api = FakeNotificationApi();
    final service = PushService.forTest(messaging: messaging, api: api);
    await service.attach(messaging);
    await service.onSignedIn();

    messaging.emitTokenRefresh('refreshed-token');
    await pumpEventQueue();

    expect(api.registeredToken, 'refreshed-token');
  });

  group('PushService.setPreferences', () {
    test('updates optimistically and keeps the value when the api call succeeds', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);
      await service.onSignedIn();

      final before = service.preferences;
      await service.setPreferences(before.rebuild((b) => b..grades = !before.grades));

      expect(service.preferences.grades, !before.grades);
      expect(api.putPreferencesCalls, isNotEmpty);
    });

    test('reverts the value when the api call throws', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);
      await service.onSignedIn();

      final before = service.preferences;
      api.throwOnPutPreferences = true;
      final future = service.setPreferences(before.rebuild((b) => b..grades = !before.grades));
      expect(service.preferences.grades, !before.grades);
      await future;

      expect(service.preferences.grades, before.grades);
    });
  });

  group('PushService.onSignOut', () {
    test('deletes the device from the backend', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);
      await service.onSignedIn();

      await service.onSignOut();

      expect(api.deletedTokens, contains('initial-token'));
    });

    test('does not throw when the api call fails', () async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi()..throwOnDeleteDevice = true;
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);
      await service.onSignedIn();

      await expectLater(service.onSignOut(), completes);
    });
  });

  test('a tapped grade message requests the grades dashboard tab', () async {
    final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
    final api = FakeNotificationApi();
    final service = PushService.forTest(messaging: messaging, api: api);
    await service.attach(messaging);
    await service.onSignedIn();

    messaging.emitMessageOpened({'type': 'grade'});
    await pumpEventQueue();

    expect(TabRequests.pending.value, DashboardTab.grades);
  });
}
