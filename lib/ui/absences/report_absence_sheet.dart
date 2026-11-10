import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../l10n/app_localizations.dart';
import '../../services/absence_reporting_service.dart';
import '../../services/toast_service.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';

/// Words a failed report for the student; the school's own message is shown when it rejected the report.
String absenceReportErrorText(AppLocalizations t, AbsenceReportException e) {
  final server = e.serverMessage;
  return switch (e.kind) {
    AbsenceReportErrorKind.schoolRejected => server ?? t.absenceErrRejected,
    AbsenceReportErrorKind.invalidRequest => server ?? t.absenceErrInvalid,
    AbsenceReportErrorKind.notWithdrawable => t.absenceErrNotWithdrawable,
    AbsenceReportErrorKind.notAllowed => t.absenceErrNotAllowed,
    AbsenceReportErrorKind.signInExpired => t.absenceErrSignIn,
    AbsenceReportErrorKind.schoolUnavailable => t.absenceErrUnavailable,
    AbsenceReportErrorKind.network => t.absenceErrNetwork,
    AbsenceReportErrorKind.notAvailable || AbsenceReportErrorKind.other => t.absenceErrOther,
  };
}

String _issueText(AppLocalizations t, AbsenceDraftIssue issue) => switch (issue) {
      AbsenceDraftIssue.endBeforeStart => t.absenceIssueEndBeforeStart,
      AbsenceDraftIssue.timesIncomplete => t.absenceIssueTimesIncomplete,
      AbsenceDraftIssue.timeEndNotAfterStart => t.absenceIssueTimeEnd,
      AbsenceDraftIssue.reasonRequired => t.absenceIssueReasonRequired,
      AbsenceDraftIssue.reasonTooLong => t.absenceIssueReasonLong,
      AbsenceDraftIssue.commentTooLong => t.absenceIssueCommentLong,
    };

const _noReason = '';
const _otherReason = '__other__';

/// The "Report absence" sheet that sends the report to the school.
class ReportAbsenceSheet extends StatefulWidget {
  final AbsenceReportTarget target;

  /// The day to start from, such as the day of an absence that still needs an excuse; today when null.
  final DateTime? initialFrom;
  final DateTime? initialTo;
  const ReportAbsenceSheet({super.key, required this.target, this.initialFrom, this.initialTo});

  @override
  State<ReportAbsenceSheet> createState() => _ReportAbsenceSheetState();
}

class _ReportAbsenceSheetState extends State<ReportAbsenceSheet> {
  final _reason = TextEditingController();
  final _comment = TextEditingController();
  late DateTime _from;
  late DateTime _to;
  String _reasonChoice = _noReason;
  bool _partial = false;
  FTime? _start;
  FTime? _end;
  bool _busy = false;
  String? _error;
  List<String>? _reasons;

  /// Bumped when the end date is moved programmatically, so its field picks up the new value.
  int _toRevision = 0;

  @override
  void initState() {
    super.initState();
    final start = widget.initialFrom ?? DateTime.now();
    _from = DateTime(start.year, start.month, start.day);
    final end = widget.initialTo ?? _from;
    _to = DateTime(end.year, end.month, end.day);
    if (_to.isBefore(_from)) _to = _from;
    _loadReasons();
  }

  Future<void> _loadReasons() async {
    final list = await AbsenceReportingService.instance.reasons(widget.target);
    if (mounted) setState(() => _reasons = list);
  }

  @override
  void dispose() {
    _reason.dispose();
    _comment.dispose();
    super.dispose();
  }

  AbsenceDraft _draft() => AbsenceDraft(
        dateFrom: _from,
        dateTo: _to,
        hourFrom: _partial && _start != null ? AbsenceDraft.formatTime(_start!.hour, _start!.minute) : null,
        hourTo: _partial && _end != null ? AbsenceDraft.formatTime(_end!.hour, _end!.minute) : null,
        reason: _reasonChoice == _otherReason ? _reason.text : _reasonChoice,
        customReason: _reasonChoice == _otherReason,
        comment: _comment.text,
      );

  Future<void> _send() async {
    final t = AppLocalizations.of(context)!;
    final draft = _draft();
    final issue = draft.validate();
    if (issue != null) {
      setState(() => _error = _issueText(t, issue));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AbsenceReportingService.instance.create(widget.target, draft);
      ToastService.success(t.absenceSentToast);
      if (mounted) Navigator.of(context).pop(true);
    } on AbsenceReportException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = absenceReportErrorText(t, e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final today = DateTime.now();
    final first = DateTime(today.year - 1);
    final last = DateTime(today.year + 1, 12, 31);
    final format = DateFormat('EEE, dd.MM.', Localizations.localeOf(context).languageCode);
    Widget chevron(BuildContext _, Object _, Set<WidgetState> _) => Padding(padding: const EdgeInsetsDirectional.only(start: 8, end: 14), child: Icon(FIcons.chevronDown, size: 16, color: colors.mutedForeground));
    Widget pair(Widget a, Widget b) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: a), const SizedBox(width: 10), Expanded(child: b)]);
    return SchulySheet(
      title: t.absenceReportTitle,
      subtitle: t.absenceReportSubtitle,
      action: t.absenceCancel,
      footer: FButton(style: blockButton(FButtonStyle.primary), onPress: _busy ? null : _send, child: Text(_busy ? t.absenceSending : t.absenceSend)),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          pair(
            FDateField.calendar(
              label: Text(t.absenceFrom),
              start: first,
              end: last,
              clearable: false,
              format: format,
              prefixBuilder: null,
              suffixBuilder: chevron,
              control: FDateFieldControl.managed(
                initial: _from,
                onChange: (d) {
                  if (d == null) return;
                  setState(() {
                    _from = DateTime(d.year, d.month, d.day);
                    if (_to.isBefore(_from)) {
                      _to = _from;
                      _toRevision++;
                    }
                  });
                },
              ),
            ),
            FDateField.calendar(
              key: ValueKey(_toRevision),
              label: Text(t.absenceTo),
              start: first,
              end: last,
              clearable: false,
              format: format,
              prefixBuilder: null,
              suffixBuilder: chevron,
              control: FDateFieldControl.managed(
                initial: _to,
                onChange: (d) {
                  if (d != null) setState(() => _to = DateTime(d.year, d.month, d.day));
                },
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.absenceWholeDay, style: typography.base.copyWith(fontWeight: FontWeight.w500)),
                    Text(t.absenceWholeDayHint, style: typography.sm.copyWith(color: colors.mutedForeground)),
                  ],
                ),
              ),
              FSwitch(value: !_partial, onChange: _busy ? null : (v) => setState(() => _partial = !v)),
            ],
          ),
          if (_partial)
            pair(
              FTimeField.picker(
                label: Text(t.absenceTimeStart),
                hour24: true,
                prefixBuilder: null,
                suffixBuilder: chevron,
                control: FTimeFieldControl.managed(initial: _start, onChange: (v) => setState(() => _start = v)),
              ),
              FTimeField.picker(
                label: Text(t.absenceTimeEnd),
                hour24: true,
                prefixBuilder: null,
                suffixBuilder: chevron,
                control: FTimeFieldControl.managed(initial: _end, onChange: (v) => setState(() => _end = v)),
              ),
            ),
          FSelect<String>(
            label: Text(t.absenceReasonLabel),
            enabled: _reasons != null,
            control: FSelectControl<String>.lifted(value: _reasonChoice, onChange: (v) => setState(() => _reasonChoice = v ?? _noReason)),
            items: {
              t.absenceReasonNone: _noReason,
              for (final r in _reasons ?? const <String>[]) r: r,
              t.absenceReasonOther: _otherReason,
            },
          ),
          if (_reasonChoice == _otherReason)
            FTextField(control: FTextFieldControl.managed(controller: _reason), label: Text(t.absenceReasonCustomLabel), maxLength: absenceTextLimit),
          FTextField(control: FTextFieldControl.managed(controller: _comment), label: Text(t.absenceCommentLabel), hint: t.absenceCommentHint, minLines: 2, maxLines: 4),
          if (_error != null) Text(_error!, style: typography.sm.copyWith(color: colors.destructive)),
          Text(t.absenceReportFootnote, style: typography.xs.copyWith(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}
