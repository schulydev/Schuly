import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Result of the Schulnetz OAuth WebView flow. Carries the mobile `code` (for
/// the Mobile token exchange) plus a Playwright-format `storage_state` blob and
/// the WebView's UA — and, additionally, the **PHP web session** read straight
/// off the cookie jar after the school's web login (PHPSESSID + the id/transid
/// URL params from a dashboard nav link). This is the approach the working
/// test-app uses. The web fields are nullable: if capture fails the login still
/// succeeds (the scraper pages just stay off).
class SchulnetzOAuthResult {
  final String code;
  final String? state;
  final String contextState;
  final String userAgent;
  final String? webSessionId;
  final String? webSessionUserId;
  final String? webSessionTransId;
  SchulnetzOAuthResult({
    required this.code,
    required this.state,
    required this.contextState,
    required this.userAgent,
    this.webSessionId,
    this.webSessionUserId,
    this.webSessionTransId,
  });
}

enum _Phase { mobileLogin, webSession, done }

class SchulnetzOAuthScreen extends StatefulWidget {
  final String authorizationUrl;

  /// School root (e.g. https://schulnetz.bbbaden.ch). After the mobile code is
  /// captured we navigate here to drive the school's *web* login and read the
  /// resulting PHP session off the cookie jar.
  final String schulnetzBaseUrl;
  const SchulnetzOAuthScreen({
    super.key,
    required this.authorizationUrl,
    required this.schulnetzBaseUrl,
  });

  @override
  State<SchulnetzOAuthScreen> createState() => _SchulnetzOAuthScreenState();
}

class _SchulnetzOAuthScreenState extends State<SchulnetzOAuthScreen> {
  final Map<String, List<Map<String, String>>> _capturedLocalStorage = {};

  _Phase _phase = _Phase.mobileLogin;
  Timer? _webTimeout;

  String? _code;
  String? _state;
  String? _contextState;

  static const _webWait = Duration(seconds: 25);

  static const _userAgent =
      'Mozilla/5.0 (Linux; Android 14; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36';

  static const _originsToProbe = <String>[
    'https://schulnetz.bbbaden.ch',
    'https://schulnetz.web.app',
    'https://login.microsoftonline.com',
    'https://login.microsoft.com',
    'https://login.live.com',
    'https://login.windows.net',
    'https://account.live.com',
    'https://account.microsoft.com',
    'https://aadcdn.msauth.net',
    'https://aadcdn.msftauth.net',
    'https://device.login.microsoftonline.com',
  ];

  String get _schulnetzHost => WebUri(widget.schulnetzBaseUrl).host;

  @override
  void dispose() {
    _webTimeout?.cancel();
    super.dispose();
  }

  Future<NavigationActionPolicy> _shouldOverride(
      InAppWebViewController c, NavigationAction action) async {
    final uri = action.request.url;
    if (_phase == _Phase.done) return NavigationActionPolicy.CANCEL;
    if (uri == null) return NavigationActionPolicy.ALLOW;

    // Mobile flow — the final mobile code is issued at schulnetz.web.app/callback.
    if (_phase == _Phase.mobileLogin &&
        uri.host == 'schulnetz.web.app' &&
        uri.path == '/callback' &&
        uri.queryParameters['code'] != null) {
      _code = uri.queryParameters['code'];
      _state = uri.queryParameters['state'];
      _contextState = await _buildContextState();

      // Drop any stale Schulnetz cookie so the school mints a FRESH PHP session
      // (a stale PHPSESSID is what made earlier captures unauthenticated), then
      // drive the school web login in the same authenticated WebView.
      try {
        await CookieManager.instance()
            .deleteCookies(url: WebUri(widget.schulnetzBaseUrl));
      } catch (_) {}

      _phase = _Phase.webSession;
      _webTimeout = Timer(_webWait, _finishMobileOnly);
      await c.loadUrl(
          urlRequest: URLRequest(url: WebUri('${widget.schulnetzBaseUrl}/')));
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  Future<void> _onPageFinished(InAppWebViewController c, WebUri? url) async {
    if (url == null) return;
    final scheme = url.scheme;
    final host = url.host;
    if (scheme.isEmpty || host.isEmpty) return;

    // During the web phase, every time a Schulnetz-host page settles, try to
    // read the authenticated PHP session off the dashboard (test-app approach).
    if (_phase == _Phase.webSession && host == _schulnetzHost) {
      await _tryCaptureWebSession(c);
    }

    final origin = '$scheme://$host';
    try {
      final raw = await c.evaluateJavascript(source: '''
        (function(){var o=[];try{for(var i=0;i<localStorage.length;i++){var k=localStorage.key(i);o.push({name:k,value:localStorage.getItem(k)});}}catch(e){}return JSON.stringify(o);})()
      ''');
      if (raw is String && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is List && decoded.isNotEmpty) {
          _capturedLocalStorage[origin] = decoded
              .whereType<Map>()
              .map((e) => {
                    'name': e['name']?.toString() ?? '',
                    'value': e['value']?.toString() ?? '',
                  })
              .toList();
        }
      }
    } catch (_) {}
  }

  /// Read PHPSESSID from the cookie jar and id/transid from a dashboard nav
  /// link. All three must be present (only the authenticated dashboard has the
  /// pageid links); otherwise wait for the next page.
  Future<void> _tryCaptureWebSession(InAppWebViewController c) async {
    if (_phase != _Phase.webSession) return;

    final cookies = await CookieManager.instance()
        .getCookies(url: WebUri(widget.schulnetzBaseUrl));
    String? sessionId;
    for (final cookie in cookies) {
      if (cookie.name == 'PHPSESSID') {
        sessionId = cookie.value.toString();
        break;
      }
    }
    if (sessionId == null || sessionId.isEmpty) return;

    final raw = await c.evaluateJavascript(source: r'''
      (function(){
        var a = document.querySelector('a[href*="pageid"]');
        if (!a) return JSON.stringify(null);
        var href = a.getAttribute('href') || '';
        var id = (href.match(/[?&]id=([a-f0-9]+)/) || [])[1];
        var transid = (href.match(/[?&]transid=([a-f0-9]+)/) || [])[1];
        return JSON.stringify({id: id || null, transid: transid || null});
      })()
    ''');

    String? id, transid;
    if (raw is String && raw.isNotEmpty && raw != 'null') {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) {
          id = decoded['id']?.toString();
          transid = decoded['transid']?.toString();
        }
      } catch (_) {}
    }
    if (id == null || id.isEmpty || transid == null || transid.isEmpty) return;

    _finish(webSessionId: sessionId, webSessionUserId: id, webSessionTransId: transid);
  }

  void _finishMobileOnly() => _finish();

  void _finish({
    String? webSessionId,
    String? webSessionUserId,
    String? webSessionTransId,
  }) {
    if (_phase == _Phase.done || _code == null || _contextState == null) return;
    _phase = _Phase.done;
    _webTimeout?.cancel();
    if (!mounted) return;
    Navigator.of(context).pop(SchulnetzOAuthResult(
      code: _code!,
      state: _state,
      contextState: _contextState!,
      userAgent: _userAgent,
      webSessionId: webSessionId,
      webSessionUserId: webSessionUserId,
      webSessionTransId: webSessionTransId,
    ));
  }

  Future<String> _buildContextState() async {
    final cm = CookieManager.instance();
    final cookies = <Map<String, String>>[];
    final seen = <String>{};

    final origins =
        {..._originsToProbe, ..._capturedLocalStorage.keys}.toList();

    for (final origin in origins) {
      final uri = WebUri(origin);
      final host = uri.host;
      if (host.isEmpty) continue;
      final cookieDomain = host.startsWith('.') ? host : '.$host';
      final list = await cm.getCookies(url: uri);
      for (final cookie in list) {
        final name = cookie.name;
        final value = cookie.value.toString();
        if (name.isEmpty) continue;
        final dedupeKey = '$cookieDomain|$name|$value';
        if (!seen.add(dedupeKey)) continue;
        cookies.add({
          'name': name,
          'value': value,
          'domain': cookieDomain,
          'path': '/',
        });
      }
    }

    final originsArr = <Map<String, Object>>[];
    _capturedLocalStorage.forEach((origin, ls) {
      originsArr.add({'origin': origin, 'localStorage': ls});
    });

    return jsonEncode({'cookies': cookies, 'origins': originsArr});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schulnetz Login')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.authorizationUrl)),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          useShouldOverrideUrlLoading: true,
          domStorageEnabled: true,
          databaseEnabled: true,
          thirdPartyCookiesEnabled: true,
          cacheEnabled: false,
          clearCache: true,
          userAgent: _userAgent,
        ),
        shouldOverrideUrlLoading: _shouldOverride,
        onLoadStop: _onPageFinished,
      ),
    );
  }
}
