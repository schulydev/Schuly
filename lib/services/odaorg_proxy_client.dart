import 'package:dio/dio.dart';

import '../config/oidc_config.dart';
import '../domain/private_data.dart';
import 'private_account_store.dart';

/// Bundle returned by the stateless OdAOrg proxy in one scrape pass.
class OdaorgData {
  final PrivateUserInfo? userInfo;
  final List<PrivateGrade> grades;
  final List<PrivateExam> exams;
  final List<PrivateAgendaEvent> agenda;
  const OdaorgData({
    this.userInfo,
    this.grades = const [],
    this.exams = const [],
    this.agenda = const [],
  });
}

/// Client for the backend's stateless OdAOrg proxy used in private mode.
/// One anonymous call scrapes with the caller's credentials and returns the
/// data; nothing is stored server-side.
class OdaorgProxyClient {
  OdaorgProxyClient._();
  static final OdaorgProxyClient instance = OdaorgProxyClient._();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: OidcConfig.backendBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 90),
  ));

  Future<OdaorgData> data(PrivateAccount account) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '${account.statelessBasePath}/data',
      data: {
        'baseUrl': account.baseUrl,
        'username': account.username,
        'password': account.password,
      },
    );
    final m = res.data ?? const {};
    return OdaorgData(
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
