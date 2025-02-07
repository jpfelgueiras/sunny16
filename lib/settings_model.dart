// settings_model.dart
enum StopIncrement { full, half, third }

class CameraSettings {
  final List<int> isoValues;
  final double minShutterSpeed;
  final double maxShutterSpeed;
  final StopIncrement stopIncrement; // Add this field

  CameraSettings.defaultSettings()
    : isoValues = [100, 200, 400, 800, 1600],
      minShutterSpeed = 1 / 4000,
      maxShutterSpeed = 30,
      stopIncrement = StopIncrement.third;
  CameraSettings({
    required this.isoValues,
    required this.minShutterSpeed,
    required this.maxShutterSpeed,
    this.stopIncrement = StopIncrement.third, // Default to third stops
  });
}