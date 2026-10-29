import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../services/active_account_service.dart';
import '../../services/linked_accounts_controller.dart';
import '../../services/linking_service.dart';
import 'link_flow_screen.dart';

/// Icon for a provider: the Lucide name it declares when the app knows it, a generic one otherwise.
IconData providerIcon(LinkProvider provider) => switch (provider.lucide) {
      'graduation-cap' => FIcons.graduationCap,
      'school' => FIcons.school,
      'mail' => FIcons.mail,
      'building' => FIcons.building,
      'building-2' => FIcons.building2,
      'key-round' => FIcons.keyRound,
      'users' => FIcons.users,
      _ => FIcons.link,
    };

/// Lets the person pick a provider (and flow, when it offers several) from the server's list, then
/// runs the generic link flow. Returns the result, or null if they backed out or nothing is available.
Future<LinkResult?> runAddAccountFlow(BuildContext context, {LinkedAccountsController? controller}) async {
  final c = controller ?? LinkedAccountsController.instance;
  if (c.providers.isEmpty) await c.load();
  if (!context.mounted) return null;
  final providers = c.providers;
  if (providers.isEmpty) {
    await _notice(context, c.error != null ? "Couldn't reach the server. Check your connection and try again." : 'No school systems are available yet.');
    return null;
  }
  final provider = providers.length == 1 ? providers.first : await pickProvider(context, providers);
  if (provider == null || !context.mounted) return null;
  return startProviderFlow(context, provider, controller: c);
}

/// Runs [provider]'s flow, asking which one first when it offers more than one.
Future<LinkResult?> startProviderFlow(BuildContext context, LinkProvider provider, {String? reauthAccountId, LinkedAccountsController? controller}) async {
  final c = controller ?? LinkedAccountsController.instance;
  String? flowId;
  if (provider.flows.length > 1 && reauthAccountId == null) {
    flowId = await _pickFlow(context, provider);
    if (flowId == null || !context.mounted) return null;
  }
  final before = ActiveAccountService.instance.schools.map((s) => s.id).toSet();
  final result = await LinkFlowScreen.open(context, providerId: provider.id, flowId: flowId, reauthAccountId: reauthAccountId, title: provider.displayName, controller: c);
  if (result != null) {
    final svc = ActiveAccountService.instance;
    final added = svc.schools.where((s) => !before.contains(s.id));
    if (added.isNotEmpty) await svc.setActive(added.first.id);
  }
  return result;
}

Future<LinkProvider?> pickProvider(BuildContext context, List<LinkProvider> providers) {
  return showFDialog<LinkProvider>(
    context: context,
    builder: (ctx, style, animation) => FDialog(
      animation: animation,
      title: const Text('Add an account'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          for (final p in providers)
            FTile(
              prefix: Icon(providerIcon(p)),
              title: Text(p.displayName),
              subtitle: p.description == null ? null : Text(p.description!),
              suffix: const Icon(FIcons.chevronRight),
              onPress: () => Navigator.of(ctx).pop(p),
            ),
        ],
      ),
      actions: [FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(), child: const Text('Cancel'))],
    ),
  );
}

Future<String?> _pickFlow(BuildContext context, LinkProvider provider) {
  return showFDialog<String>(
    context: context,
    builder: (ctx, style, animation) => FDialog(
      animation: animation,
      title: Text(provider.displayName),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          for (final f in provider.flows)
            FTile(
              title: Text(f.label),
              subtitle: f.description == null ? null : Text(f.description!),
              suffix: const Icon(FIcons.chevronRight),
              onPress: () => Navigator.of(ctx).pop(f.id),
            ),
        ],
      ),
      actions: [FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(), child: const Text('Cancel'))],
    ),
  );
}

Future<void> _notice(BuildContext context, String message) {
  return showFDialog<void>(
    context: context,
    builder: (ctx, style, animation) => FDialog(
      animation: animation,
      title: const Text('School systems unavailable'),
      body: Text(message),
      actions: [FButton(onPress: () => Navigator.of(ctx).pop(), child: const Text('OK'))],
    ),
  );
}
