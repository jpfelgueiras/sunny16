// lib/home_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sunny16/home_screen.dart';
import 'package:sunny16/settings_screen.dart';

void main() {
  group('HomeScreen Tests', () {
    testWidgets('Initial state is correct', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Verify initial state
      expect(find.text('Sunny 16 Calculator'), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(6)); // 5 weather icons
      expect(
          find.byType(ListTile), findsNothing); // No recommendations initially
    });

    testWidgets('Aperture slider changes value', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Verify initial slider value
      expect(find.text('Aperture: f/2.8'), findsOneWidget);

      // Move the slider
      await tester.drag(find.byType(Slider), Offset(200, 0));
      await tester.pump();

      // Verify updated slider value
      expect(find.text('Aperture: f/11.0'), findsOneWidget);
    });

    testWidgets('Weather icon button changes condition',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Tap on a weather icon
      await tester.tap(find.byIcon(Icons.cloud));
      await tester.pump();

      // Verify the icon color changes to blue
      final iconButton = tester.widget<Icon>(find.byIcon(Icons.cloud));
      expect(iconButton.color, Colors.blue);
    });

    testWidgets('Settings button navigates to SettingsScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(),
        routes: {
          '/settings': (context) => SettingsScreen(),
        },
      ));

      // Tap on the settings button
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Verify navigation to SettingsScreen
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });
}
