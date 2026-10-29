import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/private_account_store.dart';
import '../../services/private_linked_account_store.dart';
import '../../services/scrape_proxy_client.dart';
import '../../services/token_proxy_client.dart';
import '../../services/api_error.dart';
import '../../services/totp_service.dart';
import '../widgets/browser_sign_in.dart';
import '../widgets/dynamic_login_form.dart';
import '../widgets/linked_account_login.dart';

class PrivateConnectScreen extends StatefulWidget {
  final SchoolSystem system;
  const PrivateConnectScreen({required this.system, super.key});

  @override
  State<PrivateConnectScreen> createState() => _PrivateConnectScreenState();
}

class _PrivateConnectScreenState extends State<PrivateConnectScreen> {
  late final DynamicLoginFormController _form;
  late final LoginMethodController _method;
  late final TextEditingController _nameCtrl;
  String? _linkedAccountId;
  bool _busy = false;
  String? _error;

  SchoolSystem get _system => widget.system;

  @override
  void initState() {
    super.initState();
    _form = DynamicLoginFormController(_system.loginFields);
    _method = LoginMethodController(_system, _system.loginFields.any((f) => f.key == 'baseUrl') ? _form.controllerFor('baseUrl') : null);
    _nameCtrl = TextEditingController(text: _system.displayName);
  }

  @override
  void dispose() {
    _method.dispose();
    _form.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final missing = _form.validateRequired(hidden: _method.hiddenKeys) ?? (_method.usesLinkedAccount && _linkedAccountId == null ? 'Choose an account' : null);
    if (missing != null) {
      setState(() => _error = missing);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final name = _nameCtrl.text.trim().isEmpty
          ? _system.displayName
          : _nameCtrl.text.trim();
      final baseUrl = _form.value('baseUrl');

      final basePath = _system.statelessBasePath;
      if (basePath == null || basePath.isEmpty) {
        setState(() => _error = 'This system is not configured for private mode');
        return;
      }

      if (_method.usesLinkedAccount) {
        await _connectLinked(baseUrl, name, basePath);
      } else if (_method.usesBrowser) {
        await _connectBrowser(baseUrl, name, basePath);
      } else if (_system.privateAuthStrategy == 'token') {
        await _connectToken(baseUrl, name, basePath);
      } else {
        await _connectScrape(baseUrl, name, basePath);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = ApiError.describe(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _connectLinked(String baseUrl, String name, String basePath) async {
    final link = await PrivateLinkedAccountStore.instance.get(_linkedAccountId!);
    if (link == null) {
      setState(() => _error = 'Choose an account');
      return;
    }
    final res = await TokenProxyClient.instance.refresh(basePath: basePath, baseUrl: baseUrl, userAgent: '', contextState: link.sessionCookies);
    if (!res.success || res.accessToken == null) {
      if (!mounted) return;
      setState(() => _error = 'The sign-in of that account has expired. Link it again.');
      return;
    }
    if (res.contextState != null) await PrivateLinkedAccountStore.instance.updateSession(link.id, res.contextState!);
    await PrivateAccountStore.instance.save(PrivateAccount(
      systemKey: _system.key,
      loginMethod: _system.loginMethod,
      baseUrl: baseUrl,
      displayName: name,
      statelessBasePath: basePath,
      accessToken: res.accessToken,
      refreshToken: res.refreshToken,
      contextState: res.contextState,
      linkedAccountId: link.id,
    ));
    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _connectBrowser(String baseUrl, String name, String basePath) async {
    final browser = await signInThroughBrowser(context, _method.browserLoginPath!, baseUrl);
    if (browser == null || browser.completePath == null) return;
    final res = await TokenProxyClient.instance.completeBrowser(completePath: browser.completePath!, baseUrl: baseUrl, sign: browser);
    if (!res.success || res.accessToken == null) {
      if (!mounted) return;
      setState(() => _error = res.message ?? 'Sign-in failed');
      return;
    }
    await PrivateAccountStore.instance.save(PrivateAccount(
      systemKey: _system.key,
      loginMethod: _system.loginMethod,
      baseUrl: baseUrl,
      displayName: name,
      statelessBasePath: basePath,
      accessToken: res.accessToken,
      refreshToken: res.refreshToken,
      contextState: res.contextState,
    ));
    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _connectToken(
      String baseUrl, String name, String basePath) async {
    final email = _form.value('email');
    final password = _form.value('password');
    final totpSecret = TotpService.secretOf(_form.value('totp'));
    final res = await TokenProxyClient.instance.login(
      basePath: basePath,
      baseUrl: baseUrl,
      email: email,
      password: password,
      totpSecret: totpSecret,
    );
    if (!res.success || res.accessToken == null) {
      if (!mounted) return;
      setState(() => _error = res.message ?? 'Login failed');
      return;
    }
    await PrivateAccountStore.instance.save(PrivateAccount(
      systemKey: _system.key,
      loginMethod: _system.loginMethod,
      baseUrl: baseUrl,
      displayName: name,
      statelessBasePath: basePath,
      accessToken: res.accessToken,
      refreshToken: res.refreshToken,
      contextState: res.contextState,
      username: email,
      password: password,
      totpSecret: totpSecret,
    ));
    TextInput.finishAutofillContext();
    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _connectScrape(
      String baseUrl, String name, String basePath) async {
    final account = PrivateAccount(
      systemKey: _system.key,
      loginMethod: _system.loginMethod,
      baseUrl: baseUrl,
      displayName: name,
      statelessBasePath: basePath,
      username: _form.value('username'),
      password: _form.value('password'),
    );
    await ScrapeProxyClient.instance.data(account);
    await PrivateAccountStore.instance.save(account);
    TextInput.finishAutofillContext();
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FScaffold(
      header: FHeader.nested(
        title: Text('Connect ${_system.displayName}'),
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
      ),
      child: ListenableBuilder(
        listenable: _method,
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            const Text(
              'Private mode keeps everything on this device - no account, '
              'nothing stored on a server.',
            ),
            DynamicLoginForm(controller: _form, hidden: _method.hiddenKeys),
            if (_method.usesLinkedAccount)
              PrivateLinkedAccountPicker(
                provider: _method.linkedProvider!,
                selectedId: _linkedAccountId,
                onChanged: (id) => setState(() => _linkedAccountId = id),
              ),
            if (_method.usesBrowser)
              Text('This school uses its own login. You sign in on its page in the next step.', style: context.theme.typography.sm.copyWith(color: colors.mutedForeground)),
            FTextField(
              control: FTextFieldControl.managed(controller: _nameCtrl),
              label: const Text('Display Name'),
            ),
            FButton(
              onPress: _busy || _method.checking ? null : _connect,
              child: Text(_busy ? 'Working…' : _method.checking ? 'Checking sign-in…' : _method.usesBrowser ? 'Sign in at your school' : 'Connect'),
            ),
            if (_error != null)
              SelectableText(_error!, style: TextStyle(color: colors.destructive)),
          ],
        ),
      ),
    );
  }
}
