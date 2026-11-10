import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:schuly_api/schuly_api.dart';

import '../../domain/absence_status.dart';
import '../../l10n/app_localizations.dart';
import '../../services/absence_reporting_service.dart';
import '../../services/api_client.dart';
import '../../services/api_time.dart';
import '../../services/reported_absences.dart';
import '../../services/school_data_service.dart';
import '../../services/toast_service.dart';
import '../core/dates.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';
import '../dashboard/dashboard_scope.dart';
import '../grades/grade_data.dart';
import 'absence_detail_sheet.dart';
import 'report_absence_sheet.dart';

enum _Filter { all, absences, delays }

class AbsencesPage extends StatefulWidget {
  const AbsencesPage({super.key});

  @override
  State<AbsencesPage> createState() => _AbsencesPageState();
}

class _AbsencesPageState extends State<AbsencesPage> {
  _Filter _filter = _Filter.all;
  int? _period;

  ReportedAbsences get _reports => ReportedAbsences.instance;

  @override
  void initState() {
    super.initState();
    _reports.start();
    _reports.addListener(_onDataChanged);
    // This page is const in the dashboard, so its parent rebuilding does not reach it.
    SchoolDataService.instance.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _reports.removeListener(_onDataChanged);
    SchoolDataService.instance.removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() => setState(() {});

  Future<void> _refresh() async {
    await Future.wait([SchoolDataService.instance.refresh(), _reports.load()]);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final svc = SchoolDataService.instance;
    final reported = _reports.reported;
    final all = svc.absences.toList()..sort((a, b) => b.from.compareTo(a.from));

    final periods = periodsFor(all.map((a) => semesterKey(a.from.toLocal())));
    final period = (_period != null && periods.contains(_period)) ? _period! : defaultPeriod(periods);
    final absences = all.where((a) {
      if (periods.length > 1 && !inPeriod(period, semesterKey(a.from.toLocal()))) return false;
      return switch (_filter) {
        _Filter.all => true,
        _Filter.absences => a.type != AbsenceType.delay,
        _Filter.delays => a.type == AbsenceType.delay,
      };
    }).toList();

    final rows = <Widget>[];
    String? month;
    var group = <FItem>[];
    void flush() {
      if (group.isEmpty) return;
      rows.add(FItemGroup(
        divider: FItemDivider.full,
        // Rows sit flush with the page gutter, as in the mockup.
        style: (s) => s.copyWith(itemStyle: (i) => i.copyWith(contentStyle: (c) => c.copyWith(padding: const EdgeInsetsDirectional.fromSTEB(0, 11, 0, 11)))),
        children: group,
      ));
      group = [];
    }

    for (final a in absences) {
      final m = dates.monthYear(a.from.toLocal());
      if (m != month) {
        flush();
        month = m;
        rows.add(Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 2),
          child: Text(m, style: context.theme.typography.xs.copyWith(fontWeight: FontWeight.w600, color: context.theme.colors.mutedForeground)),
        ));
      }
      final state = absenceState(a, reported);
      group.add(FItem(
        title: Text(absenceWhen(dates, a)),
        subtitle: Text(absenceTitle(t, a)),
        suffix: absenceStateLabel(context, state),
        onPress: () => _openDetail(context, a, state),
      ));
    }
    flush();

    final canReport = _reports.target != null || svc.me != null;

    return Stack(
      children: [
        PageList(
          onRefresh: _refresh,
          bottom: 96,
          children: [
            const SchoolHeader(),
            PageTitle(
              t.tabAbsences,
              bottom: 0,
              trailing: periods.length > 1
                  ? SizedBox(
                      width: 190,
                      child: FSelect<int>(
                        style: compactSelect(context),
                        control: FSelectControl<int>.lifted(value: period, onChange: (k) => setState(() => _period = k ?? period)),
                        items: {for (final k in periods) periodLabel(t, k): k},
                      ),
                    )
                  : null,
            ),
            if (reported.isNotEmpty) ...[
              SectionHead(t.absenceWaitingTitle, top: 18),
              for (final r in reported)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FTile(
                    title: Text(_reportWhen(dates, r)),
                    subtitle: _reportText(r).isEmpty ? null : Text(_reportText(r)),
                    suffix: FButton(style: FButtonStyle.outline(), mainAxisSize: MainAxisSize.min, onPress: () => _confirmWithdraw(context, r), child: Text(t.absenceWithdraw)),
                  ),
                ),
            ],
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Segmented<_Filter>(
                value: _filter,
                onChange: (f) => setState(() => _filter = f),
                segments: [(_Filter.all, t.absenceFilterAll), (_Filter.absences, t.absenceFilterAbsences), (_Filter.delays, t.absenceFilterDelays)],
              ),
            ),
            if (absences.isEmpty) EmptyNote(t.absencesEmpty) else ...rows,
          ],
        ),
        if (canReport)
          Positioned(
            right: 16,
            bottom: 16,
            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: const [BoxShadow(color: Color(0x73000000), blurRadius: 24, offset: Offset(0, 8))]),
              child: FButton(
                mainAxisSize: MainAxisSize.min,
                style: FButtonStyle.primary((s) => s.copyWith(
                      decoration: s.decoration.map((d) => d.copyWith(borderRadius: BorderRadius.circular(25))),
                      contentStyle: (c) => c.copyWith(padding: const EdgeInsets.fromLTRB(14, 16, 18, 16), textStyle: c.textStyle.map((ts) => ts.copyWith(fontSize: 15))),
                    )),
                prefix: const Icon(FIcons.plus),
                onPress: () => _openReport(context),
                child: Text(t.absenceReportTitle),
              ),
            ),
          ),
      ],
    );
  }

  static String _reportWhen(Dates dates, ReportedAbsence r) {
    final days = sameDay(r.dateFrom, r.dateTo) ? dates.weekdayDayMonth(r.dateFrom) : '${dates.weekdayDayMonth(r.dateFrom)} – ${dates.weekdayDayMonth(r.dateTo)}';
    return r.hourFrom != null && r.hourTo != null ? '$days, ${r.hourFrom} – ${r.hourTo}' : days;
  }

  static String _reportText(ReportedAbsence r) => [r.reason, r.comment].whereType<String>().where((s) => s.trim().isNotEmpty).join(' · ');

  Future<void> _openDetail(BuildContext context, AbsenceDto a, AbsenceState state) => showAbsenceDetail(
        context,
        a,
        state,
        onReport: _reports.target == null ? null : () => _openReport(context, from: a.from.toLocal(), until: a.until.toLocal()),
        onEdit: _reports.target == null ? () => _openForm(context, existing: a) : null,
      );

  Future<void> _openReport(BuildContext context, {DateTime? from, DateTime? until}) async {
    final target = _reports.target;
    if (target == null) return _openForm(context);
    final changed = await showSchulySheet<bool>(context, builder: (_) => ReportAbsenceSheet(target: target, initialFrom: from, initialTo: until));
    if (changed == true) await _refresh();
  }

  /// The Schuly-only form, for schools without absence reporting.
  Future<void> _openForm(BuildContext context, {AbsenceDto? existing}) async {
    final changed = await showSchulySheet<bool>(context, builder: (_) => _AbsenceForm(existing: existing));
    if (changed == true) await _refresh();
  }

  Future<void> _confirmWithdraw(BuildContext context, ReportedAbsence report) async {
    final target = _reports.target;
    if (target == null) return;
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final confirmed = await showSchulySheet<bool>(
      context,
      builder: (sheetCtx) => SchulySheet(
        title: t.absenceWithdrawQuestion,
        subtitle: t.absenceWithdrawSubtitle(dates.dayMonth(report.dateFrom)),
        footer: SheetButtons(
          left: FButton(style: blockButton(FButtonStyle.outline), onPress: () => Navigator.of(sheetCtx).pop(false), child: Text(t.absenceKeep)),
          right: FButton(style: blockButton(FButtonStyle.destructive), onPress: () => Navigator.of(sheetCtx).pop(true), child: Text(t.absenceWithdraw)),
        ),
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
  int _untilRevision = 0;

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
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final today = DateTime.now();
    final format = DateFormat('EEE, dd.MM.', Localizations.localeOf(context).languageCode);
    Widget chevron(BuildContext _, Object _, Set<WidgetState> _) => Padding(padding: const EdgeInsetsDirectional.only(start: 8, end: 14), child: Icon(FIcons.chevronDown, size: 16, color: colors.mutedForeground));
    FDateField date(String label, DateTime initial, ValueChanged<DateTime> onChange, {Key? key}) => FDateField.calendar(
          key: key,
          label: Text(label),
          start: DateTime(today.year - 1),
          end: DateTime(today.year + 1, 12, 31),
          format: format,
          prefixBuilder: null,
          suffixBuilder: chevron,
          control: FDateFieldControl.managed(initial: initial, onChange: (d) {
            if (d != null) onChange(d);
          }),
        );
    return SchulySheet(
      title: widget.existing == null ? t.absenceReportTitle : t.absenceEdit,
      action: t.absenceCancel,
      footer: widget.existing == null
          ? FButton(style: blockButton(FButtonStyle.primary), onPress: _busy ? null : _save, child: Text(_busy ? t.saving : t.save))
          : SheetButtons(
              left: FButton(style: blockButton(FButtonStyle.outline, text: colors.destructive), onPress: _busy ? null : _delete, child: Text(t.delete)),
              right: FButton(style: blockButton(FButtonStyle.primary), onPress: _busy ? null : _save, child: Text(_busy ? t.saving : t.save)),
            ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          Segmented<AbsenceType>(
            value: _type,
            onChange: (v) => setState(() => _type = v),
            segments: [(AbsenceType.absence, t.absenceTypeAbsence), (AbsenceType.delay, t.absenceTypeDelay)],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: date(t.absenceFrom, _from, (d) => setState(() {
                    _from = d;
                    if (_until.isBefore(_from)) {
                      _until = _from;
                      _untilRevision++;
                    }
                  }))),
              const SizedBox(width: 10),
              Expanded(child: date(t.absenceTo, _until, (d) => setState(() => _until = d), key: ValueKey(_untilRevision))),
            ],
          ),
          FTextField(control: FTextFieldControl.managed(controller: _reason), label: Text(t.absenceReasonLabel)),
          if (_error != null) Text(_error!, style: context.theme.typography.sm.copyWith(color: colors.destructive)),
        ],
      ),
    );
  }
}
