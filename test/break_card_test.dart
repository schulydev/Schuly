import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/ui/timetable/break_card.dart';
import 'package:schuly/ui/timetable/day_schedule.dart';

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
  testWidgets('a 15-minute break renders the Break (15 min) text', (tester) async {
    final item = BreakItem(start: DateTime(2026, 1, 5, 9), end: DateTime(2026, 1, 5, 9, 15));
    await tester.pumpWidget(_wrap(BreakCard(item: item, now: DateTime(2026, 1, 5, 7))));

    expect(find.textContaining('Break (15 min)'), findsOneWidget);
  });

  testWidgets('a 45-minute lunch break renders the Lunch break (45 min) text', (tester) async {
    final item = BreakItem(start: DateTime(2026, 1, 5, 11, 45), end: DateTime(2026, 1, 5, 12, 30));
    await tester.pumpWidget(_wrap(BreakCard(item: item, now: DateTime(2026, 1, 5, 7))));

    expect(find.textContaining('Lunch break (45 min)'), findsOneWidget);
  });

  testWidgets('a current break renders the min-left text', (tester) async {
    final item = BreakItem(start: DateTime(2026, 1, 5, 9), end: DateTime(2026, 1, 5, 9, 15));
    await tester.pumpWidget(_wrap(BreakCard(item: item, now: DateTime(2026, 1, 5, 9, 5))));

    expect(find.textContaining('min left'), findsOneWidget);
  });

  testWidgets('a non-current break does not render the min-left text', (tester) async {
    final item = BreakItem(start: DateTime(2026, 1, 5, 9), end: DateTime(2026, 1, 5, 9, 15));
    await tester.pumpWidget(_wrap(BreakCard(item: item, now: DateTime(2026, 1, 5, 7))));

    expect(find.textContaining('min left'), findsNothing);
  });
}
