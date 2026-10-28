import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../services/backend_dio.dart';

/// A finished browser sign-in: the callback URL the school redirected to, and the context to send with it.
class BrowserSignInResult {
  final String callbackUrl;
  final String context;
  final String? completePath;
  const BrowserSignInResult({required this.callbackUrl, required this.context, this.completePath});

  Map<String, String> get fields => {'browserCallbackUrl': callbackUrl, 'browserContext': context};
}

/// Starts a browser sign-in at [path] for [baseUrl], lets the student sign in on the school's own pages,
/// and returns what the server needs to finish it, or null if they backed out.
Future<BrowserSignInResult?> signInThroughBrowser(BuildContext context, String path, String baseUrl) async {
  final res = await backendDio().post<Map<String, dynamic>>(path, data: {'baseUrl': baseUrl});
  final start = res.data ?? const {};
  if (!context.mounted) return null;
  final callbackUrl = await Navigator.of(context).push<String>(MaterialPageRoute(
    builder: (_) => BrowserSignInScreen(authUrl: start['authUrl'] as String, callbackUrl: start['callbackUrl'] as String, state: start['state'] as String),
  ));
  if (callbackUrl == null) return null;
  return BrowserSignInResult(callbackUrl: callbackUrl, context: start['context'] as String, completePath: start['completePath'] as String?);
}

/// The school's sign-in page in a WebView. Pops the callback URL once the school redirects there with our state.
class BrowserSignInScreen extends StatefulWidget {
  const BrowserSignInScreen({required this.authUrl, required this.callbackUrl, required this.state, super.key});

  final String authUrl;
  final String callbackUrl;
  final String state;

  @override
  State<BrowserSignInScreen> createState() => _BrowserSignInScreenState();
}

class _BrowserSignInScreenState extends State<BrowserSignInScreen> {
  late final WebViewController _controller;
  bool _loading = true;
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
          if (!_isCallback(request.url)) return NavigationDecision.navigate;
          _close(request.url);
          return NavigationDecision.prevent;
        },
      ))
      ..loadRequest(Uri.parse(widget.authUrl));
  }

  bool _isCallback(String url) => url.startsWith(widget.callbackUrl) && Uri.tryParse(url)?.queryParameters['state'] == widget.state;

  void _close(String? url) {
    if (_closed || !mounted) return;
    _closed = true;
    Navigator.of(context).pop(url);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _closed = true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign in at your school'),
          leading: IconButton(icon: const Icon(Icons.close), onPressed: () => _close(null)),
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
