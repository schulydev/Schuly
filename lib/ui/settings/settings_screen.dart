import 'package:flutter/material.dart' show MaterialPageRoute, showLicensePage, ThemeMode;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/backend_config.dart';
import '../../l10n/app_localizations.dart';
import '../../services/active_account_service.dart';
import '../../services/app_mode_service.dart';
import '../../services/auth_service.dart';
import '../../services/private_account_store.dart';
import '../../services/profile_refresh_requests.dart';
import '../../services/school_data_service.dart';
import '../linking/schools_accounts_screen.dart';
import '../../services/theme_service.dart';
import 'notification_settings_section.dart';
import 'privacy_settings_section.dart';
import 'update_settings_section.dart';
import 'accent_wheel.dart';
import 'settings_card.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final typography = context.theme.typography;
    final colors = context.theme.colors;
    final server = BackendConfig.isCustom ? BackendConfig.url : t.serverCloud;
    final isPrivate = AppModeService.instance.isPrivate;

    return SubPage(
      backLabel: t.tabAccount,
      title: t.settingsTitle,
      children: [
        const _AppearanceCard(),
        const NotificationSettingsSection(),
        if (!isPrivate)
          SettingsCard(
            title: t.settingsSecurity,
            description: t.settingsSecurityDetail,
            children: [
              FTile(
                title: Text(t.settingsManageAccount),
                subtitle: Text(t.settingsManageAccountDetail),
                suffix: FButton(style: FButtonStyle.outline(), mainAxisSize: MainAxisSize.min, onPress: _openAccountConsole, child: Text(t.settingsOpen)),
                onPress: _openAccountConsole,
              ),
              FTile(
                title: Text(t.settingsProfilePicture),
                subtitle: Text(t.settingsProfilePictureDetail),
                suffix: FButton(style: FButtonStyle.outline(), mainAxisSize: MainAxisSize.min, onPress: _openProfilePicture, child: Text(t.settingsChange)),
                onPress: _openProfilePicture,
              ),
              FTile(
                title: Text(t.accountsTitle),
                subtitle: Text(t.settingsAccountsDetail),
                suffix: chevron(),
                onPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SchoolsAccountsScreen())),
              ),
            ],
          ),
        SettingsCard(
          title: t.settingsServer,
          children: [
            FTile(
              title: Text(t.settingsBackend),
              subtitle: Text(server),
              suffix: FButton(style: FButtonStyle.outline(), mainAxisSize: MainAxisSize.min, onPress: _openServerDialog, child: Text(t.settingsChange)),
              onPress: _openServerDialog,
            ),
            FTile(
              title: Text(t.settingsLicences),
              suffix: chevron(),
              onPress: () => showLicensePage(context: context, applicationName: t.appTitle),
            ),
          ],
        ),
        const UpdateSettingsSection(),
        const PrivacySettingsSection(),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Text(t.trademarkNotice, style: typography.xs.copyWith(color: colors.mutedForeground)),
        ),
      ],
    );
  }

  Future<void> _openAccountConsole() async {
    final url = Uri.parse('${BackendConfig.url}/settings');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        showFToast(context: context, title: Text(AppLocalizations.of(context)!.settingsOpenFailed));
      }
    }
  }

  Future<void> _openProfilePicture() async {
    final url = Uri.parse('${BackendConfig.url}/settings');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        showFToast(context: context, title: Text(AppLocalizations.of(context)!.settingsOpenFailed));
      }
      return;
    }
    ProfileRefreshRequests.request();
  }

  Future<void> _openServerDialog() async {
    final changed = await showFDialog<bool>(
      context: context,
      builder: (ctx, style, animation) => _ServerDialog(animation: animation),
    );
    if (changed != true || !mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

class _ServerDialog extends StatefulWidget {
  final Animation<double> animation;
  const _ServerDialog({required this.animation});

  @override
  State<_ServerDialog> createState() => _ServerDialogState();
}

class _ServerDialogState extends State<_ServerDialog> {
  bool _custom = BackendConfig.isCustom;
  late final _urlCtrl =
      TextEditingController(text: BackendConfig.isCustom ? BackendConfig.url : '');
  String? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _urlCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_busy) return;
    String? url; // null = hosted
    if (_custom) {
      final raw = _urlCtrl.text.trim();
      final uri = Uri.tryParse(raw);
      final valid = raw.isNotEmpty &&
          uri != null &&
          (uri.isScheme('http') || uri.isScheme('https')) &&
          uri.host.isNotEmpty;
      if (!valid) {
        setState(() => _error = AppLocalizations.of(context)!.serverInvalidUrl);
        return;
      }
      if (BackendConfig.isInsecure(raw)) {
        setState(() => _error = null);
        return;
      }
      setState(() {
        _busy = true;
        _error = null;
      });
      final version = await BackendConfig.probe(raw);
      if (!mounted) return;
      if (version == null) {
        setState(() {
          _busy = false;
          _error = AppLocalizations.of(context)!.serverUnreachable;
        });
        return;
      }
      url = raw;
    } else {
      if (!BackendConfig.isCustom) {
        Navigator.of(context).pop(false);
        return;
      }
      setState(() => _busy = true);
    }

    await AuthService.signOut();
    await BackendConfig.setUrl(url);
    await PrivateAccountStore.instance.clear();
    await ActiveAccountService.instance.clear();
    SchoolDataService.instance.clear();
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final t = AppLocalizations.of(context)!;

    Widget option(String label, String sub, bool selected, VoidCallback onTap) {
      return GestureDetector(
        onTap: _busy ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FRadio(value: selected, onChange: _busy ? null : (_) => onTap()),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(sub,
                        style: typography.xs
                            .copyWith(color: colors.mutedForeground)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FDialog(
      animation: widget.animation,
      title: Text(t.settingsBackend),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          option(t.serverCloud, t.serverCloudDetail, !_custom,
              () => setState(() {
                    _custom = false;
                    _error = null;
                  })),
          option(t.serverSelfHosted, t.serverSelfHostedDetail, _custom,
              () => setState(() => _custom = true)),
          if (_custom) ...[
            const SizedBox(height: 10),
            FTextField(
              control: FTextFieldControl.managed(controller: _urlCtrl),
              label: Text(t.serverUrl),
              hint: 'https://schuly.example.com',
              autocorrect: false,
            ),
            if (BackendConfig.isInsecure(_urlCtrl.text)) ...[
              const SizedBox(height: 6),
              Text(
                t.serverHttps,
                style: typography.xs.copyWith(color: colors.destructive),
              ),
            ],
          ],
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: typography.sm.copyWith(color: colors.error)),
          ],
          const SizedBox(height: 12),
          Text(t.serverSignsOut,
              style: typography.xs.copyWith(color: colors.mutedForeground)),
        ],
      ),
      actions: [
        FButton(
          style: FButtonStyle.outline(),
          onPress: _busy ? null : () => Navigator.of(context).pop(false),
          child: Text(t.cancel),
        ),
        FButton(
          onPress: _busy ? null : _save,
          child: Text(_busy ? t.serverChecking : t.save),
        ),
      ],
    );
  }
}

/// Appearance: the six accent swatches, the colour wheel, and System, Light or Dark.
class _AppearanceCard extends StatelessWidget {
  const _AppearanceCard();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final typography = context.theme.typography;
    final colors = context.theme.colors;
    return AnimatedBuilder(
      animation: ThemeService.instance,
      builder: (context, _) {
        final svc = ThemeService.instance;
        final brightness = colors.brightness;
        return SettingsCard(
          title: t.settingsAppearance,
          description: t.settingsAppearanceDetail,
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final a in AppAccent.presets) AccentSwatch(accent: a, brightness: brightness, selected: a == svc.accent, label: accentName(t, a), onPress: () => svc.setAccent(a)),
                    RainbowSwatch(selected: svc.accent == AppAccent.custom, label: t.accentCustom, onPress: () => showAccentWheel(context)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: '${t.settingsAccent} · '),
                  TextSpan(text: accentName(t, svc.accent), style: TextStyle(color: colors.foreground, fontWeight: FontWeight.w500)),
                ]), style: typography.sm.copyWith(color: colors.mutedForeground)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Segmented<ThemeMode>(
                  value: svc.mode,
                  onChange: svc.setMode,
                  segments: [(ThemeMode.system, t.settingsThemeSystem), (ThemeMode.light, t.settingsThemeLight), (ThemeMode.dark, t.settingsThemeDark)],
                ),
              ),
            ],
          ),
          children: const [],
        );
      },
    );
  }
}

String accentName(AppLocalizations t, AppAccent a) => switch (a) {
      AppAccent.zinc => t.accentZinc,
      AppAccent.blue => t.accentBlue,
      AppAccent.violet => t.accentViolet,
      AppAccent.green => t.accentGreen,
      AppAccent.orange => t.accentOrange,
      AppAccent.rose => t.accentRose,
      AppAccent.custom => t.accentCustom,
    };

/// One accent colour: a filled circle, ringed with a check mark when chosen.
class AccentSwatch extends StatelessWidget {
  const AccentSwatch({super.key, required this.accent, required this.brightness, required this.selected, required this.label, required this.onPress});

  final AppAccent accent;
  final Brightness brightness;
  final bool selected;
  final String label;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final c = accent.swatch(brightness);
    return FTappable(
      onPress: onPress,
      selected: selected,
      semanticsLabel: label,
      builder: (context, states, _) => SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
              boxShadow: selected
                  ? [BoxShadow(color: c, spreadRadius: 4), BoxShadow(color: context.tokens.card, spreadRadius: 2)]
                  : [BoxShadow(color: context.theme.colors.foreground.withValues(alpha: 0.12), spreadRadius: 1)],
            ),
            child: selected ? Icon(FIcons.check, size: 14, color: accent.swatchCheck(brightness)) : null,
          ),
        ),
      ),
    );
  }
}
