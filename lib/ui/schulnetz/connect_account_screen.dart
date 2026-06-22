import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/api_client.dart';
import '../widgets/dynamic_login_form.dart';
import 'schulnetz_oauth_screen.dart';

/// Connects a Schulnetz school account on the backend.
///
/// Pushed as its own route. Pops with the new account id (`String`) on success
/// or `null` if the user cancels / a failure occurred. Login inputs and the
/// plugin route both come from [system]'s catalog entry — no provider is
/// hardcoded.
class ConnectAccountScreen extends StatefulWidget {
  final SchoolSystem system;
  const ConnectAccountScreen({required this.system, super.key});

  @override
  State<ConnectAccountScreen> createState() => _ConnectAccountScreenState();
}

class _ConnectAccountScreenState extends State<ConnectAccountScreen> {
  late final DynamicLoginFormController _form;
  late final TextEditingController _nameCtrl;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _form = DynamicLoginFormController(widget.system.loginFields);
    _nameCtrl = TextEditingController(text: widget.system.displayName);
  }

  @override
  void dispose() {
    _form.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final missing = _form.validateRequired();
    if (missing != null) {
      setState(() => _error = missing);
      return;
    }
    final base = widget.system.pluginBasePath;
    if (base == null || base.isEmpty) {
      setState(() => _error = 'This system is not configured for account mode');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final dio = ApiClient.instance.dio;
      final url = _form.value('baseUrl');
      String? accountId;

      // 1. Reuse an existing row if the user is reconnecting the same school.
      final list = await dio.get<List<dynamic>>('$base/accounts');
      for (final a in (list.data ?? const []).cast<Map<String, dynamic>>()) {
        if (a['schulnetzBaseUrl'] == url) {
          accountId = a['id'] as String;
          break;
        }
      }

      // 2. Otherwise create a fresh row.
      if (accountId == null) {
        final create = await dio.post<Map<String, dynamic>>(
          '$base/accounts',
          data: {
            'schulnetzBaseUrl': url,
            'displayName': _nameCtrl.text.trim(),
          },
        );
        accountId = create.data!['id'] as String;
      }

      // 3. Backend hands back the Schulnetz authorize URL + PKCE verifier.
      final urlRes = await dio.get<Map<String, dynamic>>(
          '$base/accounts/$accountId/auth/oauth/url');
      final authorizationUrl = urlRes.data!['authorizationUrl'] as String;
      final codeVerifier = urlRes.data!['codeVerifier'] as String;

      // 4. Drive Schulnetz's OAuth in a WebView and capture the SSO chain.
      if (!mounted) return;
      final result = await Navigator.of(context).push<SchulnetzOAuthResult>(
        MaterialPageRoute(
          builder: (_) => SchulnetzOAuthScreen(
            authorizationUrl: authorizationUrl,
            schulnetzBaseUrl: url,
          ),
        ),
      );
      if (result == null) {
        setState(() => _error = 'Login cancelled');
        return;
      }

      // 5. Hand the captured code + storage_state back so the backend can
      //    finish token exchange and replay the SSO chain on refresh.
      await dio.post<dynamic>(
        '$base/accounts/$accountId/auth/oauth/callback',
        data: {
          'code': result.code,
          'codeVerifier': codeVerifier,
          'state': result.state,
          'contextState': result.contextState,
          'userAgent': result.userAgent,
          'webSessionId': result.webSessionId,
          'webSessionUserId': result.webSessionUserId,
          'webSessionTransId': result.webSessionTransId,
        },
      );

      if (mounted) Navigator.of(context).pop(accountId);
    } on DioException catch (e) {
      final body = e.response?.data;
      final status = e.response?.statusCode;
      setState(() => _error =
          'HTTP ${status ?? '?'} ${e.requestOptions.method} '
          '${e.requestOptions.path}\n$body');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FScaffold(
      header: FHeader.nested(
        title: Text('Add ${widget.system.displayName} Account'),
        prefixes: [
          FHeaderAction.back(
            onPress: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          DynamicLoginForm(controller: _form),
          FTextField(
            control: FTextFieldControl.managed(controller: _nameCtrl),
            label: const Text('Display Name'),
          ),
          FButton(
            onPress: _busy ? null : _create,
            child: Text(_busy ? 'Working...' : 'Connect'),
          ),
          if (_error != null)
            SelectableText(_error!,
                style: TextStyle(color: colors.destructive)),
        ],
      ),
    );
  }
}
