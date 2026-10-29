import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/absence_reporting_service.dart';
import 'package:schuly/services/private_account_store.dart';

DioException _error(int status, [Object? body]) {
  final req = RequestOptions(path: '/x');
  return DioException(requestOptions: req, response: Response(requestOptions: req, statusCode: status, data: body));
}

void main() {
  group('AbsenceDraft', () {
    final day = DateTime(2026, 11, 7);

    test('builds the request body and drops empty optionals', () {
      final draft = AbsenceDraft(dateFrom: day, dateTo: DateTime(2026, 11, 8), hourFrom: '08:00', hourTo: '09:30', reason: '  Sick ', comment: '   ');
      expect(draft.toJson(), {'dateFrom': '2026-11-07', 'dateTo': '2026-11-08', 'hourFrom': '08:00', 'hourTo': '09:30', 'reason': 'Sick'});
      expect(AbsenceDraft(dateFrom: day, dateTo: day).toJson(), {'dateFrom': '2026-11-07', 'dateTo': '2026-11-07'});
    });

    test('formats single digits with padding', () {
      expect(AbsenceDraft.formatDate(DateTime(2026, 1, 5)), '2026-01-05');
      expect(AbsenceDraft.formatTime(8, 5), '08:05');
    });

    test('requires a typed reason only for a custom reason', () {
      expect(AbsenceDraft(dateFrom: day, dateTo: day, customReason: true, reason: '  ').validate(), AbsenceDraftIssue.reasonRequired);
      expect(AbsenceDraft(dateFrom: day, dateTo: day, customReason: true, reason: 'Zahnarzt').validate(), isNull);
      expect(AbsenceDraft(dateFrom: day, dateTo: day, customReason: true, reason: 'x' * 501).validate(), AbsenceDraftIssue.reasonTooLong);
      expect(AbsenceDraft(dateFrom: day, dateTo: day).validate(), isNull);
    });

    test('offers the six Schulnetz reasons', () {
      expect(absenceReasons, ['Krankheit', 'Unfall', 'Militär', 'gültiges Arztzeugnis für Sport', 'Andere Absenz', 'Urlaubsgesuch']);
    });

    test('accepts a valid draft', () {
      expect(AbsenceDraft(dateFrom: day, dateTo: day).validate(), isNull);
      expect(AbsenceDraft(dateFrom: day, dateTo: day, hourFrom: '08:00', hourTo: '09:30').validate(), isNull);
    });

    test('rejects an end date before the start date', () {
      expect(AbsenceDraft(dateFrom: day, dateTo: DateTime(2026, 11, 6)).validate(), AbsenceDraftIssue.endBeforeStart);
    });

    test('needs both times or none', () {
      expect(AbsenceDraft(dateFrom: day, dateTo: day, hourFrom: '08:00').validate(), AbsenceDraftIssue.timesIncomplete);
      expect(AbsenceDraft(dateFrom: day, dateTo: day, hourTo: '08:00').validate(), AbsenceDraftIssue.timesIncomplete);
    });

    test('on a single day the end must be after the start, across days it need not be', () {
      expect(AbsenceDraft(dateFrom: day, dateTo: day, hourFrom: '09:00', hourTo: '09:00').validate(), AbsenceDraftIssue.timeEndNotAfterStart);
      expect(AbsenceDraft(dateFrom: day, dateTo: day, hourFrom: '10:00', hourTo: '09:00').validate(), AbsenceDraftIssue.timeEndNotAfterStart);
      expect(AbsenceDraft(dateFrom: day, dateTo: DateTime(2026, 11, 8), hourFrom: '10:00', hourTo: '09:00').validate(), isNull);
    });

    test('limits reason and comment to 500 characters', () {
      expect(AbsenceDraft(dateFrom: day, dateTo: day, reason: 'a' * 500).validate(), isNull);
      expect(AbsenceDraft(dateFrom: day, dateTo: day, reason: 'a' * 501).validate(), AbsenceDraftIssue.reasonTooLong);
      expect(AbsenceDraft(dateFrom: day, dateTo: day, comment: 'a' * 501).validate(), AbsenceDraftIssue.commentTooLong);
    });
  });

  group('AbsenceReportException.fromDio', () {
    AbsenceReportErrorKind kind(DioException e) => AbsenceReportException.fromDio(e).kind;

    test('maps the backend error codes', () {
      expect(kind(_error(400, {'code': 'invalid_request', 'message': 'x'})), AbsenceReportErrorKind.invalidRequest);
      expect(kind(_error(400, {'code': 'schulnetz_rejected', 'message': 'x'})), AbsenceReportErrorKind.schulnetzRejected);
      expect(kind(_error(400, {'code': 'not_withdrawable'})), AbsenceReportErrorKind.notWithdrawable);
      expect(kind(_error(403, {'code': 'absence_reporting_not_allowed'})), AbsenceReportErrorKind.notAllowed);
      expect(kind(_error(409, {'code': 'schulnetz_signin_expired'})), AbsenceReportErrorKind.signInExpired);
      expect(kind(_error(502, {'code': 'schulnetz_unavailable'})), AbsenceReportErrorKind.schoolUnavailable);
    });

    test('keeps the school message and trims it', () {
      final e = AbsenceReportException.fromDio(_error(400, {'code': 'schulnetz_rejected', 'message': '  Too late. '}));
      expect(e.serverMessage, 'Too late.');
      expect(AbsenceReportException.fromDio(_error(400, {'code': 'invalid_request', 'message': ' '})).serverMessage, isNull);
    });

    test('treats a bare 404 as the plugin lacking the endpoints', () {
      expect(kind(_error(404)), AbsenceReportErrorKind.notAvailable);
    });

    test('falls back on the status when there is no code', () {
      expect(kind(_error(502, '<html>')), AbsenceReportErrorKind.schoolUnavailable);
      expect(kind(_error(500)), AbsenceReportErrorKind.other);
    });

    test('a failure without a response is a network error', () {
      final e = DioException(requestOptions: RequestOptions(path: '/x'));
      expect(kind(e), AbsenceReportErrorKind.network);
    });
  });

  group('ReportedAbsence.fromJson', () {
    test('parses a full report', () {
      final r = ReportedAbsence.fromJson({
        'ids': ['w5bA', 'mwy2'],
        'dateFrom': '2026-11-07',
        'dateTo': '2026-11-07',
        'hourFrom': '08:00',
        'hourTo': '09:30',
        'reason': 'Sick',
        'comment': null,
        'profiles': ['INEFZ21-A', 'BM1TALS15'],
        'reportedAt': '2026-10-29T09:34:37',
      });
      expect(r.ids, ['w5bA', 'mwy2']);
      expect(r.dateFrom, DateTime(2026, 11, 7));
      expect(r.hourFrom, '08:00');
      expect(r.comment, isNull);
      expect(r.profiles, hasLength(2));
      expect(r.reportedAt, DateTime(2026, 10, 29, 9, 34, 37));
    });

    test('tolerates a whole-day report without optionals', () {
      final r = ReportedAbsence.fromJson({'ids': ['a'], 'dateFrom': '2026-11-07', 'dateTo': '2026-11-09', 'profiles': []});
      expect(r.hourFrom, isNull);
      expect(r.reportedAt, isNull);
      expect(r.dateTo, DateTime(2026, 11, 9));
    });
  });

  group('AbsenceReportTarget', () {
    test('account mode uses the plugin account route', () {
      const t = AbsenceReportTarget.account(basePath: '/api/plugins/schulware', accountId: 'acc1');
      expect(t.isPrivate, isFalse);
      expect(t.absencesPath, '/api/plugins/schulware/accounts/acc1/absences');
    });

    test('private mode uses the stateless route from the catalog', () {
      const t = AbsenceReportTarget.private(PrivateAccount(
        systemKey: 'schulnetz',
        loginMethod: 'oauth-webview',
        baseUrl: 'https://schulnetz.example.ch',
        displayName: 'School',
        statelessBasePath: '/api/plugins/schulware/stateless',
        accessToken: 'tok',
      ));
      expect(t.isPrivate, isTrue);
      expect(t.absencesPath, '/api/plugins/schulware/stateless/absences');
    });
  });
}
