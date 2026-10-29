import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/services/linked_accounts_controller.dart';
import 'package:schuly/services/linking_service.dart';
import 'package:schuly/ui/linking/link_flow_screen.dart';
import 'package:schuly/ui/linking/schools_accounts_screen.dart';

import 'fakes/fake_linking_api.dart';

LinkedAccountsController _controller(FakeLinkingApi api, {void Function()? onRefresh, Duration poll = const Duration(seconds: 3)}) => LinkedAccountsController(api: api, refreshDependents: () async => onRefresh?.call(), clearCaches: () async {}, pollInterval: poll);

Widget _app(Widget home) => MaterialApp(
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      home: FTheme(data: FThemes.zinc.light, child: home),
    );

/// A screen with a button that opens a link flow and records how it ended.
class _Host extends StatefulWidget {
  final LinkedAccountsController controller;
  final String providerId;
  final List<LinkResult?> results;
  const _Host({required this.controller, required this.providerId, required this.results});

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> {
  @override
  Widget build(BuildContext context) => FScaffold(
        child: Column(children: [
          FButton(
            onPress: () async => widget.results.add(await LinkFlowScreen.open(context, providerId: widget.providerId, controller: widget.controller)),
            child: const Text('open'),
          ),
          ListenableBuilder(listenable: widget.controller, builder: (_, _) => Column(children: [for (final a in widget.controller.accounts) Text('listed:${a.title}')])),
        ]),
      );
}

Future<void> _linkIdentity(WidgetTester tester, String email) async {
  await tester.enterText(find.byType(EditableText), email);
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a nested link from a select step shows the new account in the outer step immediately', (tester) async {
    final api = FakeLinkingApi();
    final controller = _controller(api);
    await tester.pumpWidget(_app(LinkFlowScreen(providerId: FakeLinkingApi.school, controller: controller)));
    await tester.pumpAndSettle();

    expect(find.text('Link a new account'), findsOneWidget);
    expect(find.text('ada@example.org'), findsNothing);

    await tester.tap(find.text('Link a new account'));
    await tester.pumpAndSettle();
    await _linkIdentity(tester, 'ada@example.org');

    // Back on the outer step, first time, without leaving the screen or retrying.
    expect(find.text('Choose an account'), findsWidgets);
    expect(find.text('ada@example.org'), findsOneWidget);
    expect(controller.accounts.map((a) => a.id), ['ada@example.org']);
  });

  testWidgets('linking the same account twice succeeds both times and keeps a single entry', (tester) async {
    final api = FakeLinkingApi();
    final controller = _controller(api);
    final results = <LinkResult?>[];
    await tester.pumpWidget(_app(_Host(controller: controller, providerId: FakeLinkingApi.identity, results: results)));

    for (var i = 0; i < 2; i++) {
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await _linkIdentity(tester, 'ada@example.org');
      expect(results.length, i + 1);
      expect(results.last?.accountId, 'ada@example.org');
      expect(find.text('listed:ada@example.org'), findsOneWidget);
    }
    expect(controller.accounts.length, 1);
    expect(find.textContaining('went wrong'), findsNothing);
  });

  testWidgets('a failed link shows the server message and adds nothing', (tester) async {
    final api = FakeLinkingApi()..submitFailure = 'Your school blocks this sign-in.';
    final controller = _controller(api);
    final results = <LinkResult?>[];
    await tester.pumpWidget(_app(_Host(controller: controller, providerId: FakeLinkingApi.identity, results: results)));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await _linkIdentity(tester, 'ada@example.org');

    expect(find.text('Your school blocks this sign-in.'), findsOneWidget);
    expect(results, isEmpty);
    expect(controller.accounts, isEmpty);
  });

  testWidgets('a failing account reload after done is never shown as a failed link', (tester) async {
    final api = FakeLinkingApi();
    final controller = _controller(api);
    final results = <LinkResult?>[];
    await tester.pumpWidget(_app(_Host(controller: controller, providerId: FakeLinkingApi.identity, results: results)));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    api.accountsFailure = Exception('offline');
    await _linkIdentity(tester, 'ada@example.org');

    expect(results.single?.accountId, 'ada@example.org');
    expect(find.textContaining('offline'), findsNothing);
  });

  group('data after link and unlink', () {
    // Stands in for the school data stores: it only has data while a synced account exists.
    Widget dataPage(LinkedAccountsController c, ValueNotifier<List<String>> data) => _app(FScaffold(
          child: ListenableBuilder(
            listenable: Listenable.merge([c, data]),
            builder: (_, _) => c.syncing ? const Column(children: [SyncingBanner()]) : Column(children: [for (final g in data.value) Text(g)]),
          ),
        ));

    testWidgets('shows syncing, polls, then the data appears without a restart; unlink removes it', (tester) async {
      final api = FakeLinkingApi();
      final data = ValueNotifier<List<String>>(const []);
      late final LinkedAccountsController controller;
      controller = _controller(api, onRefresh: () {
        final synced = controller.accounts.any((a) => a.status == LinkedAccountStatus.ok && a.lastSyncedAt != null);
        data.value = synced ? ['Maths 5.5'] : const [];
      });
      await tester.pumpWidget(dataPage(controller, data));

      api.store.add(LinkedAccount(providerId: FakeLinkingApi.school, providerName: 'School', id: 'a1', title: 'Ada', status: LinkedAccountStatus.syncing, capabilities: const [LinkCapability(kind: schoolDataCapability, label: 'School data')]));
      await controller.linked(FakeLinkingApi.school, 'a1');
      await tester.pump();
      expect(find.text('Syncing your data…'), findsOneWidget);
      expect(find.text('Maths 5.5'), findsNothing);

      // Still syncing on the first poll.
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Syncing your data…'), findsOneWidget);

      api.store[0] = LinkedAccount(providerId: FakeLinkingApi.school, providerName: 'School', id: 'a1', title: 'Ada', lastSyncedAt: DateTime(2026, 10, 29), capabilities: const [LinkCapability(kind: schoolDataCapability, label: 'School data')]);
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.text('Syncing your data…'), findsNothing);
      expect(find.text('Maths 5.5'), findsOneWidget);

      await controller.unlink(controller.accounts.single);
      await tester.pump();
      expect(find.text('Maths 5.5'), findsNothing);
      expect(controller.accounts, isEmpty);
    });

    testWidgets('stops polling after the limit', (tester) async {
      final api = FakeLinkingApi();
      final controller = LinkedAccountsController(api: api, refreshDependents: () async {}, clearCaches: () async {}, pollInterval: const Duration(seconds: 3), pollLimit: const Duration(seconds: 9));
      api.store.add(const LinkedAccount(providerId: FakeLinkingApi.school, providerName: 'School', id: 'a1', title: 'Ada', status: LinkedAccountStatus.syncing));
      await controller.linked(FakeLinkingApi.school, 'a1');
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
      final calls = api.accountsCalls;
      await tester.pump(const Duration(seconds: 12));
      await tester.pump(const Duration(seconds: 12));
      expect(api.accountsCalls, lessThanOrEqualTo(calls + 3));
      final settled = api.accountsCalls;
      await tester.pump(const Duration(seconds: 30));
      expect(api.accountsCalls, settled);
    });
  });
}
