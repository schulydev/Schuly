import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:webview_cookie_manager_plus/webview_cookie_manager_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// What a capture redirect hands back: the callback URL that was intercepted and the cookies the
/// browser held for the requested domains, ready to submit as the step's values.
class CaptureResult {
  final String callbackUrl;
  final List<Map<String, String>> cookies;
  const CaptureResult({required this.callbackUrl, this.cookies = const []});

  Map<String, String> get values => {'callbackUrl': callbackUrl, if (cookies.isNotEmpty) 'cookies': jsonEncode(cookies)};
}

/// True when [url] is the navigation the step asked to intercept.
bool isCaptureCallback(String url, String? callbackPrefix) => callbackPrefix != null && callbackPrefix.isNotEmpty && url.startsWith(callbackPrefix);

/// Opens [url] in an embedded browser, starting without any earlier session so every link is a fresh
/// sign-in, and intercepts the first navigation starting with [callbackPrefix]. The person signs in
/// on the provider's own page, so no password passes through Schuly. Pops a [CaptureResult], or null
/// if they back out.
class CaptureBrowserScreen extends StatefulWidget {
  const CaptureBrowserScreen({required this.url, required this.callbackPrefix, this.cookieDomains = const [], this.title = 'Sign in', super.key});

  final String url;
  final String? callbackPrefix;
  final List<String> cookieDomains;
  final String title;

  @override
  State<CaptureBrowserScreen> createState() => _CaptureBrowserScreenState();
}

class _CaptureBrowserScreenState extends State<CaptureBrowserScreen> {
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
        onPageStarted: (_) {
          if (mounted) setState(() => _loading = true);
        },
        onPageFinished: (_) {
          if (mounted) setState(() => _loading = false);
        },
        onNavigationRequest: (request) {
          if (!isCaptureCallback(request.url, widget.callbackPrefix)) return NavigationDecision.navigate;
          _finish(request.url);
          return NavigationDecision.prevent;
        },
      ));
    _start();
  }

  Future<void> _start() async {
    try {
      await WebViewCookieManager().clearCookies().timeout(const Duration(seconds: 3));
    } catch (_) {}
    if (mounted) await _controller.loadRequest(Uri.parse(widget.url));
  }

  Future<void> _finish(String callbackUrl) async {
    if (_done) return;
    _done = true;
    final cookies = await _cookies();
    _close(CaptureResult(callbackUrl: callbackUrl, cookies: cookies));
  }

  Future<List<Map<String, String>>> _cookies() async {
    if (widget.cookieDomains.isEmpty) return const [];
    // WKWebView's cookie store can trail the page by a moment.
    if (Platform.isIOS) await Future<void>.delayed(const Duration(milliseconds: 500));
    final cookies = <Map<String, String>>[];
    for (final raw in widget.cookieDomains) {
      final host = raw.trim().replaceFirst(RegExp(r'^\.'), '');
      try {
        final found = await WebviewCookieManager().getCookies('https://$host/').timeout(const Duration(seconds: 3));
        for (final c in found) {
          cookies.add({'domain': host, 'name': c.name, 'path': c.path ?? '/', 'value': c.value});
        }
      } catch (_) {}
    }
    return cookies;
  }

  void _close(CaptureResult? result) {
    if (_closed || !mounted) return;
    _closed = true;
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _done = _closed = true;
      },
      child: FScaffold(
        header: FHeader.nested(
          title: Text(widget.title),
          prefixes: [FHeaderAction.back(onPress: () => _close(null))],
        ),
        childPad: false,
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loading) const Positioned(top: 0, left: 0, right: 0, child: FProgress()),
          ],
        ),
      ),
    );
  }
}
