import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/domain/private_data.dart';
import 'package:schuly/services/private_data_adapter.dart';
import 'package:schuly_api/schuly_api.dart';

void main() {
  const pastGrade = PrivateGrade(id: 'g1', examId: 'past', subject: 'Maths', score: 5.5, date: '2026-03-12');
  const noExamId = PrivateGrade(id: 'g2', subject: 'Physics', score: 4.5, date: '2026-09-02', comment: 'Optics');
  const upcoming = PrivateExam(id: 'next', name: 'Algebra', subject: 'Maths', startDate: '2030-05-02T08:00:00Z', endDate: '2030-05-02T09:00:00Z', room: 'A1');

  group('exams', () {
    final exams = PrivateDataAdapter.exams(const [upcoming], const [pastGrade, noExamId]);

    test('every grade has an exam, so the grades page can list it', () {
      final user = PrivateDataAdapter.schoolUser(null, const [pastGrade, noExamId], const [], const [upcoming]);
      final ids = exams.map((e) => e.id).toSet();
      expect(user.grades!.map((g) => g.examId), everyElement(isIn(ids)));
    });

    test('an exam made from a grade carries its date, class and note', () {
      final optics = exams.singleWhere((e) => e.name == 'Optics');
      expect(optics.date, Date(2026, 9, 2));
      expect(optics.classId, 'private-class-Physics');
    });

    test('a school exam carries its date and class', () {
      final exam = exams.singleWhere((e) => e.id == 'next');
      expect(exam.date, isNotNull);
      expect(exam.classId, 'private-class-Maths');
    });

    test('a grade whose exam is in the list adds no second exam', () {
      const graded = PrivateExam(id: 'past', name: 'Fractions', subject: 'Maths');
      expect(PrivateDataAdapter.exams(const [graded], const [pastGrade]).map((e) => e.name), ['Fractions']);
    });
  });

  test('the user is in a class for each subject, which names the grade sections', () {
    final user = PrivateDataAdapter.schoolUser(null, const [pastGrade, noExamId], const [], const [upcoming]);
    expect(user.classes!.map((c) => c.className), ['Maths', 'Physics']);
    expect(user.classes!.first.classId, 'private-class-Maths');
  });

  test('classes list the exams made from grades', () {
    final classes = PrivateDataAdapter.classes(const [pastGrade, noExamId], const [upcoming]);
    expect(classes.singleWhere((c) => c.name == 'Physics').exams!.map((e) => e.name), ['Optics']);
    expect(classes.singleWhere((c) => c.name == 'Maths').exams, hasLength(2));
  });

  group('agenda', () {
    AgendaEntryType typeOf(String? type, String title) => PrivateDataAdapter.agendaEntry(PrivateAgendaEvent(id: 'x', title: title, type: type, startDate: '2030-01-01')).entryType;

    test('the school event types map to the matching entry type', () {
      expect(typeOf('Timetable', 'Maths'), AgendaEntryType.lesson);
      expect(typeOf('Exam', 'Maths'), AgendaEntryType.test);
      expect(typeOf('Event', 'Sports day'), AgendaEntryType.event);
      expect(typeOf('Event', 'Herbstferien'), AgendaEntryType.holiday);
      expect(typeOf(null, 'Course day'), AgendaEntryType.lesson);
    });

    test('an exam still to come shows in the timetable', () {
      final agenda = PrivateDataAdapter.agenda(const [], exams: const [upcoming]);
      final entry = agenda.single;
      expect(entry.entryType, AgendaEntryType.test);
      expect(entry.title, 'Maths: Algebra');
      expect(entry.place, 'A1');
    });

    test('an exam already graded or already on the agenda is not added', () {
      const graded = PrivateGrade(id: 'g', examId: 'next', subject: 'Maths', score: 5);
      expect(PrivateDataAdapter.agenda(const [], exams: const [upcoming], grades: const [graded]), isEmpty);
      const listed = PrivateAgendaEvent(id: 'next', title: 'Algebra', type: 'Exam', startDate: '2030-05-02');
      expect(PrivateDataAdapter.agenda(const [listed], exams: const [upcoming]), hasLength(1));
    });
  });

  test('an absence keeps whether it is excused, and falls back to its subject as the reason', () {
    final absence = PrivateDataAdapter.absence(const PrivateAbsence(id: 'a', from: '2026-01-05', subject: 'Maths', excused: true));
    expect(absence.isExcused, isTrue);
    expect(absence.reason, 'Maths');
  });
}
