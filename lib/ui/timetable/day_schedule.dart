import 'package:schuly_api/schuly_api.dart';

const Duration kFallbackLessonDuration = Duration(minutes: 45);
const int kMinBreakMinutes = 5;
const int kMaxBreakMinutes = 120;
const int kMinLunchBreakMinutes = 30;

sealed class DayItem {
  DateTime get start;
  DateTime get end;

  bool isCurrentAt(DateTime now) => !now.isBefore(start) && now.isBefore(end);

  Duration remainingAt(DateTime now) => end.difference(now);

  // Only meaningful while isCurrentAt(now) is true, in which case now < end
  // already guarantees the ceiling is at least 1 minute.
  int remainingMinutesAt(DateTime now) => (remainingAt(now).inSeconds / 60).ceil();
}

final class LessonItem extends DayItem {
  LessonItem(this.entry);

  final AgendaEntryDto entry;

  @override
  DateTime get start => entry.date.toLocal();

  bool get hasEndTime => entry.endDate != null;

  @override
  // Entries without a server-provided end time still need a layout end point;
  // 45 minutes is a reasonable default lesson length, not a real schedule fact.
  DateTime get end => hasEndTime ? entry.endDate!.toLocal() : start.add(kFallbackLessonDuration);
}

final class BreakItem extends DayItem {
  BreakItem({required this.start, required this.end});

  @override
  final DateTime start;

  @override
  final DateTime end;

  int get minutes => end.difference(start).inMinutes;

  bool get isLunch {
    if (minutes < kMinLunchBreakMinutes) return false;
    const windowStart = 11 * 60;
    const windowEnd = 13 * 60 + 30;
    final startMinuteOfDay = start.hour * 60 + start.minute;
    final endMinuteOfDay = end.hour * 60 + end.minute;
    return startMinuteOfDay >= windowStart && endMinuteOfDay <= windowEnd;
  }
}

List<DayItem> buildDaySchedule(List<AgendaEntryDto> entries, {bool withBreaks = true}) {
  final sorted = List<AgendaEntryDto>.of(entries)
    ..sort((a, b) => a.date.toLocal().compareTo(b.date.toLocal()));

  final items = <DayItem>[];
  DateTime? previousEnd;
  for (final entry in sorted) {
    final lesson = LessonItem(entry);
    if (withBreaks && previousEnd != null) {
      final gapMinutes = lesson.start.difference(previousEnd).inMinutes;
      if (gapMinutes >= kMinBreakMinutes && gapMinutes <= kMaxBreakMinutes) {
        items.add(BreakItem(start: previousEnd, end: lesson.start));
      }
    }
    items.add(lesson);
    previousEnd = lesson.end;
  }
  return items;
}

DayItem? currentItem(List<DayItem> items, DateTime now) {
  for (final item in items) {
    if (item.isCurrentAt(now)) return item;
  }
  return null;
}

String formatHm(DateTime d) {
  final h = d.hour.toString().padLeft(2, '0');
  final m = d.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

final RegExp _shortCodeSuffix = RegExp(r'\s*\([A-Za-z]{2,6}\)\s*$');

// The API's description field appends a trailing teacher short code, e.g.
// "Bachofner Manuel (BaMa)". Strip it for display; leave anything else as is.
String stripShortCode(String s) => s.replaceFirst(_shortCodeSuffix, '');
