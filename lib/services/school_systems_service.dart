import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/oidc_config.dart';
import '../domain/school_system.dart';

/// Fetches the backend-served catalog of school systems (anonymous endpoint).
/// The backend is the source of truth for which systems exist and how to log
/// in; the app renders the picker from this list.
///
/// Uses a clean [Dio] with no OIDC interceptor: private (secure) mode relies on
/// this catalog and must never touch the authenticated Schuly stack.
class SchoolSystemsService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: OidcConfig.backendBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));

  /// Known systems used when the catalog can't be reached (offline / backend
  /// down), so the add-school flow still works. Mirrors the backend seed.
  static const List<SchoolSystem> fallback = [
    SchoolSystem(
      key: 'schulnetz',
      displayName: 'Schulnetz',
      loginMethod: 'oauth-webview',
      statelessBasePath: '/api/plugins/schulware/stateless',
      sortOrder: 0,
    ),
    SchoolSystem(
      key: 'odaorg',
      displayName: 'OdAOrg',
      loginMethod: 'credentials',
      statelessBasePath: '/api/plugins/odaorg/stateless',
      sortOrder: 1,
    ),
  ];

  static Future<List<SchoolSystem>> fetch() async {
    try {
      final response =
          await _dio.get<List<dynamic>>('/api/app/school-systems');
      final data = response.data ?? const [];
      final systems = data
          .map((e) => SchoolSystem.fromJson(e as Map<String, dynamic>))
          .where((s) => s.enabled)
          .toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      return systems.isEmpty ? fallback : systems;
    } catch (e) {
      debugPrint('SchoolSystemsService: falling back to bundled systems: $e');
      return fallback;
    }
  }
}
