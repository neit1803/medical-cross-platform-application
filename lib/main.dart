import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_constants.dart' as Constants;
import 'package:flutter_application_1/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Constants.darkTheme,
      home: HomeScreen(),
    );
  }
}
