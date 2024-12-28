import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiEndpoints {
  static const String baseUrl = 'https://apishpt.doctorsaigon.net/api/v2/his/DataTest';
  // static const String getDsluotDichVu = "/dsluotdichvu";
  // static const String getDsDoanhThu = "/dsdoanhthu";
  // static const String getDsDoanhThuTheObs = "/dsdoanhthutheobs";
  // static const String getDsDoanhThuTheObsThucHien = "/dsdoanhthutheobsthuchien";
  
  static const port = 8080;
  static String get customBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:$port/api';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:$port/api';
    } else if (Platform.isIOS || Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return 'http://localhost:$port/api';
    } else {
      throw Exception('Unsupported platform');
    }
  }
  
  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
  
  static String getFullCustomUrl(String endpoint) {
    return '$customBaseUrl$endpoint';
  }
}
