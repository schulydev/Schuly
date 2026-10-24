import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// The authorization code (or an error) parsed from a redirect the WebView hit.
class MicrosoftRedirect {
  final String? code;
  final String? error;
  const MicrosoftRedirect({this.code, this.error});
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

/// Shows Microsoft's real sign-in page in a WebView and pops the captured authorization code
/// (or null if the student backs out / sign-in fails). The student does the whole sign-in,
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
          _finish(redirect.code);
          return NavigationDecision.prevent;
        },
      ))
      ..loadRequest(Uri.parse(widget.authorizeUrl));
  }

  void _finish(String? code) {
    if (_done) return;
    _done = true;
    if (mounted) Navigator.of(context).pop(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in with Microsoft'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => _finish(null)),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
