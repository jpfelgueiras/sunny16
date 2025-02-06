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

  static List<Map<String, dynamic>> calculateRecommendations({
    required String condition,
    required double aperture,
    required CameraSettings settings,
  }) {

    final ev = _evValues[condition] ?? 15;
    final recommendations = <Map<String, dynamic>>[];

    for (final iso in settings.isoValues) {

      // Calculate base shutter speed
      double shutterSpeed = pow(aperture, 2) / (iso / 100 * pow(2, ev));
      
      // Convert to reciprocal (1/x format)
      shutterSpeed = 1 / shutterSpeed;

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
    if (seconds >= 1) return '${seconds.toStringAsFixed(0)}s';
    return '1/${(1/seconds).toStringAsFixed(0)}s';
  }
}