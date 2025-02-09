// lib/settings_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';

void main() {
  group('SettingsRepository Tests', () {
    late SettingsRepository repository;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      repository = SettingsRepository();
    });

    test('saveSettings saves all fields correctly', () async {
      final settings = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1 / 4000,
        maxShutterSpeed: 30,
        stopIncrement: StopIncrement.half,
      );

      await repository.saveSettings(settings);

      expect(prefs.getStringList(repository.keyISO), ['100', '200', '400']);
      expect(prefs.getDouble(repository.keyMinShutter), 1 / 4000);
      expect(prefs.getDouble(repository.keyMaxShutter), 30);
      expect(
          prefs.getString(repository.keyStopIncrement), 'StopIncrement.half');
    });

    test('loadSettings loads all fields correctly', () async {
      await prefs.setStringList(repository.keyISO, ['100', '200', '400']);
      await prefs.setDouble(repository.keyMinShutter, 1 / 4000);
      await prefs.setDouble(repository.keyMaxShutter, 30);
      await prefs.setString(repository.keyStopIncrement, 'StopIncrement.half');

      final settings = await repository.loadSettings();

      expect(settings.isoValues, [100, 200, 400]);
      expect(settings.minShutterSpeed, 1 / 4000);
      expect(settings.maxShutterSpeed, 30);
      expect(settings.stopIncrement, StopIncrement.half);
    });

    test('_parseStopIncrement parses stop increment correctly', () {
      expect(repository.parseStopIncrement('StopIncrement.full'),
          StopIncrement.full);
      expect(repository.parseStopIncrement('StopIncrement.half'),
          StopIncrement.half);
      expect(repository.parseStopIncrement('StopIncrement.third'),
          StopIncrement.third);
      expect(repository.parseStopIncrement(null), StopIncrement.third);
    });

    test('parseStopIncrement returns default value when input is null', () {
      expect(repository.parseStopIncrement(null), StopIncrement.third);
    });
  });
}
