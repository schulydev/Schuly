import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/schuly_api.dart';

import '../domain/private_data.dart';

class PrivateDataAdapter {
  static const privateSchoolUserId = 'private-self';

  static DateTime? _date(String? s) =>
      (s == null || s.isEmpty) ? null : DateTime.tryParse(s)?.toLocal();

  static DateTime _dateOr(String? s, DateTime fallback) => _date(s) ?? fallback;

  static Date? _dateOnly(String? s) {
    final d = _date(s);
    return d == null ? null : Date(d.year, d.month, d.day);
  }

  static String _classId(String subject) => 'private-class-$subject';

  static String? _classIdOrNull(String? subject) => subject == null || subject.isEmpty ? null : _classId(subject);

  /// The exam a grade belongs to. A grade without an exam id still needs one: the pages list grades through their exam.
  static String _examIdOf(PrivateGrade g) => g.examId?.isNotEmpty == true ? g.examId! : 'private-grade-${g.id ?? '${g.subject}-${g.date}-${g.score}'}';

  static GradeDto grade(PrivateGrade g) => GradeDto((b) => b
    ..id = g.id
    ..score = g.score
    ..examId = _examIdOf(g)
    ..schoolUserId = privateSchoolUserId);

  static ExamDto exam(PrivateExam e) => ExamDto((b) => b
    ..id = e.id
    ..name = (e.name?.isNotEmpty == true ? e.name! : e.subject) ?? 'Exam'
    ..classAverage = 0
    ..date = _dateOnly(e.startDate)
    ..classId = _classIdOrNull(e.subject)
    ..description = e.comment);

  /// The stateless exam list holds upcoming exams, while grades mostly belong to past ones. An exam
  /// is made up from the grade for those, as the account-mode sync does on the server.
  static ExamDto _examFromGrade(PrivateGrade g) {
    final date = _dateOnly(g.date);
    return ExamDto((b) => b
      ..id = _examIdOf(g)
      ..name = g.comment?.isNotEmpty == true ? g.comment! : (date == null ? (g.subject ?? 'Grade') : 'Grade ${date.day}.${date.month}.${date.year}')
      ..classAverage = 0
      ..date = date
      ..classId = _classIdOrNull(g.subject));
  }

  static AbsenceDto absence(PrivateAbsence a) {
    final from = _dateOr(a.from, DateTime.now());
    return AbsenceDto((b) => b
      ..id = a.id
      ..reason = a.reason?.isNotEmpty == true ? a.reason! : (a.subject?.isNotEmpty == true ? a.subject! : 'Absence')
      ..type = AbsenceType.absence
      ..isExcused = a.excused
      ..from = from
      ..until = _dateOr(a.to, from)
      ..schoolUserId = privateSchoolUserId);
  }

  /// Mirrors the words the server's holiday sync treats as a day off.
  static const _dayOffWords = ['ferien', 'feiertag', 'schulfrei', 'unterrichtsfrei', 'brückentag', 'brueckentag', 'vacances', 'vacanze', 'congé', 'conge', 'neujahr', 'berchtold', 'karfreitag', 'ostern', 'ostermontag', 'tag der arbeit', 'auffahrt', 'pfingst', 'fronleichnam', 'bundesfeier', 'nationalfeiertag', 'maria himmelfahrt', 'allerheiligen', 'maria empfängnis', 'weihnacht', 'stephan'];

  /// The stateless routes pass the school's own event type on: "Timetable", "Event", "Exam" and the like.
  static AgendaEntryType _entryType(PrivateAgendaEvent e) {
    final title = (e.title ?? '').toLowerCase();
    return switch (e.type?.toLowerCase()) {
      'holiday' => AgendaEntryType.holiday,
      'exam' || 'test' => AgendaEntryType.test,
      'event' => _dayOffWords.any(title.contains) ? AgendaEntryType.holiday : AgendaEntryType.event,
      _ => AgendaEntryType.lesson,
    };
  }

  static AgendaEntryDto agendaEntry(PrivateAgendaEvent e) => AgendaEntryDto((b) => b
    ..id = e.id
    ..entryType = _entryType(e)
    ..title = (e.title?.isNotEmpty == true ? e.title! : 'Entry')
    ..place = e.room
    ..description = e.comment
    ..date = _dateOr(e.startDate, DateTime.now())
    ..endDate = _date(e.endDate)
    ..schoolUserId = privateSchoolUserId);

  static List<String> _subjects(List<PrivateGrade> grades, List<PrivateExam> exams) {
    final subjects = <String>{
      for (final g in grades)
        if (g.subject?.isNotEmpty == true) g.subject!,
      for (final e in exams)
        if (e.subject?.isNotEmpty == true) e.subject!,
    };
    return subjects.toList()..sort();
  }

  static SchoolUserDto schoolUser(PrivateUserInfo? info, List<PrivateGrade> grades, List<PrivateAbsence> absences, [List<PrivateExam> exams = const []]) =>
      SchoolUserDto((b) => b
        ..id = privateSchoolUserId
        ..firstName = info?.firstName ?? ''
        ..lastName = info?.lastName ?? ''
        ..email = info?.email ?? ''
        ..entryDate = _dateOnly(info?.entryDate)
        ..role = Roles.student
        ..grades = ListBuilder<GradeDto>(grades.map(grade))
        ..absences = ListBuilder<AbsenceDto>(absences.map(absence))
        ..classes = ListBuilder<UserClassDto>(_subjects(grades, exams).map((s) => UserClassDto((c) => c
          ..classId = _classId(s)
          ..className = s))));

  /// The school's exams, plus one for every grade that has none in that list.
  static List<ExamDto> exams(List<PrivateExam> e, [List<PrivateGrade> grades = const []]) {
    final known = {for (final x in e) x.id};
    return [
      ...e.map(exam),
      for (final g in grades)
        if (known.add(_examIdOf(g))) _examFromGrade(g),
    ];
  }

  static List<AbsenceDto> absencesList(List<PrivateAbsence> a) =>
      a.map(absence).toList(growable: false);

  /// The school's agenda, plus the exams still to come, which account mode also shows in the timetable.
  static List<AgendaEntryDto> agenda(List<PrivateAgendaEvent> e, {List<PrivateExam> exams = const [], List<PrivateGrade> grades = const []}) {
    final known = {for (final x in e) x.id};
    final graded = {for (final g in grades) _examIdOf(g)};
    return [
      ...e.map(agendaEntry),
      for (final x in exams)
        if (_date(x.startDate) != null && !graded.contains(x.id) && known.add(x.id))
          AgendaEntryDto((b) => b
            ..id = x.id
            ..entryType = AgendaEntryType.test
            ..title = [if (x.subject?.isNotEmpty == true) x.subject!, if (x.name?.isNotEmpty == true && x.name != x.subject) x.name!].join(': ')
            ..place = x.room
            ..description = x.comment
            ..date = _date(x.startDate)!
            ..endDate = _date(x.endDate)
            ..classId = _classIdOrNull(x.subject)
            ..schoolUserId = privateSchoolUserId),
    ];
  }

  static List<ClassDto> classes(
    List<PrivateGrade> grades,
    List<PrivateExam> exams,
  ) {
    final all = PrivateDataAdapter.exams(exams, grades);
    return _subjects(grades, exams)
        .map((subject) => ClassDto((b) => b
          ..id = _classId(subject)
          ..name = subject
          ..exams = ListBuilder<ExamDto>(all.where((e) => e.classId == _classId(subject)))))
        .toList(growable: false);
  }
}
