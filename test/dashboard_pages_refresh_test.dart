import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/school_data_service.dart';
import 'package:schuly/services/secure_store.dart';
import 'package:schuly/ui/absences/absences_page.dart';
import 'package:schuly/ui/grades/grades_page.dart';
import 'package:schuly/ui/home/home_page.dart';
import 'package:schuly/ui/timetable/timetable_page.dart';
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

Widget _host(Widget page) => MaterialApp(
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...FLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => FTheme(data: FThemes.zinc.light, child: FToaster(child: child!)),
      home: Material(child: page),
    );

/// The dashboard builds its pages as `const`, so each one has to follow the data itself (#513).
void main() {
  final today = DateTime.now();
  final exam = ExamDto((b) => b
    ..id = 'e1'
    ..name = 'Algebra test'
    ..classAverage = 4.5
    ..date = Date(today.year, today.month, today.day));
  final me = SchoolUserDto((b) => b
    ..id = 'me'
    ..firstName = 'A'
    ..lastName = 'B'
    ..email = 'a@example.com'
    ..role = Roles.student
    ..grades.add(GradeDto((g) => g
      ..id = 'g1'
      ..score = 5.5
      ..examId = 'e1')));
  AgendaEntryDto lesson(String title) => AgendaEntryDto((b) => b
    ..id = title
    ..entryType = AgendaEntryType.lesson
    ..title = title
    ..date = DateTime(today.year, today.month, today.day, 10)
    ..endDate = DateTime(today.year, today.month, today.day, 11));
  final absence = AbsenceDto((b) => b
    ..id = 'a1'
    ..reason = 'Dentist'
    ..type = AbsenceType.absence
    ..from = today
    ..until = today);

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SecureStore.useBackend(_EmptyStore());
    SchoolDataService.instance.clear();
  });
  tearDown(SchoolDataService.instance.clear);

  testWidgets('home shows data that arrives after its first build', (tester) async {
    await tester.pumpWidget(_host(const HomePage()));
    expect(find.textContaining('Algebra test'), findsNothing);
    SchoolDataService.instance.setForTest(me: me, exams: [exam]);
    await tester.pump();
    expect(find.textContaining('Algebra test'), findsWidgets);
  });

  testWidgets('grades shows data that arrives after its first build', (tester) async {
    await tester.pumpWidget(_host(const GradesPage()));
    expect(find.text('No grades yet'), findsOneWidget);
    SchoolDataService.instance.setForTest(me: me, exams: [exam]);
    await tester.pump();
    expect(find.text('No grades yet'), findsNothing);
  });

  testWidgets('absences shows data that arrives after its first build', (tester) async {
    await tester.pumpWidget(_host(const AbsencesPage()));
    await tester.pump();
    expect(find.text('No absences'), findsOneWidget);
    SchoolDataService.instance.setForTest(me: me, absences: [absence]);
    await tester.pump();
    expect(find.text('No absences'), findsNothing);
    // Let the page's own account lookup finish.
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('the timetable follows a refresh after it picked its day', (tester) async {
    SchoolDataService.instance.setForTest(me: me, agenda: [lesson('Maths')]);
    await tester.pumpWidget(_host(const TimetablePage()));
    await tester.pump();
    expect(find.textContaining('Maths'), findsWidgets);
    SchoolDataService.instance.setForTest(me: me, agenda: [lesson('Physics')]);
    await tester.pump();
    expect(find.textContaining('Physics'), findsWidgets);
  });
}
