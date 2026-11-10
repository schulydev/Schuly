import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../../services/update/release_info.dart';
import '../../services/update/required_update_service.dart';
import '../../services/update/update_service.dart';
import '../core/ui/kit.dart';
import 'update_dialog.dart';

/// Shows [child], the whole app, unless the server says this version is too old: then only [RequiredUpdateScreen].
class RequiredUpdateGate extends StatelessWidget {
  const RequiredUpdateGate({super.key, required this.child, this.service});

  final Widget child;
  final RequiredUpdateService? service;

  @override
  Widget build(BuildContext context) {
    final svc = service ?? RequiredUpdateService.instance;
    return ListenableBuilder(
      listenable: svc,
      // Its own navigator, so the update dialog has somewhere to open while the app's navigator is gone.
      builder: (context, _) => svc.blocked
          ? Navigator(onGenerateRoute: (_) => MaterialPageRoute<void>(builder: (_) => RequiredUpdateScreen(service: svc)))
          : child,
    );
  }
}

/// "Please update Schuly": this version no longer works with the server. No way past it but updating, or the
/// server letting this version in again.
class RequiredUpdateScreen extends StatefulWidget {
  const RequiredUpdateScreen({super.key, this.service, this.updates});

  final RequiredUpdateService? service;
  final UpdateService? updates;

  @override
  State<RequiredUpdateScreen> createState() => _RequiredUpdateScreenState();
}

class _RequiredUpdateScreenState extends State<RequiredUpdateScreen> {
  RequiredUpdateService get _service => widget.service ?? RequiredUpdateService.instance;
  UpdateService get _updates => widget.updates ?? UpdateService.instance;

  bool _updating = false;
  String? _note;

  /// The in-app install when there is one (Android), else the release page the update dialog also links to.
  Future<void> _update() async {
    setState(() {
      _updating = true;
      _note = null;
    });
    try {
      final result = await _updates.check();
      if (!mounted) return;
      if (result is UpdateAvailable && _updates.canInstallInApp && result.release.apk != null) {
        await showFDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (ctx, style, animation) => UpdateDialog(animation: animation, release: result.release, service: _updates),
        );
      } else {
        final page = result is UpdateAvailable ? result.release.pageUrl : Uri.parse('https://github.com/$updateRepo/releases/latest');
        await launchUrl(page, mode: LaunchMode.externalApplication);
      }
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  Future<void> _recheck() async {
    final t = AppLocalizations.of(context)!;
    setState(() => _note = null);
    final ok = await _service.check();
    if (!mounted || ok == true) return;
    setState(() => _note = ok == null ? t.requiredUpdateCheckFailed : t.requiredUpdateStillTooOld);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final required = _service.requiredVersion ?? '';
    final installed = _service.installedVersion;
    return PopScope(
      canPop: false,
      child: ListenableBuilder(
        listenable: _service,
        builder: (context, _) => FScaffold(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(t.requiredUpdateTitle, style: typography.xl2.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.52)),
                    const SizedBox(height: 8),
                    Text(t.requiredUpdateBody, style: typography.base.copyWith(color: colors.mutedForeground)),
                    const SizedBox(height: 20),
                    FTileGroup(
                      divider: FItemDivider.full,
                      children: [
                        keyValueTile(context, t.requiredUpdateInstalled, installed.isEmpty ? t.updateUnknown : installed),
                        keyValueTile(context, t.requiredUpdateRequired, required.isEmpty ? t.updateUnknown : t.requiredUpdateAtLeast(required)),
                      ],
                    ),
                    if (_note != null) ...[
                      const SizedBox(height: 12),
                      Text(_note!, style: typography.sm.copyWith(color: colors.destructive)),
                    ],
                    const SizedBox(height: 20),
                    FButton(
                      style: blockButton(FButtonStyle.primary),
                      onPress: _updating ? null : _update,
                      child: Text(t.requiredUpdateUpdate),
                    ),
                    const SizedBox(height: 10),
                    FButton(
                      style: blockButton(FButtonStyle.outline),
                      onPress: _service.checking ? null : _recheck,
                      child: Text(t.requiredUpdateRecheck),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
