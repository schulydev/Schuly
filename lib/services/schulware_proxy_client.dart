import 'dart:convert';

import 'package:dio/dio.dart';

import '../config/oidc_config.dart';
import '../domain/private_data.dart';
import 'private_account_store.dart';

/// Client for the backend's stateless Schulware proxy used in private mode.
/// All endpoints are anonymous: the caller supplies its own credentials
/// (token + context_state) per request; nothing is stored server-side.
class SchulwareProxyClient {
  SchulwareProxyClient._();
  static final SchulwareProxyClient instance = SchulwareProxyClient._();

  static const _base = '/api/plugins/schulware/stateless';

  final Dio _dio = Dio(BaseOptions(
    baseUrl: OidcConfig.backendBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 60),
  ));

  // --- Auth ---

  /// Starts OAuth: returns the Schulnetz authorize URL + PKCE verifier.
  Future<PrivateAuthorizeUrl> authorizeUrl(String schulnetzBaseUrl) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '$_base/authorize-url',
      queryParameters: {'schulnetzBaseUrl': schulnetzBaseUrl},
    );
    return PrivateAuthorizeUrl.fromJson(res.data ?? const {});
  }

  /// Exchanges the OAuth code for tokens.
  Future<PrivateTokens> exchangeCode({
    required String code,
    required String codeVerifier,
    String? state,
    required String schulnetzBaseUrl,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '$_base/oauth/callback',
      data: {
        'code': code,
        'codeVerifier': codeVerifier,
        'state': state,
        'schulnetzBaseUrl': schulnetzBaseUrl,
      },
    );
    return PrivateTokens.fromJson(res.data ?? const {});
  }

  /// Passwordless refresh from a stored context_state (JSON string).
  Future<PrivateRefreshResult> refresh({
    required String schulnetzBaseUrl,
    required String userAgent,
    required String contextState,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '$_base/refresh',
      data: {
        'schulnetzBaseUrl': schulnetzBaseUrl,
        'userAgent': userAgent,
        // Send the opaque blob as a JSON object, not a string.
        'contextState': jsonDecode(contextState),
      },
    );
    final m = res.data ?? const {};
    final rotated = m['contextState'];
    return PrivateRefreshResult(
      success: m['success'] as bool? ?? false,
      message: m['message'] as String?,
      accessToken: m['accessToken'] as String?,
      refreshToken: m['refreshToken'] as String?,
      webSessionId: m['webSessionId'] as String?,
      webSessionUserId: m['webSessionUserId'] as String?,
      webSessionTransId: m['webSessionTransId'] as String?,
      // Re-encode the rotated context_state object back to a string for storage.
      contextState: rotated == null ? null : jsonEncode(rotated),
    );
  }

  // --- Data ---

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
      '$_base/userinfo',
      options: Options(headers: _headers(a)),
    );
    return res.data == null ? null : PrivateUserInfo.fromJson(res.data!);
  }

  /// Fetches everything the private dashboard needs. If the access token has
  /// expired (a 401 from any call), does one passwordless refresh from the
  /// stored `context_state`, retries, and reports the rotated account back via
  /// [SchulwarePrivateData.refreshedAccount] so the caller can persist it.
  Future<SchulwarePrivateData> fetchAll(PrivateAccount account) async {
    try {
      return await _fetchAll(account, null);
    } on DioException catch (e) {
      if (e.response?.statusCode != 401) rethrow;
      final refreshed = await _refreshAccount(account);
      if (refreshed == null) rethrow;
      return await _fetchAll(refreshed, refreshed);
    }
  }

  Future<SchulwarePrivateData> _fetchAll(
      PrivateAccount a, PrivateAccount? refreshed) async {
    final info = await userInfo(a);
    final g = await grades(a);
    final e = await exams(a);
    final ab = await absences(a);
    final ag = await agenda(a);
    return SchulwarePrivateData(
      userInfo: info,
      grades: g,
      exams: e,
      absences: ab,
      agenda: ag,
      refreshedAccount: refreshed,
    );
  }

  /// Runs a passwordless refresh and returns an account carrying the new token
  /// and rotated context_state, or null if it isn't possible / failed.
  Future<PrivateAccount?> _refreshAccount(PrivateAccount a) async {
    if (a.contextState == null || a.userAgent == null) return null;
    final r = await refresh(
      schulnetzBaseUrl: a.baseUrl,
      userAgent: a.userAgent!,
      contextState: a.contextState!,
    );
    if (!r.success || r.accessToken == null) return null;
    return PrivateAccount(
      systemKey: a.systemKey,
      loginMethod: a.loginMethod,
      baseUrl: a.baseUrl,
      displayName: a.displayName,
      accessToken: r.accessToken,
      refreshToken: r.refreshToken ?? a.refreshToken,
      contextState: r.contextState ?? a.contextState,
      userAgent: a.userAgent,
    );
  }

  Future<List<T>> _list<T>(
    String path,
    PrivateAccount a,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final res = await _dio.get<List<dynamic>>('$_base$path',
        options: Options(headers: _headers(a)));
    return (res.data ?? const [])
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, String> _headers(PrivateAccount a) => {
        'X-Schulware-Token': a.accessToken ?? '',
        'X-Schulnetz-Base-Url': a.baseUrl,
      };
}

/// Everything the private dashboard pulls in one pass. [refreshedAccount] is
/// non-null when the token was refreshed mid-fetch and should be persisted.
class SchulwarePrivateData {
  final PrivateUserInfo? userInfo;
  final List<PrivateGrade> grades;
  final List<PrivateExam> exams;
  final List<PrivateAbsence> absences;
  final List<PrivateAgendaEvent> agenda;
  final PrivateAccount? refreshedAccount;
  const SchulwarePrivateData({
    required this.userInfo,
    required this.grades,
    required this.exams,
    required this.absences,
    required this.agenda,
    this.refreshedAccount,
  });
}
