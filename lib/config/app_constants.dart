import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/colors.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: primaryColorLight,
    onPrimary: whiteLight,
    secondary: greenLight,
    onSecondary: whiteLight,
    background: whiteLight,
    surface: gray2Light,
    onSurface: blackColorLight,
    error: salmonLight,
    onError: whiteLight,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColorLight,
    foregroundColor: whiteLight,
  ),
  scaffoldBackgroundColor: whiteLight,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 32),
    displayMedium: TextStyle(color: primaryTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w400, fontSize: 28),
    titleLarge: TextStyle(color: highlightTextColorLight, fontFamily: 'TT Hoves', fontWeight: FontWeight.w500, fontSize: 22),
    bodyLarge: TextStyle(color: secondaryTextColorLight, fontFamily: 'TT Hoves', fontSize: 16),
    bodyMedium: TextStyle(color: secondaryTextColorLight, fontFamily: 'TT Hoves', fontSize: 14),
    labelLarge: TextStyle(color: errorTextColorLight, fontFamily: 'TT Hoves', fontSize: 12),
    titleMedium: TextStyle(color: successTextColorLight, fontFamily: 'TT Hoves', fontSize: 16),
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: primaryColorDark,
    onPrimary: whiteDark,
    secondary: greenDark,
    onSecondary: whiteDark,
    background: gray1Dark,
    surface: gray2Dark,
    onSurface: whiteDark,
    error: salmonDark,
    onError: whiteDark,
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: gray1Dark,
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
