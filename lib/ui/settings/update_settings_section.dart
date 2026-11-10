import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/update/update_service.dart';
import '../core/ui/kit.dart';
import '../update/check_for_updates.dart';
import 'settings_card.dart';

/// "Updates" in Settings: a manual check with the installed version, and the automatic check.
class UpdateSettingsSection extends StatelessWidget {
  const UpdateSettingsSection({super.key, this.service});

  final UpdateService? service;

  UpdateService get _service => service ?? UpdateService.instance;

  Future<void> _check() => checkForUpdatesNow(_service);

  @override
  Widget build(BuildContext context) {
    if (!_service.supported) return const SizedBox.shrink();
    final t = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _service,
      builder: (context, _) {
        final installed = _service.installedVersion.isEmpty ? t.updateUnknown : _service.installedVersion;
        final available = _service.available;
        return SettingsCard(
          title: t.updatesTitle,
          children: [
            FTile(
              title: Text(t.updatesCheck),
              subtitle: Text(
                _service.checking
                    ? t.updatesChecking
                    : available != null
                        ? t.updatesAvailable('${available.version}', installed)
                        : t.updatesInstalled(installed),
              ),
              suffix: _service.checking ? const SizedBox(width: 18, height: 18, child: FCircularProgress()) : chevron(),
              onPress: _service.checking ? null : _check,
            ),
            FTile(
              title: Text(t.updatesAuto),
              subtitle: Text(_service.isDevFlavor ? t.updatesAutoDev : t.updatesAutoDetail),
              suffix: FSwitch(value: _service.autoCheck, onChange: _service.setAutoCheck),
            ),
          ],
        );
      },
    );
  }
}
