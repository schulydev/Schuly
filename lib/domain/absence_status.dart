import 'package:schuly_api/schuly_api.dart';

import '../services/absence_reporting_service.dart';

/// Where an absence stands. Schuly only knows whether the school excused it and which reports are still pending; the
/// parents' and the Lehrbetrieb's steps are not in the data.
enum AbsenceState {
  excused,

  /// Not excused, and no pending report covers it.
  needsExcuse,

  /// Not excused, but a report that covers it is waiting for the school.
  waiting,
}

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// True when [report] covers the day [absence] starts on.
bool reportCovers(ReportedAbsence report, AbsenceDto absence) {
  final day = _day(absence.from.toLocal());
  return !day.isBefore(_day(report.dateFrom)) && !day.isAfter(_day(report.dateTo));
}

/// Only an explicit "not excused" counts as unexcused; a school that does not say is not nagged about.
AbsenceState absenceState(AbsenceDto absence, List<ReportedAbsence> reported) {
  if (absence.isExcused != false) return AbsenceState.excused;
  return reported.any((r) => reportCovers(r, absence)) ? AbsenceState.waiting : AbsenceState.needsExcuse;
}

/// The absences the school has not excused, newest first.
List<AbsenceDto> unexcusedAbsences(Iterable<AbsenceDto> absences) => absences.where((a) => a.isExcused == false).toList()..sort((a, b) => b.from.compareTo(a.from));

/// How many lessons (and tests) of [agenda] fall into [from] to [until]. A lesson without an end counts 45 minutes.
int lessonsDuring(Iterable<AgendaEntryDto> agenda, DateTime from, DateTime until) {
  var count = 0;
  for (final a in agenda) {
    if (a.entryType != AgendaEntryType.lesson && a.entryType != AgendaEntryType.test) continue;
    final start = a.date;
    final end = a.endDate ?? start.add(const Duration(minutes: 45));
    if (start.isBefore(until) && end.isAfter(from)) count++;
  }
  return count;
}
