import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../../services/outlook_calendar.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';

/// The colour of [e]'s account, as the web gives each linked account one.
Color outlookColor(OutlookEvent e) => Color(OutlookCalendar.instance.account(e.accountId)?.color ?? outlookAccountColors.first);

/// "Dienstag, 10. November, 13:00 - 14:00", "…, ganztägig" or a range of days, as the web's event sheet says it.
String outlookWhen(AppLocalizations t, Dates dates, OutlookEvent e) {
  if (e.allDay) {
    final last = e.lastDay;
    return sameDay(e.start, last) ? t.eventAllDay(dates.dayLong(e.start)) : t.eventRange(dates.dayLong(e.start), dates.dayLong(last));
  }
  return sameDay(e.start, e.end)
      ? '${dates.dayLong(e.start)}, ${dates.hm(e.start)} - ${dates.hm(e.end)}'
      : t.eventRange('${dates.dayLong(e.start)} ${dates.hm(e.start)}', '${dates.dayLong(e.end)} ${dates.hm(e.end)}');
}

Future<void> _open(String url) => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

/// The web's event sheet: the account it comes from, the title, when, where, who and the preview, with "Join
/// meeting" and "Open in Outlook".
Future<void> showOutlookEvent(BuildContext context, OutlookEvent e) {
  final t = AppLocalizations.of(context)!;
  final dates = Dates(context);
  final account = OutlookCalendar.instance.account(e.accountId);
  return showSchulySheet<void>(
    context,
    builder: (ctx) {
      final colors = ctx.theme.colors;
      final typography = ctx.theme.typography;
      final muted = typography.sm.copyWith(color: colors.mutedForeground);
      final actions = [
        if (e.joinUrl != null) FButton(style: blockButton(FButtonStyle.primary), onPress: () => _open(e.joinUrl!), child: Text(t.eventJoin)),
        if (e.webLink != null) FButton(style: blockButton(FButtonStyle.outline), onPress: () => _open(e.webLink!), child: Text(t.eventOpenOutlook)),
      ];
      return SchulySheet(
        title: e.title,
        subtitle: e.cancelled ? '${t.eventCancelled} ${outlookWhen(t, dates, e)}' : outlookWhen(t, dates, e),
        footer: actions.isEmpty ? null : Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 8, children: actions),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Row(
              children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: outlookColor(e))),
                const SizedBox(width: 8),
                Expanded(child: Text(account?.email ?? 'Outlook', style: typography.xs.copyWith(color: colors.mutedForeground))),
              ],
            ),
            if (e.location != null) Text(e.location!, style: typography.sm),
            if (e.organizer != null) Text(e.organizer!, style: typography.sm),
            if (e.preview != null) Text(e.preview!, style: muted),
            if (account != null) Text(t.eventFrom(account.detail), style: typography.xs.copyWith(color: colors.mutedForeground)),
          ],
        ),
      );
    },
  );
}

/// The day's Outlook events as the web's day list draws them: see-through cards with the account's colour as a left
/// bar, the time on the left, then the title, the account and the place.
class OutlookDayList extends StatelessWidget {
  const OutlookDayList({super.key, required this.events});

  final List<OutlookEvent> events;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final small = typography.xs.copyWith(color: colors.foreground.withValues(alpha: 0.7));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        for (final e in events)
          FTappable(
            onPress: () => showOutlookEvent(context, e),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
              decoration: BoxDecoration(
                color: outlookColor(e).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(SchulyRadii.base),
                border: Border(left: BorderSide(color: outlookColor(e), width: 4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 56,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(e.allDay ? t.eventAllDayShort : '${dates.hm(e.start)}\n${dates.hm(e.end)}', maxLines: 2, style: small.copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: typography.sm.copyWith(fontWeight: FontWeight.w500, decoration: e.cancelled ? TextDecoration.lineThrough : null)),
                        Text(OutlookCalendar.instance.account(e.accountId)?.email ?? 'Outlook', maxLines: 1, overflow: TextOverflow.ellipsis, style: small),
                        if (e.location != null) Text(e.location!, maxLines: 1, overflow: TextOverflow.ellipsis, style: small),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Room for [OutlookDayList] under a section heading, or nothing on a day without events.
List<Widget> outlookSection(BuildContext context, List<OutlookEvent> events) => events.isEmpty ? const [] : [const SectionHead('Outlook'), OutlookDayList(events: events)];
