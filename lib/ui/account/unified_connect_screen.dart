import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/api_client.dart';
import '../widgets/dynamic_login_form.dart';

class UnifiedConnectScreen extends StatefulWidget {
  final SchoolSystem system;
  const UnifiedConnectScreen({required this.system, super.key});

  @override
  State<UnifiedConnectScreen> createState() => _UnifiedConnectScreenState();
}

class _UnifiedConnectScreenState extends State<UnifiedConnectScreen> {
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
      final fields = {
        for (final f in _system.loginFields) f.key: _form.value(f.key),
      };
      final name = _nameCtrl.text.trim();
      final res = await ApiClient.instance.dio.post<Map<String, dynamic>>(
        '/api/auth/login',
        data: {
          'systemKey': _system.key,
          'fields': fields,
          'displayName': name.isEmpty ? _system.displayName : name,
        },
      );
      final accountId = res.data?['accountId']?.toString();
      if (mounted) Navigator.of(context).pop(accountId);
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
        title: Text('Add ${_system.displayName} Account'),
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
      ),
      child: SingleChildScrollView(
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
      ),
    );
  }
}
