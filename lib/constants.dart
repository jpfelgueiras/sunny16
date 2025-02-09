import 'package:flutter/material.dart';

const Map<String, IconData> weatherIcons = {
  'sunny': Icons.wb_sunny,
  'light_clouds': Icons.wb_cloudy,
  'cloudy': Icons.cloud,
  'overcast': Icons.cloud_queue,
  'sunset': Icons.brightness_3,
};

const List<double> apertureValues = [
  1.4,
  2.0,
  2.8,
  4.0,
  5.6,
  8.0,
  11.0,
  16.0,
];

const Map<String, int> evValues = {
  'sunny': 15,
  'light_clouds': 14,
  'cloudy': 13,
  'overcast': 12,
  'sunset': 10,
};

final List<double> fullStopShutterSpeeds =
    calculateShutterSpeeds(1 / 8000, 18, 2);
final List<double> halfStopShutterSpeeds =
    calculateShutterSpeeds(1 / 8000, 34, 1.5);
final List<double> thirdStopShutterSpeeds =
    calculateShutterSpeeds(1 / 8000, 52, 1.333);

List<double> calculateShutterSpeeds(double baseSpeed, int stops, double step) {
  List<double> speeds = [];
  for (int i = 0; i <= stops; i++) {
    speeds.add(baseSpeed / (step * i));
  }
  return speeds;
}
