import 'package:dio/dio.dart';

import '../config/oidc_config.dart';
import '../domain/school_system.dart';

/// Fetches the backend-served catalog of school systems (anonymous endpoint).
/// The backend is the **sole** source of truth for which systems exist and how
/// to log in - the app hardcodes nothing and renders the picker + login forms
/// entirely from this list.
///
/// Uses a clean [Dio] with no OIDC interceptor: private (secure) mode relies on
/// this catalog and must never touch the authenticated Schuly stack. Throws if
/// the catalog can't be reached; callers surface that to the user.
class SchoolSystemsService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: OidcConfig.backendBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));

  static Future<List<SchoolSystem>> fetch() async {
    final response = await _dio.get<List<dynamic>>('/api/app/school-systems');
    final data = response.data ?? const [];
    return data
        .map((e) => SchoolSystem.fromJson(e as Map<String, dynamic>))
        .where((s) => s.enabled)
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }
}
