import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_application_1/features/appointment/bloc/appointment_event.dart';
import 'package:flutter_application_1/features/appointment/bloc/appointment_state.dart';
import 'package:flutter_application_1/services/api_service.dart';


class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<FetchAppointments>(_onFetchAppointments);
  }

  Future<void> _onFetchAppointments(
    FetchAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(AppointmentLoading());
    try {
      final appointments = await ApiService.fetchAppointmentsByDate(event.date);
      final formattedAppointments = appointments.slices(4).toList();
      emit(AppointmentLoaded(formattedAppointments));
    } catch (e) {
      emit(AppointmentError("Failed to fetch appointments: $e"));
    }
  }
}