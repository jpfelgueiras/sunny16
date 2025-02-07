// lib/main_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sunny16/main.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {
  @override
  Future<CameraSettings> loadSettings() {
    return Future.value(CameraSettings(
      isoValues: [100, 200, 400],
      minShutterSpeed: 1 / 4000,
      maxShutterSpeed: 30,
    ));
  }
}


void main() {
  group('MyApp Tests', () {
    testWidgets('MyApp widget is created correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}