// home_screen.dart
import 'package:flutter/material.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/settings_screen.dart';
import 'package:sunny16/sunny16_calculator.dart';
import 'package:sunny16/condition_selector.dart';
import 'package:sunny16/aperture_slider.dart';

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
    final updatedSettings = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );

    if (updatedSettings != null) {
      setState(() {
        _currentSettings = updatedSettings;
      });
    }
  }

  void _onConditionSelected(String condition) {
    setState(() {
      _selectedCondition = condition;
      _calculate();
    });
  }

  void _onApertureSelected(int index) {
    setState(() {
      _sliderValue = index;
      _selectedAperture = _apertureValues[_sliderValue];
      _calculate();
    });
  }

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
            ConditionSelector(
              weatherIcons: _weatherIcons,
              selectedCondition: _selectedCondition,
              onConditionSelected: _onConditionSelected,
            ),
            // Aperture Selector
            ApertureSlider(
              apertureValues: _apertureValues,
              sliderValue: _sliderValue,
              onApertureSelected: _onApertureSelected,
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
