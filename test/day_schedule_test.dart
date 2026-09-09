import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/ui/timetable/day_schedule.dart';
import 'package:schuly_api/schuly_api.dart';

AgendaEntryDto _entry({
  required DateTime date,
  DateTime? endDate,
  String title = 'Math',
  AgendaEntryType type = AgendaEntryType.lesson,
}) {
  return AgendaEntryDto((b) => b
    ..entryType = type
    ..title = title
    ..date = date
    ..endDate = endDate);
}

void main() {
  group('buildDaySchedule breaks', () {
    test('no break for a 4-minute gap', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
      final b = _entry(date: DateTime(2026, 1, 5, 8, 49));
      final items = buildDaySchedule([a, b]);
      expect(items.whereType<BreakItem>(), isEmpty);
    });

    test('break for exactly a 5-minute gap', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
      final b = _entry(date: DateTime(2026, 1, 5, 8, 50));
      final items = buildDaySchedule([a, b]);
      expect(items.whereType<BreakItem>(), hasLength(1));
      expect(items.whereType<BreakItem>().first.minutes, 5);
    });

    test('break for a mid-value gap (15 minutes)', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
      final b = _entry(date: DateTime(2026, 1, 5, 9));
      final items = buildDaySchedule([a, b]);
      expect(items.whereType<BreakItem>(), hasLength(1));
      expect(items.whereType<BreakItem>().first.minutes, 15);
    });

    test('the break lands between the two lessons in the returned order', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
      final b = _entry(date: DateTime(2026, 1, 5, 9));
      final items = buildDaySchedule([a, b]);
      expect(items, [isA<LessonItem>(), isA<BreakItem>(), isA<LessonItem>()]);
      final firstLesson = items[0] as LessonItem;
      final gapBreak = items[1] as BreakItem;
      final secondLesson = items[2] as LessonItem;
      expect(gapBreak.start, firstLesson.end);
      expect(gapBreak.end, secondLesson.start);
    });

    test('break for exactly a 120-minute gap', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
      final b = _entry(date: DateTime(2026, 1, 5, 10, 45));
      final items = buildDaySchedule([a, b]);
      expect(items.whereType<BreakItem>(), hasLength(1));
      expect(items.whereType<BreakItem>().first.minutes, 120);
    });

    test('no break for a 121-minute gap', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
      final b = _entry(date: DateTime(2026, 1, 5, 10, 46));
      final items = buildDaySchedule([a, b]);
      expect(items.whereType<BreakItem>(), isEmpty);
    });

    test('no break for a zero/negative gap (overlapping entries)', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 9));
      final b = _entry(date: DateTime(2026, 1, 5, 8, 30));
      final items = buildDaySchedule([a, b]);
      expect(items.whereType<BreakItem>(), isEmpty);
    });

    test('withBreaks: false yields no breaks', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
      final b = _entry(date: DateTime(2026, 1, 5, 9));
      final items = buildDaySchedule([a, b], withBreaks: false);
      expect(items.whereType<BreakItem>(), isEmpty);
      expect(items, hasLength(2));
    });
  });

  group('buildDaySchedule ordering', () {
    test('entries are sorted by start regardless of input order', () {
      final early = _entry(date: DateTime(2026, 1, 5, 8), title: 'Early');
      final late = _entry(date: DateTime(2026, 1, 5, 10), title: 'Late');
      final mid = _entry(date: DateTime(2026, 1, 5, 9), title: 'Mid');
      final items = buildDaySchedule([late, early, mid], withBreaks: false).cast<LessonItem>();
      expect(items.map((i) => i.entry.title).toList(), ['Early', 'Mid', 'Late']);
    });

    test('does not mutate the caller-supplied list', () {
      final early = _entry(date: DateTime(2026, 1, 5, 8), title: 'Early');
      final late = _entry(date: DateTime(2026, 1, 5, 10), title: 'Late');
      final input = [late, early];
      buildDaySchedule(input);
      expect(input[0].title, 'Late');
      expect(input[1].title, 'Early');
    });
  });

  group('fallback lesson duration', () {
    test('an entry without endDate has hasEndTime false and a 45-minute fallback end', () {
      final start = DateTime(2026, 1, 5, 8);
      final entry = _entry(date: start);
      final item = LessonItem(entry);
      expect(item.hasEndTime, isFalse);
      expect(item.end, start.add(kFallbackLessonDuration));
    });

    test('the gap to the next entry is measured from the fallback end', () {
      final a = _entry(date: DateTime(2026, 1, 5, 8)); // no endDate -> ends 08:45
      final b = _entry(date: DateTime(2026, 1, 5, 9)); // gap of exactly 15 minutes from fallback end
      final items = buildDaySchedule([a, b]);
      expect(items.whereType<BreakItem>(), hasLength(1));
      expect(items.whereType<BreakItem>().first.minutes, 15);
    });
  });

  group('current-lesson detection', () {
    final entry = _entry(date: DateTime(2026, 1, 5, 8), endDate: DateTime(2026, 1, 5, 8, 45));
    final item = LessonItem(entry);

    test('isCurrentAt is true at exactly start', () {
      expect(item.isCurrentAt(item.start), isTrue);
    });

    test('isCurrentAt is true mid-lesson', () {
      expect(item.isCurrentAt(item.start.add(const Duration(minutes: 20))), isTrue);
    });

    test('isCurrentAt is false at exactly end', () {
      expect(item.isCurrentAt(item.end), isFalse);
    });

    test('isCurrentAt is false before start', () {
      expect(item.isCurrentAt(item.start.subtract(const Duration(minutes: 1))), isFalse);
    });

    test('isCurrentAt is false after end', () {
      expect(item.isCurrentAt(item.end.add(const Duration(minutes: 1))), isFalse);
    });

    test('currentItem picks the right item', () {
      final other = _entry(date: DateTime(2026, 1, 5, 9), endDate: DateTime(2026, 1, 5, 9, 45));
      final items = buildDaySchedule([entry, other], withBreaks: false);
      final now = DateTime(2026, 1, 5, 9, 10);
      final current = currentItem(items, now);
      expect(current, isA<LessonItem>());
      expect((current as LessonItem).entry.date, other.date);
    });

    test('currentItem returns null when nothing is current', () {
      final items = buildDaySchedule([entry], withBreaks: false);
      final now = DateTime(2026, 1, 5, 12);
      expect(currentItem(items, now), isNull);
    });
  });

  group('lunch detection', () {
    test('a 45-minute 11:45-12:30 break is lunch', () {
      final b = BreakItem(start: DateTime(2026, 1, 5, 11, 45), end: DateTime(2026, 1, 5, 12, 30));
      expect(b.isLunch, isTrue);
    });

    test('a 15-minute 11:45-12:00 break is not lunch (too short)', () {
      final b = BreakItem(start: DateTime(2026, 1, 5, 11, 45), end: DateTime(2026, 1, 5, 12, 0));
      expect(b.isLunch, isFalse);
    });

    test('a 45-minute 09:00-09:45 break is not lunch (outside window)', () {
      final b = BreakItem(start: DateTime(2026, 1, 5, 9), end: DateTime(2026, 1, 5, 9, 45));
      expect(b.isLunch, isFalse);
    });

    test('a break ending after 13:30 is not lunch', () {
      final b = BreakItem(start: DateTime(2026, 1, 5, 12, 50), end: DateTime(2026, 1, 5, 13, 35));
      expect(b.isLunch, isFalse);
    });
  });

  group('toLocal handling', () {
    test('a UTC DateTime produces a local, non-UTC start at the expected instant', () {
      final utc = DateTime.utc(2026, 1, 5, 8);
      final entry = _entry(date: utc);
      final item = LessonItem(entry);
      expect(item.start.isUtc, isFalse);
      expect(item.start, utc.toLocal());
    });
  });
}
