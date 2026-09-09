import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/ui/dashboard/tab_requests.dart';

void main() {
  group('TabRequests.tabForType', () {
    test('maps gradeAdded to the grades tab', () {
      expect(TabRequests.tabForType('gradeAdded'), DashboardTab.grades);
    });

    test('maps gradeChanged to the grades tab', () {
      expect(TabRequests.tabForType('gradeChanged'), DashboardTab.grades);
    });

    test('maps absenceAdded to the absences tab', () {
      expect(TabRequests.tabForType('absenceAdded'), DashboardTab.absences);
    });

    test('maps agendaAdded to the timetable tab', () {
      expect(TabRequests.tabForType('agendaAdded'), DashboardTab.timetable);
    });

    test('maps agendaChanged to the timetable tab', () {
      expect(TabRequests.tabForType('agendaChanged'), DashboardTab.timetable);
    });

    test('still maps the short names', () {
      expect(TabRequests.tabForType('grade'), DashboardTab.grades);
      expect(TabRequests.tabForType('grades'), DashboardTab.grades);
      expect(TabRequests.tabForType('absence'), DashboardTab.absences);
      expect(TabRequests.tabForType('absences'), DashboardTab.absences);
      expect(TabRequests.tabForType('agenda'), DashboardTab.timetable);
    });

    test('returns null for an unknown type', () {
      expect(TabRequests.tabForType('somethingElse'), isNull);
    });

    test('returns null for a null type', () {
      expect(TabRequests.tabForType(null), isNull);
    });
  });
}
