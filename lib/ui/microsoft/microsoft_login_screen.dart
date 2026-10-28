import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_cookie_manager_plus/webview_cookie_manager_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// The authorization code (or an error) parsed from a redirect the WebView hit,
/// plus the Microsoft sign-in session cookies the WebView holds at that moment.
class MicrosoftRedirect {
  final String? code;
  final String? error;
  final List<Map<String, String>> sessionCookies;
  const MicrosoftRedirect({this.code, this.error, this.sessionCookies = const []});
}

/// If [url] is the sign-in redirect, the code/error it carries; otherwise null (keep navigating).
/// The WebView watches for the Microsoft redirect (`.../oauth2/nativeclient?code=...`) and we read
/// the code straight out of the URL — the same capture pattern as the Schulnetz local-mode login.
MicrosoftRedirect? microsoftRedirect(String url, String redirectUri) {
  if (!url.startsWith(redirectUri)) return null;
  final q = Uri.tryParse(url)?.queryParameters ?? const {};
  if (q['code'] == null && q['error'] == null) return null;
  return MicrosoftRedirect(code: q['code'], error: q['error_description'] ?? q['error']);
}

/// Microsoft's sign-in hosts whose cookies make up the session Schulnetz can sign in with.
const microsoftSignInHosts = ['login.microsoftonline.com', 'login.microsoft.com', 'login.live.com'];

/// Shows Microsoft's real sign-in page in a WebView, starting without any earlier Microsoft
/// session so every link is a fresh sign-in for one account, and pops the redirect it captured
/// (or null if the student backs out). The student does the whole sign-in,
/// including any 2FA, on Microsoft's own page — no password passes through Schuly.
class MicrosoftLoginScreen extends StatefulWidget {
  const MicrosoftLoginScreen({required this.authorizeUrl, required this.redirectUri, super.key});

  final String authorizeUrl;
  final String redirectUri;

  @override
  State<MicrosoftLoginScreen> createState() => _MicrosoftLoginScreenState();
}

class _MicrosoftLoginScreenState extends State<MicrosoftLoginScreen> {
  late final WebViewController _controller;
  bool _loading = true;
  bool _done = false;
  bool _closed = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) { if (mounted) setState(() => _loading = true); },
        onPageFinished: (_) { if (mounted) setState(() => _loading = false); },
        onNavigationRequest: (request) {
          final redirect = microsoftRedirect(request.url, widget.redirectUri);
          if (redirect == null) return NavigationDecision.navigate;
          _finish(redirect);
          return NavigationDecision.prevent;
        },
      ));
    _start();
  }

  Future<void> _start() async {
    for (final host in microsoftSignInHosts) {
      try {
        await WebviewCookieManager().removeCookie('https://$host/').timeout(const Duration(seconds: 3));
      } catch (_) {}
    }
    if (mounted) await _controller.loadRequest(Uri.parse(widget.authorizeUrl));
  }

  Future<void> _finish(MicrosoftRedirect redirect) async {
    if (_done) return;
    _done = true;
    final result = redirect.code == null ? redirect : MicrosoftRedirect(code: redirect.code, error: redirect.error, sessionCookies: await _sessionCookies());
    _close(result);
  }

  void _cancel() {
    _done = true;
    _close(null);
  }

  void _close(MicrosoftRedirect? result) {
    if (_closed || !mounted) return;
    _closed = true;
    Navigator.of(context).pop(result);
  }

  Future<List<Map<String, String>>> _sessionCookies() async {
    // WKWebView's cookie store can trail the page by a moment.
    if (Platform.isIOS) await Future<void>.delayed(const Duration(milliseconds: 500));
    final cookies = <Map<String, String>>[];
    for (final host in microsoftSignInHosts) {
      try {
        final found = await WebviewCookieManager().getCookies('https://$host/').timeout(const Duration(seconds: 3));
        for (final c in found) {
          cookies.add({'domain': host, 'name': c.name, 'path': c.path ?? '/', 'value': c.value});
        }
      } catch (_) {}
    }
    return cookies;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _done = _closed = true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign in with Microsoft'),
          leading: IconButton(icon: const Icon(Icons.close), onPressed: _cancel),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loading) const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
