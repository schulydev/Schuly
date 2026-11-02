import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/update/apk_installer.dart';
import '../../services/update/release_info.dart';
import '../../services/update/update_service.dart';
import '../../services/toast_service.dart';
import '../widgets/markdown_text.dart';

/// Shows the update dialog for [release] using the app navigator. Wired up once at startup.
Future<void> showUpdateDialog(ReleaseInfo release) async {
  final context = ToastService.navigatorKey.currentContext;
  if (context == null || !context.mounted) return;
  await showFDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx, style, animation) => UpdateDialog(animation: animation, release: release),
  );
}

enum _Phase { idle, downloading, needsPermission, error }

class UpdateDialog extends StatefulWidget {
  const UpdateDialog({super.key, required this.animation, required this.release, this.service});

  final Animation<double> animation;
  final ReleaseInfo release;
  final UpdateService? service;

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  UpdateService get _service => widget.service ?? UpdateService.instance;

  _Phase _phase = _Phase.idle;
  double _progress = 0;
  bool _verifying = false;
  String? _error;
  String? _readyPath;
  CancelToken? _cancel;

  bool get _inApp => _service.canInstallInApp && widget.release.apk != null;

  @override
  void dispose() {
    _cancel?.cancel();
    super.dispose();
  }

  void _later() {
    _service.snooze(widget.release);
    Navigator.of(context).pop();
  }

  Future<void> _openReleasePage() async {
    await launchUrl(widget.release.pageUrl, mode: LaunchMode.externalApplication);
  }

  Future<void> _update() async {
    final path = _readyPath;
    if (path != null) return _install(path);

    final cancel = _cancel = CancelToken();
    setState(() {
      _phase = _Phase.downloading;
      _progress = 0;
      _verifying = false;
      _error = null;
    });
    try {
      final file = await _service.downloadAndVerify(
        widget.release,
        cancelToken: cancel,
        onProgress: (p) {
          if (!mounted) return;
          setState(() {
            _progress = p;
            _verifying = p >= 1;
          });
        },
      );
      if (!mounted) return;
      _readyPath = file;
      await _install(file);
    } on UpdateException catch (e) {
      if (mounted) {
        setState(() {
          _phase = _Phase.error;
          _error = e.message;
        });
      }
    } on DioException {
      // Cancelled by closing the dialog; nothing to show.
    }
  }

  Future<void> _install(String path) async {
    final result = await _service.install(path);
    if (!mounted) return;
    switch (result) {
      case InstallLaunch.started:
        Navigator.of(context).pop();
      case InstallLaunch.needsPermission:
        setState(() => _phase = _Phase.needsPermission);
      case InstallLaunch.failed:
        setState(() {
          _phase = _Phase.error;
          _error = "Couldn't open the installer. You can download the update from the release page instead.";
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final release = widget.release;
    final busy = _phase == _Phase.downloading;

    final Widget body = switch (_phase) {
      _Phase.downloading => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FDeterminateProgress(value: _progress),
            const SizedBox(height: 8),
            Text(
              _verifying ? 'Verifying...' : 'Downloading ${(_progress * 100).round()}%',
              style: typography.sm.copyWith(color: colors.mutedForeground),
            ),
          ],
        ),
      _Phase.needsPermission => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Android needs your permission to install apps from Schuly.', style: typography.sm),
            const SizedBox(height: 8),
            Text(
              'Tap "Open settings", switch on "Allow from this source", then come back and tap Install.',
              style: typography.sm.copyWith(color: colors.mutedForeground),
            ),
          ],
        ),
      _Phase.error => Text(_error ?? 'Something went wrong.', style: typography.sm.copyWith(color: colors.error)),
      _Phase.idle => ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 280),
          child: SingleChildScrollView(
            child: release.notes.isEmpty
                ? Text('No release notes were provided.', style: typography.sm.copyWith(color: colors.mutedForeground))
                : DefaultTextStyle.merge(
                    // FDialog centres its body; notes with lists read better left-aligned.
                    textAlign: TextAlign.start,
                    child: MarkdownText(release.notes),
                  ),
          ),
        ),
    };

    final List<Widget> actions;
    if (busy) {
      actions = [FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(context).pop(), child: const Text('Cancel'))];
    } else if (_phase == _Phase.needsPermission) {
      actions = [
        FButton(style: FButtonStyle.outline(), onPress: _later, child: const Text('Later')),
        FButton(style: FButtonStyle.outline(), onPress: _service.openInstallSettings, child: const Text('Open settings')),
        FButton(onPress: _update, child: const Text('Install')),
      ];
    } else if (_phase == _Phase.error) {
      actions = [
        FButton(style: FButtonStyle.outline(), onPress: _openReleasePage, child: const Text('Release page')),
        FButton(onPress: _inApp ? _update : () => Navigator.of(context).pop(), child: Text(_inApp ? 'Try again' : 'Close')),
      ];
    } else if (_inApp) {
      actions = [
        FButton(style: FButtonStyle.outline(), onPress: _later, child: const Text('Later')),
        FButton(onPress: _update, child: const Text('Update')),
      ];
    } else {
      // iOS (and Android without an APK): no in-app install, so point at the release page.
      actions = [
        FButton(style: FButtonStyle.outline(), onPress: _later, child: const Text('Later')),
        FButton(
          onPress: () {
            _openReleasePage();
            Navigator.of(context).pop();
          },
          child: const Text('View release'),
        ),
      ];
    }

    return FDialog(
      animation: widget.animation,
      title: Text(_inApp ? 'Update available' : 'New version available'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schuly ${release.version} is out (you have ${_service.installedVersion}).',
            style: typography.sm.copyWith(color: colors.mutedForeground),
          ),
          const SizedBox(height: 12),
          body,
        ],
      ),
      actions: actions,
    );
  }
}
