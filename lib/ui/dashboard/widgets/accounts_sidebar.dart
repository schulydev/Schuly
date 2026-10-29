import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../domain/my_school.dart';
import '../../../services/active_account_service.dart';
import '../../../services/app_mode_service.dart';
import '../../../services/school_data_service.dart';
import '../../../services/toast_service.dart';
import '../../authenticator/authenticator_vault_screen.dart';
import '../../settings/settings_screen.dart';
import '../../../services/linked_accounts_controller.dart';
import '../../linking/add_account_flow.dart';
import '../../linking/schools_accounts_screen.dart';

class AccountsSidebar extends StatelessWidget {
  final NavigatorState parentNavigator;
  final VoidCallback? onSignOut;
  final String? userName;
  final String? userEmail;
  final String? pictureUrl;

  const AccountsSidebar({
    super.key,
    required this.parentNavigator,
    this.onSignOut,
    this.userName,
    this.userEmail,
    this.pictureUrl,
  });

  Future<void> _confirmRemove(BuildContext context, MySchool school) async {
    final confirmed = await showFDialog<bool>(
      context: context,
      builder: (dCtx, style, animation) => FDialog(
        animation: animation,
        title: const Text('Disconnect school'),
        body: Text('Remove ${school.name}? You can reconnect it later.'),
        actions: [
          FButton(
            onPress: () => Navigator.of(dCtx).pop(false),
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () => Navigator.of(dCtx).pop(true),
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      final controller = LinkedAccountsController.instance;
      if (!controller.loaded) await controller.load();
      final matches = controller.accounts.where((a) => a.id == school.pluginAccountId);
      if (matches.isNotEmpty) {
        await controller.unlink(matches.first);
      } else {
        await ActiveAccountService.instance.removeSchool(school);
        await SchoolDataService.instance.clearCache();
        await controller.reloadAccounts();
        await SchoolDataService.instance.refresh();
      }
    } catch (e) {
      ToastService.error('Disconnect failed', e);
    }
  }

  Future<void> _add(BuildContext context) async {
    final result = await runAddAccountFlow(context);
    if (result == null) return;
    if (context.mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(right: BorderSide(color: colors.border)),
      ),
      child: AnimatedBuilder(
        animation: ActiveAccountService.instance,
        builder: (context, _) {
          final svc = ActiveAccountService.instance;
          final active = svc.active;
          final isPrivate = AppModeService.instance.isPrivate;

          final viewPadding = MediaQuery.viewPaddingOf(context);
          return Padding(
            padding: EdgeInsets.only(
              top: viewPadding.top,
              bottom: viewPadding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _IdentityHeader(
                  name: userName,
                  email: userEmail,
                  pictureUrl: pictureUrl,
                ),
                FDivider(style: (s) => s.copyWith(padding: EdgeInsets.zero)),
                if (!isPrivate)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
                    child: Text(
                      'Schools'.toUpperCase(),
                      style: typography.xs.copyWith(
                        color: colors.mutedForeground,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                Expanded(
                  child: isPrivate
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              'Private mode - your data stays on this device.',
                              textAlign: TextAlign.center,
                              style: typography.sm
                                  .copyWith(color: colors.mutedForeground),
                            ),
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          children: [
                            for (final s in svc.schools)
                              FTile(
                                prefix: _SchoolAvatar(logoUrl: s.logoUrl, systemKey: s.schoolSystemKey),
                                title: Text(s.name),
                                subtitle: (s.fullName?.isNotEmpty ?? false)
                                    ? Text(s.fullName!)
                                    : (s.email?.isNotEmpty ?? false)
                                        ? Text(s.email!)
                                        : null,
                                suffix: s.id == active?.id
                                    ? Icon(FIcons.check, color: colors.primary)
                                    : null,
                                onPress: () async {
                                  await svc.setActive(s.id);
                                  if (context.mounted) {
                                    Navigator.of(context).maybePop();
                                  }
                                },
                                onLongPress: () => _confirmRemove(context, s),
                              ),
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!isPrivate) ...[
                        FTile(
                          prefix: const Icon(FIcons.plus),
                          title: const Text('Add school account'),
                          onPress: () => _add(context),
                        ),
                        const SizedBox(height: 4),
                      ],
                      if (!isPrivate) ...[
                        FTile(
                          prefix: const Icon(FIcons.link),
                          title: const Text('Schools & accounts'),
                          onPress: () {
                            Navigator.of(context).maybePop();
                            parentNavigator.push(MaterialPageRoute(builder: (_) => const SchoolsAccountsScreen()));
                          },
                        ),
                        const SizedBox(height: 4),
                      ],
                      FTile(
                        prefix: const Icon(FIcons.keyRound),
                        title: const Text('Authenticator'),
                        onPress: () {
                          Navigator.of(context).maybePop();
                          parentNavigator.push(MaterialPageRoute(
                              builder: (_) => const AuthenticatorVaultScreen()));
                        },
                      ),
                      const SizedBox(height: 4),
                      FTile(
                        prefix: const Icon(FIcons.settings),
                        title: const Text('Settings'),
                        onPress: () {
                          Navigator.of(context).maybePop();
                          parentNavigator.push(MaterialPageRoute(
                              builder: (_) => const SettingsScreen()));
                        },
                      ),
                      if (onSignOut != null) ...[
                        const SizedBox(height: 4),
                        FTile(
                          prefix: const Icon(FIcons.logOut),
                          title: const Text('Sign out'),
                          onPress: () {
                            Navigator.of(context).maybePop();
                            onSignOut!();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SchoolAvatar extends StatelessWidget {
  static const double size = 40;
  final String? logoUrl;
  final String? systemKey;
  const _SchoolAvatar({required this.logoUrl, this.systemKey});

  Widget _network(Widget fallback) => logoUrl == null ? fallback : Image.network(logoUrl!, fit: BoxFit.contain, errorBuilder: (_, _, _) => fallback);

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fallback =
        Icon(Icons.school, size: 22, color: colors.mutedForeground);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(7),
      child: systemKey != null
          ? Image.asset('assets/schoolsystems/$systemKey.webp', fit: BoxFit.contain, errorBuilder: (_, _, _) => _network(fallback))
          : _network(fallback),
    );
  }
}

class _IdentityHeader extends StatelessWidget {
  final String? name;
  final String? email;
  final String? pictureUrl;
  const _IdentityHeader({this.name, this.email, this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final displayName = (name?.isNotEmpty ?? false) ? name! : 'Signed in';
    final initial = displayName.characters.first.toUpperCase();
    final fallback = Text(
      initial,
      style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w600),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          (pictureUrl == null || pictureUrl!.isEmpty)
              ? FAvatar.raw(size: 48, child: fallback)
              : FAvatar(size: 48, image: NetworkImage(pictureUrl!), fallback: fallback),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayName,
                  style: typography.base.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                if (email?.isNotEmpty ?? false)
                  Text(
                    email!,
                    style: typography.sm.copyWith(color: colors.mutedForeground),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> openAccountsSidebar(
  BuildContext context, {
  VoidCallback? onSignOut,
  String? userName,
  String? userEmail,
  String? pictureUrl,
}) {
  final parentNavigator = Navigator.of(context);
  return showFSheet<void>(
    context: context,
    side: FLayout.ltr,
    mainAxisMaxRatio: 0.78,
    builder: (sheetCtx) => AccountsSidebar(
      parentNavigator: parentNavigator,
      onSignOut: onSignOut,
      userName: userName,
      userEmail: userEmail,
      pictureUrl: pictureUrl,
    ),
  );
}
