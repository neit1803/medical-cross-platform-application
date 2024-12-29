import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/appointment.dart';

abstract class AppointmentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<List<Appointment>> formattedAppointments;

  AppointmentLoaded(this.formattedAppointments);

  @override
  List<Object?> get props => [formattedAppointments];
}

class AppointmentError extends AppointmentState {
  final String message;

  AppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}
