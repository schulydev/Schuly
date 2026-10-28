import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/api_client.dart';
import '../../services/api_error.dart';
import '../widgets/browser_sign_in.dart';
import '../widgets/dynamic_login_form.dart';
import '../widgets/linked_account_login.dart';

class UnifiedConnectScreen extends StatefulWidget {
  final SchoolSystem system;
  const UnifiedConnectScreen({required this.system, super.key});

  @override
  State<UnifiedConnectScreen> createState() => _UnifiedConnectScreenState();
}

class _UnifiedConnectScreenState extends State<UnifiedConnectScreen> {
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
    final missing = _form.validateRequired(hidden: _method.hiddenKeys) ?? (_method.usesLinkedAccount && _linkedAccountId == null ? 'Choose a Microsoft account' : null);
    if (missing != null) {
      setState(() => _error = missing);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final browser = _method.usesBrowser ? await signInThroughBrowser(context, _method.browserLoginPath!, _form.value('baseUrl')) : null;
      if (_method.usesBrowser && browser == null) return;
      final fields = {
        ..._form.values(hidden: _method.hiddenKeys),
        if (_method.usesLinkedAccount) SchoolSystem.linkedAccountFieldKey: _linkedAccountId!,
        ...?browser?.fields,
      };
      final name = _nameCtrl.text.trim();
      final res = await ApiClient.instance.dio.post<Map<String, dynamic>>(
        '/api/auth/login',
        data: {
          'systemKey': _system.key,
          'fields': fields,
          'displayName': name.isEmpty ? _system.displayName : name,
        },
        options: ApiClient.handled(),
      );
      final accountId = res.data?['accountId']?.toString();
      // Only once the credentials are known good, so a manager is never asked
      // to save something that did not work.
      TextInput.finishAutofillContext();
      if (mounted) Navigator.of(context).pop(accountId);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = ApiError.describe(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FScaffold(
      header: FHeader.nested(
        title: Text('Add ${_system.displayName} Account'),
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom),
        child: ListenableBuilder(
          listenable: _method,
          builder: (context, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              DynamicLoginForm(controller: _form, hidden: _method.hiddenKeys),
              if (_method.usesLinkedAccount)
                LinkedMicrosoftAccountPicker(
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
                child: Text(_busy ? 'Connecting…' : _method.checking ? 'Checking sign-in…' : _method.usesBrowser ? 'Sign in at your school' : 'Connect'),
              ),
              if (_error != null)
                SelectableText(_error!, style: TextStyle(color: colors.destructive)),
            ],
          ),
        ),
      ),
    );
  }
}
