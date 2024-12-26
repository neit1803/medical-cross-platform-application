class WorkingShift {
  final String id;
  final String doctor_name;
  final String room;
  final String date;
  final String startShift;
  final String endShift;
  final String? title;
  
  WorkingShift({
    required this.id,
    required this.doctor_name,
    this.title = "",
    required this.room,
    required this.date,
    required this.startShift,
    required this.endShift,
  });

  factory WorkingShift.fromJson(Map<String, dynamic> json) {
    return WorkingShift(
      id: json['id'],
      doctor_name: json['doctor_name'],
      title: json['title'],
      room: json['room'],
      date: json['date'],
      startShift: json['startShift'],
      endShift: json['endShift'],
    );
  }
}