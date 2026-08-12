import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/private_account_store.dart';
import '../../services/scrape_proxy_client.dart';
import '../../services/token_proxy_client.dart';
import '../../services/totp_service.dart';
import '../widgets/dynamic_login_form.dart';

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

      final basePath = _system.statelessBasePath;
      if (basePath == null || basePath.isEmpty) {
        setState(() => _error = 'This system is not configured for private mode');
        return;
      }

      if (_system.privateAuthStrategy == 'token') {
        await _connectToken(baseUrl, name, basePath);
      } else {
        await _connectScrape(baseUrl, name, basePath);
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
            'Private mode keeps everything on this device - no account, '
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
