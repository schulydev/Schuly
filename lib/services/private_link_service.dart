import 'dart:convert';

import 'package:dio/dio.dart';

import 'backend_dio.dart';
import 'private_linked_account_store.dart';

/// Where the capture browser sends the person; private mode also keeps the PKCE verifier on the device.
class PrivateLinkStart {
  final String authorizeUrl;
  final String redirectUri;
  final String? codeVerifier;
  const PrivateLinkStart({required this.authorizeUrl, required this.redirectUri, this.codeVerifier});
}

/// Sign-in hosts whose cookies make up the session a private-mode school can sign in with. The
/// anonymous stateless endpoints do not declare them, so they live here.
const privateCaptureCookieHosts = ['login.microsoftonline.com', 'login.microsoft.com', 'login.live.com'];

/// If [url] is the sign-in redirect, the code/error it carries; otherwise null (keep navigating).
({String? code, String? error})? privateLinkRedirect(String url, String redirectUri) {
  if (!url.startsWith(redirectUri)) return null;
  final q = Uri.tryParse(url)?.queryParameters ?? const {};
  if (q['code'] == null && q['error'] == null) return null;
  return (code: q['code'], error: q['error_description'] ?? q['error']);
}

/// Private mode's linked accounts (an account the school signs in with): the provider is named by
/// the school's login-method answer, the session stays on this device. Account mode never uses
/// this; it goes through the generic `/api/linking` flow.
class PrivateLinkService {
  PrivateLinkService._();
  static final PrivateLinkService instance = PrivateLinkService._();

  final Dio _dio = backendDio(connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 60));

  static String _base(String provider) => '/api/plugins/$provider/stateless/link';

  Future<PrivateLinkStart> start(String provider) async {
    final res = await _dio.post<Map<String, dynamic>>('${_base(provider)}/start');
    final data = res.data ?? const {};
    return PrivateLinkStart(authorizeUrl: data['authorizeUrl'] as String, redirectUri: data['redirectUri'] as String, codeVerifier: data['codeVerifier'] as String?);
  }

  /// Finishes the link with the code and session the browser captured; throws with the server's
  /// message when it did not complete.
  Future<PrivateLinkedAccount> complete(String provider, PrivateLinkStart start, String code, List<Map<String, String>> sessionCookies) async {
    final res = await _dio.post<Map<String, dynamic>>('${_base(provider)}/complete', data: {'code': code, 'codeVerifier': start.codeVerifier});
    final data = res.data ?? const {};
    if (data['status'] != 'complete') throw StateError(data['message'] as String? ?? 'Sign-in failed');
    if (sessionCookies.isEmpty) throw StateError('The sign-in session could not be captured. Try again.');
    final link = PrivateLinkedAccount(email: data['email'] as String? ?? '', displayName: data['displayName'] as String?, sessionCookies: jsonEncode(sessionCookies));
    await PrivateLinkedAccountStore.instance.save(link);
    return link;
  }

  Future<List<PrivateLinkedAccount>> accounts() => PrivateLinkedAccountStore.instance.list();

  Future<void> unlink(String id) => PrivateLinkedAccountStore.instance.remove(id);
}
