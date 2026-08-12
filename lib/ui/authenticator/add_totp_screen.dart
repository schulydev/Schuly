import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../services/totp_service.dart';
import '../../services/totp_vault.dart';
import 'totp_scan_screen.dart';

class AddTotpScreen extends StatefulWidget {
  const AddTotpScreen({super.key});

  @override
  State<AddTotpScreen> createState() => _AddTotpScreenState();
}

class _AddTotpScreenState extends State<AddTotpScreen> {
  final _issuerCtrl = TextEditingController();
  final _accountCtrl = TextEditingController();
  final _secretCtrl = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _issuerCtrl.dispose();
    _accountCtrl.dispose();
    _secretCtrl.dispose();
    super.dispose();
  }

  String _newId() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> _scan() async {
    final scanned = await Navigator.of(
      context,
    ).push<String>(MaterialPageRoute(builder: (_) => const TotpScanScreen()));
    if (scanned == null || scanned.isEmpty || !mounted) return;
    final entry = TotpEntry.fromPayload(_newId(), scanned);
    if (entry == null) {
      setState(
        () => _error = "That QR code doesn't contain a valid TOTP secret.",
      );
      return;
    }
    await _save(entry);
  }

  Future<void> _saveManual() async {
    final secret = _secretCtrl.text.trim();
    if (TotpConfig.tryParse(secret) == null) {
      setState(
        () => _error = 'Enter a valid TOTP secret (base32) or otpauth:// URI.',
      );
      return;
    }
    final entry = TotpEntry.fromPayload(
      _newId(),
      secret,
      issuer: _issuerCtrl.text.trim(),
      account: _accountCtrl.text.trim(),
    );
    if (entry == null) {
      setState(
        () => _error = 'Enter a valid TOTP secret (base32) or otpauth:// URI.',
      );
      return;
    }
    await _save(entry);
  }

  Future<void> _save(TotpEntry entry) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await TotpVault.instance.add(entry);
      if (mounted) Navigator.of(context).pop(entry);
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Add authenticator'),
        prefixes: [
          FHeaderAction.back(onPress: () => Navigator.of(context).pop()),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  FButton(
                    onPress: _busy ? null : _scan,
                    prefix: const Icon(FIcons.scanQrCode),
                    child: const Text('Scan QR code'),
                  ),
                  Row(
                    children: [
                      const Expanded(child: FDivider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or enter manually',
                          style: typography.sm.copyWith(
                            color: colors.mutedForeground,
                          ),
                        ),
                      ),
                      const Expanded(child: FDivider()),
                    ],
                  ),
                  FTextField(
                    control: FTextFieldControl.managed(controller: _issuerCtrl),
                    label: const Text('Provider (optional)'),
                    hint: 'e.g. Schulnetz, GitHub',
                    autocorrect: false,
                  ),
                  FTextField(
                    control: FTextFieldControl.managed(
                      controller: _accountCtrl,
                    ),
                    label: const Text('Account (optional)'),
                    hint: 'e.g. your username or email',
                    autocorrect: false,
                  ),
                  FTextField(
                    control: FTextFieldControl.managed(controller: _secretCtrl),
                    label: const Text('Setup key'),
                    hint: 'TOTP secret or otpauth:// URI',
                    autocorrect: false,
                  ),
                  FButton(
                    style: FButtonStyle.outline(),
                    onPress: _busy ? null : _saveManual,
                    child: Text(_busy ? 'Saving…' : 'Save'),
                  ),
                  if (_error != null)
                    SelectableText(
                      _error!,
                      style: TextStyle(color: colors.destructive),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
