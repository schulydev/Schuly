import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/services/secure_store.dart';
import 'package:schuly/ui/authenticator/authenticator_vault_screen.dart';

class _EmptyStore implements SecureKeyValue {
  @override
  Future<String?> read(String key) async => null;

  @override
  Future<void> write(String key, String value) async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<void> deleteAll() async {}
}

void main() {
  test('the Microsoft setup link is the short one Microsoft keeps working', () {
    expect(kMicrosoftMfaSetupUrl, 'https://aka.ms/mfasetup');
  });

  testWidgets('the empty authenticator screen links to it', (tester) async {
    SecureStore.useBackend(_EmptyStore());
    await tester.pumpWidget(MaterialApp(
      builder: (context, child) => FTheme(data: FThemes.zinc.light, child: FToaster(child: child!)),
      home: const AuthenticatorVaultScreen(),
    ));
    await tester.pump();
    await tester.pump();
    expect(find.text('Open Microsoft security settings'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });
}
