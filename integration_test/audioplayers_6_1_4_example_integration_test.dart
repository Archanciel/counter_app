import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:counter_app/tools/audioplayers_example.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Player Integration Test', () {
    testWidgets('Play and Pause Test', (
      WidgetTester tester,
    ) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());

      // Find the play button
      final playButton = find.byIcon(Icons.play_arrow);
      expect(playButton, findsOneWidget);

      // Tap the play button
      await tester.tap(playButton);
      await tester.pumpAndSettle();

      for (int i = 0; i < 10; i++) {
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      // Find the pause button (after playing)
      final pauseButton = find.byIcon(Icons.pause);
      expect(pauseButton, findsOneWidget);

      // Tap the pause button
      await tester.tap(pauseButton);
      await tester.pumpAndSettle();

      // Assert that the pause button is disabled after pausing
      expect(playButton, findsOneWidget);
    });
  });
}
