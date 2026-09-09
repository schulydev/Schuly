import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'break_card.dart';
import 'day_schedule.dart';
import 'lesson_tile.dart';

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
          FDivider(axis: Axis.vertical, style: (s) => s.copyWith(color: colors.border, padding: EdgeInsets.zero)),
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
                LessonItem lesson => LessonTile(item: lesson, now: now, showTime: false),
                BreakItem brk => BreakCard(item: brk, now: now, showTime: false),
              },
            ),
          ),
        ],
      ),
    );
  }
}
