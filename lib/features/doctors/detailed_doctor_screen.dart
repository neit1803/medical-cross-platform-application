import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/doctor.dart';
import 'package:flutter_application_1/widgets/appbar/app_bar.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class DetaileDoctorScreen extends StatefulWidget {
  List<Map> rawData;
  bool isLightTheme;
  bool isSmall;

  DetaileDoctorScreen({super.key, required this.isLightTheme, required this.isSmall, required this.rawData});

  @override
  State<DetaileDoctorScreen> createState() => _DetaileDoctorScreenState();
}

class _DetaileDoctorScreenState extends State<DetaileDoctorScreen> {
  List<Doctor> doctors = [];

  void mapToObj() {
    doctors = widget.rawData
        .map((item) => Doctor.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapToObj();
  }

  @override
  Widget build(BuildContext context) {
    int columnCount = widget.isSmall? 1 : 4;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(showSearchBar: false, isLightTheme: widget.isLightTheme, onThemeToggle: (value){}, isSmall: widget.isSmall,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: LayoutGrid(
              columnGap: 30,
              rowGap: 30,
              columnSizes: List.generate(columnCount, (_) => 1.fr),
              rowSizes: List.generate((doctors.length / columnCount).ceil(), (_) => auto),
                children: List.generate(doctors.length, (index) {
                  return Container(
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
                              "https://avatar.iran.liara.run/public/${(index % 100) + 1}}"
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '${doctors[index].ten}',
                                ),
                                Text(
                                  doctors[index].loai == 'bschidinh'? 'Bác Sĩ Chỉ Định' : "Bác Sĩ Thực Hiện",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ),
          ),
        ),
      ),
    );
  }
}