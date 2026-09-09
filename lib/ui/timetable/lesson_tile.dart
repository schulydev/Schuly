import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import 'day_schedule.dart';
import 'entry_style.dart';

class LessonTile extends StatelessWidget {
  const LessonTile({super.key, required this.item, required this.now});

  final LessonItem item;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final t = AppLocalizations.of(context)!;
    final style = entryStyle(context, item.entry.entryType);
    final current = item.isCurrentAt(now);
    final borderColor = current ? colors.primary : colors.border;

    final place = item.entry.place;
    final description = item.entry.description;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: current ? 1.5 : 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${t.lessonFrom} ${formatHm(item.start)}',
                  style: typography.xs.copyWith(color: colors.mutedForeground)),
              if (item.hasEndTime)
                Text('${t.lessonUntil} ${formatHm(item.end)}',
                    style: typography.xs.copyWith(color: colors.mutedForeground)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(style.icon, size: 14, color: style.color),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(item.entry.title,
                          style: typography.sm.copyWith(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    if (place != null && place.isNotEmpty)
                      _IconLabel(icon: FIcons.mapPin, label: place),
                    if (description != null && description.isNotEmpty)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: _IconLabel(icon: FIcons.user, label: description, ellipsis: true),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (current) _RemainingChip(label: t.minutesLeft(item.remainingMinutesAt(now))),
        ],
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({required this.icon, required this.label, this.ellipsis = false});

  final IconData icon;
  final String label;
  final bool ellipsis;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colors.mutedForeground),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: typography.xs.copyWith(color: colors.mutedForeground),
            overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class _RemainingChip extends StatelessWidget {
  const _RemainingChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(FIcons.clock, size: 14, color: colors.primary),
        const SizedBox(width: 4),
        Text(label, style: typography.xs.copyWith(color: colors.primary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
