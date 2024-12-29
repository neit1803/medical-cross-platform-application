import 'package:flutter_application_1/features/doctor/bloc/doctor_event.dart';
import 'package:flutter_application_1/features/doctor/bloc/doctor_state.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitial()) {
    on<FetchDoctorsEvent>(_onFetchDoctors);
  }

  Future<void> _onFetchDoctors(FetchDoctorsEvent event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      final doctors = await ApiService.fetchDoctors();
      emit(DoctorLoaded(doctors: doctors));
    } catch (error) {
      emit(DoctorError(message: 'Failed to fetch doctors: ${error.toString()}'));
    }
  }
}
