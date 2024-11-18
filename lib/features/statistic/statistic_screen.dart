import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/widgets/appbar/app_bar.dart';
import 'package:flutter_application_1/widgets/boxes/statistic_chart_card.dart';

class StatisticScreen extends StatefulWidget {
  bool isLightTheme;
  final dynamic chart;
  StatisticScreen({super.key, required this.chart, required this.isLightTheme});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(showSearchBar: false, isLightTheme: widget.isLightTheme, onThemeToggle: (value){},),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: FutureBuilder<Map<String, dynamic>>(
          future: ApiService.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return StatisticChartCard(data: data, chart: widget.chart);
            }
            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}
