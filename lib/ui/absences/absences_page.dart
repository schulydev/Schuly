import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';
import '../../services/absence_reporting_service.dart';
import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../../services/app_mode_service.dart';
import '../../services/api_time.dart';
import '../../services/school_data_service.dart';
import '../../services/toast_service.dart';
import 'report_absence_sheet.dart';

class AbsencesPage extends StatefulWidget {
  const AbsencesPage({super.key});

  @override
  State<AbsencesPage> createState() => _AbsencesPageState();
}

class _AbsencesPageState extends State<AbsencesPage> {
  /// The Schulnetz connection reports go to, or null when absences stay in Schuly only.
  AbsenceReportTarget? _target;
  List<ReportedAbsence> _reported = const [];
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    ActiveAccountService.instance.addListener(_loadReported);
    AppModeService.instance.addListener(_loadReported);
    _loadReported();
  }

  @override
  void dispose() {
    ActiveAccountService.instance.removeListener(_loadReported);
    AppModeService.instance.removeListener(_loadReported);
    super.dispose();
  }

  Future<void> _loadReported() async {
    final gen = ++_generation;
    AbsenceReportTarget? target;
    var reported = const <ReportedAbsence>[];
    try {
      target = await AbsenceReportingService.instance.resolveTarget(isPrivate: AppModeService.instance.isPrivate);
      if (target != null) reported = await AbsenceReportingService.instance.reported(target);
    } on AbsenceReportException catch (e) {
      // The plugin has no reporting endpoints: fall back to Schuly-only absences. Other failures
      // keep the target so the student can still report.
      if (e.kind == AbsenceReportErrorKind.notAvailable) target = null;
    } catch (_) {
      // Detection is best effort; without a target the page behaves as before.
    }
    if (!mounted || gen != _generation) return;
    setState(() {
      _target = target;
      _reported = reported;
    });
  }

  Future<void> _refresh() async {
    await Future.wait([SchoolDataService.instance.refresh(), _loadReported()]);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final svc = SchoolDataService.instance;
    final absences = svc.absences.toList()
      ..sort((a, b) => b.from.compareTo(a.from));

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FButton(
        mainAxisSize: MainAxisSize.min,
        prefix: const Icon(FIcons.plus),
        onPress: _target == null && svc.me == null ? null : () => _openForm(context),
        child: const Text('Report'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
          children: [
            if (_reported.isNotEmpty) ...[
              _SectionLabel(t.absenceWaitingTitle),
              for (final r in _reported)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _ReportedTile(report: r, onWithdraw: () => _confirmWithdraw(context, r)),
                ),
              const SizedBox(height: 8),
            ],
            if (absences.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text('No absences', style: TextStyle(color: colors.mutedForeground)),
                ),
              )
            else
              for (final a in absences)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FTile(
                    prefix: const Icon(FIcons.calendarOff),
                    title: Text(a.reason.isNotEmpty ? a.reason : 'Absence'),
                    subtitle: Text(_rangeLabel(a.from, a.until)),
                    suffix: _TypeBadge(a.type),
                    onPress: () => _openForm(context, existing: a),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {AbsenceDto? existing}) async {
    final target = _target;
    final changed = await showFSheet<bool>(
      context: context,
      side: FLayout.btt,
      mainAxisMaxRatio: null,
      builder: (_) => target != null && existing == null ? ReportAbsenceSheet(target: target) : _AbsenceForm(existing: existing),
    );
    if (changed == true) await _refresh();
  }

  Future<void> _confirmWithdraw(BuildContext context, ReportedAbsence report) async {
    final target = _target;
    if (target == null) return;
    final t = AppLocalizations.of(context)!;
    final confirmed = await showFDialog<bool>(
      context: context,
      builder: (dCtx, style, animation) => FDialog(
        animation: animation,
        title: Text(t.absenceWithdrawTitle),
        body: Text(t.absenceWithdrawBody),
        actions: [
          FButton(onPress: () => Navigator.of(dCtx).pop(false), child: Text(t.absenceCancel)),
          FButton(onPress: () => Navigator.of(dCtx).pop(true), child: Text(t.absenceWithdraw)),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await AbsenceReportingService.instance.withdraw(target, report.ids);
      ToastService.success(t.absenceWithdrawnToast);
    } on AbsenceReportException catch (e) {
      ToastService.error(t.absenceWithdrawTitle, absenceReportErrorText(t, e));
    }
    await _refresh();
  }

  static String _rangeLabel(DateTime from, DateTime until) {
    String d(DateTime x) => '${x.day}.${x.month}.${x.year}';
    final f = d(from);
    return until.difference(from).inDays.abs() < 1 ? f : '$f – ${d(until)}';
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text.toUpperCase(), style: context.theme.typography.xs.copyWith(color: c.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}

class _ReportedTile extends StatelessWidget {
  final ReportedAbsence report;
  final VoidCallback onWithdraw;
  const _ReportedTile({required this.report, required this.onWithdraw});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    String d(DateTime x) => '${x.day}.${x.month}.${x.year}';
    final dates = report.dateFrom == report.dateTo ? d(report.dateFrom) : '${d(report.dateFrom)} – ${d(report.dateTo)}';
    final hasTimes = report.hourFrom != null && report.hourTo != null;
    final title = hasTimes ? '$dates, ${report.hourFrom} – ${report.hourTo}' : dates;
    final text = [report.reason, report.comment].whereType<String>().where((s) => s.trim().isNotEmpty).join(' - ');
    return FTile(
      prefix: const Icon(FIcons.clock),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text.isNotEmpty) Text(text, style: TextStyle(color: colors.mutedForeground)),
          if (report.profiles.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final p in report.profiles) FBadge(style: FBadgeStyle.secondary(), child: Text(p))],
            ),
          ],
        ],
      ),
      suffix: FButton(style: FButtonStyle.outline(), mainAxisSize: MainAxisSize.min, onPress: onWithdraw, child: Text(t.absenceWithdraw)),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final AbsenceType? type;
  const _TypeBadge(this.type);
  @override
  Widget build(BuildContext context) {
    final isDelay = type == AbsenceType.delay;
    final color = isDelay ? const Color(0xFFF59E0B) : const Color(0xFFEF4444);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(isDelay ? 'Delay' : 'Absence',
          style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}

class _AbsenceForm extends StatefulWidget {
  final AbsenceDto? existing;
  const _AbsenceForm({this.existing});
  @override
  State<_AbsenceForm> createState() => _AbsenceFormState();
}

class _AbsenceFormState extends State<_AbsenceForm> {
  late final TextEditingController _reason;
  late AbsenceType _type;
  late DateTime _from;
  late DateTime _until;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _reason = TextEditingController(text: e?.reason ?? '');
    _type = e?.type ?? AbsenceType.absence;
    _from = e?.from ?? DateTime.now();
    _until = e?.until ?? DateTime.now();
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isFrom) async {
    final initial = isFrom ? _from : _until;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 1),
      lastDate: DateTime(initial.year + 1),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _from = picked;
          if (_until.isBefore(_from)) _until = _from;
        } else {
          _until = picked;
        }
      });
    }
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final api = ApiClient.instance.api.getAbsencesApi();
      final existing = widget.existing;
      if (existing == null) {
        final schoolUserId = SchoolDataService.instance.me?.id;
        await api.apiAbsencesPost(
          createAbsenceCommand: CreateAbsenceCommand((b) => b
            ..reason = _reason.text.trim()
            ..type = _type
            ..from = ApiTime.utcDate(_from)
            ..until = ApiTime.utcDate(_until)
            ..schoolUserId = schoolUserId),
        );
      } else {
        await api.apiAbsencesPut(
          updateAbsenceCommand: UpdateAbsenceCommand((b) => b
            ..absenceId = existing.id
            ..reason = _reason.text.trim()
            ..type = _type
            ..from = ApiTime.utcDate(_from)
            ..until = ApiTime.utcDate(_until)
            ..schoolUserId = existing.schoolUserId),
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() => _error = 'HTTP ${e.response?.statusCode}: ${e.response?.data}');
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    final existing = widget.existing;
    if (existing?.id == null) return;
    setState(() => _busy = true);
    try {
      await ApiClient.instance.api.getAbsencesApi().apiAbsencesIdDelete(id: existing!.id!);
      if (mounted) Navigator.of(context).pop(true);
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'HTTP ${e.response?.statusCode}: ${e.response?.data}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    String d(DateTime x) => '${x.day}.${x.month}.${x.year}';
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final navBar = MediaQuery.viewPaddingOf(context).bottom;
    return Container(
      decoration: BoxDecoration(color: colors.background),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + (keyboard > navBar ? keyboard : navBar)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.existing == null ? 'Report absence' : 'Edit absence',
              style: context.theme.typography.lg.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          FTextField(
            control: FTextFieldControl.managed(controller: _reason),
            label: const Text('Reason'),
          ),
          const SizedBox(height: 12),
          SegmentedButton<AbsenceType>(
            segments: const [
              ButtonSegment(value: AbsenceType.absence, label: Text('Absence')),
              ButtonSegment(value: AbsenceType.delay, label: Text('Delay')),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
            showSelectedIcon: false,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(FIcons.calendar, size: 16),
                  onPressed: () => _pickDate(true),
                  label: Text('From: ${d(_from)}'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(FIcons.calendar, size: 16),
                  onPressed: () => _pickDate(false),
                  label: Text('Until: ${d(_until)}'),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            SelectableText(_error!, style: TextStyle(color: colors.destructive)),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              if (widget.existing != null) ...[
                IconButton(
                  onPressed: _busy ? null : _delete,
                  icon: Icon(FIcons.trash2, color: colors.destructive),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: FButton(
                  onPress: _busy ? null : _save,
                  child: Text(_busy ? 'Saving…' : 'Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
