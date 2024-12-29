import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/doctor/bloc/doctor_bloc.dart';
import 'package:flutter_application_1/features/doctor/bloc/doctor_event.dart';
import 'package:flutter_application_1/features/doctor/bloc/doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/models/doctor.dart';
import 'package:flutter_application_1/widgets/appbar/app_bar.dart';
import 'package:flutter_application_1/widgets/calendar/doctor_shift.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';


class DetaileDoctorScreen extends StatefulWidget {
  final bool isLightTheme;
  final bool isSmall;

  const DetaileDoctorScreen({
    super.key,
    required this.isLightTheme,
    required this.isSmall,
  });

  @override
  State<DetaileDoctorScreen> createState() => _DetaileDoctorScreenState();
}

class _DetaileDoctorScreenState extends State<DetaileDoctorScreen> {
  void _showDoctorWorkingShifts(Doctor doctor) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.4,
            child: DoctorShiftCalendar(
              doctorName: doctor.ten,
              isLightTheme: widget.isLightTheme,
              isFullScreen: false, 
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int columnCount = widget.isSmall ? 1 : 4;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        showSearchBar: false,
        isLightTheme: widget.isLightTheme,
        onThemeToggle: (value) {},
        isSmall: widget.isSmall,
      ),
      body: BlocProvider(
        create: (_) => DoctorBloc()..add(FetchDoctorsEvent()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: BlocBuilder<DoctorBloc, DoctorState>(
            builder: (context, state) {
              if (state is DoctorLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DoctorLoaded) {
                final doctors = state.doctors;

                return SingleChildScrollView(
                  child: LayoutGrid(
                    columnGap: 30,
                    rowGap: 30,
                    columnSizes: List.generate(columnCount, (_) => 1.fr),
                    rowSizes: List.generate((doctors.length / columnCount).ceil(), (_) => auto),
                    children: List.generate(doctors.length, (index) {
                      final doctor = doctors[index];
                      return GestureDetector(
                        onTap: () => _showDoctorWorkingShifts(doctor),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.network(
                                    "https://avatar.iran.liara.run/public/${(index % 100) + 1}",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(doctor.ten),
                                      Text(
                                        doctor.loai == 'bschidinh'
                                            ? 'Bác Sĩ Chỉ Định'
                                            : 'Bác Sĩ Thực Hiện',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              } else if (state is DoctorError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No doctors available.'));
            },
          ),
        ),
      ),
    );
  }
}
