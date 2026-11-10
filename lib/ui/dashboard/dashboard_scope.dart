import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/active_account_service.dart';
import '../../services/app_mode_service.dart';
import 'schools_sheet.dart';

/// What every tab needs from the dashboard: the Schuly account's name, email and picture, the private-mode title and
/// sign-out.
class DashboardScope extends InheritedWidget {
  const DashboardScope({super.key, required this.userName, required this.userEmail, required this.pictureUrl, required this.privateTitle, required this.onSignOut, required super.child});

  final String? userName;
  final String? userEmail;
  final String? pictureUrl;
  final String? privateTitle;
  final VoidCallback onSignOut;

  static DashboardScope? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<DashboardScope>();

  @override
  bool updateShouldNotify(DashboardScope old) =>
      userName != old.userName || userEmail != old.userEmail || pictureUrl != old.pictureUrl || privateTitle != old.privateTitle || onSignOut != old.onSignOut;
}

/// The school's short name at the top of every tab. Tapping it opens the Schools sheet.
class SchoolHeader extends StatelessWidget {
  const SchoolHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return ListenableBuilder(
      listenable: ActiveAccountService.instance,
      builder: (context, _) {
        final isPrivate = AppModeService.instance.isPrivate;
        final name = isPrivate ? DashboardScope.maybeOf(context)?.privateTitle : ActiveAccountService.instance.active?.name;
        return SizedBox(
          height: 48,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FButton(
              onPress: () => openSchoolsSheet(context),
              mainAxisSize: MainAxisSize.min,
              style: FButtonStyle.ghost((s) => s.copyWith(
                    contentStyle: (c) => c.copyWith(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      spacing: 4,
                      textStyle: FWidgetStateMap.all(context.theme.typography.sm.copyWith(color: colors.mutedForeground, fontWeight: FontWeight.w500, height: 1)),
                      iconStyle: FWidgetStateMap.all(IconThemeData(color: colors.mutedForeground, size: 16)),
                    ),
                  )),
              suffix: const Icon(FIcons.chevronDown),
              child: Text(name?.isNotEmpty == true ? name! : AppLocalizations.of(context)!.appTitle),
            ),
          ),
        );
      },
    );
  }
}
