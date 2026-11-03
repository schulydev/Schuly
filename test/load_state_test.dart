import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:schuly/ui/core/ui/load_state.dart';

Widget _host(Widget child) => MaterialApp(
      builder: (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
      home: Material(child: child),
    );

void main() {
  setUp(() => LoadingWithRetry.timeout = const Duration(seconds: 30));

  testWidgets('a spinner offers a retry after the timeout, and spins again when used', (tester) async {
    var retries = 0;
    await tester.pumpWidget(_host(LoadingWithRetry(onRetry: () => retries++)));
    expect(find.byType(FCircularProgress), findsOneWidget);
    expect(find.text('Try again'), findsNothing);

    await tester.pump(const Duration(seconds: 31));
    expect(find.byType(FCircularProgress), findsNothing);
    await tester.tap(find.text('Try again'));
    await tester.pump();
    expect(retries, 1);
    expect(find.byType(FCircularProgress), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('a failure reads as a sentence and can be retried', (tester) async {
    var retries = 0;
    await tester.pumpWidget(_host(LoadFailure(error: Exception('Server down'), onRetry: () => retries++)));
    expect(find.text('Server down.'), findsOneWidget);
    await tester.tap(find.text('Try again'));
    expect(retries, 1);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });
}
