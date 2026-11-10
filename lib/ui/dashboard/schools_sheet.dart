import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../domain/my_school.dart';
import '../../l10n/app_localizations.dart';
import '../../services/active_account_service.dart';
import '../../services/app_mode_service.dart';
import '../../services/linked_accounts_controller.dart';
import '../../services/school_data_service.dart';
import '../../services/toast_service.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/auth_image.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';
import '../linking/schools_accounts_screen.dart';
import 'tab_requests.dart';

/// The Schools sheet, opened from the school name at the top of every tab: switches which school the tabs show.
/// It replaces the old side drawer.
Future<void> openSchoolsSheet(BuildContext context) {
  final navigator = Navigator.of(context);
  return showSchulySheet<void>(context, builder: (_) => _SchoolsSheet(parentNavigator: navigator));
}

class _SchoolsSheet extends StatelessWidget {
  const _SchoolsSheet({required this.parentNavigator});

  final NavigatorState parentNavigator;

  Future<void> _confirmRemove(BuildContext context, MySchool school) async {
    final t = AppLocalizations.of(context)!;
    final confirmed = await showFDialog<bool>(
      context: context,
      builder: (dCtx, style, animation) => FDialog(
        animation: animation,
        title: Text(t.schoolDisconnectTitle),
        body: Text(t.schoolDisconnectBody(school.name)),
        actions: [
          FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(dCtx).pop(false), child: Text(t.cancel)),
          FButton(style: FButtonStyle.destructive(), onPress: () => Navigator.of(dCtx).pop(true), child: Text(t.schoolDisconnect)),
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
      ToastService.error(t.schoolDisconnectFailed, e);
    }
  }

  void _manage(BuildContext context) {
    Navigator.of(context).pop();
    TabRequests.request(DashboardTab.account);
    parentNavigator.push(MaterialPageRoute(builder: (_) => const SchoolsAccountsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final typography = context.theme.typography;
    final colors = context.theme.colors;
    if (AppModeService.instance.isPrivate) {
      return SchulySheet(
        title: t.schoolsTitle,
        action: t.done,
        body: Text(t.schoolsPrivateNote, style: typography.sm.copyWith(color: colors.mutedForeground)),
      );
    }
    return ListenableBuilder(
      listenable: ActiveAccountService.instance,
      builder: (context, _) {
        final svc = ActiveAccountService.instance;
        final active = svc.active;
        return SchulySheet(
          title: t.schoolsTitle,
          subtitle: t.schoolsSubtitle,
          action: t.done,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (svc.schools.isNotEmpty)
                FTileGroup(
                  divider: FItemDivider.full,
                  children: [
                    for (final s in svc.schools)
                      FTile(
                        prefix: _SchoolLogo(school: s),
                        title: Text(s.name),
                        subtitle: (s.fullName?.isNotEmpty ?? false) ? Text(s.fullName!) : null,
                        suffix: FRadio(value: s.id == active?.id, onChange: (_) => _pick(context, s)),
                        onPress: () => _pick(context, s),
                        onLongPress: () => _confirmRemove(context, s),
                      ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(t.schoolsNote, style: typography.xs.copyWith(color: colors.mutedForeground)),
              ),
            ],
          ),
          footer: FButton(style: blockButton(FButtonStyle.outline), onPress: () => _manage(context), child: Text(t.schoolsManage)),
        );
      },
    );
  }

  Future<void> _pick(BuildContext context, MySchool s) async {
    await ActiveAccountService.instance.setActive(s.id);
    if (context.mounted) Navigator.of(context).pop();
  }
}

/// The school's logo, or the profile picture the school holds, in a rounded square.
class _SchoolLogo extends StatelessWidget {
  const _SchoolLogo({required this.school});

  final MySchool school;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final initials = school.name.trim().isEmpty ? '?' : school.name.trim().characters.take(2).toString().toUpperCase();
    final fallback = Center(child: Text(initials, style: context.theme.typography.base.copyWith(fontWeight: FontWeight.w600)));
    Widget network(String? url) => url == null || url.isEmpty ? fallback : Image(image: AuthImage(url), fit: BoxFit.cover, errorBuilder: (_, _, _) => fallback);
    if (school.profilePictureUrl?.isNotEmpty == true) return Avatar(url: school.profilePictureUrl, name: school.name, size: 40);
    return Container(
      width: 40,
      height: 40,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(SchulyRadii.base)),
      child: school.schoolSystemKey != null
          ? Padding(padding: const EdgeInsets.all(7), child: Image.asset('assets/schoolsystems/${school.schoolSystemKey}.webp', fit: BoxFit.contain, errorBuilder: (_, _, _) => network(school.logoUrl)))
          : network(school.logoUrl),
    );
  }
}
