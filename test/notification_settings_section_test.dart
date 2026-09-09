import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/push_messaging.dart';
import 'package:schuly/services/push_service.dart';
import 'package:schuly/ui/settings/notification_settings_section.dart';

import 'fakes/push_fakes.dart';

Future<void> _pump(WidgetTester tester, PushService service) => tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          ...FLocalizations.localizationsDelegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: FTheme(
          data: FThemes.zinc.light,
          child: FScaffold(
            child: ListView(children: [NotificationSettingsSection(service: service)]),
          ),
        ),
      ),
    );

void main() {
  group('NotificationSettingsSection', () {
    testWidgets('an unsupported service shows the unavailable subtitle and no per-type tiles', (tester) async {
      final service = PushService.forTest(messaging: FakePushMessaging(), api: FakeNotificationApi(), supported: false);

      await _pump(tester, service);
      await tester.pumpAndSettle();

      expect(find.text('Push notifications'), findsOneWidget);
      expect(find.text('Not available in this build'), findsOneWidget);
      expect(find.text('Grades'), findsNothing);
      expect(find.text('Absences'), findsNothing);
      expect(find.text('Agenda'), findsNothing);
      expect(find.text('Show the grade'), findsNothing);
    });

    testWidgets('a service that is on shows the four per-type tiles', (tester) async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);
      await service.onSignedIn();

      await _pump(tester, service);
      await tester.pumpAndSettle();

      expect(service.status, PushStatus.on);
      expect(find.text('Grades'), findsOneWidget);
      expect(find.text('Absences'), findsOneWidget);
      expect(find.text('Agenda'), findsOneWidget);
      expect(find.text('Show the grade'), findsOneWidget);
    });

    testWidgets('tapping the grades switch calls putPreferences with grades: false', (tester) async {
      final messaging = FakePushMessaging()..permissionResult = PushPermission.granted;
      final api = FakeNotificationApi();
      final service = PushService.forTest(messaging: messaging, api: api);
      await service.attach(messaging);
      await service.onSignedIn();

      await _pump(tester, service);
      await tester.pumpAndSettle();

      final gradesSwitch = find.descendant(
        of: find.ancestor(of: find.text('Grades'), matching: find.byType(FTile)),
        matching: find.byType(FSwitch),
      );
      expect(gradesSwitch, findsOneWidget);
      await tester.tap(gradesSwitch);
      await tester.pumpAndSettle();

      expect(api.putPreferencesCalls, isNotEmpty);
      expect(api.putPreferencesCalls.last.grades, isFalse);
    });
  });
}
