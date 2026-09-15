import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/domain/my_school.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/active_account_service.dart';
import 'package:schuly/ui/account/account_page.dart';

Future<void> _pump(WidgetTester tester, Widget child) => tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          ...FLocalizations.localizationsDelegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: FTheme(
          data: FThemes.zinc.light,
          child: FScaffold(child: child),
        ),
      ),
    );

void main() {
  group('AccountPage', () {
    testWidgets('reloads version and sync status once plugin info arrives', (tester) async {
      final service = ActiveAccountService.forTest();
      final calls = <String>[];
      Future<Map<String, dynamic>?> fetchJson(String path) async {
        calls.add(path);
        if (path.endsWith('/status')) return {'version': '2.5.0'};
        return {
          'lastSync': DateTime(2026, 9, 15, 10).toIso8601String(),
          'syncStatus': 'Success',
          'syncError': null,
        };
      }

      // Mirrors the cold-start race: the page is built while the active
      // school has no plugin info yet, because ActiveAccountService.refresh()
      // (and its plugin detection) hasn't finished.
      service.setSchoolsForTest(const [MySchool(id: 's-1', name: 'School')], activeId: 's-1');

      await _pump(
        tester,
        AccountPage(
          pictureUrl: null,
          userName: 'Ada',
          onSignOut: () {},
          accountService: service,
          fetchJson: fetchJson,
        ),
      );
      await tester.pumpAndSettle();

      expect(calls, isEmpty);
      expect(find.text('Never'), findsOneWidget);

      // Plugin detection finishes and the service notifies - the page should
      // now fetch and render the version and sync status.
      service.setSchoolsForTest(
        const [
          MySchool(
            id: 's-1',
            name: 'School',
            pluginBasePath: '/api/plugins/schulware',
            pluginAccountId: 'acc-1',
          ),
        ],
        activeId: 's-1',
      );

      await tester.pumpAndSettle();

      expect(calls, containsAll(['/api/plugins/schulware/status', '/api/plugins/schulware/accounts/acc-1/sync']));
      expect(find.text('2.5.0'), findsOneWidget);
      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Never'), findsNothing);
    });

    testWidgets('re-fetches when the account tab becomes visible with nothing loaded', (tester) async {
      // Plugin info is present from the start, but the fetch itself fails the
      // first time (a transient network hiccup) - the page's initState
      // attempt swallows the error and both values stay null, with no
      // ActiveAccountService change to trigger a retry via the listener.
      final service = ActiveAccountService.forTest();
      service.setSchoolsForTest(
        const [
          MySchool(
            id: 's-1',
            name: 'School',
            pluginBasePath: '/api/plugins/schulware',
            pluginAccountId: 'acc-1',
          ),
        ],
        activeId: 's-1',
      );

      var fail = true;
      Future<Map<String, dynamic>?> fetchJson(String path) async {
        if (fail) throw Exception('transient network error');
        if (path.endsWith('/status')) return {'version': '2.5.0'};
        return {'lastSync': null, 'syncStatus': 'Success', 'syncError': null};
      }

      await _pump(
        tester,
        AccountPage(
          pictureUrl: null,
          userName: 'Ada',
          onSignOut: () {},
          visible: false,
          accountService: service,
          fetchJson: fetchJson,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('2.5.0'), findsNothing);

      fail = false;

      // The user switches to the Account tab: the page becomes visible while
      // still empty, so the didUpdateWidget fallback should retry the fetch.
      await _pump(
        tester,
        AccountPage(
          pictureUrl: null,
          userName: 'Ada',
          onSignOut: () {},
          visible: true,
          accountService: service,
          fetchJson: fetchJson,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2.5.0'), findsOneWidget);
      expect(find.text('Success'), findsOneWidget);
    });
  });
}
