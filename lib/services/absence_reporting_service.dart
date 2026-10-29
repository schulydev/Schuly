import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../domain/my_school.dart';
import 'active_account_service.dart';
import 'api_client.dart';
import 'private_account_store.dart';
import 'token_proxy_client.dart';

/// Catalog key of the school system whose absences can be reported to the school.
const schulnetzSystemKey = 'schulnetz';

/// Longest reason or comment the school accepts.
const absenceTextLimit = 500;

enum AbsenceDraftIssue { endBeforeStart, timesIncomplete, timeEndNotAfterStart, reasonRequired, reasonTooLong, commentTooLong }

/// What the student fills in to report an absence to the school.
class AbsenceDraft {
  final DateTime dateFrom;
  final DateTime dateTo;
  final String? hourFrom;
  final String? hourTo;
  final String reason;
  final String comment;

  /// True when [reason] is free text the student typed ("Other..."), which must then not be empty.
  final bool customReason;

  const AbsenceDraft({required this.dateFrom, required this.dateTo, this.hourFrom, this.hourTo, this.reason = '', this.comment = '', this.customReason = false});

  static String formatDate(DateTime d) => '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String formatTime(int hour, int minute) => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// The same rules the server applies, so the form can say what is wrong before sending.
  AbsenceDraftIssue? validate() {
    final from = DateTime(dateFrom.year, dateFrom.month, dateFrom.day);
    final to = DateTime(dateTo.year, dateTo.month, dateTo.day);
    if (to.isBefore(from)) return AbsenceDraftIssue.endBeforeStart;
    if ((hourFrom == null) != (hourTo == null)) return AbsenceDraftIssue.timesIncomplete;
    // Zero-padded HH:mm compares correctly as text.
    if (hourFrom != null && hourTo != null && to == from && hourTo!.compareTo(hourFrom!) <= 0) return AbsenceDraftIssue.timeEndNotAfterStart;
    if (customReason && reason.trim().isEmpty) return AbsenceDraftIssue.reasonRequired;
    if (reason.trim().length > absenceTextLimit) return AbsenceDraftIssue.reasonTooLong;
    if (comment.trim().length > absenceTextLimit) return AbsenceDraftIssue.commentTooLong;
    return null;
  }

  Map<String, dynamic> toJson() {
    final reason = this.reason.trim();
    final comment = this.comment.trim();
    return {
      'dateFrom': formatDate(dateFrom),
      'dateTo': formatDate(dateTo),
      if (hourFrom != null) 'hourFrom': hourFrom,
      if (hourTo != null) 'hourTo': hourTo,
      if (reason.isNotEmpty) 'reason': reason,
      if (comment.isNotEmpty) 'comment': comment,
    };
  }
}

/// A report the school has not processed yet; [ids] has one entry per class it was created for.
class ReportedAbsence {
  final List<String> ids;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String? hourFrom;
  final String? hourTo;
  final String? reason;
  final String? comment;
  final List<String> profiles;
  final DateTime? reportedAt;

  const ReportedAbsence({required this.ids, required this.dateFrom, required this.dateTo, this.hourFrom, this.hourTo, this.reason, this.comment, this.profiles = const [], this.reportedAt});

  factory ReportedAbsence.fromJson(Map<String, dynamic> j) => ReportedAbsence(
        ids: [for (final id in (j['ids'] as List<dynamic>? ?? const [])) id.toString()],
        dateFrom: DateTime.parse(j['dateFrom'] as String),
        dateTo: DateTime.parse((j['dateTo'] ?? j['dateFrom']) as String),
        hourFrom: j['hourFrom'] as String?,
        hourTo: j['hourTo'] as String?,
        reason: j['reason'] as String?,
        comment: j['comment'] as String?,
        profiles: [for (final p in (j['profiles'] as List<dynamic>? ?? const [])) p.toString()],
        reportedAt: j['reportedAt'] == null ? null : DateTime.tryParse(j['reportedAt'] as String),
      );
}

enum AbsenceReportErrorKind { invalidRequest, schulnetzRejected, notWithdrawable, notAllowed, signInExpired, schoolUnavailable, notAvailable, network, other }

/// A failed call to the school-reporting endpoints, reduced to something the UI can word.
class AbsenceReportException implements Exception {
  final AbsenceReportErrorKind kind;

  /// The message the server sent; for [AbsenceReportErrorKind.schulnetzRejected] this is the school's own wording.
  final String? serverMessage;

  const AbsenceReportException(this.kind, [this.serverMessage]);

  /// Reads the backend's `{ "code", "message" }` error body, falling back to the status code.
  factory AbsenceReportException.fromDio(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final code = data is Map ? data['code'] as String? : null;
    final message = data is Map && data['message'] is String ? (data['message'] as String).trim() : null;
    final text = message == null || message.isEmpty ? null : message;
    if (status == null) return const AbsenceReportException(AbsenceReportErrorKind.network);
    final kind = switch (code) {
      'invalid_request' => AbsenceReportErrorKind.invalidRequest,
      'schulnetz_rejected' => AbsenceReportErrorKind.schulnetzRejected,
      'not_withdrawable' => AbsenceReportErrorKind.notWithdrawable,
      'absence_reporting_not_allowed' => AbsenceReportErrorKind.notAllowed,
      'schulnetz_signin_expired' => AbsenceReportErrorKind.signInExpired,
      'schulnetz_unavailable' => AbsenceReportErrorKind.schoolUnavailable,
      _ => switch (status) {
          404 => AbsenceReportErrorKind.notAvailable,
          502 || 503 || 504 => AbsenceReportErrorKind.schoolUnavailable,
          _ => AbsenceReportErrorKind.other,
        },
    };
    return AbsenceReportException(kind, text);
  }

  @override
  String toString() => 'AbsenceReportException($kind, $serverMessage)';
}

/// Where absence reports for the current school connection go.
class AbsenceReportTarget {
  /// Account mode: the plugin base path and the connected account.
  final String? basePath;
  final String? accountId;

  /// Private mode: the device-held Schulnetz account.
  final PrivateAccount? privateAccount;

  const AbsenceReportTarget.account({required String this.basePath, required String this.accountId}) : privateAccount = null;
  const AbsenceReportTarget.private(PrivateAccount this.privateAccount)
      : basePath = null,
        accountId = null;

  bool get isPrivate => privateAccount != null;

  /// Path of the absences collection, relative to the backend.
  String get absencesPath => isPrivate ? '${privateAccount!.statelessBasePath}/absences' : '$basePath/accounts/$accountId/absences';
}

/// Reports absences to the school (Schulnetz) and lists the reports it has not processed yet.
class AbsenceReportingService {
  AbsenceReportingService._() : _fetcher = null;
  static final AbsenceReportingService instance = AbsenceReportingService._();

  @visibleForTesting
  AbsenceReportingService.withFetcher(Future<Object?> Function(AbsenceReportTarget target) fetcher) : _fetcher = fetcher;

  final Future<Object?> Function(AbsenceReportTarget target)? _fetcher;
  final Map<String, List<String>> _reasonCache = {};

  static bool isSchulnetz(MySchool school) => school.provider == schulnetzSystemKey || school.schoolSystemKey == schulnetzSystemKey;

  /// The Schulnetz connection of the current mode, or null when there is none (then absences stay in Schuly only).
  Future<AbsenceReportTarget?> resolveTarget({required bool isPrivate}) async {
    if (isPrivate) {
      final account = await PrivateAccountStore.instance.load();
      if (account == null || account.systemKey != schulnetzSystemKey) return null;
      if (account.accessToken == null || account.statelessBasePath.isEmpty) return null;
      return AbsenceReportTarget.private(account);
    }
    final school = ActiveAccountService.instance.active;
    if (school == null || !isSchulnetz(school)) return null;
    final target = await ActiveAccountService.instance.resolvePluginTarget(school);
    if (target == null) return null;
    return AbsenceReportTarget.account(basePath: target.basePath, accountId: target.accountId);
  }

  Future<List<ReportedAbsence>> reported(AbsenceReportTarget target) async {
    final res = await _send<List<dynamic>>(target, 'GET', '${target.absencesPath}/reported');
    return [for (final e in (res.data ?? const [])) ReportedAbsence.fromJson(e as Map<String, dynamic>)];
  }

  /// Parses the reasons response (`string[]`), dropping anything that is not a non-empty string.
  static List<String> parseReasons(Object? data) {
    if (data is! List) return const [];
    return [for (final r in data) if (r is String && r.trim().isNotEmpty) r.trim()];
  }

  /// The reasons the school offers, in server order; cached per connection for the app session.
  /// Any failure (including a 404) yields an empty list, and is not cached so the next open retries.
  Future<List<String>> reasons(AbsenceReportTarget target) async {
    final key = target.absencesPath;
    final cached = _reasonCache[key];
    if (cached != null) return cached;
    try {
      final fetcher = _fetcher;
      final Object? data = fetcher != null ? await fetcher(target) : (await _send<List<dynamic>>(target, 'GET', '${target.absencesPath}/reasons')).data;
      final list = parseReasons(data);
      return _reasonCache[key] = list;
    } catch (_) {
      return const [];
    }
  }

  Future<void> create(AbsenceReportTarget target, AbsenceDraft draft) => _send<dynamic>(target, 'POST', target.absencesPath, data: draft.toJson());

  Future<void> withdraw(AbsenceReportTarget target, List<String> ids) => _send<dynamic>(target, 'DELETE', target.absencesPath, query: {'ids': ids.join(',')});

  Future<Response<T>> _send<T>(AbsenceReportTarget target, String method, String path, {Object? data, Map<String, dynamic>? query}) async {
    try {
      final account = target.privateAccount;
      if (account != null) return await TokenProxyClient.instance.send<T>(account, method, path, data: data, query: query);
      return await ApiClient.instance.dio.request<T>(path, data: data, queryParameters: query, options: ApiClient.handled(Options(method: method)));
    } on DioException catch (e) {
      throw AbsenceReportException.fromDio(e);
    }
  }
}
