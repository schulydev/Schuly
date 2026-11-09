import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../../services/linked_accounts_controller.dart';
import '../../services/linking_service.dart';
import '../../services/school_data_service.dart';
import '../../services/toast_service.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import 'add_account_flow.dart';

/// "Schools & accounts": every linked account grouped by provider, with its status, Sync or Sign in, and unlink
/// behind a tap. All of it comes from `/api/linking`.
class SchoolsAccountsScreen extends StatefulWidget {
  final LinkedAccountsController? controller;
  const SchoolsAccountsScreen({this.controller, super.key});

  @override
  State<SchoolsAccountsScreen> createState() => _SchoolsAccountsScreenState();
}

class _SchoolsAccountsScreenState extends State<SchoolsAccountsScreen> {
  LinkedAccountsController get _c => widget.controller ?? LinkedAccountsController.instance;
  final Set<String> _syncing = {};

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

  /// The school a linked account feeds, when it has a plugin sync endpoint.
  ({String accountId, String basePath})? _syncTarget(LinkedAccount account) {
    for (final s in ActiveAccountService.instance.schools) {
      if (s.pluginAccountId == account.id && s.pluginBasePath?.isNotEmpty == true) return (accountId: account.id, basePath: s.pluginBasePath!);
    }
    return null;
  }

  Future<void> _sync(LinkedAccount account) async {
    final t = AppLocalizations.of(context)!;
    final target = _syncTarget(account);
    if (target == null) return;
    setState(() => _syncing.add(account.key));
    try {
      await ApiClient.instance.dio.post<dynamic>('${target.basePath}/accounts/${target.accountId}/sync', options: ApiClient.handled());
      await SchoolDataService.instance.refresh();
      await _c.reloadAccounts();
      ToastService.success(t.accountsSyncDone, t.accountsSyncDoneDetail);
    } catch (e) {
      ToastService.error(t.accountsSyncFailed, e);
    } finally {
      if (mounted) setState(() => _syncing.remove(account.key));
    }
  }

  Future<void> _unlink(LinkedAccount account) async {
    final t = AppLocalizations.of(context)!;
    final confirmed = await showFDialog<bool>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        title: Text(t.accountsUnlinkTitle),
        body: Text(t.accountsUnlinkBody(account.title)),
        actions: [
          FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(false), child: Text(t.cancel)),
          FButton(style: FButtonStyle.destructive(), onPress: () => Navigator.of(ctx).pop(true), child: Text(t.accountsUnlink)),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _c.unlink(account);
    } catch (e) {
      ToastService.error(t.accountsUnlinkFailed, e);
    }
  }

  Future<void> _manage(LinkedAccount account) async {
    final t = AppLocalizations.of(context)!;
    final action = await showFDialog<String>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        title: Text(account.title),
        body: FTileGroup(
          divider: FItemDivider.full,
          children: [
            if (account.canReauth || account.status == LinkedAccountStatus.expired) FTile(title: Text(t.accountsSignInAgain), suffix: chevron(), onPress: () => Navigator.of(ctx).pop('reauth')),
            FTile(title: Text(t.accountsUnlink, style: TextStyle(color: ctx.theme.colors.destructive)), onPress: () => Navigator.of(ctx).pop('unlink')),
          ],
        ),
        actions: [FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(), child: Text(t.close))],
      ),
    );
    if (action == 'reauth') await _reauth(account);
    if (action == 'unlink') await _unlink(account);
  }

  static String _ago(AppLocalizations t, DateTime when) {
    final d = DateTime.now().difference(when.toLocal());
    if (d.inMinutes < 1) return t.agoJustNow;
    if (d.inMinutes < 60) return t.agoMinutes(d.inMinutes);
    if (d.inHours < 24) return t.agoHours(d.inHours);
    final l = when.toLocal();
    return '${l.day}.${l.month}.${l.year}';
  }

  Widget? _status(AppLocalizations t, LinkedAccount a) {
    final tokens = context.tokens;
    final colors = context.theme.colors;
    return switch (a.status) {
      LinkedAccountStatus.syncing => StatusLabel(t.accountsSyncing, color: colors.mutedForeground, dot: tokens.ink),
      LinkedAccountStatus.expired => StatusLabel(a.message ?? t.accountsExpired, color: tokens.warn),
      LinkedAccountStatus.error => StatusLabel(a.message ?? t.accountsError, color: tokens.bad),
      LinkedAccountStatus.ok => a.lastSyncedAt != null
          ? StatusLabel(t.accountsSynced(_ago(t, a.lastSyncedAt!)), color: colors.mutedForeground, dot: tokens.good)
          : (a.message?.isNotEmpty == true ? StatusLabel(a.message!, color: colors.mutedForeground, dot: tokens.good) : null),
    };
  }

  Widget? _action(AppLocalizations t, LinkedAccount a) {
    if (a.isProviderError) return null;
    final needsSignIn = a.status == LinkedAccountStatus.expired || a.status == LinkedAccountStatus.error;
    if (needsSignIn && (a.canReauth || a.status == LinkedAccountStatus.expired)) {
      return FButton(style: FButtonStyle.primary(), mainAxisSize: MainAxisSize.min, onPress: () => _reauth(a), child: Text(t.accountsSignIn));
    }
    if (_syncTarget(a) != null) {
      final busy = _syncing.contains(a.key);
      return FButton(
        style: FButtonStyle.outline(),
        mainAxisSize: MainAxisSize.min,
        onPress: busy || a.status == LinkedAccountStatus.syncing ? null : () => _sync(a),
        child: Text(busy ? t.accountsSyncingShort : t.accountsSync),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return ListenableBuilder(
      listenable: _c,
      builder: (context, _) {
        final groups = _c.groupedByProvider();
        return SubPage(
          backLabel: t.tabAccount,
          title: t.accountsTitle,
          action: FButton(style: FButtonStyle.outline(), mainAxisSize: MainAxisSize.min, onPress: () => runAddAccountFlow(context, controller: _c), child: Text(t.accountsAdd)),
          onRefresh: _c.reloadAccounts,
          children: [
            if (_c.syncing) const SyncingBanner(),
            if (_c.error != null && !_c.loaded) Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(t.accountsLoadFailed('${_c.error}'), style: typography.sm.copyWith(color: colors.destructive))),
            if (!_c.loaded && _c.loading) const Padding(padding: EdgeInsets.all(24), child: Center(child: FCircularProgress())),
            for (final (i, entry) in groups.entries.indexed) ...[
              Padding(padding: EdgeInsets.only(top: i == 0 ? 0 : 16, bottom: 8), child: _ProviderHead(name: entry.key, provider: _c.provider(entry.value.first.providerId))),
              FTileGroup(
                divider: FItemDivider.full,
                children: [
                  for (final a in entry.value)
                    FTile(
                      title: Text(a.isProviderError ? t.accountsProviderFailed(a.providerName) : a.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (a.detail?.isNotEmpty == true) Text(a.detail!),
                          if (_status(t, a) case final status?) Padding(padding: const EdgeInsets.only(top: 2), child: status),
                        ],
                      ),
                      suffix: _action(t, a),
                      onPress: a.isProviderError ? null : () => _manage(a),
                    ),
                ],
              ),
            ],
            if (_c.loaded && groups.isEmpty) EmptyNote(t.accountsEmpty),
            Padding(padding: const EdgeInsets.only(top: 12), child: Text(t.accountsNote, style: typography.xs.copyWith(color: colors.mutedForeground))),
          ],
        );
      },
    );
  }
}

/// A provider's initial, name and what it gives Schuly.
class _ProviderHead extends StatelessWidget {
  const _ProviderHead({required this.name, required this.provider});

  final String name;
  final LinkProvider? provider;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final caps = provider?.capabilities.map((c) => c.label).join(', ');
    final sub = provider?.description?.isNotEmpty == true ? provider!.description! : caps;
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(SchulyRadii.md)),
          child: Text(name.isEmpty ? '?' : name.characters.first.toUpperCase(), style: typography.xs.copyWith(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: typography.base.copyWith(fontWeight: FontWeight.w600)),
              if (sub?.isNotEmpty == true) Text(sub!, style: typography.xs.copyWith(color: colors.mutedForeground)),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Syncing your data…" shown wherever school data is still on its way in.
class SyncingBanner extends StatelessWidget {
  const SyncingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FTile(
        prefix: const SizedBox(width: 20, height: 20, child: FCircularProgress()),
        title: Text(t.accountsSyncing),
        subtitle: Text(t.accountsSyncingDetail),
      ),
    );
  }
}
