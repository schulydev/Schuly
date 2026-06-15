import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../services/odaorg_proxy_client.dart';
import '../../services/private_account_store.dart';

/// Private-mode OdAOrg connect: username/password stored on-device only. The
/// credentials are validated with one stateless scrape before saving. Pops
/// `true` on success.
class OdaorgPrivateConnectScreen extends StatefulWidget {
  const OdaorgPrivateConnectScreen({super.key});

  @override
  State<OdaorgPrivateConnectScreen> createState() =>
      _OdaorgPrivateConnectScreenState();
}

class _OdaorgPrivateConnectScreenState
    extends State<OdaorgPrivateConnectScreen> {
  final _urlCtrl = TextEditingController(text: 'https://odaorg.ict-bbag.ch');
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController(text: 'OdAOrg');
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _urlCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final url = _urlCtrl.text.trim();
    final user = _userCtrl.text.trim();
    final pass = _passCtrl.text;
    if (url.isEmpty || user.isEmpty || pass.isEmpty) {
      setState(() => _error = 'URL, username and password are required');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final name = _nameCtrl.text.trim();
      final account = PrivateAccount.odaorg(
        baseUrl: url,
        displayName: name.isEmpty ? 'OdAOrg' : name,
        username: user,
        password: pass,
      );
      // Validate the credentials with one scrape before persisting.
      await OdaorgProxyClient.instance.data(account);
      await PrivateAccountStore.instance.save(account);
      if (mounted) Navigator.of(context).pop(true);
    } on DioException catch (e) {
      setState(() => _error =
          'HTTP ${e.response?.statusCode ?? '?'}: ${e.response?.data}');
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Connect OdAOrg'),
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
          FTextField(
            control: FTextFieldControl.managed(controller: _urlCtrl),
            label: const Text('OdAOrg URL'),
            keyboardType: TextInputType.url,
            autocorrect: false,
          ),
          FTextField(
            control: FTextFieldControl.managed(controller: _userCtrl),
            label: const Text('Username'),
            hint: 'e.g. LRN26487',
            autocorrect: false,
          ),
          FTextField(
            control: FTextFieldControl.managed(controller: _passCtrl),
            label: const Text('Password'),
            obscureText: true,
            autocorrect: false,
          ),
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
