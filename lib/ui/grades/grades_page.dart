import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/school_data_service.dart';
import '../core/grade_color.dart';

/// Grades tab: live exam grades grouped by class.
class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) => const _GradesView();
}

class _GradesView extends StatefulWidget {
  const _GradesView();

  @override
  State<_GradesView> createState() => _GradesViewState();
}

class _GradesViewState extends State<_GradesView> {
  // Selected semester as a sortable key (year*10 + half); null = auto-pick newest.
  int? _selectedKey;

  // Swiss school year: Aug–Jan counts as the 1st semester, Feb–Jul as the 2nd.
  // A null date → key 0 ("Undated"), so dateless grades still show somewhere.
  static int _semesterKey(Date? d) {
    if (d == null) return 0;
    if (d.month >= 8) return d.year * 10 + 1;
    if (d.month <= 1) return (d.year - 1) * 10 + 1;
    return (d.year - 1) * 10 + 2;
  }

  // A "period" is either a semester (half 1/2) or a whole school year (half 0,
  // i.e. year*10). Year periods cover both halves.
  static bool _isYear(int key) => key != 0 && key % 10 == 0;

  static String _periodLabel(int key) {
    if (key == 0) return 'Undated';
    final year = key ~/ 10, half = key % 10;
    final a = (year % 100).toString().padLeft(2, '0');
    final b = ((year + 1) % 100).toString().padLeft(2, '0');
    return half == 0 ? '$a/$b' : '$half. $a/$b'; // "25/26" vs "2. 25/26"
  }

  @override
  Widget build(BuildContext context) {
    final svc = SchoolDataService.instance;
    final myGrades = svc.myGradesByExam;

    // Exams I have a grade for, paired with their derived semester.
    final graded = [
      for (final e in svc.exams)
        if (e.id != null && myGrades.containsKey(e.id)) e,
    ];
    if (graded.isEmpty) {
      return _RefreshableEmpty(onRefresh: svc.refresh, text: 'No grades yet');
    }

    // Build the period dropdown: each school year (newest first) with a whole-year
    // option above its semesters (only when the year actually has two halves).
    final semKeys = {for (final e in graded) _semesterKey(e.date)};
    final yearsDesc = {for (final k in semKeys) k ~/ 10}.toList()
      ..sort((a, b) => b.compareTo(a));
    final periods = <int>[];
    for (final y in yearsDesc) {
      if (y == 0) {
        periods.add(0); // undated
        continue;
      }
      final halves = [for (final h in [2, 1]) if (semKeys.contains(y * 10 + h)) y * 10 + h];
      if (halves.length > 1) periods.add(y * 10); // whole-year option
      periods.addAll(halves);
    }
    // Default to the newest single semester (most focused, current grades).
    final newestSemester = semKeys.where((k) => !_isYear(k)).fold(0, (m, k) => k > m ? k : m);
    final selected = (_selectedKey != null && periods.contains(_selectedKey))
        ? _selectedKey!
        : (periods.contains(newestSemester) ? newestSemester : periods.first);

    bool inSelection(int examKey) =>
        _isYear(selected) ? examKey ~/ 10 == selected ~/ 10 : examKey == selected;

    // Group the selected period's exams by class, each sorted by date.
    final classNames = <String?, String?>{
      for (final c in (svc.me?.classes ?? const <UserClassDto>[])) c.classId: c.className,
      ...svc.classNameById,
    };
    final byClass = <String, List<ExamDto>>{};
    for (final e in graded) {
      if (!inSelection(_semesterKey(e.date))) continue;
      byClass.putIfAbsent(e.classId ?? '—', () => []).add(e);
    }
    for (final list in byClass.values) {
      list.sort((a, b) => (a.date?.compareTo(b.date ?? a.date!) ?? 0));
    }

    return Column(
      children: [
        if (periods.length > 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 150,
                child: FSelect<int>(
                  control: FSelectControl<int>.lifted(
                    value: selected,
                    onChange: (k) => setState(() => _selectedKey = k ?? selected),
                  ),
                  items: {for (final k in periods) _periodLabel(k): k},
                ),
              ),
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: svc.refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              children: [
                for (final entry in byClass.entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ClassSection(
                      title: classNames[entry.key] ?? 'Class',
                      exams: entry.value,
                      myGrades: myGrades,
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

class _ClassSection extends StatelessWidget {
  final String title;
  final List<ExamDto> exams;
  final Map<String, GradeDto> myGrades;
  const _ClassSection({required this.title, required this.exams, required this.myGrades});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;

    double ws = 0, ss = 0;
    for (final e in exams) {
      final g = myGrades[e.id];
      if (g == null || !isGraded(g.score)) continue;
      final w = (g.weighting ?? 1).toDouble();
      ws += w;
      ss += g.score!.toDouble() * w;
    }
    final avg = ws > 0 ? ss / ws : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(title, style: typography.base.copyWith(fontWeight: FontWeight.w600))),
              if (avg != null)
                Text('⌀ ${formatGrade(avg)}',
                    style: typography.sm.copyWith(color: gradeColor(context, avg), fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        for (final e in exams)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FTile(
              title: Text(e.name),
              subtitle: Text([
                if ((myGrades[e.id]?.weighting ?? 1) != 1) 'weight ${formatGrade(myGrades[e.id]!.weighting ?? 1)}',
                'class ⌀ ${formatGrade(e.classAverage)}',
              ].join(' · ')),
              suffix: GradePill(myGrades[e.id]?.score),
              onPress: () => _showExamDetail(context, e, myGrades[e.id]),
            ),
          ),
      ],
    );
  }
}

void _showExamDetail(BuildContext context, ExamDto exam, GradeDto? grade) {
  showFSheet<void>(
    context: context,
    side: FLayout.btt,
    mainAxisMaxRatio: null,
    builder: (sheetCtx) => _ExamDetailSheet(exam: exam, grade: grade),
  );
}

class _ExamDetailSheet extends StatelessWidget {
  final ExamDto exam;
  final GradeDto? grade;
  const _ExamDetailSheet({required this.exam, required this.grade});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final score = grade?.score;
    final classAvg = exam.classAverage;

    Widget bar(String label, num? value) {
      final v = value ?? 0;
      final pct = (v / 6).clamp(0.0, 1.0);
      final c = isGraded(value) ? gradeColor(context, v) : colors.muted;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: typography.sm.copyWith(color: colors.mutedForeground)),
              Text(isGraded(value) ? formatGrade(v) : '—',
                  style: typography.sm.copyWith(fontWeight: FontWeight.w700, color: c)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: colors.muted,
              valueColor: AlwaysStoppedAnimation(c),
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(color: colors.background),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 24 + MediaQuery.viewPaddingOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(exam.name, style: typography.lg.copyWith(fontWeight: FontWeight.w700)),
          if ((exam.description?.isNotEmpty ?? false)) ...[
            const SizedBox(height: 4),
            Text(exam.description!, style: TextStyle(color: colors.mutedForeground)),
          ],
          const SizedBox(height: 20),
          bar('Your score', score),
          const SizedBox(height: 14),
          bar('Class average', classAvg),
          if ((grade?.weighting ?? 1) != 1) ...[
            const SizedBox(height: 16),
            Text('Weighting: ${formatGrade(grade!.weighting ?? 1)}',
                style: typography.sm.copyWith(color: colors.mutedForeground)),
          ],
        ],
      ),
    );
  }
}

class _RefreshableEmpty extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String text;
  const _RefreshableEmpty({required this.onRefresh, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 360,
            child: Center(child: Text(text, style: TextStyle(color: colors.mutedForeground))),
          ),
        ],
      ),
    );
  }
}
