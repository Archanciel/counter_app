import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:counter_app/tools/audioplayers_example.dart';
import 'package:process_run/process_run.dart';

Future<void> main() async {
  // Execute ADB command to push the file to the emulator
  var shell = Shell();

  try {
    // Push the audio file to the emulator
    await shell.run(
      'adb push "C:\\temp\\Rumanian folk dances Pe Loc.mp3" "/storage/emulated/0/Download/Rumanian.mp3"'
    );

    print('File pushed successfully to emulator');
  } catch (e) {
    print('Error pushing file to emulator: $e');
  }

  // Now initialize the test binding
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Player Integration Test', () {
    testWidgets('5 sec. Play and Pause Test', (
      WidgetTester tester,
    ) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find the play button
      final playButton = find.byIcon(Icons.play_arrow);
      expect(playButton, findsOneWidget);

      // Tap the play button
      await tester.tap(playButton);
      await tester.pumpAndSettle();

      for (int i = 0; i < 5; i++) {
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
    testWidgets('6 sec. Play and Pause Test', (
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

      for (int i = 0; i < 6; i++) {
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
