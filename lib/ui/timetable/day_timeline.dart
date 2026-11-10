import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import 'day_schedule.dart';

/// A day as a timeline: start times on the left, a rail with a dot per entry, and a card per lesson, event and break.
///
/// On today's timeline past entries fade, and the running lesson gets a "Now" tag, an accent outline and a dot that
/// moves down the rail as the lesson goes on. The card never repeats the start time the left column shows. On Home
/// ([compact]) the column has no end times, so only the day's last lesson, while it runs, says when it ends ("bis
/// 15:15"), and events keep their time range.
class DayTimeline extends StatelessWidget {
  const DayTimeline({super.key, required this.entries, required this.now, required this.isToday, this.compact = false});

  final List<AgendaEntryDto> entries;
  final DateTime now;
  final bool isToday;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final items = buildDaySchedule(entries);
    final lessons = items.whereType<LessonItem>().where((l) => l.entry.entryType != AgendaEntryType.event).toList();
    final lastLesson = lessons.isEmpty ? null : lessons.last;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, item) in items.indexed)
          _Row(
            key: ValueKey('${item.start.toIso8601String()}-$i'),
            item: item,
            now: now,
            isToday: isToday,
            compact: compact,
            first: i == 0,
            last: i == items.length - 1,
            lastLesson: identical(item, lastLesson),
            t: t,
          ),
      ],
    );
  }
}

enum _State { upcoming, running, done }

class _Row extends StatelessWidget {
  const _Row({super.key, required this.item, required this.now, required this.isToday, required this.compact, required this.first, required this.last, required this.lastLesson, required this.t});

  final DayItem item;
  final DateTime now;
  final bool isToday;
  final bool compact;
  final bool first;
  final bool last;
  final bool lastLesson;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    final item = this.item;
    final state = !isToday
        ? _State.upcoming
        : !now.isBefore(item.end)
            ? _State.done
            : !now.isBefore(item.start)
                ? _State.running
                : _State.upcoming;
    final isBreak = item is BreakItem;
    final isEvent = item is LessonItem && item.entry.entryType == AgendaEntryType.event;
    final progress = state == _State.running ? (now.difference(item.start).inSeconds / item.end.difference(item.start).inSeconds).clamp(0.0, 1.0) : 0.0;
    final showEnd = !compact && !isBreak && (item is! LessonItem || item.hasEndTime);

    final time = Padding(
      padding: EdgeInsets.only(top: isBreak ? 7 : 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formatHm(item.start), textAlign: TextAlign.right, style: (isBreak ? typography.xs : typography.sm).copyWith(color: colors.mutedForeground, height: 1.25)),
          if (showEnd) Text(formatHm(item.end), textAlign: TextAlign.right, style: typography.xs.copyWith(color: colors.mutedForeground.withValues(alpha: 0.75), height: 1.25)),
        ],
      ),
    );

    final Widget card = switch (item) {
      BreakItem b => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          margin: const EdgeInsets.only(bottom: 6),
          child: Text(b.isLunch ? t.timelineLunchBreak(b.minutes) : t.timelineBreak(b.minutes), style: typography.sm.copyWith(color: colors.mutedForeground)),
        ),
      LessonItem l => _LessonCard(lesson: l, running: state == _State.running, compact: compact, showUntil: compact && lastLesson && state == _State.running, t: t),
    };

    final row = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 44, child: time),
          const SizedBox(width: 10),
          SizedBox(
            width: 14,
            child: CustomPaint(
              painter: _RailPainter(
                first: first,
                last: last,
                state: state,
                kind: isBreak ? _Kind.breakItem : (isEvent ? _Kind.event : _Kind.lesson),
                progress: progress,
                line: colors.border,
                dot: colors.foreground.withValues(alpha: 0.22),
                background: colors.background,
                ink: tokens.ink,
                soft: tokens.soft,
                event: tokens.calendarEvent,
                muted: colors.mutedForeground,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: card),
        ],
      ),
    );
    return Opacity(opacity: state == _State.done ? 0.5 : 1, child: row);
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({required this.lesson, required this.running, required this.compact, required this.showUntil, required this.t});

  final LessonItem lesson;
  final bool running;
  final bool compact;
  final bool showUntil;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    final entry = lesson.entry;
    final isEvent = entry.entryType == AgendaEntryType.event;
    final isTest = entry.entryType == AgendaEntryType.test;
    final teacher = entry.description == null ? null : stripShortCode(entry.description!);
    final place = entry.place;
    final meta = isEvent && compact
        ? [lesson.hasEndTime ? '${formatHm(lesson.start)} – ${formatHm(lesson.end)}' : formatHm(lesson.start), place]
        : [place, isEvent ? null : teacher, if (showUntil) t.timelineUntil(formatHm(lesson.end))];
    final metaText = meta.whereType<String>().where((s) => s.isNotEmpty).join(' · ');
    final title = entry.title.isNotEmpty ? entry.title : (isEvent ? t.entryTypeEvent : t.entryTypeLesson);

    final BoxDecoration? decoration = isEvent
        ? BoxDecoration(
            color: tokens.calendarEvent.withValues(alpha: 0.09),
            border: Border(left: BorderSide(color: tokens.calendarEvent, width: 2)),
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(4), right: Radius.circular(SchulyRadii.base)),
          )
        : running
            ? BoxDecoration(
                color: tokens.card,
                borderRadius: BorderRadius.circular(SchulyRadii.base),
                border: Border.all(color: tokens.ink.withValues(alpha: 0.35)),
              )
            : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(children: [
              TextSpan(text: title),
              if (running) WidgetSpan(alignment: PlaceholderAlignment.middle, child: Tag(t.timelineNow, color: tokens.ink, background: tokens.soft)),
              if (isTest) WidgetSpan(alignment: PlaceholderAlignment.middle, child: Tag(t.entryTypeTest, color: tokens.warn, background: tokens.warnBackground)),
              if (isEvent) WidgetSpan(alignment: PlaceholderAlignment.middle, child: Tag(t.entryTypeEvent, color: tokens.calendarEvent, background: tokens.calendarEvent.withValues(alpha: 0.16))),
            ]),
            style: typography.base.copyWith(fontWeight: FontWeight.w500),
          ),
          if (metaText.isNotEmpty) Text(metaText, style: typography.sm.copyWith(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}

enum _Kind { lesson, event, breakItem }

class _RailPainter extends CustomPainter {
  _RailPainter({required this.first, required this.last, required this.state, required this.kind, required this.progress, required this.line, required this.dot, required this.background, required this.ink, required this.soft, required this.event, required this.muted});

  final bool first;
  final bool last;
  final _State state;
  final _Kind kind;
  final double progress;
  final Color line;
  final Color dot;
  final Color background;
  final Color ink;
  final Color soft;
  final Color event;
  final Color muted;

  static const double _x = 7;

  @override
  void paint(Canvas canvas, Size size) {
    final top = first ? 16.0 : 0.0;
    final bottom = last ? 16.0 : size.height;
    final linePaint = Paint()
      ..color = line
      ..strokeWidth = 2;
    if (bottom > top) canvas.drawLine(Offset(_x, top), Offset(_x, bottom), linePaint);

    if (kind == _Kind.breakItem) {
      final p = Path()
        ..moveTo(_x, 11)
        ..lineTo(_x + 4.2, 15.2)
        ..lineTo(_x, 19.4)
        ..lineTo(_x - 4.2, 15.2)
        ..close();
      canvas.drawPath(p, Paint()..color = muted);
      return;
    }

    if (state == _State.running) {
      // The dot travels down the rail while the lesson runs; the rail it has passed is in the accent.
      final y = 18 + progress * (size.height - 30).clamp(0.0, double.infinity);
      canvas.drawLine(Offset(_x, top), Offset(_x, y), linePaint..color = ink);
      canvas.drawCircle(Offset(_x, y), 9, Paint()..color = soft);
      canvas.drawCircle(Offset(_x, y), 5, Paint()..color = ink);
      return;
    }
    final center = const Offset(_x, 18);
    canvas.drawCircle(center, 4, Paint()..color = state == _State.done ? dot : background);
    canvas.drawCircle(
      center,
      4,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = kind == _Kind.event ? event : dot,
    );
  }

  @override
  bool shouldRepaint(_RailPainter old) =>
      old.first != first || old.last != last || old.state != state || old.kind != kind || old.progress != progress || old.line != line || old.ink != ink || old.dot != dot || old.background != background;
}
