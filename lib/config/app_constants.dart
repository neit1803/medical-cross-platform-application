import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/colors.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    primary: primaryColorLight,
    onPrimary: whiteLight,
    secondary: greenLight,
    onSecondary: whiteLight,
    tertiary: blueLight,
    onTertiary: yellowLight,
    background: gray2Light,
    surface: whiteLight,
    onSurface: blackColorLight,
    error: salmonLight,
    onError: successTextColorLight,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: whiteLight,
    foregroundColor: const Color.fromARGB(255, 15, 11, 11),
  ),
  scaffoldBackgroundColor: whiteLight,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.bold, fontSize: 24),
    displayMedium: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.bold, fontSize: 21),
    titleLarge: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w400, fontSize: 16),
    titleMedium: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 14),
    bodyLarge: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w400, fontSize: 14),
    bodyMedium: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w400, fontSize: 12),
    labelLarge: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 10),
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    primary: primaryColorDark,
    onPrimary: whiteDark,
    secondary: greenDark,
    tertiary: blueDark,
    onTertiary: yellowDark,
    onSecondary: whiteDark,
    background: gray1Dark,
    surface: gray3Dark,
    onSurface: whiteDark,
    error: salmonDark,
    onError: successTextColorDark,
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: gray2Dark,
    foregroundColor: whiteDark,
  ),
  scaffoldBackgroundColor: gray1Dark,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: primaryTextColorDark, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 32),
    displayMedium: TextStyle(color: primaryTextColorDark, fontFamily: 'TT Hoves', fontWeight: FontWeight.w400, fontSize: 28),
    titleLarge: TextStyle(color: primaryTextColorDark, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 22),
    bodyLarge: TextStyle(color: primaryTextColorDark, fontFamily: 'TT Hoves', fontSize: 10),
    bodyMedium: TextStyle(color: primaryTextColorDark, fontFamily: 'TT Hoves', fontSize: 14),
    labelLarge: TextStyle(color: primaryTextColorDark, fontFamily: 'TT Hoves', fontSize: 12),
    titleMedium: TextStyle(color: primaryTextColorDark, fontFamily: 'TT Hoves', fontSize: 16),
  ),
);

// Devices 
enum Devices {
  Ios,
  Android,
  Linux,
  Web,
  Desktop
}

// Charts
enum Charts {
  Pie,
  Bar,
  Line
}

// Base Colors for chart's items
List<Color> generateDistinctColors(int count) {
  return List<Color>.generate(count, (index) {
    final hue = (index * 360 / count) % 360;
    return HSVColor.fromAHSV(1.0, hue, 0.7, 0.9).toColor();
  });
}

