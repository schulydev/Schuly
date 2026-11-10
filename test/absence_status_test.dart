import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/domain/absence_status.dart';
import 'package:schuly/services/absence_reporting_service.dart';
import 'package:schuly_api/schuly_api.dart';

AbsenceDto _absence(String id, DateTime from, {bool? excused, AbsenceType type = AbsenceType.absence, DateTime? until}) => AbsenceDto((b) => b
  ..id = id
  ..reason = 'Krankheit'
  ..type = type
  ..isExcused = excused
  ..from = from
  ..until = until ?? from.add(const Duration(hours: 6)));

void main() {
  group('unexcusedAbsences', () {
    test('keeps only the ones the school marked as not excused, newest first', () {
      final list = unexcusedAbsences([
        _absence('old', DateTime(2026, 9, 1), excused: false),
        _absence('excused', DateTime(2026, 10, 1), excused: true),
        _absence('unknown', DateTime(2026, 10, 5)),
        _absence('new', DateTime(2026, 11, 3), excused: false),
      ]);
      expect(list.map((a) => a.id), ['new', 'old']);
    });

    test('is empty when everything is excused', () {
      expect(unexcusedAbsences([_absence('a', DateTime(2026, 11, 3), excused: true)]), isEmpty);
    });
  });

  group('absenceState', () {
    final report = ReportedAbsence(ids: const ['r'], dateFrom: DateTime(2026, 11, 2), dateTo: DateTime(2026, 11, 4));

    test('an excused absence is excused, whatever is pending', () {
      expect(absenceState(_absence('a', DateTime(2026, 11, 3, 8), excused: true), [report]), AbsenceState.excused);
    });

    test('an unexcused absence a pending report covers is waiting', () {
      expect(absenceState(_absence('a', DateTime(2026, 11, 3, 8), excused: false), [report]), AbsenceState.waiting);
    });

    test('an unexcused absence without a report needs an excuse', () {
      expect(absenceState(_absence('a', DateTime(2026, 11, 10, 8), excused: false), [report]), AbsenceState.needsExcuse);
      expect(absenceState(_absence('a', DateTime(2026, 11, 10, 8), excused: false), const []), AbsenceState.needsExcuse);
    });
  });

  test('lessonsDuring counts the lessons and tests an absence covers', () {
    AgendaEntryDto e(int h, AgendaEntryType type) => AgendaEntryDto((b) => b
      ..entryType = type
      ..title = 'x'
      ..date = DateTime(2026, 11, 3, h)
      ..endDate = DateTime(2026, 11, 3, h, 45));
    final agenda = [e(8, AgendaEntryType.lesson), e(10, AgendaEntryType.test), e(12, AgendaEntryType.event), e(14, AgendaEntryType.lesson)];
    expect(lessonsDuring(agenda, DateTime(2026, 11, 3, 8), DateTime(2026, 11, 3, 12)), 2);
    expect(lessonsDuring(agenda, DateTime(2026, 11, 3, 7), DateTime(2026, 11, 3, 16)), 3);
  });
}
