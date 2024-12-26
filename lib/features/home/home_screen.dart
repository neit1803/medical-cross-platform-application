import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/features/doctors/detailed_doctor_screen.dart';
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
  String formatVND(int value) {
    final format = NumberFormat('#,##0');
    return '${format.format(value)} VND';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmall = MediaQuery.of(context).size.width < 1200;
    
    List<Map> doctor_map = [
      {"color":"","value":4784101.1999999993,"title":"NV_74","ghichu":"NV_74","obdata":"","ma":"NV_74","ten":"Bs. Ngô Minh Cảnh","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":7800552.8000000007,"title":"NV22_66","ghichu":"NV22_66","obdata":"","ma":"NV22_66","ten":"Bs. Đào Xuân Toàn","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":4506300.0,"title":"NV501","ghichu":"NV501","obdata":"","ma":"NV501","ten":"Bs. Lương Trung Kiên","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":4801479.8,"title":"NV22_100","ghichu":"NV22_100","obdata":"","ma":"NV22_100","ten":"BS.CKII. Lưu Trường Bách","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":3034600.3,"title":"NV23_77","ghichu":"NV23_77","obdata":"","ma":"NV23_77","ten":"Bs. lê Thị Thu Thảo","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":2804600.0,"title":"NV77","ghichu":"NV77","obdata":"","ma":"NV77","ten":"BS. Vũ Thị Huyền Trang","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":27323941.799999997,"title":"NV22_97","ghichu":"NV22_97","obdata":"","ma":"NV22_97","ten":"Bs. Nguyễn Ngọc Vương","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":401000.0,"title":"NV23_24","ghichu":"NV23_24","obdata":"","ma":"NV23_24","ten":"Cao Thị Hương","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":7900159.6999999993,"title":"NV23_80","ghichu":"NV23_80","obdata":"","ma":"NV23_80","ten":"Huỳnh Hữu Nghĩa","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":12479652.0,"title":"NV64","ghichu":"NV64","obdata":"","ma":"NV64","ten":"BS. Trần Đức Thiện","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":200170.90726891457,"title":"NV23_58","ghichu":"NV23_58","obdata":"","ma":"NV23_58","ten":"Bs. Trần Ngọc Minh Phương","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":2242877.6620977339,"title":"NV23_76","ghichu":"NV23_76","obdata":"","ma":"NV23_76","ten":"Trịnh Duy Thắng","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":2515416.0,"title":"NV22_03","ghichu":"NV22_03","obdata":"","ma":"NV22_03","ten":"Trương Thanh Tú","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":8840460.3,"title":"NV23_46","ghichu":"NV23_46","obdata":"","ma":"NV23_46","ten":"Bs. Nguyễn Minh Khánh","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":5421000.0,"title":"NV","ghichu":"NV","obdata":"","ma":"NV","ten":"Phạm Văn Sơn","loai":"bschidinh","ten1":"doctor"},
      {"color":"","value":22887479.6,"title":"NV12","ghichu":"NV12","obdata":"","ma":"NV12","ten":"CN. Nguyễn Thị Ngọc Trinh","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":213280.0,"title":"NV_74","ghichu":"NV_74","obdata":"","ma":"NV_74","ten":"Bs. Ngô Minh Cảnh","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":3222130.0,"title":"NV32","ghichu":"NV32","obdata":"","ma":"NV32","ten":"BS. Phạm Ngọc Quang","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":15570680.176467862,"title":"NV11","ghichu":"NV11","obdata":"","ma":"NV11","ten":"BS. Nguyễn Văn Cao","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":3500000.0,"title":"NV22_84","ghichu":"NV22_84","obdata":"","ma":"NV22_84","ten":"BS.CKI Tạ Minh Vương","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":400000.0,"title":"NV501","ghichu":"NV501","obdata":"","ma":"NV501","ten":"Bs. Lương Trung Kiên","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":493280.0,"title":"NV22_100","ghichu":"NV22_100","obdata":"","ma":"NV22_100","ten":"BS.CKII. Lưu Trường Bách","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":580000.0,"title":"NV23_77","ghichu":"NV23_77","obdata":"","ma":"NV23_77","ten":"Bs. lê Thị Thu Thảo","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":915272.0,"title":"NV22_97","ghichu":"NV22_97","obdata":"","ma":"NV22_97","ten":"Bs. Nguyễn Ngọc Vương","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":664190.0,"title":"NV23_24","ghichu":"NV23_24","obdata":"","ma":"NV23_24","ten":"Cao Thị Hương","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":4227940.0,"title":"NV23_45","ghichu":"NV23_45","obdata":"","ma":"NV23_45","ten":"BS. Nguyễn Văn Kiên","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":541752.0,"title":"NV64","ghichu":"NV64","obdata":"","ma":"NV64","ten":"BS. Trần Đức Thiện","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":170.90726891458326,"title":"NV23_58","ghichu":"NV23_58","obdata":"","ma":"NV23_58","ten":"Bs. Trần Ngọc Minh Phương","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":315272.0,"title":"NV22_66","ghichu":"NV22_66","obdata":"","ma":"NV22_66","ten":"Bs. Đào Xuân Toàn","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":1259.925856245136,"title":"NV23_76","ghichu":"NV23_76","obdata":"","ma":"NV23_76","ten":"Trịnh Duy Thắng","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":160624.0,"title":"NV22_03","ghichu":"NV22_03","obdata":"","ma":"NV22_03","ten":"Trương Thanh Tú","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":1246000.0,"title":"NV53","ghichu":"NV53","obdata":"","ma":"NV53","ten":"Nguyễn Kỳ Sa","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":342960.0,"title":"NV23_46","ghichu":"NV23_46","obdata":"","ma":"NV23_46","ten":"Bs. Nguyễn Minh Khánh","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":156640.0,"title":"NV23_80","ghichu":"NV23_80","obdata":"","ma":"NV23_80","ten":"Huỳnh Hữu Nghĩa","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":0.0,"title":"NV","ghichu":"NV","obdata":"","ma":"NV","ten":"Phạm Văn Sơn","loai":"bsthuchien","ten1":"doctor"},
      {"color":"","value":100000.0,"title":"NV77","ghichu":"NV77","obdata":"","ma":"NV77","ten":"BS. Vũ Thị Huyền Trang","loai":"bsthuchien","ten1":"doctor"}
    ];

    List<Map> dashboard_card_data = [
      {
        "icon": ic_ssers_01,
        "title": "Doctors",
        "value": "5 234",
        "color": Theme.of(context).colorScheme.primary,
        "onPressed": () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => DetaileDoctorScreen(isLightTheme: widget.isLightTheme, isSmall: isSmall, rawData: doctor_map,),),
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