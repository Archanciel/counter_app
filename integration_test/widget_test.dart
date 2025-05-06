import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increments smoke test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);

    // Finds the floating action button to tap on.
    final fab = find.byKey(const ValueKey('increment'));

    // Emulate a tap on the floating action button.
    await tester.tap(fab);

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('1'), findsOneWidget);
  });
}
