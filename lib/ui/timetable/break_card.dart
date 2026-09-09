import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import 'day_schedule.dart';

/// A gap between two lessons. Kept in the same outlined tile language as
/// [LessonTile] but visibly slimmer and muted, since breaks are secondary
/// information: single line, tighter padding, no subtitle row.
class BreakCard extends StatelessWidget {
  const BreakCard({super.key, required this.item, required this.now, this.showTime = true});

  final BreakItem item;
  final DateTime now;

  /// Whether the time range is appended to the label. The timetable's
  /// timeline already shows it in its own column.
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final t = AppLocalizations.of(context)!;
    final current = item.isCurrentAt(now);

    final label = item.isLunch ? t.lunchBreakDuration(item.minutes) : t.breakDuration(item.minutes);
    final range = showTime ? '${formatHm(item.start)} – ${formatHm(item.end)}' : null;
    final base = range == null ? label : '$label · $range';
    final remaining = current ? t.minutesLeft(item.remainingMinutesAt(now)) : null;

    // The timeline's tile is narrow, so "details" ellipsises there - fold the
    // remaining-minutes text into the title instead. The home page keeps the
    // roomier "details" slot.
    final Widget title;
    if (!showTime && remaining != null) {
      title = Text.rich(TextSpan(children: [
        TextSpan(text: '$base · ', style: TextStyle(color: colors.mutedForeground)),
        TextSpan(text: remaining, style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600)),
      ]));
    } else {
      title = Text(base, style: TextStyle(color: colors.mutedForeground));
    }

    return FTile(
      style: (style) =>
          style.copyWith(contentStyle: (content) => content.copyWith(padding: const EdgeInsetsDirectional.fromSTEB(15, 6, 10, 6))),
      prefix: Icon(item.isLunch ? FIcons.utensils : FIcons.coffee, size: 16, color: colors.mutedForeground),
      title: title,
      details: showTime && remaining != null
          ? Text(remaining, style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600))
          : null,
    );
  }
}
