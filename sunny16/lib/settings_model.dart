// settings_model.dart
import 'package:shared_preferences/shared_preferences.dart';

class CameraSettings {
  final List<int> isoValues;
  final double minShutterSpeed; // in seconds (e.g., 1/4000 = 0.00025)
  final double maxShutterSpeed; // in seconds (e.g., 30s = 30)

  CameraSettings({
    required this.isoValues,
    required this.minShutterSpeed,
    required this.maxShutterSpeed,
  });
}

// settings_repository.dart
class SettingsRepository {
  static const _keyISO = 'iso_values';
  static const _keyMinShutter = 'min_shutter';
  static const _keyMaxShutter = 'max_shutter';

  Future<void> saveSettings(CameraSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyISO, settings.isoValues.map((e) => e.toString()).toList());
    await prefs.setDouble(_keyMinShutter, settings.minShutterSpeed);
    await prefs.setDouble(_keyMaxShutter, settings.maxShutterSpeed);
  }

  Future<CameraSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return CameraSettings(
      isoValues: prefs.getStringList(_keyISO)?.map(int.parse).toList() ?? [100, 200, 400, 800],
      minShutterSpeed: prefs.getDouble(_keyMinShutter) ?? 1/4000,
      maxShutterSpeed: prefs.getDouble(_keyMaxShutter) ?? 30,
    );
  }
}