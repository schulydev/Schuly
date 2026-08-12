import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../authenticator/totp_field_picker.dart';

class DynamicLoginFormController {
  final List<SchoolSystemLoginField> fields;
  final Map<String, TextEditingController> _controllers;

  DynamicLoginFormController(this.fields)
      : _controllers = {
          for (final f in fields)
            f.key: TextEditingController(text: f.defaultValue ?? ''),
        };

  TextEditingController controllerFor(String key) => _controllers[key]!;

  String value(String key) => _controllers[key]?.text.trim() ?? '';

  Map<String, String> get values =>
      {for (final f in fields) f.key: value(f.key)};

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

class DynamicLoginForm extends StatelessWidget {
  final DynamicLoginFormController controller;

  const DynamicLoginForm({required this.controller, super.key});

  static bool _isTotp(SchoolSystemLoginField f) =>
      f.type == 'totp' || f.key.toLowerCase() == 'totp';

  /// What the platform needs to tell these boxes apart. The form is built from
  /// the catalog, so this reads the descriptor rather than naming any school
  /// system; without it a password manager sees a row of anonymous text boxes
  /// and offers nothing.
  static List<String> _autofillHints(SchoolSystemLoginField f) {
    final key = f.key.toLowerCase();
    if (f.type == 'password' || key.contains('password')) return const [AutofillHints.password];
    if (f.type == 'url' || key.contains('url')) return const [AutofillHints.url];
    if (f.type == 'email' || key.contains('email') || key.contains('mail')) {
      return const [AutofillHints.username, AutofillHints.email];
    }
    if (key.contains('user') || key.contains('login')) return const [AutofillHints.username];
    return const [];
  }

  static TextInputType _keyboard(SchoolSystemLoginField f) {
    final key = f.key.toLowerCase();
    if (f.type == 'url' || key.contains('url')) return TextInputType.url;
    if (f.type == 'email' || key.contains('email') || key.contains('mail')) return TextInputType.emailAddress;
    return TextInputType.text;
  }

  @override
  Widget build(BuildContext context) {
    final fields = controller.fields;
    // One group, so the platform treats the boxes as a single credential rather
    // than unrelated inputs.
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          for (final (index, field) in fields.indexed)
            if (_isTotp(field))
              TotpFieldPicker(
                controller: controller.controllerFor(field.key),
                field: field,
              )
            else
              FTextField(
                control: FTextFieldControl.managed(
                  controller: controller.controllerFor(field.key),
                ),
                label: Text(field.label),
                hint: field.placeholder,
                obscureText: field.type == 'password',
                keyboardType: _keyboard(field),
                textInputAction: index == fields.length - 1 ? TextInputAction.done : TextInputAction.next,
                autofillHints: _autofillHints(field),
                autocorrect: false,
              ),
        ],
      ),
    );
  }
}
