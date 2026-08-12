import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:schuly_api/schuly_api.dart';

import 'active_account_service.dart';
import 'api_client.dart';
import 'app_mode_service.dart';
import 'private_account_store.dart';
import 'private_data_adapter.dart';
import 'scrape_proxy_client.dart';
import 'token_proxy_client.dart';

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

  Map<String, String> get classNameById {
    final out = <String, String>{};
    for (final c in _classes) {
      if (c.id != null && c.name.isNotEmpty) out[c.id!] = c.name;
    }
    return out;
  }

  SchulyApi get _api => ApiClient.instance.api;

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

      final myClassIds = {
        for (final c in (_me?.classes ?? const <UserClassDto>[])) c.classId,
      };
      final meId = _me?.id;
      final agenda = await _api.getAgendasApi().apiAgendasGet();
      _agenda = (agenda.data ?? BuiltList<AgendaEntryDto>())
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
      if (account.accessToken != null) {
        final d = await TokenProxyClient.instance.fetchAll(account);
        if (d.refreshedAccount != null) {
          await PrivateAccountStore.instance.save(d.refreshedAccount!);
        }
        _me = PrivateDataAdapter.schoolUser(d.userInfo, d.grades, d.absences);
        _exams = PrivateDataAdapter.exams(d.exams);
        _absences = PrivateDataAdapter.absencesList(d.absences);
        _agenda = PrivateDataAdapter.agenda(d.agenda);
        _classes = PrivateDataAdapter.classes(d.grades, d.exams);
      } else {
        final d = await ScrapeProxyClient.instance.data(account);
        _me = PrivateDataAdapter.schoolUser(d.userInfo, d.grades, const []);
        _exams = PrivateDataAdapter.exams(d.exams);
        _absences = const [];
        _agenda = PrivateDataAdapter.agenda(d.agenda);
        _classes = PrivateDataAdapter.classes(d.grades, d.exams);
      }
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
