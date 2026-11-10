import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../domain/absence_status.dart';
import '../../l10n/app_localizations.dart';
import '../../services/school_data_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';

/// "Absence · Krankheit"
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

/// Opens the absence detail: status, what it cost, and the excuse steps Schuly can see.
Future<void> showAbsenceDetail(BuildContext context, AbsenceDto absence, AbsenceState state, {VoidCallback? onReport, VoidCallback? onEdit}) =>
    showSchulySheet<void>(context, builder: (_) => AbsenceDetailSheet(absence: absence, state: state, onReport: onReport, onEdit: onEdit));

class AbsenceDetailSheet extends StatelessWidget {
  const AbsenceDetailSheet({super.key, required this.absence, required this.state, this.onReport, this.onEdit});

  final AbsenceDto absence;
  final AbsenceState state;

  /// Reports the absence to the school; shown while it still needs an excuse.
  final VoidCallback? onReport;

  /// Edits an absence kept in Schuly only.
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final extent = absenceExtent(t, dates, absence);
    final isDelay = absence.type == AbsenceType.delay;

    Widget fact(String label, Widget value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: typography.xs.copyWith(color: colors.mutedForeground)),
            const SizedBox(height: 2),
            value,
          ],
        );

    final steps = [
      _Step(
        title: t.absenceStepReported,
        detail: switch (state) {
          AbsenceState.needsExcuse => t.absenceStepReportedTodo,
          AbsenceState.waiting => t.absenceStepReportedDone,
          AbsenceState.excused => null,
        },
        done: state != AbsenceState.needsExcuse,
        next: state == AbsenceState.needsExcuse,
        nextLabel: t.absenceStepDoNext,
      ),
      _Step(
        title: t.absenceStepSchool,
        detail: state == AbsenceState.excused ? null : t.absenceStepSchoolDetail,
        done: state == AbsenceState.excused,
        next: state == AbsenceState.waiting,
        nextLabel: t.absenceStepWaiting,
      ),
    ];

    final Widget? footer = state == AbsenceState.needsExcuse && onReport != null
        ? FButton(style: blockButton(FButtonStyle.primary), onPress: () {
            Navigator.of(context).pop();
            onReport!();
          }, child: Text(t.absenceReportTitle))
        : onEdit != null
            ? FButton(style: blockButton(FButtonStyle.outline), onPress: () {
                Navigator.of(context).pop();
                onEdit!();
              }, child: Text(t.absenceEdit))
            : null;

    return SchulySheet(
      title: absenceTitle(t, absence),
      subtitle: '${absenceWhen(dates, absence)}${absence.from.toLocal().year}',
      action: t.done,
      footer: footer,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.border))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: fact(t.absenceStatus, absenceStateLabel(context, state))),
                const SizedBox(width: 12),
                Expanded(child: fact(isDelay ? t.absenceLate : t.absenceMissed, Text(extent ?? '-', style: typography.base.copyWith(fontWeight: FontWeight.w500)))),
              ],
            ),
          ),
          Eyebrow(t.absenceSteps),
          const SizedBox(height: 6),
          for (final (i, s) in steps.indexed) _StepRow(step: s, last: i == steps.length - 1),
          Text(t.absenceStepsNote, style: typography.xs.copyWith(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}

class _Step {
  const _Step({required this.title, required this.detail, required this.done, required this.next, required this.nextLabel});

  final String title;
  final String? detail;
  final bool done;
  final bool next;
  final String nextLabel;
}

/// One excuse step: a check mark when done, an amber ring on the step that is due.
class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.last});

  final _Step step;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final mark = Container(
      width: 18,
      height: 18,
      margin: const EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: step.done ? tokens.good : tokens.card,
        border: Border.all(color: step.done ? tokens.good : (step.next ? tokens.warn : colors.mutedForeground), width: 2),
        boxShadow: step.next ? [BoxShadow(color: tokens.warnBackground, spreadRadius: 4)] : null,
      ),
      child: step.done ? Icon(FIcons.check, size: 11, color: colors.background) : null,
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
                if (!last) Expanded(child: Container(width: 2, color: step.done ? Color.lerp(tokens.good, colors.border, 0.55) : colors.border)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.next ? '${step.title} · ${step.nextLabel}' : step.title, style: typography.base.copyWith(fontWeight: FontWeight.w500, color: step.next ? tokens.warn : null)),
                  if (step.detail != null) Text(step.detail!, style: typography.sm.copyWith(color: colors.mutedForeground)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
