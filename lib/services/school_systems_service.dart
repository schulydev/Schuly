import 'package:flutter/foundation.dart';

import '../domain/school_system.dart';
import 'api_client.dart';

/// Fetches the backend-served catalog of school systems (anonymous endpoint).
/// The backend is the source of truth for which systems exist and how to log
/// in; the app renders the picker from this list.
class SchoolSystemsService {
  /// Known systems used when the catalog can't be reached (offline / backend
  /// down), so the add-school flow still works. Mirrors the backend seed.
  static const List<SchoolSystem> fallback = [
    SchoolSystem(
      key: 'schulnetz',
      displayName: 'Schulnetz',
      loginMethod: 'oauth-webview',
      sortOrder: 0,
    ),
    SchoolSystem(
      key: 'odaorg',
      displayName: 'OdAOrg',
      loginMethod: 'credentials',
      sortOrder: 1,
    ),
  ];

  static Future<List<SchoolSystem>> fetch() async {
    try {
      final response =
          await ApiClient.instance.dio.get<List<dynamic>>('/api/app/school-systems');
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
