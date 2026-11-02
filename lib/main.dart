import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'config/backend_config.dart';
import 'l10n/app_localizations.dart';
import 'services/app_mode_service.dart';
import 'services/firebase_push.dart';
import 'services/school_data_service.dart';
import 'services/theme_service.dart';
import 'services/toast_service.dart';
import 'services/update/update_service.dart';
import 'ui/core/ui/root_screen.dart';
import 'ui/update/update_dialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Nothing before runApp may keep the app on its splash screen: each step is
  // bounded and a failed step keeps its defaults.
  await _startupStep('backend config', BackendConfig.load);
  await _startupStep('app mode', AppModeService.instance.load);
  await _startupStep('theme', ThemeService.instance.load);
  await _startupStep('cached school data', SchoolDataService.instance.loadCached);
  await _startupStep('updates', UpdateService.instance.load);
  UpdateService.instance.presenter = showUpdateDialog;
  runApp(const SchulyApp());
  // Update check runs after the first frame so it never delays startup or races the navigator.
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => UpdateService.instance.start(),
  );
  // Firebase touches disk and the network, so it starts after the first frame
  // and never delays startup.
  unawaited(startPush());
}

Future<void> _startupStep(String name, Future<void> Function() step) async {
  try {
    await step().timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint('Startup: $name skipped ($e)');
  }
}

class SchulyApp extends StatelessWidget {
  const SchulyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeService.instance,
      builder: (context, _) {
        return MaterialApp(
          navigatorKey: ToastService.navigatorKey,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            ...FLocalizations.localizationsDelegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: ThemeService.instance.mode,
          // ignore: experimental_member_use
          theme: FThemes.zinc.light.toApproximateMaterialTheme(),
          // ignore: experimental_member_use
          darkTheme: FThemes.zinc.dark.toApproximateMaterialTheme(),
          builder: (ctx, child) {
            final mode = ThemeService.instance.mode;
            final platformDark =
                MediaQuery.platformBrightnessOf(ctx) == Brightness.dark;
            final isDark =
                mode == ThemeMode.dark ||
                (mode == ThemeMode.system && platformDark);
            final theme = isDark ? FThemes.zinc.dark : FThemes.zinc.light;
            return FAnimatedTheme(
              data: theme,
              child: FToaster(
                style: (s) =>
                    s.copyWith(toastAlignment: FToastAlignment.topCenter),
                child: child!,
              ),
            );
          },
          home: const RootScreen(),
        );
      },
    );
  }
}
