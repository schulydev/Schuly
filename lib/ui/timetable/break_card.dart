import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import 'day_schedule.dart';

/// A gap between two lessons, in the same tile style as the lessons around it.
class BreakCard extends StatelessWidget {
  const BreakCard({super.key, required this.item, required this.now, this.showTime = true});

  final BreakItem item;
  final DateTime now;

  /// Whether the time range is part of the subtitle. The timetable's timeline
  /// already shows it in its own column.
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final t = AppLocalizations.of(context)!;
    final current = item.isCurrentAt(now);

    final label = item.isLunch ? t.lunchBreakDuration(item.minutes) : t.breakDuration(item.minutes);

    return FTile(
      prefix: Icon(item.isLunch ? FIcons.utensils : FIcons.coffee, color: current ? colors.primary : null),
      title: Text(label),
      subtitle: showTime ? Text('${formatHm(item.start)} – ${formatHm(item.end)}') : null,
      details: current ? Text(t.minutesLeft(item.remainingMinutesAt(now))) : null,
    );
  }
}
