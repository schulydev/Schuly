import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/app_localizations.dart';
import '../../services/account_api.dart';
import '../../services/app_mode_service.dart';
import '../../services/toast_service.dart';
import '../core/ui/root_screen.dart';

/// Settings section for exporting or permanently deleting the account's
/// server-side data. In private mode nothing is ever stored server-side, so
/// this renders a single explanatory tile pointing at the sign-out
/// (disconnect) action instead.
class PrivacySettingsSection extends StatefulWidget {
  const PrivacySettingsSection({super.key});

  @override
  State<PrivacySettingsSection> createState() => _PrivacySettingsSectionState();
}

class _PrivacySettingsSectionState extends State<PrivacySettingsSection> {
  bool _exporting = false;

  static String _stamp(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}';

  Future<void> _export() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final bytes = await AccountApi.exportData();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/schuly-export-${_stamp(DateTime.now())}.json');
      await file.writeAsBytes(bytes);
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    } catch (e) {
      if (mounted) ToastService.error(AppLocalizations.of(context)!.exportDataFailed, e);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _delete() async {
    final confirmed = await showFDialog<bool>(
      context: context,
      builder: (ctx, style, animation) => _DeleteAccountDialog(animation: animation),
    );
    if (confirmed != true || !mounted) return;
    try {
      await AccountApi.deleteAccount();
      await signOutAndClear();
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (mounted) ToastService.error(AppLocalizations.of(context)!.deleteAccountFailed, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              t.privacySectionLabel.toUpperCase(),
              style: typography.xs.copyWith(
                color: colors.mutedForeground,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          if (AppModeService.instance.isPrivate)
            FTile(
              prefix: const Icon(FIcons.shieldCheck),
              title: Text(t.privacyPrivateModeTitle),
              subtitle: Text(t.privacyPrivateModeSubtitle),
            )
          else ...[
            FTile(
              prefix: const Icon(FIcons.download),
              title: Text(t.exportDataTitle),
              subtitle: Text(t.exportDataSubtitle),
              suffix: _exporting ? const FCircularProgress() : null,
              onPress: _exporting ? null : _export,
            ),
            const SizedBox(height: 8),
            FTile(
              prefix: Icon(FIcons.trash2, color: colors.destructive),
              title: Text(t.deleteAccountTitle, style: TextStyle(color: colors.destructive)),
              subtitle: Text(t.deleteAccountSubtitle),
              onPress: _delete,
            ),
          ],
        ],
      ),
    );
  }
}

class _DeleteAccountDialog extends StatefulWidget {
  final Animation<double> animation;
  const _DeleteAccountDialog({required this.animation});

  @override
  State<_DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<_DeleteAccountDialog> {
  late final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final confirmed = _ctrl.text.trim() == 'DELETE';

    return FDialog(
      animation: widget.animation,
      title: Text(t.deleteAccountDialogTitle),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.deleteAccountDialogBody),
          const SizedBox(height: 12),
          FTextField(
            control: FTextFieldControl.managed(controller: _ctrl),
            label: Text(t.deleteAccountConfirmLabel),
            hint: 'DELETE',
            autocorrect: false,
          ),
        ],
      ),
      actions: [
        FButton(
          style: FButtonStyle.outline(),
          onPress: () => Navigator.of(context).pop(false),
          child: Text(t.deleteAccountCancel),
        ),
        FButton(
          style: FButtonStyle.destructive(),
          onPress: confirmed ? () => Navigator.of(context).pop(true) : null,
          child: Text(t.deleteAccountConfirm),
        ),
      ],
    );
  }
}
