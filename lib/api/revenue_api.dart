import 'package:flutter_application_1/api/api_client.dart';
import 'package:http/http.dart';

class RevenueAPI {
  static Future<Response> fetchRevenue() async {
    return await ApiClient.getBase("");
  }
}
