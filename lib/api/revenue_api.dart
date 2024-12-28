import 'package:flutter_application_1/api/api_client.dart';
import 'package:http/http.dart';

class RevenueAPI {
  static Future<Response> fetchRevenue() async {
    return await ApiClient.getBase("");
  }

  static Future<Response> fetchDoctors() async {
    return await ApiClient.getCustomBase("/doctors");
  }

  static Future<Response> fetchAppointments() async {
    return await ApiClient.getCustomBase("/appointments");
  }

  static Future<Response> fetchAppointmentsByDate(DateTime date) async {
    return await ApiClient.getCustomBase("/appointments/date/${date.toIso8601String()}");
  }

  static Future<Response> fetchWorkingShifts() async {
    return await ApiClient.getCustomBase("/working-shifts");
  }
  
  static Future<Response> fetchWorkingShiftsByDoctor(String doctorName) async {
    return await ApiClient.getCustomBase("/working-shifts/doctor-name?doctorName=$doctorName");
  }
}
