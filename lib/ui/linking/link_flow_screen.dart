import 'dart:async';

import 'package:flutter/material.dart' show MaterialPageRoute, SelectableText;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/linked_accounts_controller.dart';
import '../../services/linking_service.dart';
import 'capture_browser_screen.dart';
import 'link_step_view.dart';

/// What a finished link flow reports back.
class LinkResult {
  final String providerId;
  final String accountId;
  final String? title;
  const LinkResult({required this.providerId, required this.accountId, this.title});
}

/// Runs one provider's link flow by rendering whatever steps the server sends. Nothing here knows
/// a provider by name: forms, codes, redirects and "link another provider first" options all come
/// from the step. Pops a [LinkResult] once the flow is done, or null if the person backed out.
class LinkFlowScreen extends StatefulWidget {
  final String providerId;
  final String? flowId;
  final String? reauthAccountId;
  final String? title;
  final LinkedAccountsController controller;

  LinkFlowScreen({required this.providerId, this.flowId, this.reauthAccountId, this.title, LinkedAccountsController? controller, super.key}) : controller = controller ?? LinkedAccountsController.instance;

  /// Pushes the flow and resolves with its result.
  static Future<LinkResult?> open(BuildContext context, {required String providerId, String? flowId, String? reauthAccountId, String? title, LinkedAccountsController? controller}) {
    return Navigator.of(context).push<LinkResult>(MaterialPageRoute(builder: (_) => LinkFlowScreen(providerId: providerId, flowId: flowId, reauthAccountId: reauthAccountId, title: title, controller: controller)));
  }

  @override
  State<LinkFlowScreen> createState() => _LinkFlowScreenState();
}

class _LinkFlowScreenState extends State<LinkFlowScreen> {
  LinkingApi get _api => widget.controller.api;

  LinkSession? _session;
  bool _busy = true;
  String? _error;
  Timer? _poll;
  bool _finished = false;
  bool _launchedRedirect = false;

  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  @override
  void dispose() {
    _poll?.cancel();
    final s = _session;
    // Leaving mid-flow ends the server session; a finished one is already gone.
    if (s != null && !_finished && s.status == LinkSessionStatus.active) unawaited(_api.cancel(s.sessionId).catchError((_) {}));
    super.dispose();
  }

  Future<void> _start() async {
    try {
      final s = await _api.start(widget.providerId, flowId: widget.flowId, reauthAccountId: widget.reauthAccountId);
      await _apply(s);
    } on LinkingException catch (e) {
      _fail(e.message);
    } catch (e) {
      _fail(e.toString());
    }
  }

  void _fail(String message) {
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = message;
    });
  }

  Future<void> _apply(LinkSession s) async {
    if (!mounted) return;
    _poll?.cancel();
    if (s.status == LinkSessionStatus.done || s.step.kind == LinkStepKind.done) {
      await _finish(s);
      return;
    }
    setState(() {
      _session = s;
      _busy = false;
      _error = null;
    });
    if (s.step.kind == LinkStepKind.pushCode || s.step.kind == LinkStepKind.deviceCode) {
      final seconds = s.step.pollIntervalSeconds < 1 ? 1 : s.step.pollIntervalSeconds;
      _poll = Timer.periodic(Duration(seconds: seconds), (_) => _pollOnce(s.sessionId));
    } else if (s.step.kind == LinkStepKind.redirect && (s.step.redirect?.capture ?? false) && !_launchedRedirect) {
      _launchedRedirect = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _openRedirect());
    }
    if (s.status == LinkSessionStatus.failed || s.status == LinkSessionStatus.expired) {
      // The step carries the reason; nothing more can be submitted.
    }
  }

  bool _polling = false;

  Future<void> _pollOnce(String sessionId) async {
    if (_polling || !mounted) return;
    _polling = true;
    try {
      final s = await _api.poll(sessionId);
      if (s.step.id != _session?.step.id || s.status != LinkSessionStatus.active || s.step.error != null) await _apply(s);
    } on LinkingException catch (e) {
      _fail(e.message);
      _poll?.cancel();
    } catch (_) {
    } finally {
      _polling = false;
    }
  }

  Future<void> _finish(LinkSession s) async {
    final accountId = s.step.doneAccountId ?? '';
    _finished = true;
    _poll?.cancel();
    try {
      // Every list, picker and capability section reloads here so the account shows the first time.
      await widget.controller.linked(s.providerId, accountId);
    } catch (_) {
      // The link itself succeeded; a failed reload is picked up by the next load, never shown as a failed link.
    }
    if (mounted) Navigator.of(context).pop(LinkResult(providerId: s.providerId, accountId: accountId, title: s.step.doneTitle));
  }

  Future<void> _submit(Map<String, String> values, {String? action}) async {
    final s = _session;
    if (s == null || _busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await _apply(await _api.submit(s.sessionId, s.step.id, values, action: action));
    } on LinkingException catch (e) {
      _fail(e.message);
    } catch (e) {
      _fail(e.toString());
    }
  }

  Future<void> _pick(LinkOption option) async {
    final nested = option.linkProviderId;
    if (nested == null) return _submit({'value': option.value});
    // Link the other provider first, then ask this step to list its accounts again.
    final result = await LinkFlowScreen.open(context, providerId: nested, controller: widget.controller);
    if (result == null || !mounted) return;
    await _submit(const {}, action: 'refresh');
  }

  Future<void> _openRedirect() async {
    final s = _session;
    final redirect = s?.step.redirect;
    if (s == null || redirect == null || !mounted) return;
    if (redirect.capture) {
      final result = await Navigator.of(context).push<CaptureResult>(MaterialPageRoute(
        builder: (_) => CaptureBrowserScreen(url: redirect.url, callbackPrefix: redirect.callbackPrefix, cookieDomains: redirect.captureCookieDomains, title: s.step.title ?? widget.title ?? 'Sign in'),
      ));
      if (result == null || !mounted) return;
      await _submit(result.values);
      return;
    }
    final uri = Uri.tryParse(redirect.url);
    if (uri == null || !uri.isScheme('https')) {
      _fail('This sign-in link is not secure and was not opened.');
      return;
    }
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) _fail("Couldn't open the sign-in page.");
  }

  void _close() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final s = _session;
    final step = s?.step;
    final title = step?.title ?? widget.title ?? 'Link account';
    return FScaffold(
      header: FHeader.nested(title: Text(title), prefixes: [FHeaderAction.back(onPress: _close)]),
      child: s == null
          ? (_error != null
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, spacing: 16, children: [
                  SelectableText(_error!, textAlign: TextAlign.center, style: TextStyle(color: context.theme.colors.destructive)),
                  FButton(onPress: _close, child: const Text('Close')),
                ]))
              : const Center(child: FCircularProgress()))
          : LinkStepView(
              step: step!,
              busy: _busy,
              error: _error,
              onSubmit: (values) => _submit(values),
              onAction: (id) => _submit(const {}, action: id),
              onPickOption: _pick,
              onOpenRedirect: _openRedirect,
              onClose: _close,
            ),
    );
  }
}
