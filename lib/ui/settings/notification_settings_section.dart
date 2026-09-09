import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/app_mode_service.dart';
import '../../services/push_service.dart';

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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(t.notifications),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.bell),
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
                  onChange: disabled
                      ? null
                      : (v) => v ? _service.enable() : _service.disable(),
                ),
              ),
            ),
            if (status == PushStatus.on) ...[
              _PreferenceTile(
                icon: FIcons.chartColumn,
                title: t.notifyGrades,
                value: _service.preferences.grades,
                onChange: (v) => _service.setPreferences(_service.preferences.copyWith(grades: v)),
              ),
              _PreferenceTile(
                icon: FIcons.calendarOff,
                title: t.notifyAbsences,
                value: _service.preferences.absences,
                onChange: (v) => _service.setPreferences(_service.preferences.copyWith(absences: v)),
              ),
              _PreferenceTile(
                icon: FIcons.calendarDays,
                title: t.notifyAgenda,
                value: _service.preferences.agenda,
                onChange: (v) => _service.setPreferences(_service.preferences.copyWith(agenda: v)),
              ),
              _PreferenceTile(
                icon: FIcons.eye,
                title: t.notifyGradeValue,
                subtitle: t.notifyGradeValueSubtitle,
                value: _service.preferences.includeGradeValue,
                onChange: (v) =>
                    _service.setPreferences(_service.preferences.copyWith(includeGradeValue: v)),
              ),
            ],
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChange;
  const _PreferenceTile({required this.icon, required this.title, this.subtitle, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FTile(
          prefix: Icon(icon),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          suffix: FSwitch(value: value, onChange: onChange),
        ),
      );
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    final t = context.theme.typography;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text.toUpperCase(),
          style: t.xs.copyWith(color: c.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}
