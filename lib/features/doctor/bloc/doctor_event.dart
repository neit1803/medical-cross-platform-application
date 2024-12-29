
import 'package:equatable/equatable.dart';

abstract class DoctorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDoctorsEvent extends DoctorEvent {}
