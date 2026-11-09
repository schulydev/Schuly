import 'package:schuly_api/schuly_api.dart';

/// Grade averages the way a Swiss Zeugnis (BBB) computes them: each subject's semester grade is its weighted exam
/// average rounded to the nearest half, and the semester average is the plain mean of those subject grades.

/// A score of 0 or none means the exam is not graded yet.
bool isGradedScore(num? score) => score != null && score > 0;

double roundToHalf(double x) => (x * 2).round() / 2;

/// A subject's weighted exam average ([raw]) and its Zeugnis grade ([grade], [raw] rounded to the half).
class SubjectAverage {
  const SubjectAverage({required this.raw, required this.count});

  final double raw;
  final int count;

  double get grade => roundToHalf(raw);
}

/// The weighted average of the graded entries, or null when none is graded. A missing weight counts as 1.
SubjectAverage? subjectAverage(Iterable<GradeDto?> grades) {
  double weights = 0, sum = 0;
  var count = 0;
  for (final g in grades) {
    if (g == null || !isGradedScore(g.score)) continue;
    final w = (g.weighting ?? 1).toDouble();
    if (w <= 0) continue;
    weights += w;
    sum += g.score! * w;
    count++;
  }
  if (count == 0) return null;
  return SubjectAverage(raw: sum / weights, count: count);
}

/// The plain mean of the subjects' rounded grades, every subject counting the same; null without subjects.
double? semesterAverage(Iterable<SubjectAverage> subjects) {
  final list = subjects.toList();
  if (list.isEmpty) return null;
  return list.fold<double>(0, (s, a) => s + a.grade) / list.length;
}

/// How a grade reads: below 4 fails, below 4.5 is close, 5 and up is good.
enum GradeTone { bad, warn, ok, good }

GradeTone gradeTone(num grade) {
  if (grade < 4) return GradeTone.bad;
  if (grade < 4.5) return GradeTone.warn;
  if (grade >= 5) return GradeTone.good;
  return GradeTone.ok;
}

/// "5.0", "4.5" or "3.75": one decimal for whole and half grades, two otherwise.
String gradeLabel(num grade) {
  final g = grade.toDouble();
  return (g * 2) % 1 == 0 ? g.toStringAsFixed(1) : g.toStringAsFixed(2);
}

/// Where a grade sits on the 1 to 6 line, from 0 to 1.
double gradePosition(num grade) => ((grade.toDouble() - 1) / 5).clamp(0.0, 1.0);
