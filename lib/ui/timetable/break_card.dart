import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import 'day_schedule.dart';

class BreakCard extends StatelessWidget {
  const BreakCard({super.key, required this.item, required this.now});

  final BreakItem item;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final t = AppLocalizations.of(context)!;
    final current = item.isCurrentAt(now);

    final label = item.isLunch ? t.lunchBreakDuration(item.minutes) : t.breakDuration(item.minutes);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: current ? colors.primary.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: current ? colors.primary.withValues(alpha: 0.5) : colors.border,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.isLunch ? FIcons.utensils : FIcons.coffee,
              size: 14, color: current ? colors.primary : colors.mutedForeground),
          const SizedBox(width: 6),
          Text(label,
              style: typography.xs.copyWith(
                color: current ? colors.primary : colors.mutedForeground,
                fontWeight: current ? FontWeight.w500 : FontWeight.normal,
              )),
          if (current) ...[
            const SizedBox(width: 6),
            Text('· ${t.minutesLeft(item.remainingMinutesAt(now))}',
                style: typography.xs.copyWith(color: colors.primary, fontWeight: FontWeight.w500)),
          ],
        ],
      ),
    );
  }
}
