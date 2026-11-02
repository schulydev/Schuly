import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../services/linked_accounts_controller.dart';
import '../../services/linking_service.dart';
import '../../services/toast_service.dart';
import 'add_account_flow.dart';

/// "Schools & accounts": every linked account across all providers with its status, re-sign-in and
/// unlink, plus the providers the server offers to add. All of it comes from `/api/linking`.
class SchoolsAccountsScreen extends StatefulWidget {
  final LinkedAccountsController? controller;
  const SchoolsAccountsScreen({this.controller, super.key});

  @override
  State<SchoolsAccountsScreen> createState() => _SchoolsAccountsScreenState();
}

class _SchoolsAccountsScreenState extends State<SchoolsAccountsScreen> {
  LinkedAccountsController get _c => widget.controller ?? LinkedAccountsController.instance;

  @override
  void initState() {
    super.initState();
    _c.load();
  }

  Future<void> _reauth(LinkedAccount account) async {
    final provider = _c.provider(account.providerId);
    if (provider == null) return;
    await startProviderFlow(context, provider, reauthAccountId: account.id, controller: _c);
  }

  Future<void> _unlink(LinkedAccount account) async {
    final confirmed = await showFDialog<bool>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        title: const Text('Unlink account?'),
        body: Text('${account.title} will be removed and its data disappears from the app.'),
        actions: [
          FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          FButton(onPress: () => Navigator.of(ctx).pop(true), child: const Text('Unlink')),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _c.unlink(account);
    } catch (e) {
      ToastService.error("Couldn't unlink the account", e);
    }
  }

  Future<void> _manage(LinkedAccount account) async {
    final action = await showFDialog<String>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        title: Text(account.title),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            if (account.canReauth || account.status == LinkedAccountStatus.expired) FTile(prefix: const Icon(FIcons.refreshCw), title: const Text('Sign in again'), onPress: () => Navigator.of(ctx).pop('reauth')),
            FTile(prefix: const Icon(FIcons.trash2), title: const Text('Unlink'), onPress: () => Navigator.of(ctx).pop('unlink')),
          ],
        ),
        actions: [FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(), child: const Text('Close'))],
      ),
    );
    if (action == 'reauth') await _reauth(account);
    if (action == 'unlink') await _unlink(account);
  }

  static String _statusText(LinkedAccount a) => switch (a.status) {
        LinkedAccountStatus.syncing => 'Syncing your data…',
        LinkedAccountStatus.expired => a.message ?? 'Sign-in expired. Sign in again.',
        LinkedAccountStatus.error => a.message ?? 'Something is wrong with this account.',
        LinkedAccountStatus.ok => a.message ?? '',
      };

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FScaffold(
      header: FHeader.nested(title: const Text('Schools & accounts'), prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())]),
      child: ListenableBuilder(
        listenable: _c,
        builder: (context, _) {
          final groups = _c.groupedByProvider();
          return ListView(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 24 + MediaQuery.viewPaddingOf(context).bottom),
            children: [
              if (_c.syncing) const SyncingBanner(),
              if (_c.error != null && !_c.loaded)
                Padding(padding: const EdgeInsets.only(bottom: 12), child: Text("Couldn't load your accounts. ${_c.error}", style: context.theme.typography.sm.copyWith(color: colors.destructive))),
              if (!_c.loaded && _c.loading) const Padding(padding: EdgeInsets.all(24), child: Center(child: FCircularProgress())),
              for (final entry in groups.entries) ...[
                SectionLabel(entry.key),
                for (final a in entry.value)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FTile(
                      prefix: Icon(switch (a.status) {
                        LinkedAccountStatus.ok => FIcons.circleCheck,
                        LinkedAccountStatus.syncing => FIcons.refreshCw,
                        _ => FIcons.circleAlert,
                      }, color: a.status == LinkedAccountStatus.expired || a.status == LinkedAccountStatus.error ? colors.destructive : null),
                      title: Text(a.isProviderError ? "Couldn't load ${a.providerName} accounts" : a.title),
                      subtitle: Text([
                        if (a.detail != null) a.detail!,
                        if (_statusText(a).isNotEmpty) _statusText(a),
                        if (a.capabilities.isNotEmpty) a.capabilities.map((c) => c.label).join(', '),
                      ].join('\n')),
                      suffix: a.isProviderError ? null : const Icon(FIcons.ellipsis),
                      onPress: a.isProviderError ? null : () => _manage(a),
                    ),
                  ),
                const SizedBox(height: 12),
              ],
              if (_c.loaded && groups.isEmpty) Padding(padding: const EdgeInsets.only(bottom: 16), child: Text('No accounts linked yet.', style: context.theme.typography.sm.copyWith(color: colors.mutedForeground))),
              const SectionLabel('Add'),
              for (final p in _c.providers)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FTile(
                    prefix: Icon(providerIcon(p)),
                    title: Text(p.displayName),
                    subtitle: p.description == null ? null : Text(p.description!),
                    suffix: const Icon(FIcons.plus),
                    onPress: () => startProviderFlow(context, p, controller: _c),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Small muted uppercase label above a list.
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text.toUpperCase(), style: context.theme.typography.xs.copyWith(color: c.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}

/// "Syncing your data…" shown wherever school data is still on its way in.
class SyncingBanner extends StatelessWidget {
  const SyncingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FTile(prefix: const SizedBox(width: 20, height: 20, child: FCircularProgress()), title: const Text('Syncing your data…'), subtitle: const Text('Your school data appears here as soon as it arrives.')),
    );
  }
}
