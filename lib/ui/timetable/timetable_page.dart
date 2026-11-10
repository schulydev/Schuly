import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';
import '../../services/outlook_calendar.dart';
import '../../services/school_data_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/now_ticker.dart';
import '../dashboard/dashboard_scope.dart';
import 'day_timeline.dart';
import 'outlook_events.dart';
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
    OutlookCalendar.instance.addListener(_onDataChanged);
    _autoAnchor();
  }

  @override
  void dispose() {
    SchoolDataService.instance.removeListener(_onDataChanged);
    OutlookCalendar.instance.removeListener(_onDataChanged);
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

  /// Bumped when the day changes other than by a tap on the carousel, so the carousel scrolls to it again.
  int _recentre = 0;

  void _pick(DateTime d, {bool recentre = true}) => setState(() {
        _userPicked = true;
        _selected = d;
        if (recentre) _recentre++;
      });

  void _shift(int days, DateTime selected) => _pick(DateTime(selected.year, selected.month, selected.day + days));

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
    // The linked Microsoft accounts' calendars for the shown week, merged in as on the web.
    final outlook = OutlookCalendar.instance.week(monday);
    final days = [for (var i = 0; i < (hasWeekend ? 7 : 5); i++) DateTime(monday.year, monday.month, monday.day + i)];

    final head = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SchoolHeader(),
        PageTitle(
          t.tabTimetable,
          subtitle: t.timetableWeekLine(dates.monthYear(selected), isoWeek(selected)),
          trailing: Segmented<_View>(
            width: 156,
            value: _view,
            onChange: (v) => setState(() => _view = v),
            segments: [(_View.day, t.timetableDay), (_View.week, t.timetableWeek)],
          ),
        ),
      ],
    );

    // Swiping the day view moves a day, the week view a week; the carousel follows.
    Widget swipe(Widget child, {required int step}) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: (d) {
            final v = d.primaryVelocity ?? 0;
            if (v.abs() < 200) return;
            _shift(v < 0 ? step : -step, selected);
          },
          child: child,
        );

    // The v3.3 day carousel: Forui's line calendar, scrolled through freely, today marked, the chosen day in the accent.
    final testDays = {for (final a in svc.agenda) if (a.entryType == AgendaEntryType.test) dayOf(a.date)};
    final carousel = Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FLineCalendar(
        key: ValueKey(_recentre),
        start: DateTime(today.year - 1),
        end: DateTime(today.year + 2),
        today: today,
        initialScroll: selected,
        control: FLineCalendarControl.lifted(date: selected, onChange: (d) {
          if (d != null) _pick(d, recentre: false);
        }),
        builder: (context, data, child) => !testDays.contains(dayOf(data.date))
            ? child!
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  child!,
                  Positioned(bottom: 6, child: Container(width: 5, height: 5, decoration: BoxDecoration(shape: BoxShape.circle, color: data.states.contains(WidgetState.selected) ? context.theme.colors.primaryForeground : context.tokens.calendarTest))),
                ],
              ),
      ),
    );

    return NowTicker(
      builder: (context, now) {
        final List<Widget> body;
        if (_view == _View.week) {
          body = [carousel, swipe(WeekGlance(days: days, entries: weekEntries, agenda: svc.agenda, now: now, outlook: outlook), step: 7)];
        } else {
          final entries = svc.agenda.where((a) => a.entryType != AgendaEntryType.holiday && sameDay(dayOf(a.date), selected)).toList()..sort((a, b) => a.date.compareTo(b.date));
          final holiday = svc.agenda.where((a) => a.entryType == AgendaEntryType.holiday && !dayOf(a.date).isAfter(selected) && !dayOf(a.endDate ?? a.date).isBefore(selected)).firstOrNull;
          final lessons = entries.where((a) => a.entryType != AgendaEntryType.event).length;
          body = [
            carousel,
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(child: Text(dates.dayLong(selected), style: context.theme.typography.base.copyWith(fontWeight: FontWeight.w600))),
                  Text(holiday != null && entries.isEmpty ? holiday.title : t.timetableLessons(lessons), style: context.theme.typography.sm.copyWith(color: context.theme.colors.mutedForeground)),
                ],
              ),
            ),
            swipe(
              entries.isEmpty ? EmptyNote(holiday != null ? holiday.title : t.nothingScheduled) : DayTimeline(entries: entries, now: now, isToday: sameDay(selected, today)),
              step: 1,
            ),
            ...outlookSection(context, [for (final e in outlook) if (e.coversDay(selected)) e]),
          ];
        }
        return PageList(onRefresh: () async {
          OutlookCalendar.instance.clear();
          await svc.refresh();
        }, children: [head, ...body]);
      },
    );
  }
}
