import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../services/toast_service.dart';
import '../../services/update/update_service.dart';

/// "Updates" section of Settings: manual check with the installed version, and the auto-check toggle.
class UpdateSettingsSection extends StatelessWidget {
  const UpdateSettingsSection({super.key, this.service});

  final UpdateService? service;

  UpdateService get _service => service ?? UpdateService.instance;

  Future<void> _check() async {
    final result = await _service.check();
    switch (result) {
      case UpdateAvailable(:final release):
        await _service.present(release);
      case UpToDate():
        ToastService.success('Schuly is up to date');
      case UpdateCheckFailed():
        ToastService.error("Couldn't check for updates");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_service.supported) return const SizedBox.shrink();
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return AnimatedBuilder(
      animation: _service,
      builder: (context, _) {
        final version = _service.installedVersion;
        final available = _service.available;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Text(
                'UPDATES',
                style: typography.xs.copyWith(color: colors.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.refreshCw),
                title: const Text('Check for updates'),
                subtitle: Text(
                  _service.checking
                      ? 'Checking...'
                      : available != null
                          ? 'Version ${available.version} is available (installed ${version.isEmpty ? 'unknown' : version})'
                          : 'Version ${version.isEmpty ? 'unknown' : version}',
                ),
                suffix: _service.checking ? const SizedBox(width: 18, height: 18, child: FCircularProgress()) : const Icon(FIcons.chevronRight),
                onPress: _service.checking ? null : _check,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.bellRing),
                title: const Text('Check automatically'),
                subtitle: Text(_service.isDevFlavor ? 'Off by default in the dev build' : 'On app start, at most every 6 hours'),
                suffix: FSwitch(value: _service.autoCheck, onChange: _service.setAutoCheck),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
