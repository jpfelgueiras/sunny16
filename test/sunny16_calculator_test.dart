// filepath: /home/jpfelgueiras/sunny16/test/sunny16_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/sunny16_calculator.dart';

void main() {
  group('Sunny16Calculator Tests', () {
    
    test('_getShutterSpeeds returns correct list based on stop increment', () {
      expect(Sunny16Calculator.getShutterSpeeds(StopIncrement.full), Sunny16Calculator.fullStopShutterSpeeds);
      expect(Sunny16Calculator.getShutterSpeeds(StopIncrement.half), Sunny16Calculator.halfStopShutterSpeeds);
      expect(Sunny16Calculator.getShutterSpeeds(StopIncrement.third), Sunny16Calculator.thirdStopShutterSpeeds);
    });

    test('_roundToNearestShutterSpeed rounds to nearest standard shutter speed', () {
      expect(Sunny16Calculator.roundToNearestShutterSpeed(1 / 1000, StopIncrement.full), 1 / 1000);
      expect(Sunny16Calculator.roundToNearestShutterSpeed(1 / 750, StopIncrement.half), 1 / 750);
      expect(Sunny16Calculator.roundToNearestShutterSpeed(1 / 640, StopIncrement.third), 1 / 640);
    });
    

    test('calculateRecommendations calculates correct recommendations', () {
      final settings = CameraSettings(
        isoValues: [100, 200, 400],
        minShutterSpeed: 1 / 4000,
        maxShutterSpeed: 30,
        stopIncrement: StopIncrement.third,
      );

      final recommendations = Sunny16Calculator.calculateRecommendations(
        condition: 'sunny',
        aperture: 16,
        settings: settings,
      );

      expect(recommendations.length, 3);
      expect(recommendations[0]['iso'], 100);
      expect(recommendations[0]['shutter_speed'], '1/125s');
      expect(recommendations[1]['iso'], 200);
      expect(recommendations[1]['shutter_speed'], '1/250s');
      expect(recommendations[2]['iso'], 400);
      expect(recommendations[2]['shutter_speed'], '1/500s');
      
    });

    test('_formatShutterSpeed formats shutter speed correctly', () {
      expect(Sunny16Calculator.formatShutterSpeed(1), '1.0s');
      expect(Sunny16Calculator.formatShutterSpeed(0.5), '1/2s');
      expect(Sunny16Calculator.formatShutterSpeed(0.25), '1/4s');
    });
    
  });
}