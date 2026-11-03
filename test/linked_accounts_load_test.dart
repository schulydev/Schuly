import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/absence_reporting_service.dart';
import 'package:schuly/services/linked_accounts_controller.dart';

import 'fakes/fake_linking_api.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// The startup hang: the absences page reloads its target whenever the accounts change, and
  /// resolving the target loads the accounts when none are loaded yet. Each load notified the
  /// listener before its first await, so this recursed forever on the UI thread.
  ({LinkedAccountsController controller, int Function() depth}) resolvingListener(FakeLinkingApi api) {
    final controller = LinkedAccountsController(api: api, refreshDependents: () async {}, clearCaches: () async {});
    var depth = 0;
    controller.addListener(() {
      // A stop far above what a working load needs, so a regression fails instead of eating the heap.
      if (depth++ > 20) return;
      AbsenceReportingService.instance.resolveTarget(isPrivate: false, accounts: controller);
    });
    return (controller: controller, depth: () => depth);
  }

  test('a listener that resolves the target does not re-enter load', () async {
    final probe = resolvingListener(FakeLinkingApi());
    await probe.controller.load();
    expect(probe.controller.loaded, isTrue);
    expect(probe.depth(), lessThanOrEqualTo(2));
  });

  test('a failing load is not retried by its own listener', () async {
    final api = FakeLinkingApi()..accountsFailure = Exception('offline');
    final probe = resolvingListener(api);
    await probe.controller.load();
    await pumpEventQueue();
    expect(probe.controller.loaded, isFalse);
    expect(probe.controller.error, isNotNull);
    expect(api.accountsCalls, 1);
    expect(probe.depth(), lessThanOrEqualTo(2));
  });

  test('concurrent loads share one request', () async {
    final api = FakeLinkingApi();
    final controller = LinkedAccountsController(api: api, refreshDependents: () async {}, clearCaches: () async {});
    await Future.wait([controller.load(), controller.load()]);
    expect(api.accountsCalls, 1);
  });

  test('a later load fetches again', () async {
    final api = FakeLinkingApi();
    final controller = LinkedAccountsController(api: api, refreshDependents: () async {}, clearCaches: () async {});
    await controller.load();
    await controller.load();
    expect(api.accountsCalls, 2);
  });
}
