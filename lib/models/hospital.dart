class Hospital {
  final String ma;
  final String ten;

  Hospital({required this.ma, required this.ten});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      ma: json['ma'],
      ten: json['ten'],
    );
  }
}