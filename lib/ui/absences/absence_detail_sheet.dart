import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/absence_rows.dart';
import '../../domain/absence_status.dart';
import '../../l10n/app_localizations.dart';
import '../../services/absence_reporting_service.dart';
import '../../services/active_account_service.dart';
import '../../services/reported_absences.dart';
import '../../services/school_data_service.dart';
import '../../services/toast_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';
import 'report_absence_sheet.dart' show absenceReportErrorText;

/// "Absence · Krankheit", the row title on the Absences page and Home.
String absenceTitle(AppLocalizations t, AbsenceDto a) {
  final type = a.type == AbsenceType.delay ? t.absenceTypeDelay : t.absenceTypeAbsence;
  return a.reason.trim().isEmpty ? type : '$type · ${a.reason.trim()}';
}

/// "Tue, 03.11." or "Tue, 01.09. – Fri, 04.09."
String absenceWhen(Dates dates, AbsenceDto a) {
  final from = a.from.toLocal(), until = a.until.toLocal();
  return sameDay(from, until) ? dates.weekdayDayMonth(from) : '${dates.weekdayDayMonth(from)} – ${dates.weekdayDayMonth(until)}';
}

/// What the absence cost: the late minutes as a time range for a delay, the lessons for an absence.
String? absenceExtent(AppLocalizations t, Dates dates, AbsenceDto a) {
  if (a.type == AbsenceType.delay) return '${dates.hm(a.from.toLocal())} – ${dates.hm(a.until.toLocal())}';
  final n = lessonsDuring(SchoolDataService.instance.agenda, a.from, a.until);
  return n > 0 ? t.absenceLessons(n) : null;
}

/// The state in words with its dot: excused in muted text with a green dot, waiting in amber, open in red.
Widget absenceStateLabel(BuildContext context, AbsenceState state, {bool short = false}) {
  final t = AppLocalizations.of(context)!;
  final tokens = context.tokens;
  final colors = context.theme.colors;
  return switch (state) {
    AbsenceState.excused => StatusLabel(t.absenceExcused, color: colors.mutedForeground, dot: tokens.good),
    AbsenceState.waiting => StatusLabel(t.absenceWaiting, color: tokens.warn),
    AbsenceState.needsExcuse => StatusLabel(short ? t.absenceNeedsExcuseShort : t.absenceNeedsExcuse, color: tokens.bad),
  };
}

/// Every absence as the web builds its rows: the school's approval fields, the report waiting for it, BBB's rules
/// only where the school is BBB.
List<AbsenceRow> absenceRowsNow() {
  final schools = ActiveAccountService.instance.schools;
  final bbb = {for (final s in schools) if (isBbbWebsite(s.website)) s.id};
  // A report doesn't say which school it's from, so it only follows BBB's rules when that is the only school.
  final onlyBbb = schools.isNotEmpty && bbb.length == schools.length;
  final now = DateTime.now();
  return buildAbsenceRows(
    SchoolDataService.instance.absences,
    ReportedAbsences.instance.reported,
    today: DateTime(now.year, now.month, now.day),
    isBbb: (id) => id != null ? bbb.contains(id) : onlyBbb,
    website: (id) => (id != null ? schools.where((s) => s.id == id).firstOrNull : schools.firstOrNull)?.website,
  );
}

/// The web's view of one absence, with the report that covers it.
AbsenceRow absenceRowFor(AbsenceDto a) {
  final row = absenceRowsNow().where((r) => r.absence?.id != null && r.absence!.id == a.id).firstOrNull;
  if (row != null) return row;
  final now = DateTime.now();
  return buildAbsenceRows([a], const [], today: DateTime(now.year, now.month, now.day), isBbb: (_) => false, website: (_) => null).single;
}

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
      RowState.excused => t.absenceExcused,
      RowState.rejected => row.rejectedBy == StepKind.parents ? t.absenceStatusRejectedParents : t.absenceStatusRejectedLehrmeister,
      RowState.waiting => switch (row.waitingFor) {
          StepKind.parents => t.absenceStatusWaitingParents,
          StepKind.lehrmeister => t.absenceStatusWaitingLehrmeister,
          _ => t.absenceStatusWaitingSchool,
        },
      RowState.upcoming => t.absenceStatusUpcoming,
      RowState.needsExcuse => t.absenceStatusNeedsExcuse(row.dueExpected ? t.absenceStatusDueExpected(dates.dayMonth(row.due!)) : t.absenceStatusDue(dates.dayMonth(row.due!))),
      RowState.unexcused => t.absenceStatusNotExcused,
      RowState.unknown => '',
    };

/// The status with its dot, toned as on the web: excused muted with a green dot, waiting amber, open or rejected red.
Widget? absenceStatusLabel(BuildContext context, AbsenceRow row) {
  final t = AppLocalizations.of(context)!;
  final text = absenceStatusText(t, Dates(context), row);
  if (text.isEmpty) return null;
  final tokens = context.tokens;
  final muted = context.theme.colors.mutedForeground;
  return switch (row.state) {
    RowState.excused => StatusLabel(text, color: muted, dot: tokens.good),
    RowState.waiting => StatusLabel(text, color: tokens.warn),
    RowState.upcoming || RowState.unknown => StatusLabel(text, color: muted),
    _ => StatusLabel(text, color: tokens.bad),
  };
}

/// Opens one absence, with what the web shows when a row is expanded: the status, the steps, the Lehrmeister's
/// comment, and the print and withdraw actions. [onEdit] edits an absence kept in Schuly only.
Future<void> showAbsenceDetail(BuildContext context, AbsenceDto absence, {VoidCallback? onEdit}) => showSchulySheet<void>(context, builder: (_) => AbsenceDetailSheet(row: absenceRowFor(absence), onEdit: onEdit));

class AbsenceDetailSheet extends StatefulWidget {
  const AbsenceDetailSheet({super.key, required this.row, this.onEdit});

  final AbsenceRow row;

  /// Edits an absence kept in Schuly only, for schools without absence reporting.
  final VoidCallback? onEdit;

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
    final typography = context.theme.typography;
    final row = widget.row;
    final status = absenceStatusLabel(context, row);
    final report = row.report;

    final actions = <Widget>[
      if (row.printUrl != null) FButton(style: blockButton(FButtonStyle.outline), onPress: () => launchUrl(Uri.parse(row.printUrl!), mode: LaunchMode.externalApplication), child: Text(t.absencePrint)),
      if (report != null) FButton(style: blockButton(FButtonStyle.outline), onPress: _withdrawing ? null : () => _withdraw(report), child: Text(t.absenceWithdraw)),
      if (widget.onEdit != null)
        FButton(style: blockButton(FButtonStyle.outline), onPress: () {
          Navigator.of(context).pop();
          widget.onEdit!();
        }, child: Text(t.absenceEdit)),
    ];

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
                const SizedBox(height: 2),
                for (final (i, step) in row.steps.indexed) _StepRow(label: stepLabel(step.kind), state: step.state, last: i == row.steps.length - 1),
              ],
            ),
          if (row.trainerComment != null) Text(t.absenceTrainerComment(row.trainerComment!), style: typography.sm.copyWith(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}

/// One step in the 3.4.0 stepper: a check mark when done, an amber ring on the step that is due, a red cross where it
/// was rejected, and a line down to the next step.
class _StepRow extends StatelessWidget {
  const _StepRow({required this.label, required this.state, required this.last});

  final String label;
  final StepState state;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final done = state == StepState.done;
    final next = state == StepState.next;
    final rejected = state == StepState.rejected;
    final ring = done ? tokens.good : (rejected ? tokens.bad : (next ? tokens.warn : colors.mutedForeground));
    final mark = Container(
      width: 18,
      height: 18,
      margin: const EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: done ? tokens.good : (rejected ? tokens.bad : tokens.card),
        border: Border.all(color: ring, width: 2),
        boxShadow: next ? [BoxShadow(color: tokens.warnBackground, spreadRadius: 4)] : null,
      ),
      child: done ? Icon(FIcons.check, size: 11, color: colors.background) : (rejected ? Icon(FIcons.x, size: 11, color: colors.background) : null),
    );
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 18,
            child: Column(
              children: [
                mark,
                if (!last) Expanded(child: Container(width: 2, color: done ? Color.lerp(tokens.good, colors.border, 0.55) : colors.border)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : 16),
              child: Text(
                next ? '$label · ${t.absenceStepWaiting}' : label,
                style: typography.base.copyWith(fontWeight: FontWeight.w500, color: next ? tokens.warn : (rejected ? tokens.bad : (state == StepState.todo ? colors.mutedForeground : null))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
