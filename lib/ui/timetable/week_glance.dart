import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/sheet.dart';
import '../../services/outlook_calendar.dart';
import 'day_schedule.dart';
import 'outlook_events.dart';

/// The week at a glance, like the web calendar: a column per day with the lessons in lanes, an all-day row with
/// Outlook-style "+N" for overflow, and the now line in the accent.
class WeekGlance extends StatelessWidget {
  const WeekGlance({super.key, required this.days, required this.entries, required this.agenda, required this.now, this.outlook = const []});

  final List<DateTime> days;

  /// The timed entries that start in this week.
  final List<AgendaEntryDto> entries;

  /// Everything, for the all-day row (holidays started before the week still cover its days).
  final List<AgendaEntryDto> agenda;
  final DateTime now;

  /// The linked accounts' calendar events this week, in their account's colour, as the web merges them.
  final List<OutlookEvent> outlook;

  static const double _bodyHeight = 470;
  static const double _hoursWidth = 30;

  static bool _isAllDay(AgendaEntryDto a) {
    if (a.entryType == AgendaEntryType.holiday) return true;
    final start = a.date.toLocal();
    final end = a.endDate?.toLocal();
    return end != null && end.difference(start).inHours >= 20;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    final today = DateTime(now.year, now.month, now.day);
    final timed = entries.where((a) => !_isAllDay(a)).toList();
    final outlookTimed = outlook.where((e) => !e.allDay).toList();

    var startHour = 8, endHour = 16;
    for (final a in timed) {
      final s = a.date.toLocal(), e = (a.endDate ?? a.date.add(kFallbackLessonDuration)).toLocal();
      if (s.hour < startHour) startHour = s.hour;
      final eh = e.minute > 0 ? e.hour + 1 : e.hour;
      if (eh > endHour) endHour = eh.clamp(0, 24);
    }
    for (final e in outlookTimed) {
      if (e.start.hour < startHour) startHour = e.start.hour;
      final eh = sameDay(e.start, e.end) ? (e.end.minute > 0 ? e.end.hour + 1 : e.end.hour) : 24;
      if (eh > endHour) endHour = eh.clamp(0, 24);
    }
    final minutes = (endHour - startHour) * 60;
    final pxm = _bodyHeight / minutes;
    double y(DateTime d) => ((d.hour - startHour) * 60 + d.minute) * pxm;

    List<AgendaEntryDto> allDayOf(DateTime d) => agenda.where((a) => _isAllDay(a) && !dayOf(a.date).isAfter(d) && !dayOf(a.endDate ?? a.date).isBefore(d)).toList();

    Widget cell(Widget child, {bool first = false}) => Container(
          decoration: BoxDecoration(border: first ? null : Border(left: BorderSide(color: colors.border))),
          child: child,
        );

    final header = Row(
      children: [
        const SizedBox(width: _hoursWidth),
        for (final d in days)
          Expanded(
            child: cell(Padding(
              padding: const EdgeInsets.fromLTRB(0, 7, 0, 6),
              child: Column(
                children: [
                  Text(dates.weekdayShort(d), style: typography.xs.copyWith(fontSize: 11, color: colors.mutedForeground, height: 1.2)),
                  Text('${d.day}', style: typography.lg.copyWith(fontWeight: FontWeight.w600, height: 1.2, color: sameDay(d, today) ? tokens.ink : colors.foreground)),
                ],
              ),
            )),
          ),
      ],
    );

    Widget chip(_AllDay a) {
      final box = Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        decoration: BoxDecoration(color: a.color.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(4)),
        child: Text(a.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: typography.xs.copyWith(fontSize: 10, fontWeight: FontWeight.w500, color: a.color, height: 1.3)),
      );
      return a.onTap == null ? box : FTappable(onPress: a.onTap, child: box);
    }

    List<_AllDay> allDayItems(DateTime d) => [
          for (final a in allDayOf(d))
            _AllDay(a.title, a.entryType == AgendaEntryType.holiday ? tokens.calendarHoliday : tokens.calendarEvent, a.entryType == AgendaEntryType.holiday ? t.entryTypeHoliday : t.entryTypeEvent, null),
          for (final e in outlook.where((e) => e.allDay && e.coversDay(d))) _AllDay(e.title, outlookColor(e), OutlookCalendar.instance.account(e.accountId)?.email ?? 'Outlook', () => showOutlookEvent(context, e)),
        ];

    final allDay = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The label cell stays empty, as on the web.
          const SizedBox(width: _hoursWidth),
          for (final d in days)
            Expanded(
              child: cell(Container(
                constraints: const BoxConstraints(minHeight: 26),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                child: Builder(builder: (context) {
                  final items = allDayItems(d);
                  if (items.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 2,
                    children: [
                      chip(items.first),
                      if (items.length > 1)
                        FButton(
                          onPress: () => _showMore(context, t, dates, d, items),
                          style: FButtonStyle.outline((s) => s.copyWith(
                                decoration: s.decoration.map((b) => b.copyWith(color: const Color(0x00000000), borderRadius: BorderRadius.circular(4))),
                                contentStyle: (c) => c.copyWith(padding: const EdgeInsets.symmetric(vertical: 2), textStyle: c.textStyle.map((ts) => ts.copyWith(fontSize: 10, color: colors.mutedForeground))),
                              )),
                          child: Text('+${items.length - 1}'),
                        ),
                    ],
                  );
                }),
              )),
            ),
        ],
      ),
    );

    final body = SizedBox(
      height: _bodyHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _hoursWidth,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (var h = startHour; h < endHour; h++)
                  Positioned(
                    top: (h - startHour) * 60 * pxm - 6,
                    right: 4,
                    child: Text('$h', style: typography.xs.copyWith(fontSize: 9, color: colors.mutedForeground, height: 1.3)),
                  ),
              ],
            ),
          ),
          for (final d in days)
            Expanded(
              child: cell(_DayColumn(
                day: d,
                entries: [
                  for (final a in timed.where((a) => sameDay(dayOf(a.date), d))) _Block.agenda(a, tokens),
                  for (final e in outlookTimed.where((e) => sameDay(e.start, d))) _Block(e.start, sameDay(e.start, e.end) ? e.end : DateTime(d.year, d.month, d.day, 23, 59), e.title, e.location, outlookColor(e), () => showOutlookEvent(context, e)),
                ],
                isToday: sameDay(d, today),
                now: now,
                y: y,
                hourHeight: 60 * pxm,
                hours: endHour - startHour,
              )),
            ),
        ],
      ),
    );

    Widget dot(Color c) => Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 6), decoration: BoxDecoration(color: c, shape: BoxShape.circle));
    Widget legend(Color c, String label) => Row(mainAxisSize: MainAxisSize.min, children: [dot(c), Text(label, style: typography.xs.copyWith(color: colors.mutedForeground))]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: tokens.card, border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(SchulyRadii.list)),
          child: Column(
            children: [
              header,
              Container(decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: colors.border))), child: allDay),
              body,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              legend(tokens.calendarLesson, t.entryTypeLesson),
              legend(tokens.calendarTest, t.entryTypeTest),
              legend(tokens.calendarEvent, t.entryTypeEvent),
              legend(tokens.ink, t.timelineNow),
            ],
          ),
        ),
      ],
    );
  }

  static Future<void> _showMore(BuildContext context, AppLocalizations t, Dates dates, DateTime day, List<_AllDay> items) => showSchulySheet<void>(
        context,
        builder: (_) => SchulySheet(
          title: dates.dayLong(day),
          subtitle: t.timetableAllDayCount(items.length),
          action: t.done,
          body: FTileGroup(
            divider: FItemDivider.full,
            children: [
              for (final a in items)
                FTile(
                  title: Text(a.title),
                  details: Text(a.kind, style: context.theme.typography.xs.copyWith(fontWeight: FontWeight.w500, color: a.color)),
                  onPress: a.onTap,
                ),
            ],
          ),
        ),
      );
}

/// An all-day entry in the week's top row: a holiday or event, or an Outlook event that opens its sheet.
class _AllDay {
  const _AllDay(this.title, this.color, this.kind, this.onTap);
  final String title;
  final Color color;
  final String kind;
  final VoidCallback? onTap;
}

/// A timed block in a day column: a lesson, test or event, or an Outlook event in its account's colour.
class _Block {
  const _Block(this.start, this.end, this.title, this.place, this.color, this.onTap);

  _Block.agenda(AgendaEntryDto a, SchulyTokens tokens)
      : start = a.date.toLocal(),
        end = (a.endDate ?? a.date.add(kFallbackLessonDuration)).toLocal(),
        title = a.title,
        place = a.place,
        color = switch (a.entryType) {
          AgendaEntryType.test => tokens.calendarTest,
          AgendaEntryType.event => tokens.calendarEvent,
          _ => tokens.calendarLesson,
        },
        onTap = null;

  final DateTime start;
  final DateTime end;
  final String title;
  final String? place;
  final Color color;
  final VoidCallback? onTap;
}

class _DayColumn extends StatelessWidget {
  const _DayColumn({required this.day, required this.entries, required this.isToday, required this.now, required this.y, required this.hourHeight, required this.hours});

  final DateTime day;
  final List<_Block> entries;
  final bool isToday;
  final DateTime now;
  final double Function(DateTime) y;
  final double hourHeight;
  final int hours;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;

    // Lanes: overlapping entries share the column side by side.
    final sorted = [...entries]..sort((a, b) => a.start.compareTo(b.start));
    DateTime endOf(_Block a) => a.end;
    final lane = <_Block, int>{};
    final lanesInCluster = <_Block, int>{};
    var cluster = <_Block>[];
    var laneEnds = <DateTime>[];
    DateTime? clusterEnd;
    void closeCluster() {
      for (final a in cluster) {
        lanesInCluster[a] = laneEnds.length;
      }
      cluster = [];
      laneEnds = [];
      clusterEnd = null;
    }

    for (final a in sorted) {
      final s = a.start;
      if (clusterEnd != null && !s.isBefore(clusterEnd!)) closeCluster();
      var l = laneEnds.indexWhere((e) => !s.isBefore(e));
      if (l < 0) {
        l = laneEnds.length;
        laneEnds.add(endOf(a));
      } else {
        laneEnds[l] = endOf(a);
      }
      lane[a] = l;
      cluster.add(a);
      if (clusterEnd == null || endOf(a).isAfter(clusterEnd!)) clusterEnd = endOf(a);
    }
    closeCluster();

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        return Container(
          color: isToday ? tokens.ink.withValues(alpha: 0.05) : null,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var h = 0; h < hours; h++) Positioned(top: h * hourHeight, left: 0, right: 0, child: Container(height: 1, color: colors.border)),
              for (final a in sorted)
                Builder(builder: (context) {
                  final color = a.color;
                  final n = lanesInCluster[a] ?? 1;
                  final laneW = (w - 4) / n;
                  final top = y(a.start);
                  final height = (y(endOf(a)) - top - 2).clamp(12.0, double.infinity);
                  final done = isToday && !endOf(a).isAfter(now);
                  return Positioned(
                    top: top,
                    left: 2 + laneW * lane[a]!,
                    width: laneW - (n > 1 ? 1 : 0),
                    height: height,
                    child: FTappable(
                      onPress: a.onTap,
                      child: Opacity(
                      opacity: done ? 0.5 : 1,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(4, 3, 2, 3),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(5),
                          border: Border(left: BorderSide(color: color, width: 2)),
                        ),
                        child: ClipRect(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: typography.xs.copyWith(fontSize: 10, fontWeight: FontWeight.w600, height: 1.2)),
                              if (a.place?.isNotEmpty == true) Text(a.place!, maxLines: 1, overflow: TextOverflow.ellipsis, style: typography.xs.copyWith(fontSize: 10, color: colors.mutedForeground, height: 1.2)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ),
                  );
                }),
              if (isToday && y(now) >= 0 && y(now) <= hours * hourHeight)
                Positioned(
                  top: y(now) - 1,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(child: ColoredBox(color: tokens.ink)),
                        Positioned(left: -3, top: -3, child: Container(width: 8, height: 8, decoration: BoxDecoration(color: tokens.ink, shape: BoxShape.circle))),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
