import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/absence_rows.dart';
import '../../l10n/app_localizations.dart';
import '../../services/absence_reporting_service.dart';
import '../../services/reported_absences.dart';
import '../../services/toast_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';
import 'report_absence_sheet.dart' show absenceReportErrorText;

/// "Di, 03.11." or "Di, 01.09. – Fr, 04.09."
String absenceRange(Dates dates, AbsenceRow row) => sameDay(row.from, row.until) ? dates.weekdayDayMonth(row.from) : '${dates.weekdayDayMonth(row.from)} – ${dates.weekdayDayMonth(row.until)}';

/// The time of a part-day absence, or how many days a longer one ran.
String? absenceDetail(AppLocalizations t, AbsenceRow row) {
  if (row.time != null) return row.time;
  final days = row.until.difference(row.from).inDays + 1;
  return days > 1 ? t.absenceDays(days) : null;
}

/// "Krankheit" or "Zug verspätet · Verspätung".
String absenceReasonLine(AppLocalizations t, AbsenceRow row) {
  final reason = row.reason ?? t.absenceAbsent;
  return row.isDelay ? '$reason · ${t.absenceTypeDelay}' : reason;
}

/// The status in the web's words, empty when nothing is known.
String absenceStatusText(AppLocalizations t, Dates dates, AbsenceRow row) => switch (row.state) {
      AbsenceState.excused => t.absenceExcused,
      AbsenceState.rejected => row.rejectedBy == StepKind.parents ? t.absenceStatusRejectedParents : t.absenceStatusRejectedLehrmeister,
      AbsenceState.waiting => switch (row.waitingFor) {
          StepKind.parents => t.absenceStatusWaitingParents,
          StepKind.lehrmeister => t.absenceStatusWaitingLehrmeister,
          _ => t.absenceStatusWaitingSchool,
        },
      AbsenceState.upcoming => t.absenceStatusUpcoming,
      AbsenceState.needsExcuse => t.absenceStatusNeedsExcuse(row.dueExpected ? t.absenceStatusDueExpected(dates.dayMonth(row.due!)) : t.absenceStatusDue(dates.dayMonth(row.due!))),
      AbsenceState.unexcused => t.absenceStatusNotExcused,
      AbsenceState.unknown => '',
    };

/// The status with its dot, toned as on the web: excused muted with a green dot, waiting amber, open or rejected red.
Widget? absenceStatusLabel(BuildContext context, AbsenceRow row) {
  final t = AppLocalizations.of(context)!;
  final text = absenceStatusText(t, Dates(context), row);
  if (text.isEmpty) return null;
  final tokens = context.tokens;
  final muted = context.theme.colors.mutedForeground;
  return switch (row.state) {
    AbsenceState.excused => StatusLabel(text, color: muted, dot: tokens.good),
    AbsenceState.waiting => StatusLabel(text, color: tokens.warn),
    AbsenceState.upcoming || AbsenceState.unknown => StatusLabel(text, color: muted),
    _ => StatusLabel(text, color: tokens.bad),
  };
}

/// Opens one absence, with what the web shows when a row is expanded: the steps, the Lehrmeister's comment, and the
/// print and withdraw actions.
Future<void> showAbsenceDetail(BuildContext context, AbsenceRow row) => showSchulySheet<void>(context, builder: (_) => AbsenceDetailSheet(row: row));

class AbsenceDetailSheet extends StatefulWidget {
  const AbsenceDetailSheet({super.key, required this.row});

  final AbsenceRow row;

  @override
  State<AbsenceDetailSheet> createState() => _AbsenceDetailSheetState();
}

class _AbsenceDetailSheetState extends State<AbsenceDetailSheet> {
  bool _withdrawing = false;

  Future<void> _withdraw(ReportedAbsence report) async {
    final t = AppLocalizations.of(context)!;
    final target = ReportedAbsences.instance.target;
    if (target == null) return;
    final confirmed = await showSchulySheet<bool>(
      context,
      builder: (sheetCtx) => SchulySheet(
        title: t.absenceWithdrawQuestion,
        subtitle: t.absenceWithdrawDescription,
        footer: SheetButtons(
          left: FButton(style: blockButton(FButtonStyle.outline), onPress: () => Navigator.of(sheetCtx).pop(false), child: Text(t.absenceKeepReport)),
          right: FButton(style: blockButton(FButtonStyle.destructive), onPress: () => Navigator.of(sheetCtx).pop(true), child: Text(t.absenceWithdraw)),
        ),
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _withdrawing = true);
    try {
      await AbsenceReportingService.instance.withdraw(target, report.ids);
      ToastService.success(t.absenceWithdrawnToast);
      if (mounted) Navigator.of(context).pop();
    } on AbsenceReportException catch (e) {
      ToastService.error(t.absenceWithdrawTitle, absenceReportErrorText(t, e));
      if (mounted) setState(() => _withdrawing = false);
    }
    await ReportedAbsences.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    final row = widget.row;
    final status = absenceStatusLabel(context, row);
    final report = row.report;

    final actions = <Widget>[
      if (row.printUrl != null) FButton(style: blockButton(FButtonStyle.outline), onPress: () => launchUrl(Uri.parse(row.printUrl!), mode: LaunchMode.externalApplication), child: Text(t.absencePrint)),
      if (report != null) FButton(style: blockButton(FButtonStyle.outline), onPress: _withdrawing ? null : () => _withdraw(report), child: Text(t.absenceWithdraw)),
    ];

    (Color, Color?, bool) stepTone(StepState s) => switch (s) {
          StepState.done => (colors.foreground, tokens.good, false),
          StepState.next => (tokens.warn, null, true),
          StepState.rejected => (tokens.bad, tokens.bad, true),
          StepState.todo => (colors.mutedForeground, null, false),
        };
    String stepLabel(StepKind k) => switch (k) {
          StepKind.reported => t.absenceStepReported,
          StepKind.parents => t.absenceStepParents,
          StepKind.lehrmeister => t.absenceStepLehrmeister,
          StepKind.school => t.absenceStepSchool,
        };

    return SchulySheet(
      title: absenceRange(dates, row),
      subtitle: absenceDetail(t, row),
      action: t.done,
      footer: actions.isEmpty ? null : Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 8, children: actions),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(absenceReasonLine(t, row), style: typography.base.copyWith(fontWeight: FontWeight.w500)),
              if (row.note != null) Text(row.note!, style: typography.sm.copyWith(color: colors.mutedForeground)),
            ],
          ),
          ?status,
          if (row.steps.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Eyebrow(t.absenceProgress),
                Wrap(
                  spacing: 14,
                  runSpacing: 4,
                  children: [
                    for (final step in row.steps)
                      Builder(builder: (context) {
                        final (text, fill, strong) = stepTone(step.state);
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: fill, border: Border.all(color: fill ?? (step.state == StepState.next ? tokens.warn : colors.mutedForeground), width: 1.5)),
                            ),
                            const SizedBox(width: 6),
                            Text(stepLabel(step.kind), style: typography.sm.copyWith(color: text, fontWeight: strong ? FontWeight.w500 : null)),
                          ],
                        );
                      }),
                  ],
                ),
              ],
            ),
          if (row.trainerComment != null) Text(t.absenceTrainerComment(row.trainerComment!), style: typography.sm.copyWith(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}
