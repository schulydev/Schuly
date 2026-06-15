import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../domain/school_system.dart';
import '../../../services/school_systems_service.dart';
import '../../odaorg/connect_odaorg_screen.dart';
import '../../schulnetz/connect_account_screen.dart';

/// Local logo assets keyed by school-system key. Backend-advertised systems we
/// don't yet bundle an asset for fall back to a generic icon.
const _systemAssets = <String, String>{
  'schulnetz': 'assets/schoolsystems/schulnetz.webp',
  'odaorg': 'assets/schoolsystems/odaorg.webp',
};

/// Full add-school flow: fetch the backend's school-system catalog, show the
/// picker, then run the chosen system's connect screen. Returns the new account
/// id, or null if the user cancelled at any step. [navigator] is the navigator
/// the connect screen is pushed onto — pass the dashboard's, not a sheet/dialog
/// navigator that may be torn down mid-flow.
Future<String?> runAddSchoolFlow(
  BuildContext context,
  NavigatorState navigator,
) async {
  final systems = await SchoolSystemsService.fetch();
  if (!context.mounted) return null;

  final systemKey = await showAddSchoolModal(context, systems);
  if (systemKey == null) return null;

  final system = systems.firstWhere((s) => s.key == systemKey);
  // Branch on how the system logs in: credentials (OdAOrg) uses a
  // username/password screen, everything else uses the OAuth (WebView) flow.
  final Widget screen = switch (system.loginMethod) {
    'credentials' => ConnectOdaOrgScreen(system: system),
    _ => ConnectAccountScreen(system: system),
  };
  return navigator.push<String>(MaterialPageRoute(builder: (_) => screen));
}

/// Shows the school-system picker for [systems]. Resolves to the chosen
/// [SchoolSystem.key] or `null` if the user dismissed.
Future<String?> showAddSchoolModal(
  BuildContext context,
  List<SchoolSystem> systems,
) {
  return showFDialog<String>(
    context: context,
    builder: (dialogCtx, style, animation) => FDialog(
      animation: animation,
      title: const Text('Choose a school system'),
      body: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          for (final s in systems)
            _SystemCard(
              system: s,
              onTap:
                  s.enabled ? () => Navigator.of(dialogCtx).pop(s.key) : null,
            ),
        ],
      ),
      actions: [
        FButton(
          onPress: () => Navigator.of(dialogCtx).pop(),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}

class _SystemCard extends StatelessWidget {
  final SchoolSystem system;
  final VoidCallback? onTap;
  const _SystemCard({required this.system, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final disabled = onTap == null;
    final asset = _systemAssets[system.key];
    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: SizedBox(
        width: 120,
        height: 120,
        child: FTappable(
          onPress: onTap,
          child: FCard(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (asset != null)
                    Image.asset(asset, width: 48, height: 48)
                  else
                    Icon(Icons.school, size: 48, color: colors.mutedForeground),
                  const SizedBox(height: 10),
                  Text(
                    system.displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (disabled)
                    Text(
                      'Coming soon',
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.mutedForeground,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
