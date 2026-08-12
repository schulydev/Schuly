import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// The backend the app talks to. Defaults to the hosted Schuly Cloud (baked in
/// at build time via `--dart-define=BACKEND_BASE_URL`); a self-hoster can point
/// it at their own instance during onboarding.
///
/// Persisted locally and loaded at startup *before* any HTTP client reads
/// [url], so clients pick it up on first use - no live re-pointing needed. The
/// onboarding server step likewise sets the URL before the first backend call.
class BackendConfig {
  BackendConfig._();

  static const _key = 'backend.url';

  static const hostedUrl = String.fromEnvironment(
    'BACKEND_BASE_URL',
    defaultValue: 'http://localhost:5033',
  );

  static String _url = hostedUrl;

  static String get url => _url;

  static bool get isCustom => _url != hostedUrl;

  static Future<void> load() async {
    final saved = (await SharedPreferences.getInstance()).getString(_key);
    if (saved != null && saved.isNotEmpty) _url = saved;
  }

  static String normalise(String? value) =>
      (value ?? '').trim().replaceAll(RegExp(r'/+$'), '');

  static bool isInsecure(String? value) {
    final uri = Uri.tryParse(normalise(value));
    if (uri == null || uri.scheme != 'http') return false;
    final h = uri.host.toLowerCase();
    return h.isNotEmpty &&
        h != 'localhost' &&
        h != '127.0.0.1' &&
        h != '::1' &&
        !h.endsWith('.localhost');
  }

  static Future<String?> probe(String baseUrl) async {
    final url = normalise(baseUrl);
    if (url.isEmpty) return null;
    try {
      final r = await http
          .get(Uri.parse('$url/api/app'))
          .timeout(const Duration(seconds: 8));
      if (r.statusCode != 200) return null;
      final body = jsonDecode(r.body);
      if (body is! Map<String, dynamic> || body['clientId'] is! String) {
        return null;
      }
      final version = body['version'];
      return version is String && version.isNotEmpty ? version : 'unknown';
    } catch (_) {
      return null;
    }
  }

  static Future<String> setUrl(String? value) async {
    final prefs = await SharedPreferences.getInstance();
    final v = value?.trim().replaceAll(RegExp(r'/+$'), '');
    if (v == null || v.isEmpty || v == hostedUrl) {
      _url = hostedUrl;
      await prefs.remove(_key);
    } else {
      _url = v;
      await prefs.setString(_key, v);
    }
    return _url;
  }
}
