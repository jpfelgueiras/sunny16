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
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final settings = snapshot.data;
            if (settings == null ||
                settings.isoValues.isEmpty ||
                settings.minShutterSpeed == 0 ||
                settings.maxShutterSpeed == 0) {
              return SettingsScreen();
            }
            return HomeScreen();
          } else {
            return SettingsScreen();
          }
        },
      ),
    );
  }
}
