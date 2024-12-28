import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/features/doctors/detailed_doctor_screen.dart';
import 'package:flutter_application_1/models/doctor.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/widgets/appbar/app_bar.dart';
import 'package:flutter_application_1/widgets/boxes/meeting_card.dart';
import 'package:flutter_application_1/widgets/boxes/revenue_chart_card.dart';
import 'package:flutter_application_1/widgets/boxes/dashboard_card.dart';
import 'package:flutter_application_1/widgets/calendar/doctor_shift.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  bool isLightTheme;
  HomeScreen({super.key, required this.isLightTheme, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Doctor> doctors = [];

  String formatVND(int value) {
    final format = NumberFormat('#,##0');
    return '${format.format(value)} VND';
  }

  Future<void> fetchDoctors() async {
    try {
      List<Doctor> fetchedDoctors = await ApiService.fetchDoctors();
      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (e) {
      print('Failed to fetch doctors: $e');
    }
  }
  
  Future<void> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('https://api.mocki.io/v1/7b3f3f7b'));
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print('Failed to fetch appointments');
      }
    } catch (e) {
      print('Failed to fetch appointments: $e');
    }
  }
  
  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }


  @override
  Widget build(BuildContext context) {
    bool isSmall = MediaQuery.of(context).size.width < 1200;

    List<Map> dashboard_card_data = [
      {
        "icon": ic_ssers_01,
        "title": "Doctors",
        "value": doctors.length.toString(),
        "color": Theme.of(context).colorScheme.primary,
        "onPressed": () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => DetaileDoctorScreen(isLightTheme: widget.isLightTheme, isSmall: isSmall, rawData: doctors,),),
          );
        },
      },
      {
        "icon": ic_container,
        "title": "Services",
        "value": "2 215",
        "dropdown": true,
        "color": Theme.of(context).colorScheme.secondary,
        "onPressed": () {},
      },
      {
        "icon": ic_wallet,
        "title": "Income",
        "value": "${formatVND(20000000)}",
        "growth": 0.4,
        "color": Theme.of(context).colorScheme.tertiary,
        "onPressed": () {},
      },
      {
        "icon": ic_send,
        "title": "Outcome",
        "value": "${formatVND(12550000)}",
        "growth": -0.2,
        "color": Theme.of(context).colorScheme.onTertiary,
        "onPressed": () {},
      }
    ];
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        onThemeToggle: (bool isLightTheme) {
          widget.onThemeChanged(isLightTheme);
        },
        isLightTheme: widget.isLightTheme,
        isSmall: isSmall,
      ),      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              LayoutGrid(
                columnGap: 30,
                rowGap: 30,
                columnSizes: isSmall? [1.fr, 1.fr] : [1.fr, 1.fr, 1.fr, 1.fr],
                rowSizes: isSmall?
                  [auto, auto] :
                  [auto],
                  children: List.generate(dashboard_card_data.length, (index) {
                    return DashBoardCard(
                      context : this.context,
                      icon: dashboard_card_data[index]['icon'],
                      title: dashboard_card_data[index]['title'],
                      value: dashboard_card_data[index]['value'],
                      growth: dashboard_card_data[index]['growth'],
                      dropdown: dashboard_card_data[index]['dropdown'] != null,
                      color: dashboard_card_data[index]['color'],
                      isSmall: isSmall,
                      onPressed: dashboard_card_data[index]['onPressed'],
                    );
                  }),
              ),
              const SizedBox(height: 30,),
              isSmall? 
               Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    width: MediaQuery.sizeOf(context).width,
                    child: RevenueChart(context: this.context, isLightTheme: widget.isLightTheme, isSmall: isSmall),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    width: MediaQuery.sizeOf(context).width,
                    child: MeetingCard(context: this.context, isSmall: isSmall),
                  ),
                ],
              )
              : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: RevenueChart(context: this.context, isLightTheme: widget.isLightTheme, isSmall: isSmall),
                    ),
                  ),
                  const SizedBox(width: 30,),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: MeetingCard(context: this.context, isSmall: isSmall),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width,
                child: DoctorShiftCalendar(isFullScreen: true, isLightTheme: widget.isLightTheme,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}   