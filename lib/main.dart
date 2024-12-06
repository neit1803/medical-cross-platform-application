import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_constants.dart';
import 'package:flutter_application_1/features/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLightTheme = false;

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLightTheme = prefs.getBool('isLightTheme') ?? true;
    });
  }

  Future<void> _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLightTheme', value);
  }

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _isLightTheme ? lightTheme : darkTheme,
      home: HomeScreen(
        onThemeChanged: (bool isLightTheme) async {
          await _saveThemePreference(isLightTheme);
          setState(() {
            _isLightTheme = isLightTheme;
          });
        },
        isLightTheme: _isLightTheme,
      ),
    );
  }
}
