import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../services/toast_service.dart';
import '../../services/update/update_service.dart';

/// Manual update check: offers the update dialog, or says why there is none.
Future<void> checkForUpdatesNow([UpdateService? service]) async {
  final updates = service ?? UpdateService.instance;
  final result = await updates.check();
  switch (result) {
    case UpdateAvailable(:final release):
      await updates.present(release);
    case UpToDate():
      ToastService.success('Schuly is up to date');
    case UpdateCheckFailed():
      ToastService.error("Couldn't check for updates");
  }
}

/// A small "Check for updates" link for screens that work without an account,
/// so a signed-out or broken app can still update itself.
class CheckForUpdatesLink extends StatelessWidget {
  const CheckForUpdatesLink({super.key, this.service});

  final UpdateService? service;

  @override
  Widget build(BuildContext context) {
    final updates = service ?? UpdateService.instance;
    if (!updates.supported) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: updates,
      builder: (context, _) => FButton(
        style: FButtonStyle.ghost(),
        onPress: updates.checking ? null : () => checkForUpdatesNow(updates),
        prefix: updates.checking ? const SizedBox(width: 16, height: 16, child: FCircularProgress()) : const Icon(FIcons.refreshCw),
        child: Text(updates.checking ? 'Checking for updates...' : 'Check for updates'),
      ),
    );
  }
}
