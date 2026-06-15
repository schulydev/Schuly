import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../domain/school_system.dart';
import '../../services/api_client.dart';
import '../widgets/dynamic_login_form.dart';

/// Connects an OdaOrg account. Unlike Schulnetz (OAuth/WebView), OdaOrg uses
/// plain username/password credentials posted to the backend, which then runs
/// the initial sync. Pops with the new account id (String) on success. The
/// login inputs are rendered from [system]'s backend-described `loginFields`.
class ConnectOdaOrgScreen extends StatefulWidget {
  final SchoolSystem system;
  const ConnectOdaOrgScreen({required this.system, super.key});

  @override
  State<ConnectOdaOrgScreen> createState() => _ConnectOdaOrgScreenState();
}

class _ConnectOdaOrgScreenState extends State<ConnectOdaOrgScreen> {
  late final DynamicLoginFormController _form;
  late final TextEditingController _nameCtrl;
  bool _busy = false;
  String? _error;

  SchulyApi get _api => ApiClient.instance.api;

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

  T _expectJson<T>(Response<void> response) {
    final data = response.data as Object?;
    if (data is! T) {
      throw StateError('Expected ${T.toString()}, got ${data.runtimeType}: $data');
    }
    return data;
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
      final accountsApi = _api.getAccountsApi();
      final create = await accountsApi.apiPluginsOdaorgAccountsPost(
        connectOdaOrgRequest: ConnectOdaOrgRequest((b) => b
          ..username = _form.value('username')
          ..password = _form.value('password')
          ..baseUrl = _form.value('baseUrl')
          ..displayName = _nameCtrl.text.trim()),
      );
      final accountId = _expectJson<Map<String, dynamic>>(create)['id'] as String;

      // Kick off the initial sync so data lands before we return.
      await _api.getSyncApi().apiPluginsOdaorgAccountsAccountIdSyncPost(accountId: accountId);

      if (mounted) Navigator.of(context).pop(accountId);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final body = e.response?.data;
      setState(() => _error = 'HTTP ${status ?? '?'}: $body');
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
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
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
            onPress: _busy ? null : _connect,
            child: Text(_busy ? 'Connecting…' : 'Connect'),
          ),
          if (_error != null)
            SelectableText(_error!, style: TextStyle(color: colors.destructive)),
        ],
      ),
    );
  }
}
