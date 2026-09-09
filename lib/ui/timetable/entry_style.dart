import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';

({String label, IconData icon}) entryStyle(BuildContext context, AgendaEntryType type) {
  final t = AppLocalizations.of(context)!;
  switch (type) {
    case AgendaEntryType.test:
      return (label: t.entryTypeTest, icon: FIcons.clipboardList);
    case AgendaEntryType.event:
      return (label: t.entryTypeEvent, icon: FIcons.calendarHeart);
    case AgendaEntryType.holiday:
      return (label: t.entryTypeHoliday, icon: FIcons.treePalm);
    case AgendaEntryType.lesson:
    default:
      return (label: t.entryTypeLesson, icon: FIcons.bookOpen);
  }
}
