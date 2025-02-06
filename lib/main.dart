import 'package:flutter/material.dart';
import 'package:sunny16/home_screen.dart';
import 'package:sunny16/settings_repository.dart';
import 'package:sunny16/settings_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: SettingsRepository().loadSettings(),
        builder: (context, snapshot) =>
            snapshot.hasData ? HomeScreen() : SettingsScreen(),
      ),
    );
  }
}