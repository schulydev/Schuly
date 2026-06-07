import 'package:flutter/material.dart' show showLicensePage, ThemeMode;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../services/theme_service.dart';

/// App settings: appearance (theme mode) and open-source licenses.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Settings'),
        prefixes: [
          FHeaderAction.back(onPress: () => Navigator.of(context).pop()),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          AnimatedBuilder(
            animation: ThemeService.instance,
            builder: (context, _) => FSelectTileGroup<ThemeMode>(
              label: const Text('Appearance'),
              control: FMultiValueControl.managedRadio(
                initial: ThemeService.instance.mode,
                onChange: (selected) {
                  if (selected.isNotEmpty) {
                    ThemeService.instance.setMode(selected.first);
                  }
                },
              ),
              children: const [
                FSelectTile(value: ThemeMode.system, title: Text('System')),
                FSelectTile(value: ThemeMode.light, title: Text('Light')),
                FSelectTile(value: ThemeMode.dark, title: Text('Dark')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FTileGroup(
            label: const Text('About'),
            children: [
              FTile(
                prefix: const Icon(FIcons.fileText),
                title: const Text('Open-source licenses'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () => showLicensePage(
                  context: context,
                  applicationName: 'Schuly',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
