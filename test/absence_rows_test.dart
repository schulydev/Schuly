import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/domain/absence_rows.dart';
import 'package:schuly/services/absence_reporting_service.dart';
import 'package:schuly_api/schuly_api.dart';

AbsenceDto _absence(String id, DateTime from, {bool? excused, AbsenceType type = AbsenceType.absence, String? parent, String? trainer, String? deadline, String? schoolId}) => AbsenceDto((b) => b
  ..id = id
  ..reason = 'Krankheit'
  ..type = type
  ..isExcused = excused
  ..from = from
  ..until = from.add(const Duration(hours: 6))
  ..parentStatus = parent
  ..trainerStatus = trainer
  ..excuseDeadline = deadline
  ..schoolId = schoolId);

final _today = DateTime(2026, 11, 10);

List<AbsenceRow> _rows(List<AbsenceDto> absences, {List<ReportedAbsence> reports = const [], bool bbb = false}) =>
    buildAbsenceRows(absences, reports, today: _today, isBbb: (_) => bbb, website: (_) => 'https://schulnetz.bbbaden.ch/');

void main() {
  test('steps follow the school\'s approval fields, as on the web', () {
    expect(absenceSteps(reported: false), isEmpty);
    final steps = absenceSteps(reported: false, parentStatus: 'ofAge', trainerStatus: 'open');
    expect(steps.map((s) => (s.kind, s.state)), [(StepKind.reported, StepState.done), (StepKind.lehrmeister, StepState.next), (StepKind.school, StepState.todo)]);
    final rejected = absenceSteps(reported: true, parentStatus: 'declined', trainerStatus: 'confirmed');
    expect(rejected.map((s) => s.state), [StepState.done, StepState.rejected, StepState.todo, StepState.todo]);
  });

  test('states: excused, waiting for the Lehrmeister, rejected, needs an excuse, not excused', () {
    final rows = _rows([
      _absence('excused', DateTime(2026, 11, 2, 8), excused: true),
      _absence('waiting', DateTime(2026, 11, 3, 8), excused: false, trainer: 'open'),
      _absence('rejected', DateTime(2026, 11, 4, 8), excused: false, parent: 'declined'),
      _absence('due', DateTime(2026, 11, 5, 8), excused: false, deadline: '2026-11-19'),
      _absence('late', DateTime(2026, 9, 1, 8), excused: false),
    ]);
    final byKey = {for (final r in rows) r.key: r};
    expect(byKey['excused']!.state, AbsenceState.excused);
    expect(byKey['waiting']!.state, AbsenceState.waiting);
    expect(byKey['waiting']!.waitingFor, StepKind.lehrmeister);
    expect(byKey['rejected']!.state, AbsenceState.rejected);
    expect(byKey['rejected']!.rejectedBy, StepKind.parents);
    expect(byKey['due']!.state, AbsenceState.needsExcuse);
    expect(byKey['due']!.due, DateTime(2026, 11, 19));
    expect(byKey['due']!.dueExpected, isFalse);
    expect(byKey['late']!.state, AbsenceState.unexcused);
    expect(rows.first.key, 'due');
  });

  test('BBB expects 14 days and offers the print form while the Lehrmeister has not confirmed', () {
    final row = _rows([_absence('a', DateTime(2026, 11, 3, 8), excused: false)], bbb: true).single;
    expect(row.state, AbsenceState.needsExcuse);
    expect(row.due, DateTime(2026, 11, 17));
    expect(row.dueExpected, isTrue);
    expect(row.printUrl, 'https://schulnetz.bbbaden.ch/');
  });

  test('a report and its absence share one row that can be withdrawn; a report alone is a row too', () {
    final report = ReportedAbsence(ids: const ['r1'], dateFrom: DateTime(2026, 11, 3), dateTo: DateTime(2026, 11, 3), reason: 'Krankheit');
    final alone = ReportedAbsence(ids: const ['r2'], dateFrom: DateTime(2026, 11, 12), dateTo: DateTime(2026, 11, 12), reason: 'Arzt', hourFrom: '08:15', hourTo: '09:50');
    final rows = _rows([_absence('a', DateTime(2026, 11, 3, 8), excused: false)], reports: [report, alone]);
    expect(rows, hasLength(2));
    expect(rows.last.key, 'a');
    expect(rows.last.report, report);
    expect(rows.last.state, AbsenceState.waiting);
    expect(rows.last.waitingFor, StepKind.school);
    expect(rows.first.report, alone);
    expect(rows.first.time, '08:15 – 09:50');
    expect(rows.first.state, AbsenceState.waiting);
  });

  test('days missed count weekdays once, lessons only when the school sent them', () {
    final rows = _rows([_absence('a', DateTime(2026, 11, 6, 8), excused: true), _absence('b', DateTime(2026, 11, 6, 13), excused: true)]);
    expect(daysMissed(rows, _today), 1);
    expect(lessonsMissed(rows), isNull);
  });
}
