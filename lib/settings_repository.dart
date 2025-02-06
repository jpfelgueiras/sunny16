// settings_repository.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunny16/settings_model.dart';

class SettingsRepository {
  static const _keyISO = 'iso_values';
  static const _keyMinShutter = 'min_shutter';
  static const _keyMaxShutter = 'max_shutter';
  static const _keyStopIncrement = 'stop_increment'; // New key

  Future<void> saveSettings(CameraSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyISO, settings.isoValues.map((e) => e.toString()).toList());
    await prefs.setDouble(_keyMinShutter, settings.minShutterSpeed);
    await prefs.setDouble(_keyMaxShutter, settings.maxShutterSpeed);
    await prefs.setString(_keyStopIncrement, settings.stopIncrement.toString()); // Save stop increment
  }

  Future<CameraSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return CameraSettings(
      isoValues: prefs.getStringList(_keyISO)?.map(int.parse).toList() ?? [100, 200, 400, 800],
      minShutterSpeed: prefs.getDouble(_keyMinShutter) ?? 1 / 4000,
      maxShutterSpeed: prefs.getDouble(_keyMaxShutter) ?? 30,
      stopIncrement: _parseStopIncrement(prefs.getString(_keyStopIncrement)), // Load stop increment
    );
  }

  StopIncrement _parseStopIncrement(String? value) {
    switch (value) {
      case 'StopIncrement.full':
        return StopIncrement.full;
      case 'StopIncrement.half':
        return StopIncrement.half;
      default:
        return StopIncrement.third; // Default to third stops
    }
  }
}