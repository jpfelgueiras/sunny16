// sunny16_calculator.dart
import 'dart:math';

import 'package:sunny16/settings_model.dart';

class Sunny16Calculator {
  static const _evValues = {
    'sunny': 15,
    'light_clouds': 14,
    'cloudy': 13,
    'overcast': 12,
    'sunset': 10,
  };

  static const _fullStopShutterSpeeds = [
    1 / 8000, 1 / 4000, 1 / 2000, 1 / 1000, 1 / 500, 1 / 250, 1 / 125, 1 / 60,
    1 / 30, 1 / 15, 1 / 8, 1 / 4, 1 / 2, 1, 2, 4, 8, 15, 30
  ];

    static const _halfStopShutterSpeeds = [
    1 / 8000, 1 / 4000, 1 / 3000, 1 / 2000, 1 / 1500, 1 / 1000, 1 / 750, 1 / 500, 1 / 360, 1 / 250, 1/180, 1 / 125, 1/90, 1 / 60,
    1/45, 1 / 30, 1/24,  1 / 15, 1/12, 1 / 8, 1/6, 1 / 4, 1/3, 1 / 2,0.7, 1, 1.5,  2, 3, 4, 6, 8, 15, 30
  ];


  static const _thirdStopShutterSpeeds = [
    1 / 8000, 1 / 6400, 1 / 5000, 1 / 4000, 1 / 3200, 1 / 2500, 1 / 2000,
    1 / 1600, 1 / 1250, 1 / 1000, 1 / 800, 1 / 640, 1 / 500, 1 / 400, 1 / 320,
    1 / 250, 1 / 200, 1 / 160, 1 / 125, 1 / 100, 1 / 80, 1 / 60, 1 / 50, 1 / 40,
    1 / 30, 1 / 25, 1 / 20, 1 / 15, 1 / 13, 1 / 10, 1 / 8, 1 / 6, 1 / 5, 1 / 4,
    1 / 3, 1 / 2.5, 1 / 2, 1 / 1.6, 1 / 1.3, 1, 1.3, 1.6, 2, 2.5, 3, 4, 5, 6,
    8, 10, 13, 15, 20, 25, 30
  ];

  static List<num> _getShutterSpeeds(StopIncrement increment) {
    switch (increment) {
      case StopIncrement.full:
        return _fullStopShutterSpeeds;
      case StopIncrement.half:
        return _halfStopShutterSpeeds;
      case StopIncrement.third:
        return _thirdStopShutterSpeeds;
    }
  }

static num roundToNearestShutterSpeed(double seconds, StopIncrement increment) {
  return _roundToNearestShutterSpeed( seconds,  increment);
}
  static num _roundToNearestShutterSpeed(double seconds, StopIncrement increment) {
    final shutterSpeeds = _getShutterSpeeds(increment);
    num closestSpeed = shutterSpeeds[0];
    double minDifference = (seconds - closestSpeed).abs();

    for (final speed in shutterSpeeds) {
      final difference = (seconds - speed).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestSpeed = speed;
      }
    }

    return closestSpeed;
  }

  static List<Map<String, dynamic>> calculateRecommendations({
    required String condition,
    required double aperture,
    required CameraSettings settings,
  }) {
    final ev = _evValues[condition] ?? 15;
    final recommendations = <Map<String, dynamic>>[];

    for (final iso in settings.isoValues) {
      // Calculate base shutter speed
      double? shutterSpeed = pow(aperture, 2) / (iso / 100 * pow(2, ev));
      
      // Convert to reciprocal (1/x format)
      shutterSpeed = 1 / shutterSpeed;

      // Round to the nearest standard shutter speed
    shutterSpeed = _roundToNearestShutterSpeed(shutterSpeed, settings.stopIncrement).toDouble();

      // Check against camera limits
      if (shutterSpeed >= settings.minShutterSpeed && 
          shutterSpeed <= settings.maxShutterSpeed) {
        recommendations.add({
          'iso': iso,
          'shutter_speed': _formatShutterSpeed(shutterSpeed),
        });
      }
    }

    return recommendations;
  }

  static String _formatShutterSpeed(double seconds) {
    if (seconds >= 1) return '${seconds.toStringAsFixed(1)}s';
    return '1/${(1 / seconds).toStringAsFixed(0)}s';
  }
}