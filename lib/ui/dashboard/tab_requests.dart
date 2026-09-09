import 'package:flutter/foundation.dart';

enum DashboardTab { home, timetable, grades, absences, account }

/// A cross-screen request to bring a dashboard tab to the front (a notification
/// tap), which the dashboard clears once it has acted on it.
class TabRequests {
  TabRequests._();

  static final ValueNotifier<DashboardTab?> pending = ValueNotifier<DashboardTab?>(null);

  static void request(DashboardTab tab) => pending.value = tab;

  static void clear() => pending.value = null;

  /// Maps an FCM data payload `type` to a tab. Null for unknown types.
  ///
  /// Matches backend types (`gradeAdded`, `gradeChanged`, `absenceAdded`,
  /// `agendaAdded`, `agendaChanged`) by prefix, and the app's own short
  /// names (`grade`/`grades`, `absence`/`absences`, `agenda`) exactly.
  static DashboardTab? tabForType(String? type) {
    final normalized = type?.toLowerCase();
    if (normalized == null) return null;
    if (normalized.startsWith('grade')) return DashboardTab.grades;
    if (normalized.startsWith('absence')) return DashboardTab.absences;
    if (normalized.startsWith('agenda')) return DashboardTab.timetable;
    return null;
  }
}
