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
  static DashboardTab? tabForType(String? type) {
    switch (type?.toLowerCase()) {
      case 'grade':
      case 'grades':
        return DashboardTab.grades;
      case 'absence':
      case 'absences':
        return DashboardTab.absences;
      case 'agenda':
        return DashboardTab.timetable;
      default:
        return null;
    }
  }
}
