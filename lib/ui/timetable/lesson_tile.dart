import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import 'day_schedule.dart';
import 'entry_style.dart';

/// A lesson on the home page, styled like every other home tile: icon prefix,
/// title, one-line subtitle, optional detail on the right.
class LessonTile extends StatelessWidget {
  const LessonTile({super.key, required this.item, required this.now, this.showTime = true});

  final LessonItem item;
  final DateTime now;

  /// Whether the time range is part of the subtitle. The timetable's timeline
  /// already shows it in its own column.
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final t = AppLocalizations.of(context)!;
    final style = entryStyle(context, item.entry.entryType);
    final current = item.isCurrentAt(now);

    final time = item.hasEndTime
        ? '${formatHm(item.start)} – ${formatHm(item.end)}'
        : formatHm(item.start);
    final subtitleText = [
      if (showTime) time,
      item.entry.place,
      item.entry.description,
    ].where((s) => s != null && s.isNotEmpty).join(' · ');
    final remaining = current ? t.minutesLeft(item.remainingMinutesAt(now)) : null;

    // The timeline's tile is narrow, so "details" ellipsises there - fold the
    // remaining-minutes text into the subtitle instead. The home page keeps
    // the roomier "details" slot.
    final Widget? subtitle;
    if (!showTime && remaining != null) {
      subtitle = Text.rich(TextSpan(children: [
        if (subtitleText.isNotEmpty) TextSpan(text: '$subtitleText · '),
        TextSpan(text: remaining, style: TextStyle(color: colors.primary)),
      ]));
    } else {
      subtitle = subtitleText.isEmpty ? null : Text(subtitleText);
    }

    return FTile(
      prefix: Icon(style.icon, color: current ? colors.primary : null),
      title: Text(item.entry.title.isNotEmpty ? item.entry.title : style.label),
      subtitle: subtitle,
      details: showTime && remaining != null ? Text(remaining) : null,
    );
  }
}
