import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/school_data_service.dart';
import '../core/ui/now_ticker.dart';
import 'day_schedule.dart';
import 'timeline_row.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  DateTime? _selected; // null until the user picks or we auto-anchor
  bool _userPicked = false;

  @override
  void initState() {
    super.initState();
    SchoolDataService.instance.addListener(_autoAnchor);
    _autoAnchor();
  }

  @override
  void dispose() {
    SchoolDataService.instance.removeListener(_autoAnchor);
    super.dispose();
  }

  void _autoAnchor() {
    if (_userPicked || _selected != null) return;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = _nearestEntryDay(SchoolDataService.instance.agenda, today);
    if (day != null && mounted) setState(() => _selected = day);
  }

  static DateTime? _nearestEntryDay(List<dynamic> agenda, DateTime today) {
    final days = <DateTime>{
      for (final a in agenda) _localDay(a.date),
    }.toList()
      ..sort();
    if (days.isEmpty) return null;
    for (final d in days) {
      if (!d.isBefore(today)) return d; // soonest upcoming (incl. today)
    }
    return days.last; // everything is in the past → most recent
  }

  static DateTime _localDay(DateTime d) {
    final local = d.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final t = AppLocalizations.of(context)!;
    final svc = SchoolDataService.instance;
    final now = DateTime.now();
    final selected = _selected ?? DateTime(now.year, now.month, now.day);

    bool sameDay(DateTime d) {
      final local = d.toLocal();
      return local.year == selected.year && local.month == selected.month && local.day == selected.day;
    }

    final entries = svc.agenda.where((a) => sameDay(a.date)).toList()
      ..sort((a, b) => a.date.toLocal().compareTo(b.date.toLocal()));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FLineCalendar(
            key: ValueKey(_selected != null),
            start: DateTime(now.year - 1),
            end: DateTime(now.year + 2),
            today: now,
            initialScroll: selected,
            control: FLineCalendarControl.lifted(
              date: selected,
              onChange: (d) {
                if (d != null) {
                  setState(() {
                    _userPicked = true;
                    _selected = d;
                  });
                }
              },
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: svc.refresh,
            child: entries.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 320,
                        child: Center(
                          child: Text(t.nothingScheduled,
                              style: TextStyle(color: colors.mutedForeground)),
                        ),
                      ),
                    ],
                  )
                : NowTicker(
                    builder: (context, now) {
                      final items = buildDaySchedule(entries);
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        children: [
                          for (var i = 0; i < items.length; i++)
                            TimelineRow(item: items[i], now: now, isLast: i == items.length - 1),
                        ],
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
