import 'package:flutter_application_1/api/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static Future<http.Response> getBase(String endpoint) async {
    final url = Uri.parse(ApiEndpoints.getFullUrl(endpoint));
    return await http.get(url);
  }
}
