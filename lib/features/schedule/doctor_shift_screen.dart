import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/appbar/app_bar.dart';
import 'package:flutter_application_1/widgets/calendar/doctor_shift.dart';

class DoctorShiftScreen extends StatefulWidget {
  bool isLightTheme;
  DoctorShiftScreen({super.key, required this.isLightTheme});

  @override
  State<DoctorShiftScreen> createState() => _DoctorShiftScreen();
}

class _DoctorShiftScreen extends State<DoctorShiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(showSearchBar: false, isLightTheme: widget.isLightTheme, onThemeToggle: (value){}, isSmall: MediaQuery.of(context).size.width < 1200,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: DoctorShiftCalendar(isFullScreen: false, isLightTheme: widget.isLightTheme,),
      ),
    );
  }
}