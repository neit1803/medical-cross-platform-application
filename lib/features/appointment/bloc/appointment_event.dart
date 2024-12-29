import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAppointments extends AppointmentEvent {
  final DateTime date;

  FetchAppointments(this.date);

  @override
  List<Object?> get props => [date];
}