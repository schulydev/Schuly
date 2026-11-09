import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';
import '../../services/school_data_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/now_ticker.dart';
import '../dashboard/dashboard_scope.dart';
import 'day_timeline.dart';
import 'week_glance.dart';

enum _View { day, week }

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  DateTime? _selected; // null until the user picks or the page anchors itself
  bool _userPicked = false;
  _View _view = _View.day;

  @override
  void initState() {
    super.initState();
    SchoolDataService.instance.addListener(_onDataChanged);
    _autoAnchor();
  }

  @override
  void dispose() {
    SchoolDataService.instance.removeListener(_onDataChanged);
    super.dispose();
  }

  // This page is const in the dashboard, so its parent rebuilding does not reach it.
  void _onDataChanged() => setState(_autoAnchor);

  void _autoAnchor() {
    if (_userPicked || _selected != null) return;
    final now = DateTime.now();
    final day = _nearestEntryDay(SchoolDataService.instance.agenda, DateTime(now.year, now.month, now.day));
    if (day != null) _selected = day;
  }

  static DateTime? _nearestEntryDay(List<AgendaEntryDto> agenda, DateTime today) {
    final days = <DateTime>{for (final a in agenda) if (a.entryType != AgendaEntryType.holiday) dayOf(a.date)}.toList()..sort();
    if (days.isEmpty) return null;
    for (final d in days) {
      if (!d.isBefore(today)) return d; // soonest upcoming, today included
    }
    return days.last; // everything is in the past: the most recent day
  }

  void _pick(DateTime d) => setState(() {
        _userPicked = true;
        _selected = d;
      });

  void _shiftWeek(int weeks, DateTime selected) => _pick(DateTime(selected.year, selected.month, selected.day + 7 * weeks));

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final svc = SchoolDataService.instance;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = _selected ?? today;
    final monday = mondayOf(selected);
    final weekEntries = svc.agenda.where((a) {
      final d = dayOf(a.date);
      return !d.isBefore(monday) && d.isBefore(DateTime(monday.year, monday.month, monday.day + 7));
    }).toList();
    final hasWeekend = weekEntries.any((a) => a.entryType != AgendaEntryType.holiday && dayOf(a.date).weekday > 5) || selected.weekday > 5;
    final days = [for (var i = 0; i < (hasWeekend ? 7 : 5); i++) DateTime(monday.year, monday.month, monday.day + i)];

    final head = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SchoolHeader(),
        PageTitle(
          t.tabTimetable,
          subtitle: t.timetableWeekLine(dates.monthYear(selected), isoWeek(selected)),
          trailing: Segmented<_View>(
            width: 132,
            value: _view,
            onChange: (v) => setState(() => _view = v),
            segments: [(_View.day, t.timetableDay), (_View.week, t.timetableWeek)],
          ),
        ),
      ],
    );

    Widget swipe(Widget child) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: (d) {
            final v = d.primaryVelocity ?? 0;
            if (v.abs() < 200) return;
            _shiftWeek(v < 0 ? 1 : -1, selected);
          },
          child: child,
        );

    return NowTicker(
      builder: (context, now) {
        final List<Widget> body;
        if (_view == _View.week) {
          body = [swipe(WeekGlance(days: days, entries: weekEntries, agenda: svc.agenda, now: now))];
        } else {
          final entries = svc.agenda.where((a) => a.entryType != AgendaEntryType.holiday && sameDay(dayOf(a.date), selected)).toList()..sort((a, b) => a.date.compareTo(b.date));
          final holiday = svc.agenda.where((a) => a.entryType == AgendaEntryType.holiday && !dayOf(a.date).isAfter(selected) && !dayOf(a.endDate ?? a.date).isBefore(selected)).firstOrNull;
          final lessons = entries.where((a) => a.entryType != AgendaEntryType.event).length;
          body = [
            swipe(_DayStrip(days: days, selected: selected, today: today, agenda: weekEntries, onPick: _pick)),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(child: Text(dates.dayLong(selected), style: context.theme.typography.base.copyWith(fontWeight: FontWeight.w600))),
                  Text(holiday != null && entries.isEmpty ? holiday.title : t.timetableLessons(lessons), style: context.theme.typography.sm.copyWith(color: context.theme.colors.mutedForeground)),
                ],
              ),
            ),
            if (entries.isEmpty)
              EmptyNote(holiday != null ? holiday.title : t.nothingScheduled)
            else
              DayTimeline(entries: entries, now: now, isToday: sameDay(selected, today)),
          ];
        }
        return PageList(onRefresh: svc.refresh, children: [head, ...body]);
      },
    );
  }
}

/// The week's school days in thumb-sized cells; the accent fills the chosen day and a red dot marks test days.
class _DayStrip extends StatelessWidget {
  const _DayStrip({required this.days, required this.selected, required this.today, required this.agenda, required this.onPick});

  final List<DateTime> days;
  final DateTime selected;
  final DateTime today;
  final List<AgendaEntryDto> agenda;
  final ValueChanged<DateTime> onPick;

  @override
  Widget build(BuildContext context) {
    final dates = Dates(context);
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          for (final (i, d) in days.indexed) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: Builder(builder: (context) {
                final on = sameDay(d, selected);
                final isToday = sameDay(d, today);
                final hasTest = agenda.any((a) => a.entryType == AgendaEntryType.test && sameDay(dayOf(a.date), d));
                final fg = on ? colors.primaryForeground : null;
                return FButton(
                  onPress: () => onPick(d),
                  selected: on,
                  style: (on ? FButtonStyle.primary : FButtonStyle.ghost)((s) => s.copyWith(
                        decoration: s.decoration.map((b) => b.copyWith(
                              borderRadius: BorderRadius.circular(SchulyRadii.list),
                              border: on ? null : Border.all(color: colors.border),
                            )),
                        contentStyle: (c) => c.copyWith(padding: EdgeInsets.zero),
                      )),
                  child: SizedBox(
                    height: 60,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(dates.weekdayShort(d), style: typography.xs.copyWith(color: fg ?? colors.mutedForeground, height: 1.3)),
                            Text('${d.day}', style: typography.xl.copyWith(fontWeight: FontWeight.w600, height: 1.2, color: fg ?? (isToday ? tokens.ink : colors.foreground))),
                          ],
                        ),
                        if (hasTest) Positioned(bottom: 6, child: Container(width: 5, height: 5, decoration: BoxDecoration(shape: BoxShape.circle, color: on ? colors.primaryForeground : tokens.calendarTest))),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}
