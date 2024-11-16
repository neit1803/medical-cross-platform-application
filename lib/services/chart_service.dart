import 'dart:ui';

import 'package:flutter/material.dart';

class ChartService {
  List getValues(List<dynamic> data) {
      return data.map((item) => item.value).toList();
  }

  List getLabels(List<dynamic> data) {
      return data.map((item) => item.ten).toList();
  }

  List getColors(List<dynamic> data) {
      return data.map((item) => item.color).toList();
  }

  static double calculateTotalValue(List<double> data) {
    return data.fold(0, (sum, item) => sum + (item as double));
  }

  static Color parseColor(String colorString) {
    if (colorString.startsWith('#') && colorString.length == 9) {
      try {
        return Color(int.parse(colorString.replaceFirst('#', ''), radix: 16) | 0xFF000000);
      } catch (e) {
        print("Invalid color format: $colorString, error: $e");
        return Colors.grey;
      }
    }
    print("Invalid color string 111: $colorString");
    return Colors.grey;
  } 

}