// lib/settings_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sunny16/settings_model.dart';

void main() {
  group('CameraSettings Tests', () {
    test('CameraSettings constructor initializes all fields correctly', () {
      final settings = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1/4000,
        maxShutterSpeed: 30,
        stopIncrement: StopIncrement.half,
      );

      expect(settings.isoValues, [100, 200, 400]);
      expect(settings.minShutterSpeed, 1/4000);
      expect(settings.maxShutterSpeed, 30);
      expect(settings.stopIncrement, StopIncrement.half);
    });

    test('CameraSettings default stopIncrement is StopIncrement.third', () {
      final settings = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1/4000,
        maxShutterSpeed: 30,
      );

      expect(settings.stopIncrement, StopIncrement.third);
    });

    test('CameraSettings constructor with different stopIncrement values', () {
      final settingsFull = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1/4000,
        maxShutterSpeed: 30,
        stopIncrement: StopIncrement.full,
      );

      final settingsHalf = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1/4000,
        maxShutterSpeed: 30,
        stopIncrement: StopIncrement.half,
      );

      final settingsThird = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1/4000,
        maxShutterSpeed: 30,
        stopIncrement: StopIncrement.third,
      );

      expect(settingsFull.stopIncrement, StopIncrement.full);
      expect(settingsHalf.stopIncrement, StopIncrement.half);
      expect(settingsThird.stopIncrement, StopIncrement.third);
    });
  });
}