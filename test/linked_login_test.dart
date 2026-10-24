import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/domain/school_system.dart';
import 'package:schuly/ui/widgets/dynamic_login_form.dart';
import 'package:schuly/ui/widgets/linked_account_login.dart';

void main() {
  final schulnetz = SchoolSystem.fromJson({
    'key': 'schulnetz',
    'displayName': 'Schulnetz',
    'loginMethod': 'credentials',
    'loginMethodPath': '/api/plugins/schulware/stateless/login-method',
    'loginFields': [
      {'key': 'baseUrl', 'label': 'Schulnetz URL', 'type': 'url', 'required': true},
      {'key': 'email', 'label': 'Email', 'type': 'text', 'required': true, 'replacedByLinkedAccount': true},
      {'key': 'password', 'label': 'Password', 'type': 'password', 'required': true, 'replacedByLinkedAccount': true},
    ],
  });

  test('reads the login-method hook and the fields a linked account replaces', () {
    expect(schulnetz.loginMethodPath, '/api/plugins/schulware/stateless/login-method');
    expect(schulnetz.loginFields.where((f) => f.replacedByLinkedAccount).map((f) => f.key), ['email', 'password']);
  });

  test('hides nothing until the school is known to sign in with a linked account', () {
    final method = LoginMethodController(schulnetz, null);
    expect(method.usesLinkedAccount, isFalse);
    expect(method.hiddenKeys, isEmpty);
    method.dispose();
  });

  test('hidden fields are neither required nor submitted', () {
    final form = DynamicLoginFormController(schulnetz.loginFields);
    form.controllerFor('baseUrl').text = 'https://schulnetz.bbbaden.ch';
    const hidden = {'email', 'password'};

    expect(form.validateRequired(), 'Email is required');
    expect(form.validateRequired(hidden: hidden), isNull);
    expect(form.values(hidden: hidden), {'baseUrl': 'https://schulnetz.bbbaden.ch'});
    form.dispose();
  });
}
