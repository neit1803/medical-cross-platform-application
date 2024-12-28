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
    try {
      DateTime parsedDateTime;

      if (json['dateTime'] is Map<String, dynamic>) {
        // Firestore timestamp format
        final timestamp = json['dateTime'];
        final seconds = timestamp['seconds'] as int;
        final nanos = timestamp['nanos'] as int;
        parsedDateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000)
            .add(Duration(microseconds: nanos ~/ 1000));
      } else if (json['dateTime'] is String) {
        parsedDateTime = DateTime.parse(json['dateTime']);
      } else {
        throw FormatException(
            "Unsupported dateTime format: ${json['dateTime']?.toString()}");
      }

      return Appointment(
        id: json['id'] as String,
        title: json['title'] as String,
        dateTime: parsedDateTime,
      );
    } catch (e) {
      throw FormatException("Error parsing Appointment: $e");
    }
}

}
