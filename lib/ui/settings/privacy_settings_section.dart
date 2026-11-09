import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/app_localizations.dart';
import '../../services/api_client.dart';
import '../../services/app_mode_service.dart';
import '../../services/toast_service.dart';
import '../core/ui/kit.dart';
import '../core/ui/root_screen.dart';
import 'settings_card.dart';

const _handled = <String, dynamic>{ApiClient.handlesErrors: true};

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
      final res = await ApiClient.instance.api.getAuthApi().apiAuthMeExportGet(extra: _handled);
      final data = res.data;
      if (data == null) throw StateError('Account export response had no body');
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/schuly-export-${_stamp(DateTime.now())}.json');
      await file.writeAsString(jsonEncode(standardSerializers.serializeWith(AccountExportDto.serializer, data)));
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    } catch (e) {
      if (mounted) ToastService.error(AppLocalizations.of(context)!.exportDataFailed, e);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _delete() async {
    final password = await showFDialog<String>(
      context: context,
      builder: (ctx, style, animation) => _DeleteAccountDialog(animation: animation),
    );
    if (password == null || !mounted) return;
    try {
      await ApiClient.instance.api.getAuthApi().apiAuthMeDelete(deleteAccountRequest: DeleteAccountRequest((b) => b.password = password.isEmpty ? null : password), extra: _handled);
      await signOutAndClear();
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (mounted) ToastService.error(AppLocalizations.of(context)!.deleteAccountFailed, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (AppModeService.instance.isPrivate) {
      return SettingsCard(
        title: t.privacySectionLabel,
        children: [FTile(title: Text(t.privacyPrivateModeTitle), subtitle: Text(t.privacyPrivateModeSubtitle))],
      );
    }
    return SettingsCard(
      title: t.settingsDangerZone,
      description: t.settingsDangerZoneDetail,
      danger: true,
      children: [
        FTile(
          title: Text(t.exportDataTitle),
          subtitle: Text(t.exportDataSubtitle),
          suffix: FButton(style: FButtonStyle.outline(), mainAxisSize: MainAxisSize.min, onPress: _exporting ? null : _export, child: Text(_exporting ? t.exporting : t.exportAction)),
          onPress: _exporting ? null : _export,
        ),
        FTile(
          title: Text(t.deleteAccountTitle),
          subtitle: Text(t.deleteAccountSubtitle),
          suffix: FButton(style: dangerOutline(context), mainAxisSize: MainAxisSize.min, onPress: _delete, child: Text(t.delete)),
          onPress: _delete,
        ),
      ],
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
  late final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _password.dispose();
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
          const SizedBox(height: 12),
          FTextField(
            control: FTextFieldControl.managed(controller: _password),
            label: Text(t.deleteAccountPasswordLabel),
            obscureText: true,
            autocorrect: false,
          ),
        ],
      ),
      actions: [
        FButton(
          style: FButtonStyle.outline(),
          onPress: () => Navigator.of(context).pop(),
          child: Text(t.deleteAccountCancel),
        ),
        FButton(
          style: FButtonStyle.destructive(),
          onPress: confirmed ? () => Navigator.of(context).pop(_password.text) : null,
          child: Text(t.deleteAccountConfirm),
        ),
      ],
    );
  }
}
