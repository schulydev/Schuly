import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/domain/private_data.dart';
import 'package:schuly/services/api_time.dart';
import 'package:schuly/services/private_data_adapter.dart';
import 'package:schuly_api/schuly_api.dart';

void main() {
  group('ApiTime.agendaEntry', () {
    test('converts a UTC date and endDate to local, preserving the instant', () {
      final utcDate = DateTime.utc(2024, 3, 1, 7, 15);
      final utcEndDate = DateTime.utc(2024, 3, 1, 8, 0);
      final entry = AgendaEntryDto((b) => b
        ..entryType = AgendaEntryType.lesson
        ..title = 'Math'
        ..date = utcDate
        ..endDate = utcEndDate);

      final result = ApiTime.agendaEntry(entry);

      expect(result.date.isUtc, isFalse);
      expect(result.date.millisecondsSinceEpoch, utcDate.millisecondsSinceEpoch);
      expect(result.date, utcDate.toLocal());

      expect(result.endDate, isNotNull);
      expect(result.endDate!.isUtc, isFalse);
      expect(result.endDate!.millisecondsSinceEpoch, utcEndDate.millisecondsSinceEpoch);
      expect(result.endDate, utcEndDate.toLocal());
    });

    test('leaves a null endDate null', () {
      final utcDate = DateTime.utc(2024, 3, 1, 7, 15);
      final entry = AgendaEntryDto((b) => b
        ..entryType = AgendaEntryType.lesson
        ..title = 'Math'
        ..date = utcDate);

      final result = ApiTime.agendaEntry(entry);

      expect(result.endDate, isNull);
    });
  });

  group('ApiTime.absence', () {
    test('converts from and until to local, preserving the instant', () {
      final utcFrom = DateTime.utc(2024, 2, 28, 23, 0);
      final utcUntil = DateTime.utc(2024, 3, 1, 23, 0);
      final absence = AbsenceDto((b) => b
        ..reason = 'Sick'
        ..type = AbsenceType.absence
        ..from = utcFrom
        ..until = utcUntil);

      final result = ApiTime.absence(absence);

      expect(result.from.isUtc, isFalse);
      expect(result.from.millisecondsSinceEpoch, utcFrom.millisecondsSinceEpoch);
      expect(result.from, utcFrom.toLocal());

      expect(result.until.isUtc, isFalse);
      expect(result.until.millisecondsSinceEpoch, utcUntil.millisecondsSinceEpoch);
      expect(result.until, utcUntil.toLocal());
    });
  });

  group('ApiTime.schoolClass', () {
    test('converts nested agenda entries', () {
      final utcDate = DateTime.utc(2024, 3, 1, 7, 15);
      final entry = AgendaEntryDto((b) => b
        ..entryType = AgendaEntryType.lesson
        ..title = 'Math'
        ..date = utcDate);
      final schoolClass = ClassDto((b) => b
        ..name = 'Class A'
        ..agenda.replace([entry]));

      final result = ApiTime.schoolClass(schoolClass);

      expect(result.agenda, isNotNull);
      expect(result.agenda!.single.date.isUtc, isFalse);
      expect(result.agenda!.single.date, utcDate.toLocal());
    });

    test('leaves a null agenda null', () {
      final schoolClass = ClassDto((b) => b..name = 'Class A');

      final result = ApiTime.schoolClass(schoolClass);

      expect(result.agenda, isNull);
    });
  });

  group('ApiTime.utcDate', () {
    test('pins a local calendar day to UTC midnight', () {
      final input = DateTime(2024, 3, 1, 13, 30);
      final result = ApiTime.utcDate(input);

      expect(result, DateTime.utc(2024, 3, 1));
      expect(result.isUtc, isTrue);
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.year, input.year);
      expect(result.month, input.month);
      expect(result.day, input.day);
    });
  });

  group('PrivateDataAdapter', () {
    test('agendaEntry produces a local, instant-preserving date', () {
      final event = PrivateAgendaEvent(
        id: '1',
        title: 'History',
        startDate: '2024-03-01T07:15:00Z',
        endDate: '2024-03-01T08:00:00Z',
      );

      final result = PrivateDataAdapter.agendaEntry(event);

      final expected = DateTime.parse('2024-03-01T07:15:00Z');
      expect(result.date.isUtc, isFalse);
      expect(result.date.millisecondsSinceEpoch, expected.millisecondsSinceEpoch);

      final expectedEnd = DateTime.parse('2024-03-01T08:00:00Z');
      expect(result.endDate!.isUtc, isFalse);
      expect(result.endDate!.millisecondsSinceEpoch, expectedEnd.millisecondsSinceEpoch);
    });

    test('absence produces local, instant-preserving from/until', () {
      final privateAbsence = PrivateAbsence(
        id: '1',
        from: '2024-03-01T00:00:00Z',
        to: '2024-03-02T00:00:00Z',
        reason: 'Sick',
      );

      final result = PrivateDataAdapter.absence(privateAbsence);

      final expectedFrom = DateTime.parse('2024-03-01T00:00:00Z');
      final expectedUntil = DateTime.parse('2024-03-02T00:00:00Z');
      expect(result.from.isUtc, isFalse);
      expect(result.from.millisecondsSinceEpoch, expectedFrom.millisecondsSinceEpoch);
      expect(result.until.isUtc, isFalse);
      expect(result.until.millisecondsSinceEpoch, expectedUntil.millisecondsSinceEpoch);
    });
  });
}
