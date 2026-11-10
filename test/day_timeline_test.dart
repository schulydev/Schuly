import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/ui/core/theme/schuly_theme.dart';
import 'package:schuly/ui/timetable/day_timeline.dart';
import 'package:schuly_api/schuly_api.dart';

AgendaEntryDto _entry(String title, int h, int m, int eh, int em, {AgendaEntryType type = AgendaEntryType.lesson}) => AgendaEntryDto((b) => b
  ..id = title
  ..entryType = type
  ..title = title
  ..place = 'B112'
  ..description = 'Brunner Claire (BrCl)'
  ..date = DateTime(2026, 11, 10, h, m)
  ..endDate = DateTime(2026, 11, 10, eh, em));

Future<void> _pump(WidgetTester tester, Widget child) => tester.pumpWidget(MaterialApp(
      localizationsDelegates: const [...AppLocalizations.localizationsDelegates, ...FLocalizations.localizationsDelegates],
      supportedLocales: AppLocalizations.supportedLocales,
      home: FTheme(data: buildSchulyTheme(Brightness.dark, AppAccent.zinc), child: SingleChildScrollView(child: child)),
    ));

void main() {
  final day = [
    _entry('M164', 8, 15, 9, 50),
    _entry('Englisch', 10, 10, 11, 45),
    _entry('Klassenfoto', 11, 50, 12, 10, type: AgendaEntryType.event),
    _entry('Sport', 12, 45, 14, 20),
  ];

  testWidgets('the running lesson gets a Now tag and no time in its card or a minutes-left line', (tester) async {
    await _pump(tester, DayTimeline(entries: day, now: DateTime(2026, 11, 10, 10, 30), isToday: true, compact: true));
    expect(find.textContaining('Now', findRichText: true), findsOneWidget);
    expect(find.text('B112 · Brunner Claire'), findsNWidgets(3));
    expect(find.textContaining('min left'), findsNothing);
    expect(find.textContaining('until'), findsNothing);
  });

  testWidgets('only the last lesson, while it runs, says when it ends on Home', (tester) async {
    await _pump(tester, DayTimeline(entries: day, now: DateTime(2026, 11, 10, 13), isToday: true, compact: true));
    expect(find.text('B112 · Brunner Claire · until 14:20'), findsOneWidget);
  });

  testWidgets('events keep their time range on Home, and breaks show', (tester) async {
    await _pump(tester, DayTimeline(entries: day, now: DateTime(2026, 11, 10, 7), isToday: true, compact: true));
    expect(find.text('11:50 – 12:10 · B112'), findsOneWidget);
    expect(find.text('Break · 20 min'), findsOneWidget);
  });

  testWidgets('the timetable shows the end time in the time column, not in the card', (tester) async {
    await _pump(tester, DayTimeline(entries: day, now: DateTime(2026, 11, 10, 13), isToday: true));
    expect(find.text('14:20'), findsOneWidget);
    expect(find.textContaining('until'), findsNothing);
  });
}
