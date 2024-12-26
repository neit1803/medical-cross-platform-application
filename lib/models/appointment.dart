class Appointment {
  final String id;
  final String title;
  final DateTime dateTime;

  Appointment({
    required this.id,
    required this.title,
    required this.dateTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      title: json['title'],
      dateTime: json['dateTime'],
    );
  }
}