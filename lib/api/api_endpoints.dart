class ApiEndpoints {
  static const String baseUrl = 'https://apishpt.doctorsaigon.net/api/v2/his/DataTest';

  // static const String getDsluotDichVu = "/dsluotdichvu";
  // static const String getDsDoanhThu = "/dsdoanhthu";
  // static const String getDsDoanhThuTheObs = "/dsdoanhthutheobs";
  // static const String getDsDoanhThuTheObsThucHien = "/dsdoanhthutheobsthuchien";

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  
  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }

}
