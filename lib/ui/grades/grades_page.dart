import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../domain/grade_math.dart';
import '../../l10n/app_localizations.dart';
import '../../services/school_data_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../dashboard/dashboard_scope.dart';
import 'grade_data.dart';
import 'grade_detail_sheet.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  int? _period;

  // This page is const in the dashboard, so its parent rebuilding does not reach it.
  @override
  void initState() {
    super.initState();
    SchoolDataService.instance.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    SchoolDataService.instance.removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final svc = SchoolDataService.instance;
    final mine = svc.myGradesByExam;
    final graded = [for (final e in svc.exams) if (e.id != null && mine.containsKey(e.id)) e];

    final periods = periodsFor(graded.map((e) => semesterKey(examDay(e))));
    final period = (_period != null && periods.contains(_period)) ? _period! : defaultPeriod(periods);
    final subjects = subjectGrades(svc, include: (e) => inPeriod(period, semesterKey(examDay(e))), unnamed: t.gradesSubjectFallback);
    final averaged = [for (final s in subjects) if (s.average != null) s.average!];
    final semAvg = semesterAverage(averaged);
    final below = subjects.where((s) => s.average != null && s.average!.grade < 4).toList();

    final children = <Widget>[
      const SchoolHeader(),
      PageTitle(
        t.tabGrades,
        trailing: periods.length > 1
            ? SizedBox(
                width: 170,
                child: FSelect<int>(
                  control: FSelectControl<int>.lifted(value: period, onChange: (k) => setState(() => _period = k ?? period)),
                  items: {for (final k in periods) periodLabel(t, k): k},
                ),
              )
            : null,
      ),
    ];

    if (graded.isEmpty) {
      children.add(EmptyNote(t.gradesEmpty));
    } else {
      children.addAll([
        _Summary(average: semAvg, below: below.map((s) => s.name).toList(), label: isYearKey(period) ? t.gradesYearAverage : t.gradesSemesterAverage),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              _LegendItem(mark: Container(width: 8, height: 8, decoration: BoxDecoration(color: context.tokens.good, shape: BoxShape.circle)), label: t.gradesLegendYours),
              _LegendItem(mark: Container(width: 3, height: 11, decoration: BoxDecoration(color: context.tokens.ink, borderRadius: BorderRadius.circular(2))), label: t.gradesLegendAverage),
            ],
          ),
        ),
        const SizedBox(height: 6),
        FAccordion(
          style: (s) => s.copyWith(
            titlePadding: const EdgeInsets.fromLTRB(0, 13, 0, 12),
            childPadding: const EdgeInsets.only(bottom: 10),
            titleTextStyle: FWidgetStateMap.all(context.theme.typography.base),
          ),
          children: [
            for (final s in subjects)
              FAccordionItem(
                icon: const SizedBox.shrink(),
                title: _SubjectHead(subject: s, t: t),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [for (final e in s.exams.reversed) _examItem(context, t, e, mine[e.id])],
                ),
              ),
          ],
        ),
      ]);
    }

    return PageList(onRefresh: svc.refresh, children: children);
  }

  Widget _examItem(BuildContext context, AppLocalizations t, ExamDto e, GradeDto? g) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final dates = Dates(context);
    final day = examDay(e);
    final weight = (g?.weighting ?? 1).toDouble();
    final parts = [
      if (day != null) dates.dayMonth(day),
      if (isGradedScore(e.classAverage)) t.gradesClassAverage(e.classAverage.toStringAsFixed(1)),
    ];
    return FItem(
      style: (s) => s.copyWith(contentStyle: (c) => c.copyWith(padding: const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 7))),
      title: Text(e.name, style: typography.base.copyWith(fontWeight: FontWeight.w400)),
      subtitle: Text.rich(TextSpan(children: [
        TextSpan(text: parts.join(' · ')),
        if (weight != 1) TextSpan(text: '${parts.isEmpty ? '' : ' · '}${t.gradesWeight(_num(weight))}', style: TextStyle(color: context.tokens.ink, fontWeight: FontWeight.w500)),
      ]), style: typography.xs.copyWith(color: colors.mutedForeground)),
      suffix: GradePill(g?.score),
      onPress: () => showGradeDetail(context, e),
    );
  }

  static String _num(double w) => w == w.roundToDouble() ? w.toStringAsFixed(0) : w.toString();
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.mark, required this.label});

  final Widget mark;
  final String label;

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [mark, const SizedBox(width: 5), Text(label, style: context.theme.typography.xs.copyWith(color: context.theme.colors.mutedForeground))]);
}

/// The semester average: one number first, what it means, and where it sits on the 1 to 6 scale.
class _Summary extends StatelessWidget {
  const _Summary({required this.average, required this.below, required this.label});

  final double? average;
  final List<String> below;
  final String label;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    final avg = average;
    final ok = below.isEmpty;
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.border))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Eyebrow(label),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 14),
            child: Row(
              children: [
                Text(avg == null ? '-' : avg.toStringAsFixed(1), style: typography.xl6.copyWith(fontWeight: FontWeight.w600, letterSpacing: -2)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ok ? t.gradesOnTrack : t.gradesBelowFour(below.length), style: typography.xl.copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: ok ? tokens.good : tokens.bad)),
                      Text(ok ? t.gradesOnTrackDetail : below.join(', '), maxLines: 2, overflow: TextOverflow.ellipsis, style: typography.sm.copyWith(color: colors.mutedForeground)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (avg != null) _Scale(value: avg),
        ],
      ),
    );
  }
}

/// The 1 to 6 scale with the fail zone tinted, the pass mark at 4 and the average as a dot in the accent.
class _Scale extends StatelessWidget {
  const _Scale({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    return SizedBox(
      height: 34,
      child: LayoutBuilder(builder: (context, c) {
        final w = c.maxWidth;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 8,
              height: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Row(children: [Expanded(flex: 60, child: ColoredBox(color: tokens.badBackground)), Expanded(flex: 40, child: ColoredBox(color: colors.muted))]),
              ),
            ),
            Positioned(left: w * 0.6, top: 3, child: Container(width: 2, height: 16, color: colors.mutedForeground)),
            Positioned(
              left: gradePosition(value) * w - 8,
              top: 3,
              child: Container(width: 16, height: 16, decoration: BoxDecoration(shape: BoxShape.circle, color: tokens.ink, border: Border.all(color: colors.background, width: 3))),
            ),
            for (var g = 1; g <= 6; g++)
              Positioned(
                top: 21,
                left: g == 6 ? null : (g == 1 ? 0 : gradePosition(g) * w - 3),
                right: g == 6 ? 0 : null,
                child: Text('$g', style: typography.xs.copyWith(fontSize: 11, color: colors.mutedForeground)),
              ),
          ],
        );
      }),
    );
  }
}

/// A subject's name, grade count and raw average, its Zeugnis grade, and the 1 to 6 line with a dot per grade and an
/// average tick.
class _SubjectHead extends StatelessWidget {
  const _SubjectHead({required this.subject, required this.t});

  final SubjectGrades subject;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final avg = subject.average;
    final scores = [
      for (final e in subject.exams)
        if (isGradedScore(SchoolDataService.instance.myGradesByExam[e.id]?.score)) SchoolDataService.instance.myGradesByExam[e.id]!.score!,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject.name, style: typography.lg.copyWith(fontWeight: FontWeight.w500)),
                  Text(
                    avg == null ? t.gradesCount(scores.length) : '${t.gradesCount(scores.length)} · ⌀ ${avg.raw.toStringAsFixed(2)}',
                    style: typography.xs.copyWith(color: colors.mutedForeground),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GradePill(avg?.grade),
          ],
        ),
        const SizedBox(height: 8),
        GradeDotLine(scores: scores, average: avg?.raw),
      ],
    );
  }
}

/// The 1 to 6 line: a dot per grade in its tone and the average as a tick in the accent.
class GradeDotLine extends StatelessWidget {
  const GradeDotLine({super.key, required this.scores, required this.average});

  final List<double> scores;
  final double? average;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final tokens = context.tokens;
    return SizedBox(
      height: 14,
      child: LayoutBuilder(builder: (context, c) {
        final w = c.maxWidth;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(left: 0, right: 0, top: 6, child: Container(height: 2, decoration: BoxDecoration(color: colors.mutedForeground.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(1)))),
            Positioned(left: w * 0.6, top: 2, child: Container(width: 1, height: 10, color: colors.mutedForeground.withValues(alpha: 0.5))),
            for (final g in scores)
              Positioned(
                left: gradePosition(g) * w - 6,
                top: 1,
                child: Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: gradeDotColor(context, g), border: Border.all(color: colors.background, width: 2))),
              ),
            if (average != null)
              Positioned(
                left: gradePosition(average!) * w - 2.5,
                top: -1,
                child: Container(width: 5, height: 16, decoration: BoxDecoration(color: tokens.ink, borderRadius: BorderRadius.circular(2), border: Border.all(color: colors.background, width: 1))),
              ),
          ],
        );
      }),
    );
  }
}
