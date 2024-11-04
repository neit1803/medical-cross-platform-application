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
    background: gray2Light,
    surface: whiteLight,
    onSurface: blackColorLight,
    error: salmonLight,
    onError: whiteLight,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: whiteLight,
    foregroundColor: const Color.fromARGB(255, 15, 11, 11),
  ),
  scaffoldBackgroundColor: whiteLight,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 24),
    displayMedium: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 21),
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
    onSecondary: whiteDark,
    background: gray1Dark,
    surface: gray3Dark,
    onSurface: whiteDark,
    error: salmonDark,
    onError: whiteDark,
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
    titleLarge: TextStyle(color: highlightTextColorDark, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 22),
    bodyLarge: TextStyle(color: secondaryTextColorDark, fontFamily: 'TT Hoves', fontSize: 16),
    bodyMedium: TextStyle(color: secondaryTextColorDark, fontFamily: 'TT Hoves', fontSize: 14),
    labelLarge: TextStyle(color: errorTextColorDark, fontFamily: 'TT Hoves', fontSize: 12),
    titleMedium: TextStyle(color: successTextColorDark, fontFamily: 'TT Hoves', fontSize: 16),
  ),
);
