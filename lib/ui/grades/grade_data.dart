import 'package:schuly_api/schuly_api.dart';

import '../../domain/grade_math.dart';
import '../../l10n/app_localizations.dart';
import '../../services/school_data_service.dart';

/// Class (subject) names by class id: from the profile, then from the class list.
Map<String?, String?> subjectNames(SchoolDataService svc) => <String?, String?>{
      for (final c in (svc.me?.classes ?? const <UserClassDto>[])) c.classId: c.className,
      ...svc.classNameById,
    };

DateTime? examDay(ExamDto e) => e.date == null ? null : DateTime(e.date!.year, e.date!.month, e.date!.day);

/// A semester as `year * 10 + half` (half 1 from August, half 2 from February), a whole school year as `year * 10`,
/// and 0 for undated entries.
int semesterKey(DateTime? d) {
  if (d == null) return 0;
  if (d.month >= 8) return d.year * 10 + 1;
  if (d.month <= 1) return (d.year - 1) * 10 + 1;
  return (d.year - 1) * 10 + 2;
}

bool isYearKey(int key) => key != 0 && key % 10 == 0;

bool inPeriod(int period, int key) => isYearKey(period) ? key ~/ 10 == period ~/ 10 : key == period;

/// The pickable periods, newest first: each school year with both halves also gets a whole-year option.
List<int> periodsFor(Iterable<int> keys) {
  final semKeys = keys.toSet();
  final years = {for (final k in semKeys) k ~/ 10}.toList()..sort((a, b) => b.compareTo(a));
  final out = <int>[];
  for (final y in years) {
    if (y == 0) {
      out.add(0);
      continue;
    }
    final halves = [for (final h in [2, 1]) if (semKeys.contains(y * 10 + h)) y * 10 + h];
    if (halves.length > 1) out.add(y * 10);
    out.addAll(halves);
  }
  return out;
}

/// The newest semester among [keys], or the first period when there is none.
int defaultPeriod(List<int> periods) {
  final semesters = periods.where((k) => k != 0 && !isYearKey(k));
  if (semesters.isEmpty) return periods.isEmpty ? 0 : periods.first;
  return semesters.reduce((a, b) => a > b ? a : b);
}

/// A subject in a period: its graded exams, oldest first, and its average.
class SubjectGrades {
  const SubjectGrades({required this.classId, required this.name, required this.exams, required this.average});

  final String classId;
  final String name;
  final List<ExamDto> exams;
  final SubjectAverage? average;
}

/// The student's graded exams by subject, for the exams [include] accepts, sorted by subject name.
List<SubjectGrades> subjectGrades(SchoolDataService svc, {bool Function(ExamDto exam)? include, String unnamed = ''}) {
  final mine = svc.myGradesByExam;
  final names = subjectNames(svc);
  final byClass = <String, List<ExamDto>>{};
  for (final e in svc.exams) {
    if (e.id == null || !mine.containsKey(e.id)) continue;
    if (include != null && !include(e)) continue;
    byClass.putIfAbsent(e.classId ?? '-', () => []).add(e);
  }
  final out = [
    for (final entry in byClass.entries)
      SubjectGrades(
        classId: entry.key,
        name: names[entry.key] ?? unnamed,
        exams: entry.value..sort((a, b) => (examDay(a) ?? DateTime(0)).compareTo(examDay(b) ?? DateTime(0))),
        average: subjectAverage(entry.value.map((e) => mine[e.id])),
      ),
  ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return out;
}

/// "Semester 1 · 26/27", "School year 25/26" or "Undated".
String periodLabel(AppLocalizations t, int key) {
  if (key == 0) return t.periodUndated;
  final year = key ~/ 10, half = key % 10;
  final a = (year % 100).toString().padLeft(2, '0');
  final b = ((year + 1) % 100).toString().padLeft(2, '0');
  return half == 0 ? t.periodYear('$a/$b') : t.periodSemester(half, '$a/$b');
}

/// "All semesters" in the semester select.
const kAllSemesters = -1;

/// The web's semester options: the semesters newest first, then "No date" when undated grades exist, then "All
/// semesters" when there is more than one choice.
List<int> semesterOptions(Iterable<int> keys) {
  final set = keys.toSet();
  final semesters = set.where((k) => k > 0).toList()..sort((a, b) => b.compareTo(a));
  final undated = set.contains(0);
  return [...semesters, if (undated) 0, if (semesters.length > 1 || undated) kAllSemesters];
}

/// The newest semester, else "No date", else "All semesters", as the web opens the page.
int defaultSemesterOption(List<int> options) => options.firstWhere((k) => k > 0, orElse: () => options.contains(0) ? 0 : kAllSemesters);

/// The first school year of [keys], which semester numbers count from, as a Zeugnis does.
int firstSchoolYear(Iterable<int> keys) {
  final years = keys.where((k) => k > 0).map((k) => k ~/ 10);
  return years.isEmpty ? DateTime.now().year : years.reduce((a, b) => a < b ? a : b);
}

/// "Semester 3 · 2026/27", "No date" or "All semesters", the web's wording.
String semesterOptionLabel(AppLocalizations t, int key, int firstYear) {
  if (key == 0) return t.gradesNoDate;
  if (key == kAllSemesters) return t.gradesAllSemesters;
  final year = key ~/ 10, half = key % 10;
  return t.semesterNumbered((year - firstYear) * 2 + half, '$year/${((year + 1) % 100).toString().padLeft(2, '0')}');
}
