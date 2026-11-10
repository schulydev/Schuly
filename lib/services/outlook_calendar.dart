import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_client.dart';
import 'app_mode_service.dart';
import 'linked_accounts_controller.dart';

/// The capability kind whose feed carries the linked Microsoft accounts' calendars.
const calendarCapability = 'calendar';

/// One event of a linked account's calendar, as the feed (`GET <basePath>?start&end`) sends it.
class OutlookEvent {
  const OutlookEvent({required this.id, required this.accountId, required this.title, required this.start, required this.end, required this.allDay, this.location, this.organizer, this.preview, this.webLink, this.joinUrl, this.cancelled = false});

  final String id;
  final String accountId;
  final String title;
  final DateTime start;
  final DateTime end;
  final bool allDay;
  final String? location;
  final String? organizer;
  final String? preview;
  final String? webLink;
  final String? joinUrl;
  final bool cancelled;

  /// An all-day event's date as that day at local midnight, whatever zone the feed wrote it in; a timed one in local time.
  static DateTime _parse(String value, bool allDay) {
    final d = DateTime.parse(value);
    if (!allDay) return d.toLocal();
    final day = RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value) ? d : (d.isUtc ? d : d.toUtc());
    return DateTime(day.year, day.month, day.day);
  }

  factory OutlookEvent.fromJson(Map<String, dynamic> j) {
    final allDay = j['isAllDay'] == true;
    String? text(String key) => (j[key] as String?)?.trim().isNotEmpty == true ? (j[key] as String).trim() : null;
    return OutlookEvent(
      id: '${j['id']}',
      accountId: '${j['accountId']}',
      title: (j['title'] as String?) ?? '',
      start: _parse(j['start'] as String, allDay),
      end: _parse(j['end'] as String, allDay),
      allDay: allDay,
      location: text('location'),
      organizer: text('organizer'),
      preview: text('preview'),
      webLink: text('webLink'),
      joinUrl: text('joinUrl'),
      cancelled: j['isCancelled'] == true,
    );
  }

  /// The last day it covers: an all-day event ends at midnight after its last day, a timed one counts its start day.
  DateTime get lastDay {
    if (!allDay) return DateTime(start.year, start.month, start.day);
    final last = DateTime(end.year, end.month, end.day - 1);
    return last.isBefore(start) ? DateTime(start.year, start.month, start.day) : last;
  }

  bool coversDay(DateTime day) {
    final first = DateTime(start.year, start.month, start.day);
    return !day.isBefore(first) && !day.isAfter(lastDay);
  }
}

/// A linked account in the feed, with the colour its events get.
class OutlookAccount {
  const OutlookAccount({required this.id, required this.email, this.displayName, required this.color});

  final String id;
  final String email;
  final String? displayName;

  /// ARGB, one of the web's account colours by position.
  final int color;

  /// "Mia Muster (mia@example.ch)", as the web's event sheet names the source.
  String get detail => displayName?.isNotEmpty == true ? '$displayName ($email)' : email;
}

/// The web calendar's account colours (oklch 0.6 0.19 255, 0.6 0.21 300, 0.62 0.15 195, 0.63 0.21 350, 0.64 0.16 140).
const outlookAccountColors = [0xFF127EEE, 0xFF9657E8, 0xFF00A0A2, 0xFFDF419B, 0xFF50A33D];

/// The linked Microsoft accounts' calendars, a week at a time, merged into the timetable the way the web merges
/// them into its calendar. Only in account mode with an account that offers the calendar capability; a failure
/// leaves the week empty and never reaches the timetable.
class OutlookCalendar extends ChangeNotifier {
  OutlookCalendar._();
  static final OutlookCalendar instance = OutlookCalendar._();

  final Map<DateTime, List<OutlookEvent>> _weeks = {};
  final Set<DateTime> _loading = {};
  Map<String, OutlookAccount> _accounts = const {};
  bool _listening = false;

  OutlookAccount? account(String id) => _accounts[id];

  List<String> get _paths {
    if (AppModeService.instance.isPrivate) return const [];
    final paths = <String>{};
    for (final a in LinkedAccountsController.instance.withCapability(calendarCapability)) {
      final base = a.capability(calendarCapability)?.basePath;
      if (base != null && base.isNotEmpty) paths.add(base.replaceAll(RegExp(r'/+$'), ''));
    }
    return paths.toList();
  }

  void _listen() {
    if (_listening) return;
    _listening = true;
    // A new or removed calendar account changes what the feed holds.
    var known = _accountKey();
    LinkedAccountsController.instance.addListener(() {
      final now = _accountKey();
      if (now == known) return;
      known = now;
      clear();
    });
  }

  String _accountKey() => [for (final a in LinkedAccountsController.instance.withCapability(calendarCapability)) '${a.id}:${a.status.name}'].join(',');

  /// Forgets every loaded week, so they load again.
  void clear() {
    if (_weeks.isEmpty) return;
    _weeks.clear();
    notifyListeners();
  }

  /// The events of the week starting on [monday]; empty until loaded, then the listeners hear about it.
  List<OutlookEvent> week(DateTime monday) {
    _listen();
    final key = DateTime(monday.year, monday.month, monday.day);
    final known = _weeks[key];
    if (known != null) return known;
    if (!_loading.contains(key)) _load(key);
    return const [];
  }

  Future<void> _load(DateTime monday) async {
    final paths = _paths;
    if (paths.isEmpty) {
      _weeks[monday] = const [];
      return;
    }
    _loading.add(monday);
    final events = <OutlookEvent>[];
    final accounts = Map<String, OutlookAccount>.of(_accounts);
    final end = DateTime(monday.year, monday.month, monday.day + 7);
    for (final path in paths) {
      try {
        final res = await ApiClient.instance.dio.get<Map<String, dynamic>>(
          path,
          queryParameters: {'start': monday.toUtc().toIso8601String(), 'end': end.toUtc().toIso8601String()},
          options: ApiClient.handled(),
        );
        final data = res.data ?? const {};
        for (final a in (data['accounts'] as List<dynamic>? ?? const [])) {
          final m = a as Map<String, dynamic>;
          final id = '${m['id']}';
          accounts.putIfAbsent(id, () => OutlookAccount(id: id, email: (m['email'] as String?) ?? '', displayName: m['displayName'] as String?, color: outlookAccountColors[accounts.length % outlookAccountColors.length]));
        }
        for (final e in (data['events'] as List<dynamic>? ?? const [])) {
          try {
            events.add(OutlookEvent.fromJson(e as Map<String, dynamic>));
          } catch (_) {
            // One malformed event does not take the week with it.
          }
        }
      } on DioException catch (_) {
        // A calendar that is not answering leaves the timetable as it is.
      } catch (_) {}
    }
    events.sort((a, b) => a.start.compareTo(b.start));
    _loading.remove(monday);
    _accounts = accounts;
    _weeks[monday] = events;
    notifyListeners();
  }
}
