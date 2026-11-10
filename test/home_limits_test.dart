import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/school_data_service.dart';
import 'package:schuly/services/secure_store.dart';
import 'package:schuly/ui/core/theme/schuly_theme.dart';
import 'package:schuly/ui/core/ui/kit.dart';
import 'package:schuly/ui/home/home_page.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _EmptyStore implements SecureKeyValue {
  @override
  Future<String?> read(String key) async => null;

  @override
  Future<void> write(String key, String value) async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<void> deleteAll() async {}
}

/// Hard rule: every list on Home shows at most three items.
void main() {
  final now = DateTime.now();
  final exams = [
    for (var i = 0; i < 5; i++)
      ExamDto((b) => b
        ..id = 'e$i'
        ..name = 'Exam $i'
        ..classAverage = 4.5
        ..date = Date(now.year, now.month, 1 + i)),
  ];
  final me = SchoolUserDto((b) => b
    ..id = 'me'
    ..firstName = 'Mia'
    ..lastName = 'Muster'
    ..email = 'mia@example.ch'
    ..role = Roles.student
    ..grades.addAll([
      for (var i = 0; i < 5; i++)
        GradeDto((g) => g
          ..id = 'g$i'
          ..score = 5
          ..examId = 'e$i'),
    ]));
  final absences = [
    for (var i = 0; i < 5; i++)
      AbsenceDto((b) => b
        ..id = 'a$i'
        ..reason = 'Reason $i'
        ..type = AbsenceType.absence
        ..isExcused = false
        ..from = now.subtract(Duration(days: 10 + i))
        ..until = now.subtract(Duration(days: 10 + i))),
  ];
  final upcoming = [
    for (var i = 0; i < 5; i++)
      AgendaEntryDto((b) => b
        ..id = 't$i'
        ..entryType = AgendaEntryType.test
        ..title = 'Test $i'
        ..date = DateTime(now.year, now.month, now.day + 2 + i, 10)),
  ];

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SecureStore.useBackend(_EmptyStore());
    SchoolDataService.instance.clear();
  });
  tearDown(SchoolDataService.instance.clear);

  test('the limit is three', () => expect(kHomeMaxItems, 3));

  test('new grades and coming up take at most three, newest grades and nearest dates first', () {
    SchoolDataService.instance.setForTest(me: me, exams: exams, agenda: upcoming);
    final grades = latestGradedExams(SchoolDataService.instance);
    expect(grades.map((e) => e.name), ['Exam 4', 'Exam 3', 'Exam 2']);
    expect(comingUp(upcoming, now).map((a) => a.title), ['Test 0', 'Test 1', 'Test 2']);
  });

  testWidgets('home shows three of five grades, unexcused absences and upcoming tests', (tester) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SchoolDataService.instance.setForTest(me: me, exams: exams, absences: absences, agenda: upcoming);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...FLocalizations.localizationsDelegates],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => FTheme(data: buildSchulyTheme(Brightness.dark, AppAccent.zinc), child: FToaster(child: child!)),
      home: const Material(child: HomePage()),
    ));
    await tester.pump();

    expect(find.textContaining(RegExp(r'^Exam \d$')), findsNWidgets(3));
    expect(find.textContaining(RegExp(r'^Reason \d$')), findsNWidgets(3));
    expect(find.textContaining(RegExp(r'^Test \d$')), findsNWidgets(3));
    expect(find.text('Unexcused absences'), findsOneWidget);
  });

  testWidgets('the unexcused section is hidden when everything is excused', (tester) async {
    SchoolDataService.instance.setForTest(me: me, absences: [absences.first.rebuild((b) => b..isExcused = true)]);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...FLocalizations.localizationsDelegates],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => FTheme(data: buildSchulyTheme(Brightness.dark, AppAccent.zinc), child: FToaster(child: child!)),
      home: const Material(child: HomePage()),
    ));
    await tester.pump();
    expect(find.text('Unexcused absences'), findsNothing);
  });
}
