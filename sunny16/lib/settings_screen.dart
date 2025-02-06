// settings_screen.dart
import 'package:flutter/material.dart';
import 'package:sunny16/settings_model.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<int> _isoValues = [];
  final _minController = TextEditingController();
  final _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Load saved settings when the screen is initialized
  }

  Future<void> _loadSettings() async {
    final settings = await SettingsRepository().loadSettings();
    setState(() {
      _isoValues.addAll(settings.isoValues);
      _minController.text = settings.minShutterSpeed.toString();
      _maxController.text = settings.maxShutterSpeed.toString();
    });
  }

  Future<void> _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      final settings = CameraSettings(
        isoValues: _isoValues,
        minShutterSpeed: double.parse(_minController.text),
        maxShutterSpeed: double.parse(_maxController.text),
      );

      await SettingsRepository().saveSettings(settings);
      Navigator.pop(context, settings); // Return updated settings
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Settings'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // ISO Input Section
            Wrap(
              spacing: 8,
              children: _isoValues.map((iso) => Chip(
                label: Text('ISO $iso'),
                onDeleted: () => setState(() => _isoValues.remove(iso)),
              )).toList(),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                setState(() => _isoValues.add(int.parse(value)));
              },
              decoration: InputDecoration(labelText: 'Add ISO Value'),
            ),
            
            // Shutter Speed Inputs
            TextFormField(
              controller: _minController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              decoration: InputDecoration(labelText: 'Min Shutter Speed (s)'),
            ),
            TextFormField(
              controller: _maxController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              decoration: InputDecoration(labelText: 'Max Shutter Speed (s)'),
            ),
            
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}