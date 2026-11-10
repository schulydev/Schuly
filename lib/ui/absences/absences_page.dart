import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../domain/absence_rows.dart';
import '../../l10n/app_localizations.dart';
import '../../services/active_account_service.dart';
import '../../services/reported_absences.dart';
import '../../services/school_data_service.dart';
import '../core/dates.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';
import '../dashboard/dashboard_scope.dart';
import '../grades/grade_data.dart';
import 'absence_detail_sheet.dart';
import 'report_absence_sheet.dart';

enum _Filter { all, absences, delays }

/// The rows of the Absences page, built the way the web builds them: absences and pending reports merged, statuses
/// from the school's approval fields, BBB's rules only where the school is BBB.
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

class AbsencesPage extends StatefulWidget {
  const AbsencesPage({super.key});

  @override
  State<AbsencesPage> createState() => _AbsencesPageState();
}

class _AbsencesPageState extends State<AbsencesPage> {
  _Filter _filter = _Filter.all;
  int? _semester;

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
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final all = absenceRowsNow();

    // As on the web: always the current semester, plus every semester with an absence; numbered from the first.
    final keys = {semesterKey(today), for (final r in all) semesterKey(r.from)}.toList()..sort((a, b) => b.compareTo(a));
    final firstYear = firstSchoolYear(keys);
    final semester = (_semester != null && keys.contains(_semester)) ? _semester! : semesterKey(today);
    final inSemester = all.where((r) => semesterKey(r.from) == semester).toList();
    final shown = inSemester.where((r) => switch (_filter) {
          _Filter.all => true,
          _Filter.absences => !r.isDelay,
          _Filter.delays => r.isDelay,
        });

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

    for (final r in shown) {
      final m = dates.monthYear(r.from);
      if (m != month) {
        flush();
        month = m;
        rows.add(Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 2),
          child: Text(m, style: typography.xs.copyWith(fontWeight: FontWeight.w600, color: colors.mutedForeground)),
        ));
      }
      final detail = absenceDetail(t, r);
      final status = absenceStatusLabel(context, r);
      group.add(FItem(
        title: Text(detail == null ? absenceRange(dates, r) : '${absenceRange(dates, r)} · $detail'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(absenceReasonLine(t, r)),
            if (r.note != null) Text(r.note!),
            if (status != null) Padding(padding: const EdgeInsets.only(top: 3), child: status),
          ],
        ),
        suffix: r.canOpen ? chevron() : null,
        onPress: r.canOpen ? () => showAbsenceDetail(context, r) : null,
      ));
    }
    flush();

    final target = _reports.target;
    Widget stat(String value, String label) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: typography.xl2.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.4)),
            Text(label, maxLines: 1, softWrap: false, style: typography.sm.copyWith(color: colors.mutedForeground)),
          ],
        );

    return PageList(
      onRefresh: _refresh,
      children: [
        const SchoolHeader(),
        PageTitle(t.tabAbsences, bottom: 12),
        // The web's summary row: the semester select with "Report absence" beside it, then the counts.
        Row(
          children: [
            Expanded(
              child: FSelect<int>(
                style: compactSelect(context),
                control: FSelectControl<int>.lifted(value: semester, onChange: (k) => setState(() => _semester = k ?? semester)),
                items: {for (final k in keys) semesterOptionLabel(t, k, firstYear): k},
              ),
            ),
            if (target != null) ...[
              const SizedBox(width: 8),
              FButton(
                mainAxisSize: MainAxisSize.min,
                prefix: const Icon(FIcons.send),
                onPress: () => _openReport(context),
                child: Text(t.absenceReportTitle),
              ),
            ],
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Row(
            spacing: 28,
            children: [
              stat('${daysMissed(inSemester, today)}', t.absenceDaysMissed),
              stat('${inSemester.where((r) => r.isDelay).length}', t.absenceFilterDelays),
              stat('${lessonsMissed(inSemester) ?? '–'}', t.absenceLessonsLabel),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Segmented<_Filter>(
            value: _filter,
            onChange: (f) => setState(() => _filter = f),
            segments: [(_Filter.all, t.absenceFilterAll), (_Filter.absences, t.absenceFilterAbsences), (_Filter.delays, t.absenceFilterDelays)],
          ),
        ),
        if (all.isEmpty) EmptyNote(t.absencesEmpty) else if (rows.isEmpty) EmptyNote(t.absenceEmptySemester) else ...rows,
      ],
    );
  }

  Future<void> _openReport(BuildContext context) async {
    final target = _reports.target;
    if (target == null) return;
    final changed = await showSchulySheet<bool>(context, builder: (_) => ReportAbsenceSheet(target: target));
    if (changed == true) await _refresh();
  }
}
