import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';

({String label, Color color, IconData icon}) entryStyle(BuildContext context, AgendaEntryType type) {
  final colors = context.theme.colors;
  final t = AppLocalizations.of(context)!;
  switch (type) {
    case AgendaEntryType.test:
      return (label: t.entryTypeTest, color: const Color(0xFFEF4444), icon: FIcons.clipboardList);
    case AgendaEntryType.event:
      return (label: t.entryTypeEvent, color: const Color(0xFF22C55E), icon: FIcons.calendarHeart);
    case AgendaEntryType.holiday:
      return (label: t.entryTypeHoliday, color: const Color(0xFFF59E0B), icon: FIcons.treePalm);
    case AgendaEntryType.lesson:
    default:
      return (label: t.entryTypeLesson, color: colors.primary, icon: FIcons.bookOpen);
  }
}

class EntryTypeBadge extends StatelessWidget {
  final String label;
  final Color color;
  const EntryTypeBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
      );
}
