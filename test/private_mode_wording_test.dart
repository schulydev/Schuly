import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Requests and school data pass through the server in private mode, so no text may say all of it stays on the device.
void main() {
  const screens = [
    'lib/ui/onboarding/onboarding_screen.dart',
    'lib/ui/private/private_connect_screen.dart',
    'lib/ui/dashboard/widgets/accounts_sidebar.dart',
    'lib/l10n/app_en.arb',
    'lib/l10n/app_de.arb',
  ];

  for (final path in screens) {
    test('$path does not overstate private mode', () {
      final source = File(path).readAsStringSync().replaceAll(RegExp(r"'\s*\n\s*'"), '');
      expect(source, isNot(contains('everything stays on your device')));
      expect(source, isNot(contains('keeps everything on this device')));
      expect(source, isNot(contains('on this device only')));
      expect(source, isNot(contains('nur auf diesem Gerät')));
    });
  }

  test('the onboarding says requests pass through the server without being stored', () {
    final source = File('lib/ui/onboarding/onboarding_screen.dart').readAsStringSync().replaceAll(RegExp(r"'\s*\n\s*'"), '');
    expect(source, contains('requests pass through the Schuly server without being stored'));
  });
}
