import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';
import 'break_card.dart';
import 'day_schedule.dart';
import 'entry_style.dart';

class TimelineRow extends StatelessWidget {
  const TimelineRow({super.key, required this.item, required this.now, required this.isLast});

  final DayItem item;
  final DateTime now;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final dayItem = item;
    final showEndTime = dayItem is! LessonItem || dayItem.hasEndTime;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 68,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatHm(item.start),
                      style: typography.xs.copyWith(fontWeight: FontWeight.w600)),
                  if (showEndTime)
                    Text(formatHm(item.end),
                        style: typography.xs.copyWith(color: colors.mutedForeground)),
                ],
              ),
            ),
          ),
          Container(width: 1, color: colors.border),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: isLast
                  ? null
                  : BoxDecoration(
                      border: Border(bottom: BorderSide(color: colors.border.withValues(alpha: 0.4))),
                    ),
              child: switch (item) {
                LessonItem lesson => _LessonContent(lesson: lesson, now: now),
                BreakItem brk => BreakCard(item: brk, now: now),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonContent extends StatelessWidget {
  const _LessonContent({required this.lesson, required this.now});

  final LessonItem lesson;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final t = AppLocalizations.of(context)!;
    final style = entryStyle(context, lesson.entry.entryType);
    final current = lesson.isCurrentAt(now);
    final borderColor = current ? colors.primary : colors.border;

    final subtitle = [lesson.entry.place, lesson.entry.description]
        .where((s) => s != null && s.isNotEmpty)
        .join(' - ');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: current ? 1.5 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(lesson.entry.title,
                    style: typography.sm.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
              if (lesson.entry.entryType != AgendaEntryType.lesson) ...[
                const SizedBox(width: 6),
                EntryTypeBadge(label: style.label, color: style.color),
              ],
            ],
          ),
          if (subtitle.isNotEmpty || current) ...[
            const SizedBox(height: 2),
            Text(
              [
                if (subtitle.isNotEmpty) subtitle,
                if (current) t.minutesLeft(lesson.remainingMinutesAt(now)),
              ].join(' · '),
              style: typography.xs.copyWith(color: colors.mutedForeground),
            ),
          ],
        ],
      ),
    );
  }
}
