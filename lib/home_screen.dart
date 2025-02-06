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
            if (_currentSettings != null)
              Text('Current ISO Values: ${_currentSettings!.isoValues.join(', ')}'),
            // Condition Selector
            DropdownButton<String>(
              hint: Text('Select Weather Condition'),
              value: _selectedCondition,
              items: const [
                DropdownMenuItem(value: 'sunny', child: Text('Sunny')),
                DropdownMenuItem(value: 'light_clouds', child: Text('Light Clouds')),
                DropdownMenuItem(value: 'cloudy', child: Text('Cloudy')),
                DropdownMenuItem(value: 'overcast', child: Text('Overcast')),
                DropdownMenuItem(value: 'sunset', child: Text('Sunset')),
              ],
              onChanged: (v) => setState(() => _selectedCondition = v),
            ),

            // Aperture Selector
            DropdownButton<double>(
              hint: Text('Select Aperture'),
              value: _selectedAperture,
              items: [2, 2.8, 4, 5.6, 8, 11, 16, 22]
                  .map((f) => DropdownMenuItem(
                        value: f.toDouble(),
                        child: Text('f/$f'),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedAperture = v),
            ),

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