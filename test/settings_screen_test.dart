// filepath: /home/jpfelgueiras/sunny16/test/settings_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/settings_screen.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  group('SettingsScreen Tests', () {
    late MockSettingsRepository mockSettingsRepository;

    setUp(() {
      mockSettingsRepository = MockSettingsRepository();
    });

    testWidgets('SettingsScreen widget is created correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsScreen()));

      expect(find.byType(SettingsScreen), findsOneWidget);
    });
/*
    testWidgets('Settings are loaded correctly in initState', (WidgetTester tester) async {
      final settings = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1 / 4000,
        maxShutterSpeed: 30,
        stopIncrement: StopIncrement.half,
      );

      when(mockSettingsRepository.loadSettings()).thenAnswer((_) async => settings);

      await tester.pumpWidget(MaterialApp(home: SettingsScreen()));

      await tester.pump(); // Rebuild the widget with the future's result

      expect(find.text('ISO 100'), findsOneWidget);
      expect(find.text('ISO 200'), findsOneWidget);
      expect(find.text('ISO 400'), findsOneWidget);
      expect(find.text('0.00025'), findsOneWidget); // 1/4000
      expect(find.text('30.0'), findsOneWidget);
      expect(find.text('half'), findsOneWidget);
    });

    testWidgets('Settings are saved correctly when save button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsScreen()));

      await tester.enterText(find.byType(TextFormField).at(0), '100');
      await tester.enterText(find.byType(TextFormField).at(1), '0.00025'); // 1/4000
      await tester.enterText(find.byType(TextFormField).at(2), '30.0');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockSettingsRepository.saveSettings(any as CameraSettings)).called(1);
    });
*/
    testWidgets('Stop increment selector works correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsScreen()));

      await tester.tap(find.byType(DropdownButton<StopIncrement>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('half').last);
      await tester.pump();

      expect(find.text('half'), findsAny);
    });
  });
}
