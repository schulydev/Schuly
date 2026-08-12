import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../config/oidc_config.dart';
import '../../../domain/school_system.dart';
import '../../../services/school_systems_service.dart';
import '../../account/unified_connect_screen.dart';

Future<String?> runAddSchoolFlow(
  BuildContext context,
  NavigatorState navigator,
) async {
  final systems = await fetchSystemsOrShowError(context);
  if (systems == null || !context.mounted) return null;

  final systemKey = await showAddSchoolModal(context, systems);
  if (systemKey == null) return null;

  final system = systems.firstWhere((s) => s.key == systemKey);
  return navigator.push<String>(
    MaterialPageRoute(builder: (_) => UnifiedConnectScreen(system: system)),
  );
}

Future<List<SchoolSystem>?> fetchSystemsOrShowError(BuildContext context) async {
  List<SchoolSystem> systems;
  try {
    systems = await SchoolSystemsService.fetch();
  } catch (_) {
    if (context.mounted) {
      await _showCatalogError(
          context, "Couldn't reach the server. Check your connection and try again.");
    }
    return null;
  }
  if (systems.isEmpty) {
    if (context.mounted) {
      await _showCatalogError(context, 'No school systems are available yet.');
    }
    return null;
  }
  return systems;
}

Future<void> _showCatalogError(BuildContext context, String message) =>
    showFDialog<void>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        title: const Text('School systems unavailable'),
        body: Text(message),
        actions: [
          FButton(
            onPress: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );

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
        spacing: 10,
        runSpacing: 10,
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
    final logoUrl = OidcConfig.resolveUrl(system.logoUrl);
    final fallbackIcon =
        Icon(Icons.school, size: 36, color: colors.mutedForeground);
    final logo = Image.asset(
      'assets/schoolsystems/${system.key}.webp',
      width: 36,
      height: 36,
      errorBuilder: (_, _, _) => logoUrl != null
          ? Image.network(logoUrl,
              width: 36, height: 36, errorBuilder: (_, _, _) => fallbackIcon)
          : fallbackIcon,
    );
    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: SizedBox(
        width: 108,
        child: FTappable(
          onPress: onTap,
          child: FCard(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      system.displayName,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                  if (disabled)
                    Text(
                      'Coming soon',
                      style: TextStyle(
                        fontSize: 10,
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
