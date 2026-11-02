import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/absence_reporting_service.dart';
import 'package:schuly/services/linked_accounts_controller.dart';
import 'package:schuly/services/linking_service.dart';

import 'fakes/fake_linking_api.dart';

void main() {
  test('the reporting target is an account whose provider has the absence_reporting capability', () async {
    final api = FakeLinkingApi();
    api.store.addAll(const [
      LinkedAccount(providerId: 'identity', providerName: 'Identity', id: 'm1', title: 'm1', capabilities: [LinkCapability(kind: 'mail', label: 'Mail', basePath: '/api/plugins/mail/accounts')]),
      LinkedAccount(providerId: 'school', providerName: 'School', id: 's1', title: 's1', capabilities: [LinkCapability(kind: absenceReportingCapability, label: 'Absences', basePath: '/api/plugins/x/accounts')]),
    ]);
    final controller = LinkedAccountsController(api: api, refreshDependents: () async {}, clearCaches: () async {});
    final target = await AbsenceReportingService.instance.resolveTarget(isPrivate: false, accounts: controller);
    expect(target?.absencesPath, '/api/plugins/x/accounts/s1/absences');
  });

  test('no account with the capability means no target', () async {
    final controller = LinkedAccountsController(api: FakeLinkingApi(), refreshDependents: () async {}, clearCaches: () async {});
    expect(await AbsenceReportingService.instance.resolveTarget(isPrivate: false, accounts: controller), isNull);
  });
}
