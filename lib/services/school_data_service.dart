import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart' show Response;
import 'package:flutter/foundation.dart';
import 'package:schuly_api/schuly_api.dart';

import 'active_account_service.dart';
import 'api_client.dart';
import 'app_mode_service.dart';
import 'private_account_store.dart';
import 'private_data_adapter.dart';
import 'school_data_snapshot.dart';
import 'scrape_proxy_client.dart';
import 'toast_service.dart';
import 'token_proxy_client.dart';

class SchoolDataService extends ChangeNotifier {
  SchoolDataService._();
  static final SchoolDataService instance = SchoolDataService._();

  static const _handled = <String, dynamic>{ApiClient.handlesErrors: true};

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
  int _generation = 0;
  bool _hasLoaded = false;
  String? _snapshotKey;

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
  bool get hasLoaded => _hasLoaded;

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

  String? get _currentKey {
    if (AppModeService.instance.isPrivate) return 'private';
    final id = ActiveAccountService.instance.active?.id;
    return id == null ? null : 'account.$id';
  }

  /// Loads the last successful snapshot from disk so the first frame shows real
  /// data instead of an empty home. Called once at startup, before a live
  /// [refresh] has had a chance to commit.
  Future<void> loadCached() async {
    if (_hasLoaded) return;
    String? key;
    if (AppModeService.instance.isPrivate) {
      key = 'private';
    } else {
      final id = await ActiveAccountService.persistedActiveId();
      if (id == null) return;
      key = 'account.$id';
    }

    final gen = _generation;
    final snapshot = await SchoolDataSnapshotStore.instance.load(key);
    if (snapshot == null || gen != _generation || _hasLoaded) return;

    _me = snapshot.me;
    _exams = snapshot.exams;
    _agenda = snapshot.agenda;
    _absences = snapshot.absences;
    _classes = snapshot.classes;
    _reports = snapshot.reports;
    _teachers = snapshot.teachers;
    _documents = snapshot.documents;
    _snapshotKey = key;
    _hasLoaded = true;
    notifyListeners();
  }

  Future<void> refresh() async {
    final gen = ++_generation;
    final key = _currentKey;
    if (_snapshotKey != null && _snapshotKey != key) _resetData();
    _snapshotKey = key;

    if (AppModeService.instance.isPrivate) {
      await _refreshPrivate(gen);
      return;
    }

    final schoolId = ActiveAccountService.instance.active?.id;
    if (schoolId == null) {
      _resetData();
      _hasLoaded = true;
      notifyListeners();
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final me = await _api.getAuthApi().apiAuthMeGet(extra: _handled);
      final appUserId = me.data?.id;
      SchoolUserDto? mine;
      if (appUserId != null) {
        final users = await _api
            .getSchoolUsersApi()
            .apiSchoolUsersGet(applicationUserId: appUserId, extra: _handled);
        mine = (users.data ?? BuiltList<SchoolUserDto>())
            .where((u) => u.schoolId == schoolId)
            .cast<SchoolUserDto?>()
            .firstWhere((_) => true, orElse: () => null);
      }

      final myClassIds = {
        for (final c in (mine?.classes ?? const <UserClassDto>[])) c.classId,
      };
      final meId = mine?.id;

      final responses = await Future.wait<Response<dynamic>>([
        _api.getExamsApi().apiExamsGet(extra: _handled),
        _api.getAgendasApi().apiAgendasGet(extra: _handled),
        _api.getAbsencesApi().apiAbsencesGet(extra: _handled),
        _api.getClassApi().apiClassGet(extra: _handled),
        _api.getSemesterReportsApi().apiSemesterReportsGet(extra: _handled),
        _api.getTeachersApi().apiTeachersGet(extra: _handled),
        _api.getStudentDocumentsApi().apiDocumentsGet(extra: _handled),
      ]);

      final exams = ((responses[0].data as BuiltList<ExamDto>?) ?? BuiltList<ExamDto>())
          .where((e) => e.schoolId == schoolId)
          .toList(growable: false);

      final agenda = ((responses[1].data as BuiltList<AgendaEntryDto>?) ?? BuiltList<AgendaEntryDto>())
          .where((a) =>
              (meId != null && a.schoolUserId == meId) ||
              a.entryType == AgendaEntryType.holiday ||
              myClassIds.isEmpty ||
              myClassIds.contains(a.classId))
          .toList(growable: false);

      final absences = ((responses[2].data as BuiltList<AbsenceDto>?) ?? BuiltList<AbsenceDto>())
          .where((a) => a.schoolId == schoolId)
          .toList(growable: false);

      final classes = ((responses[3].data as BuiltList<ClassDto>?) ?? BuiltList<ClassDto>())
          .where((c) => c.schoolId == schoolId)
          .toList(growable: false);

      final reports = ((responses[4].data as BuiltList<SemesterReportDto>?) ?? BuiltList<SemesterReportDto>())
          .where((r) => meId == null || r.schoolUserId == meId)
          .toList(growable: false);

      final teachers = ((responses[5].data as BuiltList<TeacherDto>?) ?? BuiltList<TeacherDto>())
          .where((t) => t.schoolId == schoolId)
          .toList(growable: false);

      final documents = ((responses[6].data as BuiltList<StudentDocumentDto>?) ?? BuiltList<StudentDocumentDto>())
          .where((d) => meId == null || d.schoolUserId == meId)
          .toList(growable: false);

      if (gen != _generation) return;
      _me = mine;
      _exams = exams;
      _agenda = agenda;
      _absences = absences;
      _classes = classes;
      _reports = reports;
      _teachers = teachers;
      _documents = documents;
      if (key != null) {
        await SchoolDataSnapshotStore.instance.save(
            key,
            SchoolDataSnapshot(me: _me, exams: _exams, agenda: _agenda, absences: _absences, classes: _classes, reports: _reports, teachers: _teachers, documents: _documents));
      }
      _hasLoaded = true;
    } catch (e) {
      if (gen != _generation) return;
      _error = e;
      if (_me != null) ToastService.error('Could not refresh', e);
    } finally {
      if (gen == _generation) {
        _loading = false;
        notifyListeners();
      }
    }
  }

  Future<void> _refreshPrivate(int gen) async {
    final account = await PrivateAccountStore.instance.load();
    if (account == null) {
      _resetData();
      _hasLoaded = true;
      _snapshotKey = null;
      notifyListeners();
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();
    try {
      SchoolUserDto? mine;
      List<ExamDto> exams;
      List<AbsenceDto> absences;
      List<AgendaEntryDto> agenda;
      List<ClassDto> classes;
      if (account.accessToken != null) {
        final d = await TokenProxyClient.instance.fetchAll(account);
        if (d.refreshedAccount != null) {
          await PrivateAccountStore.instance.save(d.refreshedAccount!);
        }
        mine = PrivateDataAdapter.schoolUser(d.userInfo, d.grades, d.absences);
        exams = PrivateDataAdapter.exams(d.exams);
        absences = PrivateDataAdapter.absencesList(d.absences);
        agenda = PrivateDataAdapter.agenda(d.agenda);
        classes = PrivateDataAdapter.classes(d.grades, d.exams);
      } else {
        final d = await ScrapeProxyClient.instance.data(account);
        mine = PrivateDataAdapter.schoolUser(d.userInfo, d.grades, const []);
        exams = PrivateDataAdapter.exams(d.exams);
        absences = const [];
        agenda = PrivateDataAdapter.agenda(d.agenda);
        classes = PrivateDataAdapter.classes(d.grades, d.exams);
      }

      if (gen != _generation) return;
      _me = mine;
      _exams = exams;
      _absences = absences;
      _agenda = agenda;
      _classes = classes;
      _reports = const [];
      _teachers = const [];
      _documents = const [];
      await SchoolDataSnapshotStore.instance.save(
          'private',
          SchoolDataSnapshot(me: _me, exams: _exams, agenda: _agenda, absences: _absences, classes: _classes, reports: _reports, teachers: _teachers, documents: _documents));
      _hasLoaded = true;
    } catch (e) {
      if (gen != _generation) return;
      _error = e;
      if (_me != null) ToastService.error('Could not refresh', e);
    } finally {
      if (gen == _generation) {
        _loading = false;
        notifyListeners();
      }
    }
  }

  void _resetData() {
    _me = null;
    _exams = const [];
    _agenda = const [];
    _absences = const [];
    _classes = const [];
    _reports = const [];
    _teachers = const [];
    _documents = const [];
    _error = null;
    _hasLoaded = false;
  }

  void clear() {
    _generation++;
    _resetData();
    _snapshotKey = null;
    notifyListeners();
  }

  /// Ends the first-load state without touching the data: the school list could
  /// not be fetched, so the cached snapshot is the best there is to show.
  void settle() {
    if (_hasLoaded) return;
    _hasLoaded = true;
    notifyListeners();
  }

  Future<void> clearCache() async {
    await SchoolDataSnapshotStore.instance.clear();
  }
}
