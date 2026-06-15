import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:schuly_api/schuly_api.dart';

import 'active_account_service.dart';
import 'api_client.dart';
import 'app_mode_service.dart';
import 'odaorg_proxy_client.dart';
import 'private_account_store.dart';
import 'private_data_adapter.dart';
import 'schulware_proxy_client.dart';

/// Loads and caches the per-school data the UI renders: the signed-in user's
/// SchoolUser record (with nested grades/absences/classes), plus the school's
/// exams and agenda. Everything is filtered to [ActiveAccountService.active].
///
/// The backend scopes responses to the authenticated user but doesn't filter
/// by school, so we filter by `schoolId` client-side.
class SchoolDataService extends ChangeNotifier {
  SchoolDataService._();
  static final SchoolDataService instance = SchoolDataService._();

  SchoolUserDto? _me;
  List<ExamDto> _exams = const [];
  List<AgendaEntryDto> _agenda = const [];
  List<AbsenceDto> _absences = const [];
  List<ClassDto> _classes = const [];
  List<SemesterReportDto> _reports = const [];
  List<TeacherDto> _teachers = const [];
  List<StudentDocumentDto> _documents = const [];
  bool _loading = false;
  Object? _error;

  SchoolUserDto? get me => _me;
  List<ExamDto> get exams => _exams;
  List<AgendaEntryDto> get agenda => _agenda;
  List<AbsenceDto> get absences => _absences;
  List<ClassDto> get classes => _classes;
  List<SemesterReportDto> get reports => _reports;
  List<TeacherDto> get teachers => _teachers;
  List<StudentDocumentDto> get documents => _documents;
  bool get loading => _loading;
  Object? get error => _error;

  /// Friendly class name by class id, from the full ClassDto.
  Map<String, String> get classNameById {
    final out = <String, String>{};
    for (final c in _classes) {
      if (c.id != null && c.name.isNotEmpty) out[c.id!] = c.name;
    }
    return out;
  }

  SchulyApi get _api => ApiClient.instance.api;

  /// My grades for the active school, keyed by examId.
  Map<String, GradeDto> get myGradesByExam {
    final out = <String, GradeDto>{};
    final grades = _me?.grades;
    if (grades != null) {
      for (final g in grades) {
        if (g.examId != null) out[g.examId!] = g;
      }
    }
    return out;
  }

  Future<void> refresh() async {
    if (AppModeService.instance.isPrivate) {
      await _refreshPrivate();
      return;
    }

    final schoolId = ActiveAccountService.instance.active?.id;
    if (schoolId == null) {
      _me = null;
      _exams = const [];
      _agenda = const [];
      _absences = const [];
      notifyListeners();
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();
    try {
      // Who am I → my SchoolUser for this school (carries nested grades etc.).
      final me = await _api.getAuthApi().apiAuthMeGet();
      final appUserId = me.data?.id;
      if (appUserId != null) {
        final users = await _api
            .getSchoolUsersApi()
            .apiSchoolUsersGet(applicationUserId: appUserId);
        _me = (users.data ?? BuiltList<SchoolUserDto>())
            .where((u) => u.schoolId == schoolId)
            .cast<SchoolUserDto?>()
            .firstWhere((_) => true, orElse: () => null);
      }

      final exams = await _api.getExamsApi().apiExamsGet();
      _exams = (exams.data ?? BuiltList<ExamDto>())
          .where((e) => e.schoolId == schoolId)
          .toList(growable: false);

      // Agenda entries carry a classId but no schoolId, so scope them by the
      // user's classes (their classes all belong to the active school).
      final myClassIds = {
        for (final c in (_me?.classes ?? const <UserClassDto>[])) c.classId,
      };
      final meId = _me?.id;
      final agenda = await _api.getAgendasApi().apiAgendasGet();
      _agenda = (agenda.data ?? BuiltList<AgendaEntryDto>())
          // Scraped lessons + holidays are scoped to the SchoolUser (no class);
          // class-scoped entries are matched by the user's class membership.
          .where((a) =>
              (meId != null && a.schoolUserId == meId) ||
              a.entryType == AgendaEntryType.holiday ||
              myClassIds.isEmpty ||
              myClassIds.contains(a.classId))
          .toList(growable: false);

      final absences = await _api.getAbsencesApi().apiAbsencesGet();
      _absences = (absences.data ?? BuiltList<AbsenceDto>())
          .where((a) => a.schoolId == schoolId)
          .toList(growable: false);

      final classes = await _api.getClassApi().apiClassGet();
      _classes = (classes.data ?? BuiltList<ClassDto>())
          .where((c) => c.schoolId == schoolId)
          .toList(growable: false);

      final reports = await _api.getSemesterReportsApi().apiSemesterReportsGet();
      _reports = (reports.data ?? BuiltList<SemesterReportDto>())
          .where((r) => meId == null || r.schoolUserId == meId)
          .toList(growable: false);

      final teachers = await _api.getTeachersApi().apiTeachersGet();
      _teachers = (teachers.data ?? BuiltList<TeacherDto>())
          .where((t) => t.schoolId == schoolId)
          .toList(growable: false);

      final documents = await _api.getStudentDocumentsApi().apiDocumentsGet();
      _documents = (documents.data ?? BuiltList<StudentDocumentDto>())
          .where((d) => meId == null || d.schoolUserId == meId)
          .toList(growable: false);
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Private mode: pull data from the stateless proxy with the on-device
  /// credentials and adapt it into the same DTOs the UI renders. Nothing here
  /// touches a Schuly account; features without a proxy source stay empty.
  Future<void> _refreshPrivate() async {
    final account = await PrivateAccountStore.instance.load();
    if (account == null) {
      clear();
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();
    try {
      if (account.isOdaorg) {
        // OdAOrg: one scrape pass returns everything.
        final d = await OdaorgProxyClient.instance.data(account);
        _me = PrivateDataAdapter.schoolUser(d.userInfo, d.grades, const []);
        _exams = PrivateDataAdapter.exams(d.exams);
        _absences = const [];
        _agenda = PrivateDataAdapter.agenda(d.agenda);
      } else {
        // Schulnetz: separate mobile endpoints.
        final proxy = SchulwareProxyClient.instance;
        final info = await proxy.userInfo(account);
        final grades = await proxy.grades(account);
        final exams = await proxy.exams(account);
        final absences = await proxy.absences(account);
        final agenda = await proxy.agenda(account);

        _me = PrivateDataAdapter.schoolUser(info, grades, absences);
        _exams = PrivateDataAdapter.exams(exams);
        _absences = PrivateDataAdapter.absencesList(absences);
        _agenda = PrivateDataAdapter.agenda(agenda);
      }
      _classes = const [];
      _reports = const [];
      _teachers = const [];
      _documents = const [];
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear() {
    _me = null;
    _exams = const [];
    _agenda = const [];
    _absences = const [];
    _classes = const [];
    _reports = const [];
    _teachers = const [];
    _documents = const [];
    _error = null;
    notifyListeners();
  }
}
