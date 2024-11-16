class ParaclinicalDoctor {
  final String ma;
  final String ten;

  ParaclinicalDoctor({required this.ma, required this.ten});

  factory ParaclinicalDoctor.fromJson(Map<String, dynamic> json) {
    return ParaclinicalDoctor(
      ma: json['ma'],
      ten: json['ten'],
    );
  }
}