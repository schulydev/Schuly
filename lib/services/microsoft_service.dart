import 'package:dio/dio.dart';

import 'auth_service.dart';
import 'backend_dio.dart';

/// Where the WebView sends the code and the plugin finishes the link.
class MicrosoftLinkStart {
  final String authorizeUrl;
  final String redirectUri;
  const MicrosoftLinkStart({required this.authorizeUrl, required this.redirectUri});
}

class MicrosoftAccount {
  final String id;
  final String email;
  final String? displayName;
  const MicrosoftAccount({required this.id, required this.email, this.displayName});

  factory MicrosoftAccount.fromJson(Map<String, dynamic> j) => MicrosoftAccount(
        id: j['id'] as String,
        email: j['email'] as String? ?? '',
        displayName: j['displayName'] as String?,
      );
}

/// Calls the Microsoft plugin (`/api/plugins/microsoft/...`). The plugin endpoints aren't in the
/// generated API client, so this uses a plain backend Dio with the current access token attached.
class MicrosoftService {
  MicrosoftService._();
  static final MicrosoftService instance = MicrosoftService._();

  final Dio _dio = backendDio(connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 60))
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await AuthService.getAccessToken();
      if (token != null) options.headers['Authorization'] = 'Bearer $token';
      handler.next(options);
    }));

  static const _base = '/api/plugins/microsoft';

  Future<MicrosoftLinkStart> startLink() async {
    final res = await _dio.post<Map<String, dynamic>>('$_base/link/start');
    final data = res.data ?? const {};
    return MicrosoftLinkStart(authorizeUrl: data['authorizeUrl'] as String, redirectUri: data['redirectUri'] as String);
  }

  /// Finishes the link with the code the WebView captured. Returns the new account, or null on failure.
  Future<MicrosoftAccount?> completeLink(String code) async {
    final res = await _dio.post<Map<String, dynamic>>('$_base/link/complete', data: {'code': code});
    final data = res.data ?? const {};
    if (data['status'] != 'complete') return null;
    return MicrosoftAccount(id: data['accountId'] as String, email: data['email'] as String? ?? '', displayName: data['displayName'] as String?);
  }

  Future<List<MicrosoftAccount>> accounts() async {
    final res = await _dio.get<List<dynamic>>('$_base/accounts');
    return (res.data ?? const []).map((e) => MicrosoftAccount.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> unlink(String accountId) => _dio.delete('$_base/accounts/$accountId');

  Future<List<dynamic>> mail(String accountId, {int top = 25, bool unread = false}) async {
    final res = await _dio.get<List<dynamic>>('$_base/accounts/$accountId/mail', queryParameters: {'top': top, 'unread': unread});
    return res.data ?? const [];
  }

  Future<List<dynamic>> calendar(String accountId, {int top = 25}) async {
    final res = await _dio.get<List<dynamic>>('$_base/accounts/$accountId/calendar', queryParameters: {'top': top});
    return res.data ?? const [];
  }

  Future<List<dynamic>> files(String accountId, {String path = 'root'}) async {
    final res = await _dio.get<List<dynamic>>('$_base/accounts/$accountId/files', queryParameters: {'path': path});
    return res.data ?? const [];
  }
}
