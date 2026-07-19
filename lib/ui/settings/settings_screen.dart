import 'package:flutter/material.dart' show showLicensePage, ThemeMode;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/backend_config.dart';
import '../../config/oidc_config.dart';
import '../../services/active_account_service.dart';
import '../../services/app_mode_service.dart';
import '../../services/auth_service.dart';
import '../../services/private_account_store.dart';
import '../../services/school_data_service.dart';
import '../../services/theme_service.dart';

/// App settings: appearance, the backend server, and open-source licenses.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final server = BackendConfig.isCustom ? BackendConfig.url : 'Schuly Cloud';

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Settings'),
        prefixes: [
          FHeaderAction.back(onPress: () => Navigator.of(context).pop()),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Only account mode has a Schuly (Keycloak) identity to manage; private
          // mode keeps everything on-device with no account.
          if (!AppModeService.instance.isPrivate) ...[
            FTileGroup(
              label: const Text('Account'),
              children: [
                FTile(
                  prefix: const Icon(FIcons.circleUser),
                  title: const Text('Manage account'),
                  subtitle: const Text('Profile, password & security'),
                  suffix: const Icon(FIcons.externalLink),
                  onPress: _openAccountConsole,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
          AnimatedBuilder(
            animation: ThemeService.instance,
            builder: (context, _) => FSelectTileGroup<ThemeMode>(
              label: const Text('Appearance'),
              control: FMultiValueControl.managedRadio(
                initial: ThemeService.instance.mode,
                onChange: (selected) {
                  if (selected.isNotEmpty) {
                    ThemeService.instance.setMode(selected.first);
                  }
                },
              ),
              children: const [
                FSelectTile(value: ThemeMode.system, title: Text('System')),
                FSelectTile(value: ThemeMode.light, title: Text('Light')),
                FSelectTile(value: ThemeMode.dark, title: Text('Dark')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FTileGroup(
            label: const Text('Server'),
            children: [
              FTile(
                prefix: const Icon(FIcons.server),
                title: const Text('Backend server'),
                subtitle: Text(server),
                suffix: const Icon(FIcons.chevronRight),
                onPress: _openServerDialog,
              ),
            ],
          ),
          const SizedBox(height: 20),
          FTileGroup(
            label: const Text('About'),
            children: [
              FTile(
                prefix: const Icon(FIcons.fileText),
                title: const Text('Open-source licenses'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () => showLicensePage(
                  context: context,
                  applicationName: 'Schuly',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Opens the identity provider's account console (Keycloak's `/account`) in the
  /// external browser, where the user manages their profile, password and
  /// sign-in security. The authority is discovered at runtime, never hardcoded.
  Future<void> _openAccountConsole() async {
    Uri? url;
    try {
      final cfg = await OidcConfig.settings();
      url = Uri.parse('${cfg.authority}/account');
    } catch (_) {
      url = null;
    }
    if (!mounted) return;
    if (url == null || !await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        showFToast(context: context, title: const Text("Couldn't open the account page"));
      }
    }
  }

  Future<void> _openServerDialog() async {
    final changed = await showFDialog<bool>(
      context: context,
      builder: (ctx, style, animation) => _ServerDialog(animation: animation),
    );
    if (changed != true || !mounted) return;
    // The session was cleared while switching backends; drop back to the root
    // gate, which re-evaluates against the new server.
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

/// Lets the user point the app at the hosted Schuly Cloud or a self-hosted
/// backend. Saving re-points the HTTP clients, clears the OIDC cache, and signs
/// out - a session and its data belong to one backend. Pops `true` on success.
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
    // Live-update the insecure-URL warning as the user types.
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
        setState(() => _error = 'Enter a valid http(s) URL.');
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
          _error = "Couldn't reach a Schuly backend at this URL.";
        });
        return;
      }
      url = raw;
    } else {
      if (!BackendConfig.isCustom) {
        // Already on hosted - nothing to change.
        Navigator.of(context).pop(false);
        return;
      }
      setState(() => _busy = true);
    }

    await BackendConfig.setUrl(url);
    // The HTTP clients re-point themselves at BackendConfig.url per request; just
    // reset the cached OIDC settings so the new backend's authority is re-fetched.
    OidcConfig.reset();
    // Drop the now wrong-backend session + cached data.
    await AuthService.signOut();
    await PrivateAccountStore.instance.clear();
    await ActiveAccountService.instance.clear();
    SchoolDataService.instance.clear();
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    Widget option(String label, String sub, bool selected, VoidCallback onTap) {
      return GestureDetector(
        onTap: _busy ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                selected ? FIcons.circleCheck : FIcons.circle,
                size: 20,
                color: selected ? colors.primary : colors.mutedForeground,
              ),
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
      title: const Text('Backend server'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          option('Schuly Cloud', 'The official Schuly server', !_custom,
              () => setState(() {
                    _custom = false;
                    _error = null;
                  })),
          option('Self-hosted', 'Your own Schuly backend', _custom,
              () => setState(() => _custom = true)),
          if (_custom) ...[
            const SizedBox(height: 10),
            FTextField(
              control: FTextFieldControl.managed(controller: _urlCtrl),
              label: const Text('Backend URL'),
              hint: 'https://schuly.example.com',
              autocorrect: false,
            ),
            if (BackendConfig.isInsecure(_urlCtrl.text)) ...[
              const SizedBox(height: 6),
              Text(
                'Plaintext http:// - your login would be sent unencrypted. Use https:// unless this is a trusted local network.',
                style: typography.xs.copyWith(color: colors.error),
              ),
            ],
          ],
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: typography.sm.copyWith(color: colors.error)),
          ],
          const SizedBox(height: 12),
          Text('Changing the server signs you out.',
              style: typography.xs.copyWith(color: colors.mutedForeground)),
        ],
      ),
      actions: [
        FButton(
          style: FButtonStyle.outline(),
          onPress: _busy ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FButton(
          onPress: _busy ? null : _save,
          child: Text(_busy ? 'Checking...' : 'Save'),
        ),
      ],
    );
  }
}
