import 'package:flutter/foundation.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/school_system.dart';
import '../domain/my_school.dart';
import 'api_client.dart';
import 'school_systems_service.dart';

class ActiveAccountService extends ChangeNotifier {
  ActiveAccountService._();
  static final ActiveAccountService instance = ActiveAccountService._();

  static const _activeIdKey = 'accounts.active_id';

  List<MySchool> _schools = const [];
  String? _activeId;
  bool _loading = false;
  Object? _error;

  List<MySchool> get schools => _schools;
  bool get loading => _loading;
  Object? get error => _error;

  MySchool? get active {
    if (_schools.isEmpty) return null;
    if (_activeId != null) {
      for (final s in _schools) {
        if (s.id == _activeId) return s;
      }
    }
    return _schools.first;
  }

  Future<void> refresh() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final api = ApiClient.instance.api;
      final res = await api.getSchoolsApi().apiSchoolsMySchoolsGet();
      final data = res.data;

      final pluginBySchoolId = await _detectPluginAccounts();
      _schools = data == null
          ? const []
          : data.map((dto) {
              final info = pluginBySchoolId[dto.id];
              return MySchool.fromDto(dto,
                  provider: info?.provider ?? '',
                  pluginBasePath: info?.pluginBasePath,
                  pluginAccountId: info?.accountId);
            }).toList(growable: false);

      final prefs = await SharedPreferences.getInstance();
      final persisted = prefs.getString(_activeIdKey);
      if (persisted != null && _schools.any((s) => s.id == persisted)) {
        _activeId = persisted;
      } else {
        _activeId = _schools.isEmpty ? null : _schools.first.id;
        if (_activeId != null) {
          await prefs.setString(_activeIdKey, _activeId!);
        } else {
          await prefs.remove(_activeIdKey);
        }
      }
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<Map<String, ({String provider, String accountId, String? pluginBasePath})>>
      _detectPluginAccounts() async {
    try {
      final api = ApiClient.instance.api;
      final dio = ApiClient.instance.dio;
      final me = await api.getAuthApi().apiAuthMeGet();
      final appUserId = me.data?.id;
      if (appUserId == null) return const {};

      final usersRes =
          await api.getSchoolUsersApi().apiSchoolUsersGet(applicationUserId: appUserId);
      final schoolIdByUser = <String, String>{
        for (final u in (usersRes.data ?? const <SchoolUserDto>[]))
          if (u.id != null && u.schoolId != null) u.id!: u.schoolId!,
      };

      List<SchoolSystem> systems;
      try {
        systems = await SchoolSystemsService.fetch();
      } catch (_) {
        systems = const [];
      }

      final out =
          <String, ({String provider, String accountId, String? pluginBasePath})>{};
      for (final sys in systems) {
        final base = sys.pluginBasePath;
        if (base == null || base.isEmpty) continue;
        try {
          final res = await dio.get<List<dynamic>>('$base/accounts');
          for (final a in (res.data ?? const []).cast<Map<String, dynamic>>()) {
            final suId = a['schoolUserId'] as String?;
            final accId = a['id'] as String?;
            final schoolId = suId == null ? null : schoolIdByUser[suId];
            if (schoolId != null && accId != null) {
              out[schoolId] =
                  (provider: sys.key, accountId: accId, pluginBasePath: base);
            }
          }
        } catch (_) {}
      }
      return out;
    } catch (_) {
      return const {};
    }
  }

  Future<void> setActive(String id) async {
    if (_activeId == id) return;
    _activeId = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeIdKey, id);
    notifyListeners();
  }

  /// Resolves a school's plugin account, re-running detection when the id is
  /// missing - startup detection is best-effort and can fail transiently.
  Future<({String accountId, String basePath})?> resolvePluginTarget(MySchool school) async {
    final id = school.pluginAccountId;
    final base = school.pluginBasePath;
    if (id != null && base != null && base.isNotEmpty) return (accountId: id, basePath: base);
    final detected = (await _detectPluginAccounts())[school.id];
    final detectedBase = detected?.pluginBasePath;
    if (detected == null || detectedBase == null || detectedBase.isEmpty) return null;
    return (accountId: detected.accountId, basePath: detectedBase);
  }

  Future<void> removeSchool(MySchool school) async {
    final target = await resolvePluginTarget(school);
    if (target == null) {
      throw Exception('Could not resolve the connected account for ${school.name}. Check your connection and try again.');
    }
    await ApiClient.instance.dio.delete<dynamic>('${target.basePath}/accounts/${target.accountId}');
    if (_activeId == school.id) {
      _activeId = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_activeIdKey);
    }
    await refresh();
  }

  Future<void> clear() async {
    _schools = const [];
    _activeId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeIdKey);
    notifyListeners();
  }
}
