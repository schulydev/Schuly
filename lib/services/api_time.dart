import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/schuly_api.dart';

/// The generated client hands back every `DateTime` in UTC - its serializer
/// calls `toUtc()` on deserialize. The UI reads calendar fields and compares
/// against `DateTime.now()`, so DTOs are converted to local time here, where
/// they enter the app. `Date` fields carry no time zone and are left alone.
class ApiTime {
  const ApiTime._();

  static AgendaEntryDto agendaEntry(AgendaEntryDto a) => a.rebuild((b) => b
    ..date = a.date.toLocal()
    ..endDate = a.endDate?.toLocal());

  static List<AgendaEntryDto> agenda(Iterable<AgendaEntryDto> entries) =>
      entries.map(agendaEntry).toList(growable: false);

  static AbsenceDto absence(AbsenceDto a) => a.rebuild((b) => b
    ..from = a.from.toLocal()
    ..until = a.until.toLocal());

  static List<AbsenceDto> absences(Iterable<AbsenceDto> list) =>
      list.map(absence).toList(growable: false);

  static StudentDocumentDto document(StudentDocumentDto d) => d.rebuild((b) => b
    ..notifiedAt = d.notifiedAt?.toLocal()
    ..createdAt = d.createdAt?.toLocal());

  static List<StudentDocumentDto> documents(Iterable<StudentDocumentDto> list) =>
      list.map(document).toList(growable: false);

  static ClassDto schoolClass(ClassDto c) {
    final agenda = c.agenda;
    if (agenda == null) return c;
    return c.rebuild((b) => b..agenda = ListBuilder<AgendaEntryDto>(agenda.map(agendaEntry)));
  }

  static List<ClassDto> classes(Iterable<ClassDto> list) =>
      list.map(schoolClass).toList(growable: false);

  /// A date-only value sent to the API: the picked calendar day, pinned to UTC
  /// midnight so the day survives the round trip.
  static DateTime utcDate(DateTime d) => DateTime.utc(d.year, d.month, d.day);
}
