import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/absence_reporting_service.dart';
import '../../services/toast_service.dart';

/// Words a failed report for the student; the school's own message is shown when it rejected the report.
String absenceReportErrorText(AppLocalizations t, AbsenceReportException e) {
  final server = e.serverMessage;
  return switch (e.kind) {
    AbsenceReportErrorKind.schulnetzRejected => server ?? t.absenceErrRejected,
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
  const ReportAbsenceSheet({super.key, required this.target});

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

  /// Bumped when the end date is moved programmatically, so its field picks up the new value.
  int _toRevision = 0;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _from = DateTime(now.year, now.month, now.day);
    _to = _from;
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
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final navBar = MediaQuery.viewPaddingOf(context).bottom;
    final today = DateTime.now();
    final first = DateTime(today.year - 1);
    final last = DateTime(today.year + 1, 12, 31);
    return Container(
      decoration: BoxDecoration(color: colors.background),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + (keyboard > navBar ? keyboard : navBar)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.absenceReportTitle, style: typography.lg.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(t.absenceReportNote, style: typography.sm.copyWith(color: colors.mutedForeground)),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FDateField.calendar(
                    label: Text(t.absenceFrom),
                    start: first,
                    end: last,
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
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FDateField.calendar(
                    key: ValueKey(_toRevision),
                    label: Text(t.absenceTo),
                    start: first,
                    end: last,
                    control: FDateFieldControl.managed(
                      initial: _to,
                      onChange: (d) {
                        if (d != null) setState(() => _to = DateTime(d.year, d.month, d.day));
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Text(t.absencePartialLessons, style: typography.sm)),
                FSwitch(value: _partial, onChange: _busy ? null : (v) => setState(() => _partial = v)),
              ],
            ),
            if (_partial) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FTimeField.picker(
                      label: Text(t.absenceTimeStart),
                      hour24: true,
                      control: FTimeFieldControl.managed(initial: _start, onChange: (v) => setState(() => _start = v)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FTimeField.picker(
                      label: Text(t.absenceTimeEnd),
                      hour24: true,
                      control: FTimeFieldControl.managed(initial: _end, onChange: (v) => setState(() => _end = v)),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            FSelect<String>(
              label: Text(t.absenceReasonLabel),
              control: FSelectControl<String>.lifted(value: _reasonChoice, onChange: (v) => setState(() => _reasonChoice = v ?? _noReason)),
              items: {
                t.absenceReasonNone: _noReason,
                for (final r in absenceReasons) r: r,
                t.absenceReasonOther: _otherReason,
              },
            ),
            if (_reasonChoice == _otherReason) ...[
              const SizedBox(height: 12),
              FTextField(control: FTextFieldControl.managed(controller: _reason), label: Text(t.absenceReasonCustomLabel), maxLength: absenceTextLimit),
            ],
            const SizedBox(height: 12),
            FTextField(control: FTextFieldControl.managed(controller: _comment), label: Text(t.absenceCommentLabel), minLines: 2, maxLines: 4),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: typography.sm.copyWith(color: colors.destructive)),
            ],
            const SizedBox(height: 16),
            FButton(onPress: _busy ? null : _send, child: Text(_busy ? t.absenceSending : t.absenceSend)),
          ],
        ),
      ),
    );
  }
}
