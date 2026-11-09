import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/app_mode_service.dart';
import '../../services/push_service.dart';
import 'settings_card.dart';

class NotificationSettingsSection extends StatefulWidget {
  const NotificationSettingsSection({super.key, this.service});
  final PushService? service;

  @override
  State<NotificationSettingsSection> createState() => _NotificationSettingsSectionState();
}

class _NotificationSettingsSectionState extends State<NotificationSettingsSection> {
  PushService get _service => widget.service ?? PushService.instance;

  @override
  Widget build(BuildContext context) {
    if (AppModeService.instance.isPrivate) return const SizedBox.shrink();

    final t = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _service,
      builder: (context, _) {
        final status = _service.status;
        final disabled = !_service.supported || _service.busy;

        return SettingsCard(
          title: t.notifications,
          children: [
            FTile(
              title: Text(t.pushNotifications),
              subtitle: Text(
                !_service.supported
                    ? t.pushUnavailable
                    : status == PushStatus.denied
                        ? t.pushDenied
                        : t.pushNotificationsSubtitle,
              ),
              suffix: FSwitch(
                value: status == PushStatus.on,
                enabled: !disabled,
                onChange: disabled ? null : (v) => v ? _service.enable() : _service.disable(),
              ),
            ),
            if (status == PushStatus.on) ...[
              _preference(t.notifyGrades, null, _service.preferences.grades, (v) => _service.setPreferences(_service.preferences.rebuild((b) => b..grades = v))),
              _preference(t.notifyAbsences, null, _service.preferences.absences, (v) => _service.setPreferences(_service.preferences.rebuild((b) => b..absences = v))),
              _preference(t.notifyAgenda, null, _service.preferences.agenda, (v) => _service.setPreferences(_service.preferences.rebuild((b) => b..agenda = v))),
              _preference(t.notifyGradeValue, t.notifyGradeValueSubtitle, _service.preferences.includeGradeValue, (v) => _service.setPreferences(_service.preferences.rebuild((b) => b..includeGradeValue = v))),
              _preference(t.notifyDetails, t.notifyDetailsSubtitle, _service.preferences.includeDetails, (v) => _service.setPreferences(_service.preferences.rebuild((b) => b..includeDetails = v))),
            ],
          ],
        );
      },
    );
  }

  static FTile _preference(String title, String? subtitle, bool value, ValueChanged<bool> onChange) =>
      FTile(title: Text(title), subtitle: subtitle != null ? Text(subtitle) : null, suffix: FSwitch(value: value, onChange: onChange));
}
