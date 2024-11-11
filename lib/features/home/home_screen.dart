import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/widgets/appbar/app_bar.dart';
import 'package:flutter_application_1/widgets/boxes/revenue_chart_card.dart';
import 'package:flutter_application_1/widgets/boxes/dashboard_card.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  dynamic? data;

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  Future<void> loadJsonAsset() async { 
    final String jsonString = await rootBundle.loadString('assets/escaped.json'); 
    final jsonData = jsonDecode(jsonString); 
    setState(() {
      widget.data = jsonData;
    });
  }

  String formatVND(int value) {
    final format = NumberFormat('#,##0');
    return '${format.format(value)} VND';
  }

  @override
  void initState() {
    super.initState();
    loadJsonAsset();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final List<Map> dashboard_card_data = [
      {
        "icon": ic_ssers_01,
        "title": "Doctors",
        "value": "5 234",
        "dropdown": true,
        "color": Theme.of(context).colorScheme.primary
      },
      {
        "icon": ic_container,
        "title": "Services",
        "value": "2 215",
        "dropdown": true,
        "color": Theme.of(context).colorScheme.secondary
      },
      {
        "icon": ic_wallet,
        "title": "Income",
        "value": "${formatVND(20000000)}",
        "growth": 0.4,
        "color": Theme.of(context).colorScheme.tertiary
      },
      {
        "icon": ic_send,
        "title": "Outcome",
        "value": "${formatVND(12550000)}",
        "growth": -0.2,
        "color": Theme.of(context).colorScheme.onTertiary
      }
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(),      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: (itemWidth / itemHeight),
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return DashBoardCard(
                    context : this.context,
                    icon: dashboard_card_data[index]['icon'],
                    title: dashboard_card_data[index]['title'],
                    value: dashboard_card_data[index]['value'],
                    growth: dashboard_card_data[index]['growth'],
                    dropdown: dashboard_card_data[index]['dropdown'] != null,
                    color: dashboard_card_data[index]['color'],
                  );
                },
              ),
              SizedBox(height: 30,),
              RevenueChart(height: MediaQuery.sizeOf(context).height * 0.6, context: this.context,),
            ],
          ),
        ),
      ),
    );
  }
}   