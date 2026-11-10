import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/student_id_card_service.dart';
import 'package:schuly/ui/account/student_id_page.dart';
import 'package:schuly/ui/core/theme/schuly_theme.dart';

import 'student_id_card_service_test.dart' show MemoryCardCache;

class _FakeScreen extends StudentIdScreen {
  int entered = 0;
  int left = 0;

  @override
  Future<bool> enter() async {
    entered++;
    return false;
  }

  @override
  Future<void> leave({required bool wasAwake}) async => left++;
}

const _target = StudentIdCardTarget.account(path: '/api/plugins/schulware/accounts/a1/student-id-card', accountId: 'a1');
const _fallback = StudentId(firstName: 'Max', lastName: 'Muster', schoolName: 'Fake School');

Map<String, dynamic> _body(String html, String at) => {'html': html, 'fetchedAt': at, 'source': 'mobile'};

DioException _http(int status, String code) {
  final options = RequestOptions(path: '/x');
  return DioException(requestOptions: options, response: Response(requestOptions: options, statusCode: status, data: {'code': code}));
}

Future<void> _pump(WidgetTester tester, Widget page) {
  tester.view.physicalSize = const Size(800, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  return tester.pumpWidget(
    MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...FLocalizations.localizationsDelegates],
      supportedLocales: AppLocalizations.supportedLocales,
      home: FTheme(data: buildSchulyTheme(Brightness.light, AppAccent.zinc), child: page),
    ),
  );
}

Widget _view(String html) => Text('HTML:$html');

void main() {
  testWidgets('shows the saved card at once, then the fresh one with its date', (tester) async {
    final cache = MemoryCardCache()..cards['account:a1'] = StudentIdCard.fromJson(_body('old', '2026-11-01T07:00:00Z'));
    final reply = Completer<Map<String, dynamic>?>();
    var calls = 0;
    final service = StudentIdCardService.withDeps(get: (_) {
      calls++;
      return reply.future;
    }, cache: cache);

    await _pump(tester, StudentIdPage(service: service, target: _target, screen: _FakeScreen(), cardView: _view, fallback: _fallback));
    await tester.pump();

    expect(find.text('HTML:old'), findsOneWidget);
    expect(find.textContaining('Stand: 01.11.2026'), findsOneWidget);
    expect(calls, 1);

    reply.complete(_body('new', '2026-11-10T07:30:00Z'));
    await tester.pumpAndSettle();

    expect(find.text('HTML:new'), findsOneWidget);
    expect(find.textContaining('Stand: 10.11.2026'), findsOneWidget);
    expect(find.byKey(const ValueKey('student-id-self-built')), findsNothing);
    expect((await cache.read('account:a1'))!.html, 'new');
  });

  testWidgets('pulling down really asks the server again', (tester) async {
    var calls = 0;
    final service = StudentIdCardService.withDeps(get: (_) async {
      calls++;
      return _body('card $calls', '2026-11-10T07:30:00Z');
    }, cache: MemoryCardCache());

    await _pump(tester, StudentIdPage(service: service, target: _target, screen: _FakeScreen(), cardView: _view));
    await tester.pumpAndSettle();
    expect(find.text('HTML:card 1'), findsOneWidget);

    await tester.fling(find.text('Lernendenausweis').first, const Offset(0, 400), 1000);
    await tester.pumpAndSettle();

    expect(calls, 2);
    expect(find.text('HTML:card 2'), findsOneWidget);
  });

  testWidgets('only a school without the card gets the self-built one, labelled as not official', (tester) async {
    final service = StudentIdCardService.withDeps(get: (_) async => throw _http(404, 'not_offered'), cache: MemoryCardCache());

    await _pump(tester, StudentIdPage(service: service, target: _target, screen: _FakeScreen(), cardView: _view, fallback: _fallback));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('student-id-self-built')), findsOneWidget);
    expect(find.text('Nicht der offizielle Lernendenausweis'), findsOneWidget);
    expect(find.byKey(const ValueKey('student-id-official')), findsNothing);
  });

  testWidgets('an expired sign-in keeps showing the saved card, not the self-built one', (tester) async {
    final cache = MemoryCardCache()..cards['account:a1'] = StudentIdCard.fromJson(_body('saved', '2026-11-01T07:00:00Z'));
    final service = StudentIdCardService.withDeps(get: (_) async => throw _http(409, 'signin_expired'), cache: cache);

    await _pump(tester, StudentIdPage(service: service, target: _target, screen: _FakeScreen(), cardView: _view, fallback: _fallback));
    await tester.pumpAndSettle();

    expect(find.text('HTML:saved'), findsOneWidget);
    expect(find.text('Deine Schulanmeldung ist abgelaufen'), findsOneWidget);
    expect(find.byKey(const ValueKey('student-id-self-built')), findsNothing);
  });

  testWidgets('brightness and wake lock are raised while open and restored on exit', (tester) async {
    final screen = _FakeScreen();
    final service = StudentIdCardService.withDeps(get: (_) async => _body('card', '2026-11-10T07:30:00Z'), cache: MemoryCardCache());

    await _pump(tester, StudentIdPage(service: service, target: _target, screen: screen, cardView: _view));
    await tester.pumpAndSettle();
    expect(screen.entered, 1);
    expect(screen.left, 0);

    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    expect(screen.left, 1);
  });
}
