// home_screen.dart
import 'package:flutter/material.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/settings_screen.dart';
import 'package:sunny16/sunny16_calculator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraSettings? _currentSettings;
  String? _selectedCondition;
  double? _selectedAperture;
  List<Map<String, dynamic>> _recommendations = [];

    @override
  void initState() {
    super.initState();
    _loadSettings();
  }

    Future<void> _loadSettings() async {
    final settings = await SettingsRepository().loadSettings();
    setState(() {
      _currentSettings = settings;
    });
  }

  Future<void> _calculate() async {
    final settings = await SettingsRepository().loadSettings();
    
    if (_selectedCondition == null || _selectedAperture == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select all parameters'))
      );
      return;
    }

    setState(() {
      _recommendations = Sunny16Calculator.calculateRecommendations(
        condition: _selectedCondition!,
        aperture: _selectedAperture!,
        settings: settings,
      );
    });
  }

  void _openSettings() async {
    // Navigate to SettingsScreen and wait for a result
    final updatedSettings = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );

    // If settings were updated, refresh the home screen
    if (updatedSettings != null) {
      setState(() {
        _currentSettings = updatedSettings;
      });
    }
  }
final Map<String, IconData> _weatherIcons = {
  'sunny': Icons.wb_sunny,
  'light_clouds': Icons.wb_cloudy,
  'cloudy': Icons.cloud,
  'overcast': Icons.cloud_queue,
  'sunset': Icons.brightness_3,
};


  Widget _buildWeatherIcon(String condition, IconData icon) {
    return IconButton(
      icon: Icon(icon, size: 40),
      color: _selectedCondition == condition ? Colors.blue : Colors.grey,
      onPressed: () {
        setState(() => _selectedCondition = condition);
      },
    );
  }

  // Define aperture values
final List<double> _apertureValues = [2, 2.8, 4, 5.6, 8, 11, 16, 22];
  int _sliderValue = 1; // Slider index

Widget _buildApertureSlider() {
    return Column(
      children: [
        Text(
          'Aperture: f/${_apertureValues[_sliderValue].toStringAsFixed(1)}',
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: _sliderValue.toDouble(),
          min: 0,
          max: _apertureValues.length - 1,
          divisions: _apertureValues.length - 1,
          label: 'f/${_apertureValues[_sliderValue].toStringAsFixed(1)}',
          onChanged: (value) {
            setState(() {
              _sliderValue = value.round();
              _selectedAperture = _apertureValues[_sliderValue];
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sunny 16 Calculator'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSettings, // Open settings screen
          ),
        ],
      ),body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Condition Selector
                        Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _weatherIcons.entries.map((entry) {
                return _buildWeatherIcon(entry.key, entry.value);
              }).toList(),
            ),

            // Aperture Selector
             _buildApertureSlider(),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Calculate'),
            ),
            // Results
            Expanded(
              child: ListView.builder(
                itemCount: _recommendations.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('ISO ${_recommendations[index]['iso']}'),
                  subtitle: Text(_recommendations[index]['shutter_speed']),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}