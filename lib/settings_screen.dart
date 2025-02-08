// settings_screen.dart
import 'package:flutter/material.dart';
import 'package:sunny16/settings_model.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/fraction_input_formatter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<int> _isoValues = [];
  final _minController = TextEditingController();
  final _maxController = TextEditingController();
  StopIncrement _stopIncrement = StopIncrement.third; // Default to third stops

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Load saved settings
  }

  Future<void> _loadSettings() async {
    final settings = await SettingsRepository().loadSettings();
    setState(() {
      _isoValues.addAll(settings.isoValues);
      _minController.text = FractionInputFormatter.doubleToFraction(settings.minShutterSpeed);
      _maxController.text = FractionInputFormatter.doubleToFraction(settings.maxShutterSpeed);
      _stopIncrement = settings.stopIncrement; // Load stop increment
    });
  }

  Future<void> _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      final settings = CameraSettings(
        isoValues: _isoValues,
        minShutterSpeed: FractionInputFormatter.parseFraction(_minController.text),
        maxShutterSpeed: FractionInputFormatter.parseFraction(_maxController.text),
        stopIncrement: _stopIncrement, // Save stop increment
      );

      await SettingsRepository().saveSettings(settings);
      Navigator.pop(context, settings); // Return updated settings
    }
  }

  Widget _buildStopIncrementSelector() {
    return DropdownButton<StopIncrement>(
      value: _stopIncrement,
      onChanged: (value) {
        setState(() => _stopIncrement = value!);
      },
      items: StopIncrement.values.map((increment) {
        return DropdownMenuItem(
          value: increment,
          child: Text(increment.toString().split('.').last),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Settings')),
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
              keyboardType: TextInputType.text,
              inputFormatters: [FractionInputFormatter()],
              validator: (v) => v!.isEmpty ? 'Required' : null,
              decoration: InputDecoration(labelText: 'Fastest Shutter Speed'),
            ),
            TextFormField(
              controller: _maxController,
              keyboardType: TextInputType.text,
              inputFormatters: [FractionInputFormatter()],
              validator: (v) => v!.isEmpty ? 'Required' : null,
              decoration: InputDecoration(labelText: 'Slowest Shutter Speed'),
            ),
            
            // Stop Increment Selector
            _buildStopIncrementSelector(),
            
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