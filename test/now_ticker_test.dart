import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/ui/core/ui/now_ticker.dart';

void main() {
  testWidgets('now stays stale across an app resume without the resume-refresh fix path', (tester) async {
    // A long interval so the periodic timer has no chance to fire during the
    // test - only an explicit resume should be able to refresh `now`.
    final calls = <DateTime>[];
    await tester.pumpWidget(MaterialApp(
      home: NowTicker(
        interval: const Duration(minutes: 30),
        builder: (context, now) {
          calls.add(now);
          return const SizedBox();
        },
      ),
    ));

    expect(calls, hasLength(1));

    // Simulate the device being backgrounded for a while (its background
    // timers are commonly suspended by the OS) and then resumed.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    // A resume must trigger an immediate rebuild with a fresh `now`, not wait
    // for the next 30-minute tick - this is what made the home page miss a
    // lesson that was already running by the time the app was reopened.
    expect(calls.length, greaterThan(1));
  });

  testWidgets('the periodic tick still refreshes now on its own', (tester) async {
    final calls = <DateTime>[];
    await tester.pumpWidget(MaterialApp(
      home: NowTicker(
        interval: const Duration(seconds: 30),
        builder: (context, now) {
          calls.add(now);
          return const SizedBox();
        },
      ),
    ));

    expect(calls, hasLength(1));
    await tester.pump(const Duration(seconds: 31));
    expect(calls.length, greaterThan(1));
  });
}
