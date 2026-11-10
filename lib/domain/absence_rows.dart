import 'package:schuly_api/schuly_api.dart';

import '../services/absence_reporting_service.dart';

/// What Schulnetz's approval fields mean. The mobile API sends English codes (seen on BBB accounts): `trainerStatus`
/// (the Lehrmeister) is `open`, `confirmed` or `declined`, and `parentStatus` is `ofAge` for adults, which means there
/// is no parents' step. Some schools use the German words. Any other word means "unknown": no step, never a guess.
/// The same table as the web app's `absence-steps.ts`.
enum ApprovalState { open, confirmed, rejected, excused }

const _words = <String, ApprovalState>{
  'open': ApprovalState.open,
  'confirmed': ApprovalState.confirmed,
  'declined': ApprovalState.rejected,
  'offen': ApprovalState.open,
  'bestätigt': ApprovalState.confirmed,
  'abgelehnt': ApprovalState.rejected,
  'entschuldigt': ApprovalState.excused,
};

ApprovalState? approvalState(String? value) {
  final word = (value ?? '').trim().toLowerCase();
  return word == 'ofage' ? null : _words[word];
}

enum StepKind { reported, parents, lehrmeister, school }

enum StepState { done, next, todo, rejected }

class AbsenceStep {
  const AbsenceStep(this.kind, this.state);
  final StepKind kind;
  final StepState state;
}

/// The steps this absence really has. Parents and Lehrmeister only appear with a value from the school, and nothing
/// known means no steps at all.
List<AbsenceStep> absenceSteps({required bool reported, String? parentStatus, String? trainerStatus}) {
  final parent = approvalState(parentStatus);
  final trainer = approvalState(trainerStatus);
  if (!reported && parent == null && trainer == null) return const [];
  final steps = <AbsenceStep>[const AbsenceStep(StepKind.reported, StepState.done)];
  var stopped = false;
  void add(StepKind kind, ApprovalState? state) {
    if (state == null) return;
    if (stopped) {
      steps.add(AbsenceStep(kind, StepState.todo));
    } else if (state == ApprovalState.rejected) {
      steps.add(AbsenceStep(kind, StepState.rejected));
      stopped = true;
    } else if (state == ApprovalState.open) {
      steps.add(AbsenceStep(kind, StepState.next));
      stopped = true;
    } else {
      steps.add(AbsenceStep(kind, StepState.done));
    }
  }

  add(StepKind.parents, parent);
  add(StepKind.lehrmeister, trainer);
  steps.add(AbsenceStep(StepKind.school, stopped ? StepState.todo : StepState.next));
  return steps;
}

/// Where an absence stands, as the web app words it.
enum AbsenceState { excused, needsExcuse, unexcused, waiting, rejected, upcoming, unknown }

/// One absence as the web's Absences page shows it: a report and the absence it became share one row.
class AbsenceRow {
  const AbsenceRow({required this.key, required this.isDelay, required this.from, required this.until, required this.time, required this.reason, required this.note, required this.state, required this.waitingFor, required this.rejectedBy, required this.due, required this.dueExpected, required this.steps, required this.trainerComment, required this.lessons, required this.report, required this.printUrl, required this.bbb, required this.absence});

  final String key;
  final bool isDelay;

  /// Days, local midnight.
  final DateTime from;
  final DateTime until;

  /// "08:15 – 11:45", or null for whole days.
  final String? time;

  /// The reason, or null for "Absent".
  final String? reason;
  final String? note;
  final AbsenceState state;

  /// The step being waited for, when [state] is waiting.
  final StepKind? waitingFor;

  /// The step that rejected it, when [state] is rejected.
  final StepKind? rejectedBy;

  /// The last day to excuse it, when [state] is needsExcuse.
  final DateTime? due;

  /// True when [due] is Schuly's estimate (BBB's 14 days) rather than the school's own deadline.
  final bool dueExpected;
  final List<AbsenceStep> steps;
  final String? trainerComment;
  final int? lessons;

  /// The report to withdraw, while the school hasn't processed it.
  final ReportedAbsence? report;

  /// The school's Schulnetz, where BBB students print the form for the Lehrmeister.
  final String? printUrl;
  final bool bbb;
  final AbsenceDto? absence;

  bool get canOpen => steps.isNotEmpty || trainerComment != null || printUrl != null || report != null;
}

/// BBB's rules are only confirmed there: its Schulnetz host.
bool isBbbWebsite(String? website) => website != null && (Uri.tryParse(website)?.host.toLowerCase() == 'schulnetz.bbbaden.ch');

/// BBB: unforeseen absences within 14 days after the absence.
const _bbbExcuseDays = 14;

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// Schuly stores a date-only absence as midnight UTC, which isn't a time anyone was absent.
bool _isDateOnly(DateTime d) {
  final u = d.toUtc();
  return u.hour == 0 && u.minute == 0 && u.second == 0;
}

DateTime _dayOfAbsence(DateTime d) {
  if (_isDateOnly(d)) {
    final u = d.toUtc();
    return DateTime(u.year, u.month, u.day);
  }
  return _day(d.toLocal());
}

String _hm(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

String? _timeOf(AbsenceDto a) {
  if ((a.startTime ?? '').isNotEmpty && (a.endTime ?? '').isNotEmpty) return '${a.startTime} – ${a.endTime}';
  if (_isDateOnly(a.from)) return null;
  final start = _hm(a.from.toLocal()), end = _hm(a.until.toLocal());
  return start == end ? start : '$start – $end';
}

DateTime? _parseDay(String? s) {
  if (s == null || s.length < 10) return null;
  final d = DateTime.tryParse(s.substring(0, 10));
  return d == null ? null : DateTime(d.year, d.month, d.day);
}

/// The same absence listed twice before the sync stopped doing that: an excused copy is the newer one.
List<AbsenceDto> _mergeCopies(Iterable<AbsenceDto> absences) {
  final byIdentity = <String, AbsenceDto>{};
  for (final a in absences) {
    final key = [a.type, a.from.toIso8601String(), a.until.toIso8601String(), a.reason.trim()].join('|');
    final seen = byIdentity[key];
    if (seen == null) {
      byIdentity[key] = a;
    } else if (a.isExcused == true && seen.isExcused != true) {
      byIdentity[key] = seen.rebuild((b) => b.isExcused = true);
    }
  }
  return byIdentity.values.toList();
}

AbsenceRow _buildRow(AbsenceDto? absence, ReportedAbsence? report, {required DateTime today, required bool Function(String? schoolId) isBbb, required String? Function(String? schoolId) website}) {
  final from = absence != null ? _dayOfAbsence(absence.from) : _day(report!.dateFrom);
  final until = absence != null ? _dayOfAbsence(absence.until) : _day(report!.dateTo);
  final isDelay = absence?.type == AbsenceType.delay;
  final schoolId = absence?.schoolId;
  final bbb = isBbb(schoolId);
  final excused = absence?.isExcused == true;
  final steps = excused || isDelay ? const <AbsenceStep>[] : absenceSteps(reported: report != null, parentStatus: absence?.parentStatus, trainerStatus: absence?.trainerStatus);
  final rejectedBy = steps.where((s) => s.state == StepState.rejected && (s.kind == StepKind.parents || s.kind == StepKind.lehrmeister)).firstOrNull?.kind;
  final waitingFor = steps.where((s) => s.state == StepState.next).firstOrNull?.kind;
  final future = from.isAfter(today);
  final schoolDeadline = _parseDay(absence?.excuseDeadline);
  final deadline = schoolDeadline ?? (bbb && !isDelay ? until.add(const Duration(days: _bbbExcuseDays)) : null);

  AbsenceState state;
  DateTime? due;
  if (excused) {
    state = AbsenceState.excused;
  } else if (rejectedBy != null) {
    state = AbsenceState.rejected;
  } else if (waitingFor != null && waitingFor != StepKind.reported) {
    state = AbsenceState.waiting;
  } else if (future) {
    state = AbsenceState.upcoming;
  } else if (absence?.isExcused == false && !isDelay && deadline != null && !deadline.isBefore(today)) {
    state = AbsenceState.needsExcuse;
    due = deadline;
  } else if (absence?.isExcused == false) {
    state = AbsenceState.unexcused;
  } else {
    state = AbsenceState.unknown;
  }

  final trainer = approvalState(absence?.trainerStatus);
  final trainerDone = trainer == ApprovalState.confirmed || trainer == ApprovalState.excused;
  final canPrint = bbb && !isDelay && !trainerDone && (state == AbsenceState.needsExcuse || state == AbsenceState.waiting);
  final reportTime = report?.hourFrom != null && report?.hourTo != null ? '${report!.hourFrom} – ${report.hourTo}' : null;

  String? text(String? s) => (s == null || s.trim().isEmpty) ? null : s.trim();

  return AbsenceRow(
    key: absence?.id ?? 'report|$from|$until|${report?.reason ?? ''}',
    isDelay: isDelay,
    from: from,
    until: until,
    time: absence != null ? (_timeOf(absence) ?? reportTime) : reportTime,
    reason: text(absence?.reason) ?? text(report?.reason),
    note: text(absence?.comment) ?? text(report?.comment),
    state: state,
    waitingFor: state == AbsenceState.waiting ? waitingFor : null,
    rejectedBy: rejectedBy,
    due: due,
    dueExpected: schoolDeadline == null,
    steps: steps,
    trainerComment: text(absence?.trainerComment),
    lessons: absence?.lessons,
    report: report,
    printUrl: canPrint ? website(schoolId) : null,
    bbb: bbb,
    absence: absence,
  );
}

/// One row per absence, newest first: a report and the absence it became are the same thing, so they share a row and
/// keep the Withdraw action. The web app's `buildAbsenceRows`.
List<AbsenceRow> buildAbsenceRows(Iterable<AbsenceDto> absences, Iterable<ReportedAbsence> reports, {required DateTime today, required bool Function(String? schoolId) isBbb, required String? Function(String? schoolId) website}) {
  final unmatched = _mergeCopies(absences);
  final rows = <AbsenceRow>[];
  for (final report in reports) {
    final sameDates = unmatched.where((a) => a.type != AbsenceType.delay && _dayOfAbsence(a.from) == _day(report.dateFrom) && _dayOfAbsence(a.until) == _day(report.dateTo)).toList();
    final match = sameDates.where((a) => a.reason == report.reason).firstOrNull ?? sameDates.firstOrNull;
    if (match != null) unmatched.remove(match);
    rows.add(_buildRow(match, report, today: today, isBbb: isBbb, website: website));
  }
  for (final a in unmatched) {
    rows.add(_buildRow(a, null, today: today, isBbb: isBbb, website: website));
  }
  rows.sort((a, b) {
    final c = b.from.compareTo(a.from);
    return c != 0 ? c : b.key.compareTo(a.key);
  });
  return rows;
}

/// Weekdays someone was absent up to today, each counted once.
int daysMissed(Iterable<AbsenceRow> rows, DateTime today) {
  final days = <DateTime>{};
  for (final r in rows) {
    if (r.isDelay) continue;
    for (var d = r.from; !d.isAfter(r.until) && !d.isAfter(today); d = DateTime(d.year, d.month, d.day + 1)) {
      if (d.weekday <= 5) days.add(d);
    }
  }
  return days.length;
}

/// What the school sent per absence, or null when nothing is known.
int? lessonsMissed(Iterable<AbsenceRow> rows) {
  final known = rows.map((r) => r.lessons).whereType<int>().toList();
  return known.isEmpty ? null : known.fold<int>(0, (a, b) => a + b);
}
