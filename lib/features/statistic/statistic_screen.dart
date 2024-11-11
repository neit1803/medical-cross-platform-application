import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/appbar/app_bar.dart';
import 'package:flutter_application_1/widgets/boxes/statistic_chart_card.dart';
import 'package:flutter/services.dart' show rootBundle;

class StatisticScreen extends StatefulWidget {
  BuildContext? context;
  Map? data;
  var chart;
  StatisticScreen({super.key, this.data, required this.chart});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {

  Future<void> loadJsonAsset() async { 
    final String jsonString = await rootBundle.loadString('assets/escaped.json'); 
    final jsonData = jsonDecode(jsonString); 
    setState(() {
      widget.data = jsonData;
    });
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadJsonAsset();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(showSearchBar: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30), 
          child: widget.data != null ? 
          StatisticChartCard(data: widget.data!, chart: widget.chart)
          : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}