// settings_model.dart
enum StopIncrement { full, half, third }

class CameraSettings {
  final List<int> isoValues;
  final double minShutterSpeed;
  final double maxShutterSpeed;
  final StopIncrement stopIncrement; // Add this field

  CameraSettings({
    required this.isoValues,
    required this.minShutterSpeed,
    required this.maxShutterSpeed,
    this.stopIncrement = StopIncrement.third, // Default to third stops
  });
}