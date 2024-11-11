class ApiEndpoints {
  static const String baseUrl = "https://api.example.com";

  static const String getDsluotDichVu = "/dsluotdichvu";
  static const String getDsDoanhThu = "/dsdoanhthu";
  static const String getDsDoanhThuTheObs = "/dsdoanhthutheobs";
  static const String getDsDoanhThuTheObsThucHien = "/dsdoanhthutheobsthuchien";

  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
