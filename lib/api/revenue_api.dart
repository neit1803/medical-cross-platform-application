import 'package:flutter_application_1/api/api_c;lient.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RevenueAPI {
  static Future<Response> fetchRevenue() async {
    return await ApiClient.getBase("");
  }
}
