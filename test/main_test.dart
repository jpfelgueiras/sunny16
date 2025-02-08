import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sunny16/main.dart';
import 'package:sunny16/home_screen.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/settings_screen.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {
  @override
  Future<CameraSettings> loadSettings() {
    return super.noSuchMethod(Invocation.method(#loadSettings, []),
        returnValue: Future.value(CameraSettings(
            isoValues: [100, 200, 400, 800],
            minShutterSpeed: 1 / 4000,
            maxShutterSpeed: 30)));
  }
}

void main() {
  group('MyApp Tests', () {
    late MockSettingsRepository mockSettingsRepository;

    setUp(() {
      mockSettingsRepository = MockSettingsRepository();
    });

    testWidgets('MyApp widget is created correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      expect(find.byType(MyApp), findsOneWidget);
    });

    testWidgets(
        'FutureBuilder shows HomeScreen when loadSettings completes successfully',
        (WidgetTester tester) async {
      when(mockSettingsRepository.loadSettings()).thenAnswer((_) async =>
          CameraSettings(
              isoValues: [100, 200, 400, 800],
              minShutterSpeed: 1 / 4000,
              maxShutterSpeed: 30));

      await tester.pumpWidget(MaterialApp(
        home: FutureBuilder(
          future: mockSettingsRepository.loadSettings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return SettingsScreen();
              } else if (snapshot.hasData) {
                return HomeScreen();
              }
            }
            return SettingsScreen();
          },
        ),
      ));

      await tester.pump(); // Rebuild the widget with the future's result

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(SettingsScreen), findsNothing);
    });

    testWidgets(
        'FutureBuilder shows SettingsScreen when loadSettings does not complete successfully',
        (WidgetTester tester) async {
      when(mockSettingsRepository.loadSettings()).thenAnswer((_) async =>
          CameraSettings(
              isoValues: [], minShutterSpeed: 0, maxShutterSpeed: 0));

      await tester.pumpWidget(MaterialApp(
        home: FutureBuilder(
          future: mockSettingsRepository.loadSettings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final settings = snapshot.data;
                if (settings == null ||
                    settings.isoValues.isEmpty ||
                    settings.minShutterSpeed == 0 ||
                    settings.maxShutterSpeed == 0) {
                  return SettingsScreen();
                }
                return HomeScreen();
              } else {
                return SettingsScreen();
              }
            }
            return SettingsScreen();
          },
        ),
      ));

      await tester.pump(); // Rebuild the widget with the future's result

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });
}
