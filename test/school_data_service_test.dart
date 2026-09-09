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
        ..role = Roles.student);

      final exams = [
        ExamDto((b) => b
          ..id = 'e-1'
          ..name = 'Midterm'
          ..classAverage = 4.5
          ..date = Date(2026, 3, 12)
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
          ..classAverage = 4.0
          ..schoolId = 's-1'),
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
          ..schoolId = 's-1'),
      ];

      final snapshot = SchoolDataSnapshot(me: me, exams: exams, agenda: const [], absences: absences, classes: classes, reports: const [], teachers: const [], documents: const []);

      final roundTripped = jsonDecode(jsonEncode(snapshot.toJson())) as Map<String, dynamic>;
      final restored = SchoolDataSnapshot.fromJson(roundTripped);

      expect(restored, isNotNull);
      expect(restored!.me?.id, 'su-1');
      expect(restored.me?.firstName, 'Ada');
      expect(restored.me?.lastName, 'Byron');
      expect(restored.exams.length, 2);
      expect(restored.exams.first.id, 'e-1');
      expect(restored.exams.first.date, Date(2026, 3, 12));
      expect(restored.exams.first.grades?.single.score, 5.5);
      expect(restored.absences.single.reason, 'Sick');
      expect(restored.classes.single.name, '4a');
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
