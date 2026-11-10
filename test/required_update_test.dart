import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/update/required_update_service.dart';
import 'package:schuly/ui/update/required_update_screen.dart';

RequiredUpdateService _service({String installed = '3.5.0', Future<String?> Function()? fetch, DateTime Function()? clock}) =>
    RequiredUpdateService(installed: () => installed, fetchMinimum: fetch ?? () async => null, clock: clock);

void main() {
  group('isBelowMinimum', () {
    test('an older app is below the minimum', () {
      expect(isBelowMinimum('3.5.0', '3.6.0'), isTrue);
      expect(isBelowMinimum('3.4.9', '3.5.0'), isTrue);
      expect(isBelowMinimum('2.9.9', '3.0.0'), isTrue);
    });

    test('the same or a newer app is not', () {
      expect(isBelowMinimum('3.6.0', '3.6.0'), isFalse);
      expect(isBelowMinimum('3.7.0', '3.6.0'), isFalse);
      expect(isBelowMinimum('3.5.0-DEV', '3.5.0'), isFalse);
      expect(isBelowMinimum('3.5.0+12', '3.5.0'), isFalse);
    });

    test('"0.0.0" turns the check off', () => expect(isBelowMinimum('0.1.0', '0.0.0'), isFalse));

    test('an unknown or unreadable version never blocks', () {
      expect(isBelowMinimum('', '3.6.0'), isFalse);
      expect(isBelowMinimum(null, '3.6.0'), isFalse);
      expect(isBelowMinimum('3.5.0', null), isFalse);
      expect(isBelowMinimum('3.5.0', ''), isFalse);
      expect(isBelowMinimum('3.5.0', 'latest'), isFalse);
    });
  });

  group('requiredVersionOf', () {
    test('reads the server\'s 426 answer', () {
      expect(requiredVersionOf(426, {'code': 'app_update_required', 'minAppVersion': '3.6.0', 'message': 'too old'}), '3.6.0');
      expect(requiredVersionOf(426, {'code': 'app_update_required'}), '');
    });

    test('ignores everything else', () {
      expect(requiredVersionOf(426, {'code': 'something_else'}), isNull);
      expect(requiredVersionOf(426, 'Upgrade Required'), isNull);
      expect(requiredVersionOf(426, null), isNull);
      expect(requiredVersionOf(400, {'code': 'app_update_required', 'minAppVersion': '3.6.0'}), isNull);
      expect(requiredVersionOf(null, null), isNull);
    });
  });

  group('RequiredUpdateService', () {
    test('blocks when the server needs a newer app', () async {
      final svc = _service(fetch: () async => '3.6.0');
      expect(await svc.check(), isFalse);
      expect(svc.blocked, isTrue);
      expect(svc.requiredVersion, '3.6.0');
    });

    test('lets the app in when it is new enough or the server names no minimum', () async {
      expect(await _service(fetch: () async => '3.5.0').check(), isTrue);
      expect(await _service(fetch: () async => null).check(), isTrue);
    });

    test('a failed check does not block, and does not unblock either', () async {
      var fail = true;
      final svc = _service(fetch: () async => fail ? throw Exception('offline') : '3.6.0');
      expect(await svc.check(), isNull);
      expect(svc.blocked, isFalse);

      fail = false;
      await svc.check();
      expect(svc.blocked, isTrue);
      fail = true;
      expect(await svc.check(), isNull);
      expect(svc.blocked, isTrue);
    });

    test('a 426 answer blocks, and a good check lets the app in again', () async {
      final svc = _service(fetch: () async => '3.5.0');
      svc.report(200, {'code': 'app_update_required'});
      expect(svc.blocked, isFalse);
      svc.report(426, {'code': 'app_update_required', 'minAppVersion': '3.6.0'});
      expect(svc.requiredVersion, '3.6.0');
      expect(await svc.check(), isTrue);
      expect(svc.blocked, isFalse);
    });

    test('checks on resume at most every 15 minutes, unless blocked', () async {
      var now = DateTime(2026, 11, 10, 9);
      var calls = 0;
      var minimum = '3.5.0';
      final svc = _service(fetch: () async {
        calls++;
        return minimum;
      }, clock: () => now);
      await svc.checkIfDue();
      await svc.checkIfDue();
      expect(calls, 1);
      now = now.add(const Duration(minutes: 16));
      minimum = '3.6.0';
      await svc.checkIfDue();
      expect(calls, 2);
      expect(svc.blocked, isTrue);
      await svc.checkIfDue();
      expect(calls, 3);
    });
  });

  testWidgets('the gate replaces the app while blocked', (tester) async {
    final svc = _service();
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...FLocalizations.localizationsDelegates],
      supportedLocales: AppLocalizations.supportedLocales,
      home: FTheme(data: FThemes.zinc.light, child: RequiredUpdateGate(service: svc, child: const Text('the app'))),
    ));
    expect(find.text('the app'), findsOneWidget);

    svc.report(426, {'code': 'app_update_required', 'minAppVersion': '3.6.0'});
    await tester.pumpAndSettle();
    expect(find.text('the app'), findsNothing);
    expect(find.text('Bitte aktualisiere Schuly'), findsOneWidget);
    expect(find.text('3.6.0 oder neuer'), findsOneWidget);
    expect(find.text('Aktualisieren'), findsOneWidget);
    expect(find.text('Erneut prüfen'), findsOneWidget);

    // The system back is swallowed, so it neither closes the app nor leaves the screen.
    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Bitte aktualisiere Schuly'), findsOneWidget);
  });
}
