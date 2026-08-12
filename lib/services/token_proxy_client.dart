import 'dart:convert';

import 'package:dio/dio.dart';

import '../domain/private_data.dart';
import 'backend_dio.dart';
import 'private_account_store.dart';
import 'totp_service.dart';

/// Client for the backend's stateless **token-strategy** proxy used in private
/// mode. A headless login mints a bearer token (+ refreshable session); data is
/// then fetched with that token. All endpoints are anonymous: the caller
/// supplies its own credentials (token + context_state) per request; nothing is
/// stored server-side. The system's stateless route comes from the catalog.
class TokenProxyClient {
  TokenProxyClient._();
  static final TokenProxyClient instance = TokenProxyClient._();

  final Dio _dio = backendDio(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 60),
  );

  /// Headless credential login (private mode): POST email + password (+ TOTP) to
  /// the stateless `/login` and get back tokens + the rotated context_state.
  Future<PrivateRefreshResult> login({
    required String basePath,
    required String baseUrl,
    required String email,
    required String password,
    String? totpSecret,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '$basePath/login',
      data: {
        'baseUrl': baseUrl,
        'email': email,
        'password': password,
        'totpSecret': totpSecret,
      },
    );
    return _parse(res.data ?? const {});
  }

  Future<PrivateRefreshResult> refresh({
    required String basePath,
    required String baseUrl,
    required String userAgent,
    required String contextState,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '$basePath/refresh',
      data: {
        'baseUrl': baseUrl,
        'userAgent': userAgent,
        // Send the opaque blob as a JSON object, not a string.
        'contextState': jsonDecode(contextState),
      },
    );
    return _parse(res.data ?? const {});
  }

  /// Builds the result from a stateless login/refresh response. The opaque
  /// rotated context_state is re-encoded to a JSON string for storage.
  PrivateRefreshResult _parse(Map<String, dynamic> m) {
    final rotated = m['contextState'];
    return PrivateRefreshResult(
      success: m['success'] as bool? ?? false,
      message: m['message'] as String?,
      accessToken: m['accessToken'] as String?,
      refreshToken: m['refreshToken'] as String?,
      webSessionId: m['webSessionId'] as String?,
      webSessionUserId: m['webSessionUserId'] as String?,
      webSessionTransId: m['webSessionTransId'] as String?,
      contextState: rotated == null ? null : jsonEncode(rotated),
    );
  }

  Future<List<PrivateGrade>> grades(PrivateAccount a) =>
      _list('/grades', a, PrivateGrade.fromJson);

  Future<List<PrivateExam>> exams(PrivateAccount a) =>
      _list('/exams', a, PrivateExam.fromJson);

  Future<List<PrivateAbsence>> absences(PrivateAccount a) =>
      _list('/absences', a, PrivateAbsence.fromJson);

  Future<List<PrivateAgendaEvent>> agenda(PrivateAccount a) =>
      _list('/agenda', a, PrivateAgendaEvent.fromJson);

  Future<PrivateUserInfo?> userInfo(PrivateAccount a) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '${a.statelessBasePath}/userinfo',
      options: Options(headers: _headers(a)),
    );
    return res.data == null ? null : PrivateUserInfo.fromJson(res.data!);
  }

  Future<TokenPrivateData> fetchAll(PrivateAccount account) async {
    try {
      return await _fetchAll(account, null);
    } on DioException catch (e) {
      if (e.response?.statusCode != 401) rethrow;
      final refreshed = await _refreshAccount(account);
      if (refreshed == null) rethrow;
      return await _fetchAll(refreshed, refreshed);
    }
  }

  Future<TokenPrivateData> _fetchAll(
      PrivateAccount a, PrivateAccount? refreshed) async {
    final info = await userInfo(a);
    final g = await grades(a);
    final e = await exams(a);
    final ab = await absences(a);
    final ag = await agenda(a);
    return TokenPrivateData(
      userInfo: info,
      grades: g,
      exams: e,
      absences: ab,
      agenda: ag,
      refreshedAccount: refreshed,
    );
  }

  /// Re-establishes a token, returning an account carrying the new token and
  /// rotated context_state, or null if it isn't possible / failed. Tries the
  /// cheap passwordless refresh first; if that's unavailable or rejected, falls
  /// back to a full credential re-login from the vaulted email/password/seed -
  /// Schuly regenerates the OTP itself, so the user is never prompted.
  Future<PrivateAccount?> _refreshAccount(PrivateAccount a) async {
    if (a.contextState != null) {
      final r = await refresh(
        basePath: a.statelessBasePath,
        baseUrl: a.baseUrl,
        userAgent: a.userAgent ?? '',
        contextState: a.contextState!,
      );
      if (r.success && r.accessToken != null) return _applied(a, r);
    }
    return _credentialRelogin(a);
  }

  Future<PrivateAccount?> _credentialRelogin(PrivateAccount a) async {
    final email = a.username;
    final password = a.password;
    if (email == null || email.isEmpty || password == null || password.isEmpty) {
      return null;
    }
    final r = await login(
      basePath: a.statelessBasePath,
      baseUrl: a.baseUrl,
      email: email,
      password: password,
      totpSecret: TotpService.secretOf(a.totpSecret),
    );
    if (!r.success || r.accessToken == null) return null;
    return _applied(a, r);
  }

  PrivateAccount _applied(PrivateAccount a, PrivateRefreshResult r) =>
      PrivateAccount(
        systemKey: a.systemKey,
        loginMethod: a.loginMethod,
        baseUrl: a.baseUrl,
        displayName: a.displayName,
        statelessBasePath: a.statelessBasePath,
        accessToken: r.accessToken,
        refreshToken: r.refreshToken ?? a.refreshToken,
        contextState: r.contextState ?? a.contextState,
        userAgent: a.userAgent,
        username: a.username,
        password: a.password,
        totpSecret: a.totpSecret,
      );

  Future<List<T>> _list<T>(
    String path,
    PrivateAccount a,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final res = await _dio.get<List<dynamic>>('${a.statelessBasePath}$path',
        options: Options(headers: _headers(a)));
    return (res.data ?? const [])
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, String> _headers(PrivateAccount a) => {
        'X-Plugin-Token': a.accessToken ?? '',
        'X-Provider-Base-Url': a.baseUrl,
      };
}

class TokenPrivateData {
  final PrivateUserInfo? userInfo;
  final List<PrivateGrade> grades;
  final List<PrivateExam> exams;
  final List<PrivateAbsence> absences;
  final List<PrivateAgendaEvent> agenda;
  final PrivateAccount? refreshedAccount;
  const TokenPrivateData({
    required this.userInfo,
    required this.grades,
    required this.exams,
    required this.absences,
    required this.agenda,
    this.refreshedAccount,
  });
}
