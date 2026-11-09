import 'package:flutter/foundation.dart';

import 'absence_reporting_service.dart';
import 'active_account_service.dart';
import 'app_mode_service.dart';
import 'linked_accounts_controller.dart';

/// The school connection absence reports go to, and the reports still waiting for the school. Shared by Home (an
/// unexcused absence a report covers reads "Waiting") and the Absences tab.
class ReportedAbsences extends ChangeNotifier {
  ReportedAbsences._();
  static final ReportedAbsences instance = ReportedAbsences._();

  AbsenceReportTarget? _target;
  List<ReportedAbsence> _reported = const [];
  int _generation = 0;
  bool _started = false;

  /// Null when absences stay in Schuly only.
  AbsenceReportTarget? get target => _target;
  List<ReportedAbsence> get reported => _reported;

  /// Loads once and follows the active school, the linked accounts and the app mode from then on.
  void start() {
    if (_started) return;
    _started = true;
    ActiveAccountService.instance.addListener(load);
    LinkedAccountsController.instance.addListener(load);
    AppModeService.instance.addListener(load);
    load();
  }

  Future<void> load() async {
    final gen = ++_generation;
    AbsenceReportTarget? target;
    var reported = const <ReportedAbsence>[];
    try {
      target = await AbsenceReportingService.instance.resolveTarget(isPrivate: AppModeService.instance.isPrivate);
      if (target != null) reported = await AbsenceReportingService.instance.reported(target);
    } on AbsenceReportException catch (e) {
      // The plugin has no reporting endpoints: fall back to Schuly-only absences. Other failures keep the target so
      // the student can still report.
      if (e.kind == AbsenceReportErrorKind.notAvailable) target = null;
    } catch (_) {
      // Detection is best effort; without a target the page behaves as before.
    }
    if (gen != _generation) return;
    _target = target;
    _reported = reported;
    notifyListeners();
  }
}
