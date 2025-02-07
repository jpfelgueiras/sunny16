// filepath: /home/jpfelgueiras/sunny16/test/main_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sunny16/main.dart';
import 'package:sunny16/home_screen.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/settings_screen.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  group('MyApp Tests', () {
    late MockSettingsRepository mockSettingsRepository;

    setUp(() {
      mockSettingsRepository = MockSettingsRepository();
    });

    testWidgets('MyApp widget is created correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      expect(find.byType(MyApp), findsOneWidget);
    });
/*
    testWidgets('FutureBuilder shows HomeScreen when loadSettings completes successfully', (WidgetTester tester) async {
      when(mockSettingsRepository.loadSettings()).thenAnswer((_) async => true);

      await tester.pumpWidget(MaterialApp(
        home: FutureBuilder(
          future: mockSettingsRepository.loadSettings(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.done && snapshot.hasData ? HomeScreen() : SettingsScreen(),
        ),
      ));

      await tester.pump(); // Rebuild the widget with the future's result

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(SettingsScreen), findsNothing);
    });

    testWidgets('FutureBuilder shows SettingsScreen when loadSettings does not complete successfully', (WidgetTester tester) async {
      when(mockSettingsRepository.loadSettings()).thenAnswer((_) async => false);

      await tester.pumpWidget(MaterialApp(
        home: FutureBuilder(
          future: mockSettingsRepository.loadSettings(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.done && snapshot.hasData ? HomeScreen() : SettingsScreen(),
        ),
      ));

      await tester.pump(); // Rebuild the widget with the future's result

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
    */
  });
}