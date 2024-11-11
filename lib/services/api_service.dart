class ApiService {
  
  double getTotalIncome(Map data) {
    return data['obdata']['tongdoanhthu'];
  }

  double calculateTotalValue(List<dynamic> data) {
    return data.fold(0, (sum, item) => sum + (item['value'] as double));
  }

  List<dynamic> getServiceIncomeList(Map data) {
    return data['obdata']['dsluotdichvu'];
  }

  List<dynamic> getRevenueList(Map data) {
    return data['obdata']['dsdoanhthu'];
  }

  List<dynamic> getRevenueByDoctorList(Map data) {
    return data['obdata']['dsdoanhthutheobs'];
  }

  List<dynamic> getRevenueByPerformingDoctorList(Map data) {
    return data['obdata']['dsdoanhthutheobsthuchien'];
  }

  List<double> getValues (List<dynamic> data) {
    return data.map((item) => item['value'] as double).toList();
  }

  List<String> getTitles (List<dynamic> data) {
    return data.map((item) => item['ten'] as String).toList();
  }
}