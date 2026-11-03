import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/app_mode_service.dart';
import 'package:schuly/services/privacy_notice_service.dart';
import 'package:schuly/ui/privacy/privacy_notice_screen.dart';

class _FakeBackend implements PrivacyNoticeBackend {
  PrivacyNoticeInfo? account;
  PrivacyNoticeInfo? public;
  bool fail = false;
  final accepted = <(String, bool)>[];

  @override
  Future<PrivacyNoticeInfo?> fetchForAccount() async {
    if (fail) throw Exception('offline');
    return account;
  }

  @override
  Future<void> acceptForAccount(String version, bool swissSchoolConfirmed) async => accepted.add((version, swissSchoolConfirmed));

  @override
  Future<PrivacyNoticeInfo?> fetchPublic() async {
    if (fail) throw Exception('offline');
    return public;
  }
}

const _plain = PrivacyNoticeInfo(version: 'v1', url: kPrivacyPolicyUrl, swissSchoolConfirmationRequired: false);
const _swiss = PrivacyNoticeInfo(version: 'v1', url: kPrivacyPolicyUrl, swissSchoolConfirmationRequired: true);

Widget _wrap(Widget child) => MaterialApp(
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...FLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: FTheme(data: FThemes.zinc.light, child: child),
    );

void main() {
  late _FakeBackend backend;
  late PrivacyNoticeService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AppModeService.instance.setMode(AppMode.account);
    backend = _FakeBackend();
    service = PrivacyNoticeService(backend);
  });

  group('account mode', () {
    test('asks what the server says is open, and records it on the server', () async {
      backend.account = _swiss;
      expect(await service.pending(), _swiss);

      await service.accept(_swiss, swissSchoolConfirmed: true);

      expect(backend.accepted, [('v1', true)]);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(PrivacyNoticeService.versionKey), isNull);
    });

    test('a failed check asks nothing', () async {
      backend.fail = true;
      expect(await service.pending(), isNull);
    });
  });

  group('private mode', () {
    setUp(() => AppModeService.instance.setMode(AppMode.private));

    test('asks once, then records on the device only', () async {
      backend.public = _swiss;
      expect(await service.pending(), _swiss);

      await service.accept(_swiss, swissSchoolConfirmed: true);

      expect(backend.accepted, isEmpty);
      expect(await service.pending(), isNull);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(PrivacyNoticeService.swissConfirmedAtKey), isNotNull);
    });

    test('a server without the Swiss limit records no confirmation', () async {
      backend.public = _plain;
      expect(await service.pending(), _plain);

      await service.accept(_plain, swissSchoolConfirmed: false);

      expect(await service.pending(), isNull);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(PrivacyNoticeService.swissConfirmedAtKey), isNull);
    });

    test('a new policy version asks again', () async {
      backend.public = _plain;
      await service.accept(_plain, swissSchoolConfirmed: false);

      backend.public = const PrivacyNoticeInfo(version: 'v2', url: kPrivacyPolicyUrl, swissSchoolConfirmationRequired: false);
      expect((await service.pending())?.version, 'v2');
    });

    test('turning the Swiss limit on later asks again', () async {
      backend.public = _plain;
      await service.accept(_plain, swissSchoolConfirmed: false);

      backend.public = _swiss;
      expect(await service.pending(), _swiss);
    });

    test('leaving private mode forgets the device record', () async {
      backend.public = _plain;
      await service.accept(_plain, swissSchoolConfirmed: false);

      await PrivacyNoticeService.clearDeviceRecord();

      expect(await service.pending(), _plain);
    });
  });

  group('screen', () {
    testWidgets('names absence reasons and health information, with a policy link', (tester) async {
      await tester.pumpWidget(_wrap(PrivacyNoticeScreen(info: _plain, onAccepted: () {}, onSignOut: () {}, service: service)));
      await tester.pumpAndSettle();

      expect(find.textContaining('Absence reasons can reveal health information'), findsOneWidget);
      expect(find.text('Read the Privacy Policy'), findsOneWidget);
      expect(find.text('I attend a school in Switzerland.'), findsNothing);
    });

    testWidgets('without the Swiss limit Continue records the notice', (tester) async {
      var done = false;
      await tester.pumpWidget(_wrap(PrivacyNoticeScreen(info: _plain, onAccepted: () => done = true, onSignOut: () {}, service: service)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(done, isTrue);
      expect(backend.accepted, [('v1', false)]);
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('with the Swiss limit Continue waits for the tick', (tester) async {
      var done = false;
      await tester.pumpWidget(_wrap(PrivacyNoticeScreen(info: _swiss, onAccepted: () => done = true, onSignOut: () {}, service: service)));
      await tester.pumpAndSettle();
      expect(find.text('I attend a school in Switzerland.'), findsOneWidget);

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(done, isFalse);

      await tester.tap(find.text('I attend a school in Switzerland.'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(done, isTrue);
      expect(backend.accepted, [('v1', true)]);
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('private mode says requests pass through the server without being stored', (tester) async {
      await AppModeService.instance.setMode(AppMode.private);
      await tester.pumpWidget(_wrap(PrivacyNoticeScreen(info: _plain, onAccepted: () {}, onSignOut: () {}, service: service)));
      await tester.pumpAndSettle();

      expect(find.textContaining('pass through the Schuly server without being stored'), findsOneWidget);
    });
  });
}
