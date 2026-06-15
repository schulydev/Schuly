import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../services/private_account_store.dart';
import '../../services/schulware_proxy_client.dart';
import 'schulnetz_oauth_screen.dart';

/// Private-mode Schulnetz connect: runs OAuth against the stateless proxy and
/// stores the resulting credentials on-device only (no Schuly account). Pops
/// `true` on success.
class PrivateConnectScreen extends StatefulWidget {
  const PrivateConnectScreen({super.key});

  @override
  State<PrivateConnectScreen> createState() => _PrivateConnectScreenState();
}

class _PrivateConnectScreenState extends State<PrivateConnectScreen> {
  final _urlCtrl = TextEditingController();
  final _nameCtrl = TextEditingController(text: 'Schulnetz');
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _urlCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) {
      setState(() => _error = 'Schulnetz URL is required');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final proxy = SchulwareProxyClient.instance;

      // 1. Get the authorize URL + PKCE verifier from the stateless proxy.
      final auth = await proxy.authorizeUrl(url);
      if (auth.authorizationUrl == null || auth.codeVerifier == null) {
        setState(() => _error = 'Failed to start login');
        return;
      }

      // 2. Drive Schulnetz OAuth in the WebView, capturing code + context_state.
      if (!mounted) return;
      final result = await Navigator.of(context).push<SchulnetzOAuthResult>(
        MaterialPageRoute(
          builder: (_) => SchulnetzOAuthScreen(
            authorizationUrl: auth.authorizationUrl!,
            schulnetzBaseUrl: url,
          ),
        ),
      );
      if (result == null) {
        setState(() => _error = 'Login cancelled');
        return;
      }

      // 3. Exchange the code for tokens (stateless; nothing stored server-side).
      final tokens = await proxy.exchangeCode(
        code: result.code,
        codeVerifier: auth.codeVerifier!,
        state: result.state,
        schulnetzBaseUrl: url,
      );
      if (tokens.accessToken == null) {
        setState(() => _error = 'Token exchange failed');
        return;
      }

      // 4. Persist everything on-device for passwordless refresh + data calls.
      final name = _nameCtrl.text.trim();
      await PrivateAccountStore.instance.save(PrivateAccount(
        schulnetzBaseUrl: url,
        displayName: name.isEmpty ? 'Schulnetz' : name,
        accessToken: tokens.accessToken!,
        refreshToken: tokens.refreshToken,
        contextState: result.contextState,
        userAgent: result.userAgent,
      ));

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
        title: const Text('Connect Schulnetz'),
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
            label: const Text('Schulnetz URL'),
            hint: 'https://schulnetz.example.ch',
            keyboardType: TextInputType.url,
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
