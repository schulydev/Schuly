import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'l10n/app_localizations.dart';
import 'services/app_mode_service.dart';
import 'services/theme_service.dart';
import 'ui/core/ui/root_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppModeService.instance.load();
  await ThemeService.instance.load();
  runApp(const SchulyApp());
}

class SchulyApp extends StatelessWidget {
  const SchulyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeService.instance,
      builder: (context, _) {
        return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            ...FLocalizations.localizationsDelegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: ThemeService.instance.mode,
          theme: FThemes.zinc.light.toApproximateMaterialTheme(),
          darkTheme: FThemes.zinc.dark.toApproximateMaterialTheme(),
          builder: (ctx, child) {
            // Resolve the active Forui theme from the mode, following the OS
            // brightness when set to system.
            final mode = ThemeService.instance.mode;
            final platformDark =
                MediaQuery.platformBrightnessOf(ctx) == Brightness.dark;
            final isDark = mode == ThemeMode.dark ||
                (mode == ThemeMode.system && platformDark);
            final theme = isDark ? FThemes.zinc.dark : FThemes.zinc.light;
            return FAnimatedTheme(data: theme, child: child!);
          },
          home: const RootScreen(),
        );
      },
    );
  }
}
