class Doctor {
  String _color;
  final String? id;
  final double value;
  final String title;
  final String ghichu;
  final String obdata;
  final String ma;
  final String ten;
  final String loai;
  final String ten1;

  Doctor({
    required String color,
    this.id = "",
    required this.value,
    required this.title,
    required this.ghichu,
    required this.obdata,
    required this.ma,
    required this.ten,
    required this.loai,
    required this.ten1,
  }) : _color = color;

  String get color => _color;

  set color(String newColor) {
    _color = newColor;
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      color: json['color'],
      id: json['id'],
      value: json['value'],
      title: json['title'],
      ghichu: json['ghichu'],
      obdata: json['obdata'],
      ma: json['ma'],
      ten: json['ten'],
      loai: json['loai'],
      ten1: json['ten1'],
    );
  }

  List<Doctor> parseDoctors(List<dynamic> jsonData) {
    return jsonData.map((json) => Doctor.fromJson(json)).toList();
  }
}