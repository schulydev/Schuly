import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';

/// Owns the text controllers for a set of backend-described login fields and
/// exposes their collected values. The screen creates one from a system's
/// [SchoolSystemLoginField]s and reads [values] on submit.
class DynamicLoginFormController {
  final List<SchoolSystemLoginField> fields;
  final Map<String, TextEditingController> _controllers;

  DynamicLoginFormController(this.fields)
      : _controllers = {
          for (final f in fields)
            f.key: TextEditingController(text: f.defaultValue ?? ''),
        };

  TextEditingController controllerFor(String key) => _controllers[key]!;

  /// Trimmed value for [key], or empty string if the field isn't present.
  String value(String key) => _controllers[key]?.text.trim() ?? '';

  /// Collected values keyed by field key.
  Map<String, String> get values =>
      {for (final f in fields) f.key: value(f.key)};

  /// First missing required field as an error message, or null if all present.
  String? validateRequired() {
    for (final f in fields) {
      if (f.required && value(f.key).isEmpty) {
        return '${f.label} is required';
      }
    }
    return null;
  }

  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
  }
}

/// Renders the login inputs a school system advertises (`loginFields`) so the
/// backend, not the app, decides what the login form shows.
class DynamicLoginForm extends StatelessWidget {
  final DynamicLoginFormController controller;

  /// Invoked when the user taps "Scan QR code" on a TOTP field. Receives the
  /// field key; the caller scans and writes the result back into the
  /// controller. When null, no scan affordance is shown.
  final Future<void> Function(String fieldKey)? onScanField;

  const DynamicLoginForm({
    required this.controller,
    this.onScanField,
    super.key,
  });

  /// A field that carries a TOTP seed — obscured and offered a QR scanner.
  /// Detected by an explicit `totp` type or the conventional `totp` key, so the
  /// backend catalog can opt in without the app hardcoding a provider.
  static bool _isTotp(SchoolSystemLoginField f) =>
      f.type == 'totp' || f.key.toLowerCase() == 'totp';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        for (final field in controller.fields)
          if (_isTotp(field))
            _TotpField(
              controller: controller.controllerFor(field.key),
              field: field,
              onScan: onScanField == null
                  ? null
                  : () => onScanField!(field.key),
            )
          else
            FTextField(
              control: FTextFieldControl.managed(
                controller: controller.controllerFor(field.key),
              ),
              label: Text(field.label),
              hint: field.placeholder,
              obscureText: field.type == 'password',
              keyboardType: field.type == 'url'
                  ? TextInputType.url
                  : TextInputType.text,
              autocorrect: false,
            ),
      ],
    );
  }
}

/// A TOTP seed input: obscured text plus an optional "Scan QR code" button.
class _TotpField extends StatelessWidget {
  final TextEditingController controller;
  final SchoolSystemLoginField field;
  final VoidCallback? onScan;

  const _TotpField({
    required this.controller,
    required this.field,
    this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        FTextField(
          control: FTextFieldControl.managed(controller: controller),
          label: Text(field.label),
          hint: field.placeholder ?? 'Secret or otpauth:// URI',
          obscureText: true,
          autocorrect: false,
        ),
        if (onScan != null)
          FButton(
            style: FButtonStyle.outline(),
            prefix: const Icon(FIcons.scanQrCode),
            onPress: onScan,
            child: const Text('Scan QR code'),
          ),
      ],
    );
  }
}
