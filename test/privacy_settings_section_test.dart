import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:schuly/l10n/app_localizations.dart';
import 'package:schuly/services/app_mode_service.dart';
import 'package:schuly/ui/settings/privacy_settings_section.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [
      ...AppLocalizations.localizationsDelegates,
      ...FLocalizations.localizationsDelegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: FTheme(data: FThemes.zinc.light, child: Scaffold(body: child)),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('account mode shows both the export and delete tiles', (tester) async {
    await AppModeService.instance.setMode(AppMode.account);
    await tester.pumpWidget(_wrap(const PrivacySettingsSection()));
    await tester.pumpAndSettle();

    expect(find.text('Export my data'), findsOneWidget);
    expect(find.text('Delete account'), findsOneWidget);
    expect(find.text('Nothing stored on our servers'), findsNothing);
  });

  testWidgets('private mode shows a single explanatory tile', (tester) async {
    await AppModeService.instance.setMode(AppMode.private);
    await tester.pumpWidget(_wrap(const PrivacySettingsSection()));
    await tester.pumpAndSettle();

    expect(find.text('Export my data'), findsNothing);
    expect(find.text('Delete account'), findsNothing);
    expect(find.text('Nothing stored on our servers'), findsOneWidget);
  });
}
