// home_screen.dart
import 'package:flutter/material.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/settings_screen.dart';
import 'package:sunny16/sunny16_calculator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  CameraSettings? _currentSettings;
  String? _selectedCondition;
  double? _selectedAperture;
  List<Map<String, dynamic>> _recommendations = [];
  final Map<String, IconData> _weatherIcons = {
    'sunny': Icons.wb_sunny,
    'light_clouds': Icons.wb_cloudy,
    'cloudy': Icons.cloud,
    'overcast': Icons.cloud_queue,
    'sunset': Icons.brightness_3,
  };

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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select all parameters')));
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

  Widget _buildWeatherIcon(String condition, IconData icon) {
    return IconButton(
      icon: Icon(icon,
          size: 40,
          color: _selectedCondition == condition ? Colors.blue : Colors.grey),
      onPressed: () {
        setState(() {
          _selectedCondition = condition;
          _calculate();
        });
      },
    );
  }

  // Define aperture values
  final List<double> _apertureValues = [
    1.4,
    2.0,
    2.8,
    4.0,
    5.6,
    8.0,
    11.0,
    16.0
  ];
  int _sliderValue = 1; // Slider index

  Widget _buildApertureSlider() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Aperture",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _apertureValues.length,
                  itemBuilder: (context, index) {
                    if ((index - _sliderValue).abs() > 1) {
                      return Container(
                          width: 80); // Empty space for non-adjacent values
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _sliderValue = index;
                          _selectedAperture = _apertureValues[_sliderValue];
                          _calculate();
                        });
                      },
                      child: Container(
                        width: 80,
                        alignment: Alignment.center,
                        child: Text(
                          "f/${_apertureValues[index]}",
                          style: TextStyle(
                            fontSize: _sliderValue == index ? 24 : 18,
                            color: _sliderValue == index
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sunny 16 Calculator'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSettings, // Open settings screen
          ),
        ],
      ),
      body: Padding(
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
