// sunny16_calculator.dart
import 'dart:math';

import 'package:sunny16/settings_model.dart';
import 'package:sunny16/constants.dart'; // Import the constants

class Sunny16Calculator {
  static const _weatherData = weatherData;

  static List<num> getShutterSpeeds(StopIncrement increment) {
    return _getShutterSpeeds(increment);
  }

  static List<num> _getShutterSpeeds(StopIncrement increment) {
    switch (increment) {
      case StopIncrement.full:
        return fullStopShutterSpeeds;
      case StopIncrement.half:
        return halfStopShutterSpeeds;
      case StopIncrement.third:
        return thirdStopShutterSpeeds;
    }
  }

  static num roundToNearestShutterSpeed(
      double seconds, StopIncrement increment) {
    return _roundToNearestShutterSpeed(seconds, increment);
  }

  static num _roundToNearestShutterSpeed(
      double seconds, StopIncrement increment) {
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
    final ev = _weatherData[condition]?['ev'] ?? 15;
    final recommendations = <Map<String, dynamic>>[];

    for (final iso in settings.isoValues) {
      // Calculate base shutter speed
      double? shutterSpeed = pow(aperture, 2) / (iso / 100 * pow(2, ev));

      // Round to the nearest standard shutter speed
      shutterSpeed =
          _roundToNearestShutterSpeed(shutterSpeed, settings.stopIncrement)
              .toDouble();

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

  static String formatShutterSpeed(double seconds) {
    return _formatShutterSpeed(seconds);
  }

  static String _formatShutterSpeed(double seconds) {
    if (seconds >= 1) return '${seconds.toStringAsFixed(1)}s';
    return '1/${(1 / seconds).toStringAsFixed(0)}s';
  }
}
