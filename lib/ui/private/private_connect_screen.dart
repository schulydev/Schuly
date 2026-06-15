import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/odaorg_proxy_client.dart';
import '../../services/private_account_store.dart';
import '../../services/schulware_proxy_client.dart';
import '../schulnetz/schulnetz_oauth_screen.dart';
import '../widgets/dynamic_login_form.dart';

/// Generic private-mode connect screen. Renders the chosen [system]'s
/// backend-described `loginFields` and drives the connection by its
/// backend-provided `loginMethod` — no provider is hardcoded. Stores the
/// resulting credentials on-device only. Pops `true` on success.
class PrivateConnectScreen extends StatefulWidget {
  final SchoolSystem system;
  const PrivateConnectScreen({required this.system, super.key});

  @override
  State<PrivateConnectScreen> createState() => _PrivateConnectScreenState();
}

class _PrivateConnectScreenState extends State<PrivateConnectScreen> {
  late final DynamicLoginFormController _form;
  late final TextEditingController _nameCtrl;
  bool _busy = false;
  String? _error;

  SchoolSystem get _system => widget.system;

  @override
  void initState() {
    super.initState();
    _form = DynamicLoginFormController(_system.loginFields);
    _nameCtrl = TextEditingController(text: _system.displayName);
  }

  @override
  void dispose() {
    _form.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final missing = _form.validateRequired();
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

      if (_system.loginMethod == 'oauth-webview') {
        await _connectOauth(baseUrl, name);
      } else {
        await _connectCredentials(baseUrl, name);
      }
    } on DioException catch (e) {
      setState(() => _error =
          'HTTP ${e.response?.statusCode ?? '?'}: ${e.response?.data}');
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _connectOauth(String baseUrl, String name) async {
    final basePath = _system.resolvedStatelessBasePath;
    final proxy = SchulwareProxyClient.instance;
    final auth = await proxy.authorizeUrl(basePath, baseUrl);
    if (auth.authorizationUrl == null || auth.codeVerifier == null) {
      setState(() => _error = 'Failed to start login');
      return;
    }
    if (!mounted) return;
    final result = await Navigator.of(context).push<SchulnetzOAuthResult>(
      MaterialPageRoute(
        builder: (_) => SchulnetzOAuthScreen(
          authorizationUrl: auth.authorizationUrl!,
          schulnetzBaseUrl: baseUrl,
        ),
      ),
    );
    if (result == null) {
      setState(() => _error = 'Login cancelled');
      return;
    }
    final tokens = await proxy.exchangeCode(
      basePath: basePath,
      code: result.code,
      codeVerifier: auth.codeVerifier!,
      state: result.state,
      schulnetzBaseUrl: baseUrl,
    );
    if (tokens.accessToken == null) {
      setState(() => _error = 'Token exchange failed');
      return;
    }
    await PrivateAccountStore.instance.save(PrivateAccount(
      systemKey: _system.key,
      loginMethod: _system.loginMethod,
      baseUrl: baseUrl,
      displayName: name,
      statelessBasePath: basePath,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      contextState: result.contextState,
      userAgent: result.userAgent,
    ));
    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _connectCredentials(String baseUrl, String name) async {
    final account = PrivateAccount(
      systemKey: _system.key,
      loginMethod: _system.loginMethod,
      baseUrl: baseUrl,
      displayName: name,
      statelessBasePath: _system.resolvedStatelessBasePath,
      username: _form.value('username'),
      password: _form.value('password'),
    );
    // Validate the credentials with one fetch before persisting.
    await OdaorgProxyClient.instance.data(account);
    await PrivateAccountStore.instance.save(account);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          const Text(
            'Private mode keeps everything on this device — no account, '
            'nothing stored on a server.',
          ),
          DynamicLoginForm(controller: _form),
          FTextField(
            control: FTextFieldControl.managed(controller: _nameCtrl),
            label: const Text('Display Name'),
          ),
          FButton(
            onPress: _busy ? null : _connect,
            child: Text(_busy ? 'Working…' : 'Connect'),
          ),
          if (_error != null)
            SelectableText(_error!, style: TextStyle(color: colors.destructive)),
        ],
      ),
    );
  }
}
