class WorkingShift {
  final String? id;
  final String doctorName;
  final String room;
  final String date;
  final String startShift;
  final String endShift;
  final String? title;
  
  WorkingShift({
    this.id = "",
    required this.doctorName,
    this.title = "",
    required this.room,
    required this.date,
    required this.startShift,
    required this.endShift,
  });

  factory WorkingShift.fromJson(Map<String, dynamic> json) {
    return WorkingShift(
      id: json['id'],
      doctorName: json['doctorName'],
      title: json['title'],
      room: json['room'],
      date: json['date'],
      startShift: json['startShift'],
      endShift: json['endShift'],
    );
  }
}