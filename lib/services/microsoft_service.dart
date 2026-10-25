import 'dart:convert';

import 'package:dio/dio.dart';

import 'app_mode_service.dart';
import 'auth_service.dart';
import 'backend_dio.dart';
import 'private_microsoft_store.dart';

/// Where the WebView sends the student; private mode also keeps the PKCE verifier on the device.
class MicrosoftLinkStart {
  final String authorizeUrl;
  final String redirectUri;
  final String? codeVerifier;
  const MicrosoftLinkStart({required this.authorizeUrl, required this.redirectUri, this.codeVerifier});
}

/// A Microsoft account linked in Settings: a Schuly linked account (account mode) or one kept on
/// the device (private mode).
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

/// Links Microsoft accounts and reads their Microsoft 365 data. Account mode goes through the
/// Microsoft plugin and the backend's linked accounts; private mode uses the plugin's anonymous
/// endpoints and keeps the Microsoft session on the device.
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
  static bool get _private => AppModeService.instance.isPrivate;

  Future<MicrosoftLinkStart> startLink() async {
    final res = await _dio.post<Map<String, dynamic>>(_private ? '$_base/stateless/link/start' : '$_base/link/start');
    final data = res.data ?? const {};
    return MicrosoftLinkStart(authorizeUrl: data['authorizeUrl'] as String, redirectUri: data['redirectUri'] as String, codeVerifier: data['codeVerifier'] as String?);
  }

  /// Finishes the link with the code and Microsoft session the WebView captured. Returns the account, or null on failure.
  Future<MicrosoftAccount?> completeLink(MicrosoftLinkStart start, String code, List<Map<String, String>> sessionCookies) async {
    if (!_private) {
      final res = await _dio.post<Map<String, dynamic>>('$_base/link/complete', data: {'code': code, 'sessionCookies': sessionCookies});
      final data = res.data ?? const {};
      if (data['status'] != 'complete') return null;
      return MicrosoftAccount(id: data['accountId'] as String, email: data['email'] as String? ?? '', displayName: data['displayName'] as String?);
    }

    final res = await _dio.post<Map<String, dynamic>>('$_base/stateless/link/complete', data: {'code': code, 'codeVerifier': start.codeVerifier});
    final data = res.data ?? const {};
    if (data['status'] != 'complete' || sessionCookies.isEmpty) return null;
    final link = PrivateMicrosoftLink(email: data['email'] as String? ?? '', displayName: data['displayName'] as String?, sessionCookies: jsonEncode(sessionCookies));
    await PrivateMicrosoftStore.instance.save(link);
    return MicrosoftAccount(id: link.id, email: link.email, displayName: link.displayName);
  }

  Future<List<MicrosoftAccount>> accounts() async {
    if (_private) {
      return [for (final l in await PrivateMicrosoftStore.instance.list()) MicrosoftAccount(id: l.id, email: l.email, displayName: l.displayName)];
    }
    final res = await _dio.get<List<dynamic>>('/api/me/linked-accounts', queryParameters: {'provider': 'microsoft'});
    return (res.data ?? const []).map((e) => MicrosoftAccount.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> unlink(String accountId) async {
    if (_private) return PrivateMicrosoftStore.instance.remove(accountId);
    await _dio.delete('/api/me/linked-accounts/$accountId');
  }

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
