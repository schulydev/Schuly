import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/ui/timetable/day_schedule.dart';
import 'package:schuly/ui/timetable/lesson_tile.dart';
import 'package:schuly_api/schuly_api.dart';

AgendaEntryDto _entry({required DateTime date, DateTime? endDate, String title = 'Math'}) {
  return AgendaEntryDto((b) => b
    ..entryType = AgendaEntryType.lesson
    ..title = title
    ..date = date
    ..endDate = endDate);
}

Widget _wrap(Widget child) => MaterialApp(
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...FLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: FTheme(data: FThemes.zinc.light, child: Scaffold(body: child)),
    );

void main() {
  testWidgets('a lesson with an endDate renders both the from and until times', (tester) async {
    final entry = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
    final item = LessonItem(entry);
    await tester.pumpWidget(_wrap(LessonTile(item: item, now: DateTime(2026, 1, 5, 7))));

    expect(find.textContaining('08:00'), findsOneWidget);
    expect(find.textContaining('08:45'), findsOneWidget);
  });

  testWidgets('a lesson without an endDate renders the start time but no until time', (tester) async {
    final entry = _entry(date: DateTime(2026, 1, 5, 8));
    final item = LessonItem(entry);
    await tester.pumpWidget(_wrap(LessonTile(item: item, now: DateTime(2026, 1, 5, 7))));

    expect(find.textContaining('08:00'), findsOneWidget);
    expect(find.textContaining('08:45'), findsNothing);
  });

  testWidgets('a current lesson renders the min-left text', (tester) async {
    final entry = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
    final item = LessonItem(entry);
    await tester.pumpWidget(_wrap(LessonTile(item: item, now: DateTime(2026, 1, 5, 8, 30))));

    expect(find.textContaining('min left'), findsOneWidget);
  });

  testWidgets('a non-current lesson does not render the min-left text', (tester) async {
    final entry = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
    final item = LessonItem(entry);
    await tester.pumpWidget(_wrap(LessonTile(item: item, now: DateTime(2026, 1, 5, 7))));

    expect(find.textContaining('min left'), findsNothing);
  });
}
