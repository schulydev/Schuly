import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Date and time labels in the app's language.
class Dates {
  Dates(BuildContext context) : locale = Localizations.localeOf(context).languageCode;

  final String locale;

  bool get _de => locale == 'de';

  /// "Tue" / "Di"
  String weekdayShort(DateTime d) => DateFormat.E(locale).format(d).replaceAll('.', '');

  /// "Tuesday, 10 November" / "Dienstag, 10. November"
  String dayLong(DateTime d) => DateFormat(_de ? 'EEEE, d. MMMM' : 'EEEE, d MMMM', locale).format(d);

  /// "November 2026"
  String monthYear(DateTime d) => DateFormat.yMMMM(locale).format(d);

  /// "03.11."
  String dayMonth(DateTime d) => DateFormat('dd.MM.').format(d);

  /// "03.11.2026"
  String full(DateTime d) => DateFormat('dd.MM.yyyy').format(d);

  /// "Tue, 03.11." / "Di, 03.11."
  String weekdayDayMonth(DateTime d) => '${weekdayShort(d)}, ${dayMonth(d)}';

  /// "09:41"
  String hm(DateTime d) => DateFormat('HH:mm').format(d);
}

DateTime dayOf(DateTime d) {
  final l = d.toLocal();
  return DateTime(l.year, l.month, l.day);
}

bool sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

/// Monday of the week [d] is in.
DateTime mondayOf(DateTime d) => DateTime(d.year, d.month, d.day - (d.weekday - 1));

/// The ISO 8601 week number.
int isoWeek(DateTime d) {
  final thursday = DateTime.utc(d.year, d.month, d.day + (4 - d.weekday));
  final jan4 = DateTime.utc(thursday.year, 1, 4);
  final week1Monday = DateTime.utc(jan4.year, jan4.month, jan4.day - (jan4.weekday - 1));
  return 1 + (thursday.difference(week1Monday).inDays ~/ 7);
}
