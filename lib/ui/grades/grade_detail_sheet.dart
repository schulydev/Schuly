import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../domain/grade_math.dart';
import '../../l10n/app_localizations.dart';
import '../../services/school_data_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';
import 'grade_data.dart';

/// Opens the grade detail sheet: the grade against the class, its weight, and what it does to the subject's
/// Zeugnis grade.
Future<void> showGradeDetail(BuildContext context, ExamDto exam) => showSchulySheet<void>(context, builder: (_) => GradeDetailSheet(exam: exam));

class GradeDetailSheet extends StatelessWidget {
  const GradeDetailSheet({super.key, required this.exam});

  final ExamDto exam;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final svc = SchoolDataService.instance;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final dates = Dates(context);
    final grade = svc.myGradesByExam[exam.id];
    final score = grade?.score;
    final day = examDay(exam);
    final key = semesterKey(day);
    final subjectName = subjectNames(svc)[exam.classId] ?? t.gradesSubjectFallback;
    final siblings = svc.exams.where((e) => e.classId == exam.classId && semesterKey(examDay(e)) == key).toList();
    final now = subjectAverage(siblings.map((e) => svc.myGradesByExam[e.id]));
    final without = subjectAverage(siblings.where((e) => e.id != exam.id).map((e) => svc.myGradesByExam[e.id]));
    final weight = (grade?.weighting ?? 1).toDouble();
    final classAvg = isGradedScore(exam.classAverage) ? exam.classAverage : null;
    final graded = isGradedScore(score);

    final String comparison;
    if (!graded || classAvg == null) {
      comparison = graded ? t.gradeNoClassAverage : t.gradeNotGraded;
    } else {
      final diff = score! - classAvg;
      comparison = diff >= 0 ? t.gradeAboveClass(diff.toStringAsFixed(2)) : t.gradeBelowClass((-diff).toStringAsFixed(2));
    }

    final weightText = weight == 1 ? t.gradeWeightFull : (weight == 0.5 ? t.gradeWeightHalf : t.gradeWeightOther(_num(weight)));

    return SchulySheet(
      title: exam.name,
      subtitle: [subjectName, if (day != null) dates.full(day)].join(' · '),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 16),
            child: Row(
              children: [
                GradePill(score, large: true),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comparison, style: typography.base.copyWith(fontWeight: FontWeight.w500)),
                      if (classAvg != null) Text(t.gradeClassAverage(classAvg.toStringAsFixed(1)), style: typography.sm.copyWith(color: colors.mutedForeground)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (graded) _Comparison(you: score!, classAverage: classAvg, youLabel: t.gradeYou),
          if (exam.description?.isNotEmpty == true) Padding(padding: const EdgeInsets.only(top: 10), child: Text(exam.description!, style: typography.sm.copyWith(color: colors.mutedForeground))),
          const SizedBox(height: 14),
          FTileGroup(
            divider: FItemDivider.full,
            children: [
              _fact(context, t.gradeWeight, weightText),
              if (now != null) _fact(context, t.gradeSubjectNow(subjectName), t.gradeOnZeugnis(now.raw.toStringAsFixed(2), gradeLabel(now.grade))),
              if (graded && without != null) _fact(context, t.gradeWithout, t.gradeArrow(without.raw.toStringAsFixed(2), gradeLabel(without.grade))),
            ],
          ),
          if (graded && score! < 4 && now != null && without != null && without.grade > now.grade)
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Callout(title: t.gradeBelowFourTitle, text: t.gradeBelowFourText(subjectName, gradeLabel(without.grade)), bad: true),
            ),
        ],
      ),
    );
  }

  static String _num(double w) => w == w.roundToDouble() ? w.toStringAsFixed(0) : w.toString();

  static FTile _fact(BuildContext context, String label, String value) => FTile(
        title: Text(label, style: context.theme.typography.sm.copyWith(color: context.theme.colors.mutedForeground, fontWeight: FontWeight.w400)),
        details: Text(value, style: context.theme.typography.base.copyWith(fontWeight: FontWeight.w500, color: context.theme.colors.foreground)),
      );
}

/// You against the class on the 1 to 6 line, with the fail zone below 4 tinted.
class _Comparison extends StatelessWidget {
  const _Comparison({required this.you, required this.classAverage, required this.youLabel});

  final double you;
  final double? classAverage;
  final String youLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    return SizedBox(
      height: 54,
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          double x(num g) => gradePosition(g) * w;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 22,
                height: 4,
                child: Row(children: [
                  Expanded(flex: 60, child: Container(decoration: BoxDecoration(color: tokens.badBackground, borderRadius: const BorderRadius.horizontal(left: Radius.circular(2))))),
                  Expanded(flex: 40, child: Container(decoration: BoxDecoration(color: colors.muted, borderRadius: const BorderRadius.horizontal(right: Radius.circular(2))))),
                ]),
              ),
              if (classAverage != null) Positioned(left: x(classAverage!) - 1.5, top: 16, child: Container(width: 3, height: 16, decoration: BoxDecoration(color: tokens.ink, borderRadius: BorderRadius.circular(2)))),
              Positioned(
                left: x(you) - 30,
                width: 60,
                top: 0,
                child: Column(
                  children: [
                    Text(youLabel, style: typography.xs.copyWith(fontSize: 11, fontWeight: FontWeight.w500, height: 1)),
                    const SizedBox(height: 4),
                    Container(width: 14, height: 14, decoration: BoxDecoration(color: gradeDotColor(context, you), shape: BoxShape.circle, border: Border.all(color: tokens.card, width: 3))),
                  ],
                ),
              ),
              for (var g = 1; g <= 6; g++)
                Positioned(
                  top: 34,
                  left: g == 1 ? 0 : null,
                  right: g == 6 ? 0 : null,
                  child: g == 1 || g == 6
                      ? Text('$g', style: typography.xs.copyWith(fontSize: 11, color: colors.mutedForeground))
                      : Transform.translate(offset: Offset(x(g) - 3, 0), child: Text('$g', style: typography.xs.copyWith(fontSize: 11, color: colors.mutedForeground))),
                ),
            ],
          );
        },
      ),
    );
  }
}
