import 'package:dio/dio.dart';

import '../config/backend_config.dart';
import '../config/oidc_config.dart';
import '../domain/private_data.dart';
import 'private_account_store.dart';

/// Bundle returned by the stateless scrape proxy in one pass.
class ScrapeData {
  final PrivateUserInfo? userInfo;
  final List<PrivateGrade> grades;
  final List<PrivateExam> exams;
  final List<PrivateAgendaEvent> agenda;
  const ScrapeData({
    this.userInfo,
    this.grades = const [],
    this.exams = const [],
    this.agenda = const [],
  });
}

/// Client for the backend's stateless **scrape-strategy** proxy used in private
/// mode. One anonymous call scrapes with the caller's credentials and returns
/// the data; nothing is stored server-side. The system's stateless route comes
/// from the catalog.
class ScrapeProxyClient {
  ScrapeProxyClient._();
  static final ScrapeProxyClient instance = ScrapeProxyClient._();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: OidcConfig.backendBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 90),
  ));

  /// Re-point at the current [BackendConfig.url] after a runtime server change.
  void applyBaseUrl() => _dio.options.baseUrl = BackendConfig.url;

  Future<ScrapeData> data(PrivateAccount account) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '${account.statelessBasePath}/data',
      data: {
        'baseUrl': account.baseUrl,
        'username': account.username,
        'password': account.password,
      },
    );
    final m = res.data ?? const {};
    return ScrapeData(
      userInfo: m['userInfo'] == null
          ? null
          : PrivateUserInfo.fromJson(m['userInfo'] as Map<String, dynamic>),
      grades: (m['grades'] as List<dynamic>? ?? const [])
          .map((e) => PrivateGrade.fromJson(e as Map<String, dynamic>))
          .toList(),
      exams: (m['exams'] as List<dynamic>? ?? const [])
          .map((e) => PrivateExam.fromJson(e as Map<String, dynamic>))
          .toList(),
      agenda: (m['agenda'] as List<dynamic>? ?? const [])
          .map((e) => PrivateAgendaEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
