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
  const DynamicLoginForm({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        for (final field in controller.fields)
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
