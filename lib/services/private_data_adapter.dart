import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/schuly_api.dart';

import '../domain/private_data.dart';

/// Adapts the stateless proxy's flat private-mode DTOs into the generated
/// `SchulyApi` DTOs the account-mode UI already renders, so private mode reuses
/// the same screens. Date formats and a few field choices are best-guess until
/// validated against a real account.
class PrivateDataAdapter {
  /// Synthetic SchoolUser id linking the private user's grades/absences.
  static const privateSchoolUserId = 'private-self';

  static DateTime? _date(String? s) =>
      (s == null || s.isEmpty) ? null : DateTime.tryParse(s);

  static DateTime _dateOr(String? s, DateTime fallback) => _date(s) ?? fallback;

  static GradeDto grade(PrivateGrade g) => GradeDto((b) => b
    ..id = g.id
    ..score = g.score
    ..examId = g.examId
    ..schoolUserId = privateSchoolUserId);

  static ExamDto exam(PrivateExam e) => ExamDto((b) => b
    ..id = e.id
    ..name = (e.name?.isNotEmpty == true ? e.name! : e.subject) ?? 'Exam'
    ..classAverage = 0
    ..description = e.comment);

  static AbsenceDto absence(PrivateAbsence a) {
    final from = _dateOr(a.from, DateTime.now());
    return AbsenceDto((b) => b
      ..id = a.id
      ..reason = (a.reason?.isNotEmpty == true ? a.reason! : 'Absence')
      ..type = AbsenceType.absence
      ..from = from
      ..until = _dateOr(a.to, from)
      ..schoolUserId = privateSchoolUserId);
  }

  static AgendaEntryDto agendaEntry(PrivateAgendaEvent e) => AgendaEntryDto((b) => b
    ..id = e.id
    ..entryType = e.type?.toLowerCase() == 'holiday'
        ? AgendaEntryType.holiday
        : AgendaEntryType.lesson
    ..title = (e.title?.isNotEmpty == true ? e.title! : 'Entry')
    ..place = e.room
    ..description = e.comment
    ..date = _dateOr(e.startDate, DateTime.now())
    ..endDate = _date(e.endDate)
    ..schoolUserId = privateSchoolUserId);

  static SchoolUserDto schoolUser(
    PrivateUserInfo? info,
    List<PrivateGrade> grades,
    List<PrivateAbsence> absences,
  ) =>
      SchoolUserDto((b) => b
        ..id = privateSchoolUserId
        ..firstName = info?.firstName ?? ''
        ..lastName = info?.lastName ?? ''
        ..email = info?.email ?? ''
        ..role = Roles.student
        ..grades = ListBuilder<GradeDto>(grades.map(grade))
        ..absences = ListBuilder<AbsenceDto>(absences.map(absence)));

  static List<ExamDto> exams(List<PrivateExam> e) =>
      e.map(exam).toList(growable: false);

  static List<AbsenceDto> absencesList(List<PrivateAbsence> a) =>
      a.map(absence).toList(growable: false);

  static List<AgendaEntryDto> agenda(List<PrivateAgendaEvent> e) =>
      e.map(agendaEntry).toList(growable: false);
}
