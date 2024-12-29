import 'dart:convert';

import 'package:flutter_application_1/api/revenue_api.dart';
import 'package:flutter_application_1/models/appointment.dart';
import 'package:flutter_application_1/models/doctor.dart';
import 'package:flutter_application_1/models/hospital.dart';
import 'package:flutter_application_1/models/paraclinical_doctor.dart';
import 'package:flutter_application_1/models/revenue.dart';
import 'package:flutter_application_1/models/working_shift.dart';

class ApiService {
  static Future<Map<String, dynamic>> fetchData() async {
    Map<String, dynamic> resp = {
      "dsluotdichvu": [],
      "dsdoanhthu": [],
      "dsdoanhthutheobs": [],
      "dsdoanhthutheobsthuchien": [],
      "dstilebacsicanlamsang": [],
      "dsbenhvien": [],
      "ngay": "",
    };

    try {
      final response = await RevenueAPI.fetchRevenue();

      final statusCode = jsonDecode(response.body)['statusCode'];
      if (statusCode != 200) {
        throw Exception('Failed to load data: $statusCode');
      }

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final bodyData = jsonData['body'];
      final decodedBodyData = jsonDecode(bodyData);
      final obdata = decodedBodyData['obdata'];
      final parsedObdata = jsonDecode(obdata);

      resp['dsluotdichvu'] = getServiceIncomeList(parsedObdata);
      resp['dsdoanhthu'] = getRevenueList(parsedObdata);
      resp['dsdoanhthutheobs'] = getRevenueByDoctorList(parsedObdata);
      resp['dsdoanhthutheobsthuchien'] = getRevenueByPerformingDoctorList(parsedObdata);
      resp['dstilebacsicanlamsang'] = getServiceIncomeList(parsedObdata);
      resp['dsbenhvien'] = getHospitals(parsedObdata);
      resp['ngay'] = getDate(decodedBodyData);

      return resp;
    } on FormatException catch (e) {
      print('JSON Parsing Error: $e');
      rethrow;
    } catch (e) {
      print('Unexpected Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  static List<Revenue> getServiceIncomeList(Map data) {
    final rawData = data['dsluotdichvu'];
    final List<dynamic> serviceList = rawData is String ? jsonDecode(rawData) : rawData;
    return serviceList
        .map((item) => Revenue.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<dynamic> getRevenueList(Map data) {
    final rawData = data['dsdoanhthu'];
    final List<dynamic> serviceList = rawData is String ? jsonDecode(rawData) : rawData;
    return serviceList
        .map((item) => Revenue.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<dynamic> getRevenueByDoctorList(Map data) {
    final rawData = data['dsdoanhthutheobs'];
    final List<dynamic> serviceList = rawData is String ? jsonDecode(rawData) : rawData;
    return serviceList
        .map((item) => Doctor.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<dynamic> getRevenueByPerformingDoctorList(Map data) {
    final rawData = data['dsdoanhthutheobsthuchien'];
    final List<dynamic> serviceList = rawData is String ? jsonDecode(rawData) : rawData;
    return serviceList
        .map((item) => Doctor.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<dynamic> getClinicalDoctor(Map data) {
    final rawData = data['dstilebacsicanlamsang'];
   final List<dynamic> serviceList = rawData is String ? jsonDecode(rawData) : rawData;
    return serviceList
        .map((item) => ParaclinicalDoctor.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<dynamic> getHospitals(Map data) {
    final rawData = data['dsbenhvien'];
    final List<dynamic> serviceList = rawData is String ? jsonDecode(rawData) : rawData;
    return serviceList
        .map((item) => Hospital.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static String getDate(Map data) {
    return data['ngay']?.toString() ?? '0';
  }

  static Future<List<Doctor>> fetchDoctors() async {
    final response = await RevenueAPI.fetchDoctors();
    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = jsonDecode(responseBody);
        return jsonData.map((item) => Doctor.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Appointment>> fetchAppointments() async {
    try {
      final response = await RevenueAPI.fetchAppointments();
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = jsonDecode(responseBody);
          return jsonData.map((item) {
          try {
            return Appointment.fromJson(item as Map<String, dynamic>);
          } catch (e) {
            print('Error parsing appointment: $item, Error: $e');
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('Failed to load appointments');
      }
    } on FormatException catch (e) {
      print('JSON Parsing Error: $e');
      rethrow;
    } catch (e) {
      print('Unexpected Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<List<Appointment>> fetchAppointmentsByDate(DateTime date) async {
    try {
      final response = await RevenueAPI.fetchAppointmentsByDate(date);
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = jsonDecode(responseBody);
        return jsonData.map((item) {
          try {
            return Appointment.fromJson(item as Map<String, dynamic>);
          } catch (e) {
            print('Error parsing appointment: $item, Error: $e');
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('Failed to load appointments');
      }
    } on FormatException catch (e) {
      print('JSON Parsing Error: $e');
      rethrow;
    } catch (e) {
      print('Unexpected Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<List<WorkingShift>> fetchWorkingShifts() async {
    final response = await RevenueAPI.fetchWorkingShifts();
    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = jsonDecode(responseBody);
        return jsonData.map((item) => WorkingShift.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  
  static Future<List<WorkingShift>> fetchWorkingShiftsByDoctor(String doctorName) async {
    try {
      final response = await RevenueAPI.fetchWorkingShiftsByDoctor(doctorName);
      
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = jsonDecode(responseBody);
        return jsonData.map((item) => WorkingShift.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        print('Failed to load working shifts: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load working shifts');
      }
    } catch (e) {
      print('Error fetching working shifts: $e');
      rethrow;
    }
  }

}