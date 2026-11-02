import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/app_mode_service.dart';
import 'package:schuly/services/auth_service.dart';
import 'package:schuly/services/secure_store.dart';
import 'package:schuly/ui/core/ui/root_screen.dart';

class _ThrowingStore implements SecureKeyValue {
  @override
  Future<String?> read(String key) async => throw Exception('AEADBadTagException');

  @override
  Future<void> write(String key, String value) async => throw Exception('AEADBadTagException');

  @override
  Future<void> delete(String key) async => throw Exception('AEADBadTagException');

  @override
  Future<void> deleteAll() async {}
}

class _HangingStore implements SecureKeyValue {
  @override
  Future<String?> read(String key) => Completer<String?>().future;

  @override
  Future<void> write(String key, String value) => Completer<void>().future;

  @override
  Future<void> delete(String key) => Completer<void>().future;

  @override
  Future<void> deleteAll() => Completer<void>().future;
}

Widget _app() {
  return MaterialApp(
    localizationsDelegates: const [
      ...AppLocalizations.localizationsDelegates,
      ...FLocalizations.localizationsDelegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    builder: (context, child) => FTheme(data: FThemes.zinc.light, child: FToaster(child: child!)),
    home: const RootScreen(),
  );
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'onboarding.seen.v1': true});
    await AppModeService.instance.setMode(AppMode.account);
    AuthService.resetForTest();
    RootScreen.bootstrapTimeout = const Duration(seconds: 15);
  });

  testWidgets('a store that throws lands on sign-in with a notice', (tester) async {
    SecureStore.useBackend(_ThrowingStore(), timeout: const Duration(seconds: 1));
    await tester.pumpWidget(_app());
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Sign in to your Schuly account to continue.'), findsOneWidget);
    expect(find.text('Please sign in again.'), findsOneWidget);
  });

  testWidgets('a store that hangs lands on sign-in after its timeout', (tester) async {
    SecureStore.useBackend(_HangingStore(), timeout: const Duration(seconds: 1));
    await tester.pumpWidget(_app());
    expect(find.byType(FCircularProgress), findsOneWidget);

    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.text('Sign in to your Schuly account to continue.'), findsOneWidget);
    expect(find.text('Please sign in again.'), findsOneWidget);
  });

  testWidgets('startup never waits longer than the bootstrap timeout', (tester) async {
    // The keystore's own timeout is out of reach; only the bootstrap timeout can end the wait.
    SecureStore.useBackend(_HangingStore(), timeout: const Duration(hours: 1));
    RootScreen.bootstrapTimeout = const Duration(seconds: 3);
    await tester.pumpWidget(_app());

    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.text('Sign in to your Schuly account to continue.'), findsOneWidget);
    expect(find.text('Please sign in again.'), findsOneWidget);

    // Let the abandoned keystore timer run out so the test ends with no pending timers.
    await tester.pump(const Duration(hours: 2));
  });
}
