import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/school_data_service.dart';
import 'package:schuly/services/school_data_snapshot.dart';
import 'package:schuly_api/schuly_api.dart';

void main() {
  group('SchoolDataSnapshot', () {
    test('round-trips through json', () {
      final me = SchoolUserDto((b) => b
        ..firstName = 'Ada'
        ..lastName = 'Byron'
        ..email = 'ada@example.com'
        ..id = 'su-1'
        ..schoolId = 's-1'
        ..schoolName = 'School'
        ..applicationUserId = 'au-1'
        ..street = 'Main St'
        ..city = 'City'
        ..zip = '1234'
        ..birthday = Date(2000, 1, 1)
        ..entryDate = Date(2015, 9, 1)
        ..role = Roles.student
        ..state = UserState.active
        ..createdAt = DateTime.utc(2024, 1, 1)
        ..updatedAt = DateTime.utc(2024, 1, 2)
        ..absences.add(AbsenceDto((a) => a
          ..id = 'a-me'
          ..reason = 'Sick'
          ..type = AbsenceType.delay
          ..from = DateTime.utc(2026, 1, 5)
          ..until = DateTime.utc(2026, 1, 6)
          ..schoolUserId = 'su-1'))
        ..grades.add(GradeDto((g) => g
          ..id = 'g-1'
          ..score = 5.5
          ..weighting = 1
          ..examId = 'e-1'
          ..schoolUserId = 'su-1'))
        ..classes.add(UserClassDto((c) => c
          ..classId = 'c-1'
          ..className = '4a')));

      final exams = [
        ExamDto((b) => b
          ..id = 'e-1'
          ..name = 'Midterm'
          ..description = 'Chapters 1-4'
          ..type = ExamType.classic
          ..classAverage = 4.5
          ..date = Date(2026, 3, 12)
          ..classId = 'c-1'
          ..schoolId = 's-1'
          ..grades.add(GradeDto((g) => g
            ..id = 'g-1'
            ..score = 5.5
            ..weighting = 1
            ..examId = 'e-1'
            ..schoolUserId = 'su-1'))),
        ExamDto((b) => b
          ..id = 'e-2'
          ..name = 'Final'
          ..type = ExamType.finalExam
          ..classAverage = 0
          ..schoolId = 's-1'),
      ];

      final agenda = [
        AgendaEntryDto((b) => b
          ..id = 'ag-1'
          ..entryType = AgendaEntryType.lesson
          ..title = 'Math'
          ..description = 'Algebra'
          ..place = 'Room 1'
          ..date = DateTime.utc(2026, 3, 1, 8)
          ..endDate = DateTime.utc(2026, 3, 1, 9)
          ..classId = 'c-1'
          ..schoolId = 's-1'
          ..schoolUserId = 'su-1'),
        AgendaEntryDto((b) => b
          ..id = 'ag-2'
          ..entryType = AgendaEntryType.holiday
          ..title = 'Holiday'
          ..date = DateTime.utc(2026, 4, 1)),
        AgendaEntryDto((b) => b
          ..id = 'ag-3'
          ..entryType = AgendaEntryType.test
          ..title = 'Quiz'
          ..date = DateTime.utc(2026, 3, 5)),
        AgendaEntryDto((b) => b
          ..id = 'ag-4'
          ..entryType = AgendaEntryType.event
          ..title = 'Event'
          ..date = DateTime.utc(2026, 3, 6)),
      ];

      final absences = [
        AbsenceDto((b) => b
          ..id = 'a-1'
          ..reason = 'Sick'
          ..type = AbsenceType.absence
          ..from = DateTime.utc(2026, 1, 5)
          ..until = DateTime.utc(2026, 1, 6)
          ..schoolUserId = 'su-1'
          ..schoolId = 's-1'),
      ];

      final classes = [
        ClassDto((b) => b
          ..id = 'c-1'
          ..name = '4a'
          ..description = 'Fourth grade A'
          ..schoolId = 's-1'
          ..schoolName = 'School'),
      ];

      final reports = [
        SemesterReportDto((b) => b
          ..id = 'r-1'
          ..schoolUserId = 'su-1'
          ..programCode = 'PC'
          ..schoolYearStart = 2025
          ..semesterHalf = 1
          ..className = '4a'
          ..promotionDecision = 'Promoted'
          ..gradeAverage = 5.2
          ..insufficientGradeCount = 0
          ..deficiencyPoints = 0
          ..excusedAbsences = 1
          ..unexcusedAbsences = 0
          ..totalAbsences = 1
          ..subjects.add(SemesterSubjectGradeDto((s) => s
            ..subjectCode = 'MATH'
            ..subjectName = 'Math'
            ..grade = 5.0))),
      ];

      final teachers = [
        TeacherDto((b) => b
          ..id = 't-1'
          ..schoolId = 's-1'
          ..schoolName = 'School'
          ..firstName = 'John'
          ..lastName = 'Doe'
          ..code = 'JD'
          ..email = 'jd@example.com'),
      ];

      final documents = [
        StudentDocumentDto((b) => b
          ..id = 'd-1'
          ..schoolUserId = 'su-1'
          ..title = 'Report'
          ..comment = 'A comment'
          ..category = 'General'
          ..enteredBy = 'teacher'
          ..fileName = 'file.pdf'
          ..fileSizeBytes = 1234
          ..followUpAction = 'Follow up'
          ..followUpDate = Date(2026, 5, 1)
          ..completedDate = Date(2026, 5, 2)
          ..notifiedAt = DateTime.utc(2026, 4, 1)
          ..createdAt = DateTime.utc(2026, 3, 1)),
      ];

      final snapshot = SchoolDataSnapshot(me: me, exams: exams, agenda: agenda, absences: absences, classes: classes, reports: reports, teachers: teachers, documents: documents);

      final encoded = jsonEncode(snapshot.toJson());
      final roundTripped = jsonDecode(encoded) as Map<String, dynamic>;
      final restored = SchoolDataSnapshot.fromJson(roundTripped);

      expect(restored, isNotNull);
      expect(restored!.me?.id, 'su-1');
      expect(restored.me?.firstName, 'Ada');
      expect(restored.me?.lastName, 'Byron');
      expect(restored.me?.role, Roles.student);
      expect(restored.me?.state, UserState.active);
      expect(restored.me?.birthday, Date(2000, 1, 1));
      expect(restored.me?.grades?.single.score, 5.5);
      expect(restored.me?.classes?.single.classId, 'c-1');
      expect(restored.exams.length, 2);
      expect(restored.exams.first.id, 'e-1');
      expect(restored.exams.first.type, ExamType.classic);
      expect(restored.exams.first.date, Date(2026, 3, 12));
      expect(restored.exams.first.grades?.single.score, 5.5);
      expect(restored.exams.last.type, ExamType.finalExam);
      expect(restored.agenda.map((a) => a.entryType), containsAll(AgendaEntryType.values));
      expect(restored.absences.single.reason, 'Sick');
      expect(restored.classes.single.name, '4a');
      expect(restored.reports.single.subjects?.single.subjectCode, 'MATH');
      expect(restored.teachers.single.code, 'JD');
      expect(restored.documents.single.followUpDate, Date(2026, 5, 1));
      expect(restored.documents.single.notifiedAt, DateTime.utc(2026, 4, 1));
    });

    test('non-finite doubles do not break jsonEncode and round-trip intact', () {
      // built_value's DoubleSerializer turns NaN/Infinity into sentinel
      // strings ('NaN' / 'INF' / '-INF') before jsonEncode ever sees a raw
      // double, and reverses that on decode - guard this behaviour so a
      // built_value upgrade that drops it is caught here, not on a device.
      final exams = [
        ExamDto((b) => b
          ..id = 'e-1'
          ..name = 'Bad average'
          ..classAverage = double.nan
          ..schoolId = 's-1'
          ..grades.add(GradeDto((g) => g
            ..id = 'g-1'
            ..score = double.infinity
            ..examId = 'e-1'
            ..schoolUserId = 'su-1'))),
      ];

      final snapshot = SchoolDataSnapshot(me: null, exams: exams, agenda: const [], absences: const [], classes: const [], reports: const [], teachers: const [], documents: const []);

      final encoded = jsonEncode(snapshot.toJson());
      final restored = SchoolDataSnapshot.fromJson(jsonDecode(encoded) as Map<String, dynamic>);

      expect(restored, isNotNull);
      expect(restored!.exams.single.classAverage.isNaN, isTrue);
      expect(restored.exams.single.grades?.single.score, double.infinity);
    });

    test('skips an unreadable item instead of discarding the whole list', () {
      final json = {
        'version': 1,
        'me': null,
        'exams': [
          {'id': 'e-1', 'name': 'Midterm', 'classAverage': 4.5},
          'not an exam',
        ],
        'agenda': const [],
        'absences': const [],
        'classes': const [],
        'reports': const [],
        'teachers': const [],
        'documents': const [],
      };

      final restored = SchoolDataSnapshot.fromJson(json);

      expect(restored, isNotNull);
      expect(restored!.exams.length, 1);
      expect(restored.exams.single.id, 'e-1');
    });

    test('returns null for an unknown version', () {
      expect(SchoolDataSnapshot.fromJson({'version': 99}), isNull);
    });

    test('returns null instead of throwing on malformed data', () {
      expect(SchoolDataSnapshot.fromJson({'version': 1, 'exams': 'nope'}), isNull);
    });
  });

  group('SchoolDataService', () {
    test('refresh with no active school settles into the empty loaded state', () async {
      await SchoolDataService.instance.refresh();

      expect(SchoolDataService.instance.hasLoaded, isTrue);
      expect(SchoolDataService.instance.me, isNull);
      expect(SchoolDataService.instance.loading, isFalse);
      expect(SchoolDataService.instance.exams, isEmpty);

      SchoolDataService.instance.clear();
      expect(SchoolDataService.instance.hasLoaded, isFalse);
    });
  });
}
