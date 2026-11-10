import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/domain/grade_math.dart';
import 'package:schuly_api/schuly_api.dart';

GradeDto _g(double? score, [double? weight]) => GradeDto((b) => b
  ..score = score
  ..weighting = weight);

void main() {
  test('a subject is its weighted exam average rounded to the half', () {
    // Mathematik in the mockup: 4.5, 5 and a half-weight 3.75 average 4.55, a 4.5 on the Zeugnis.
    final maths = subjectAverage([_g(4.5), _g(5), _g(3.75, 0.5)])!;
    expect(maths.raw, closeTo(4.55, 0.0001));
    expect(maths.grade, 4.5);
    expect(maths.count, 3);
    expect(subjectAverage([_g(4.75), _g(5.25), _g(5.5)])!.grade, 5.0);
    expect(roundToHalf(4.75), 5.0);
    expect(roundToHalf(4.74), 4.5);
  });

  test('ungraded entries (none or 0) do not count', () {
    expect(subjectAverage([_g(null), _g(0)]), isNull);
    expect(subjectAverage([_g(5), _g(0), null])!.raw, 5);
  });

  test('the semester average is the plain mean of the rounded subject grades', () {
    final subjects = [
      subjectAverage([_g(4.5), _g(5), _g(3.75, 0.5)])!, // 4.5
      subjectAverage([_g(5.5, 0.5), _g(5), _g(6, 0.5)])!, // 5.375 -> 5.5
      subjectAverage([_g(3.5), _g(4.25)])!, // 3.875 -> 4.0
    ];
    expect(semesterAverage(subjects), closeTo((4.5 + 5.5 + 4.0) / 3, 1e-9));
    expect(semesterAverage(const []), isNull);
  });

  test('tones and labels follow the web', () {
    expect(gradeTone(3.75), GradeTone.bad);
    expect(gradeTone(4.25), GradeTone.warn);
    expect(gradeTone(4.5), GradeTone.ok);
    expect(gradeTone(5), GradeTone.good);
    expect(gradeLabel(5), '5.0');
    expect(gradeLabel(4.5), '4.5');
    expect(gradeLabel(3.75), '3.75');
    expect(gradePosition(4), closeTo(0.6, 1e-9));
  });
}
