import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/chart_service.dart';
import 'package:flutter_application_1/widgets/legends/pie_chart_legend.dart';

class PieChartCard extends StatefulWidget {
  List<dynamic> data;

  PieChartCard({super.key, required this.data});

  @override
  State<PieChartCard> createState() => _PieChartCard();
}

class _PieChartCard extends State<PieChartCard> {
  int touchedIndex = -1;
  double totalValue = 0.0;

  List<double> values = List.filled(4, 0.0);
  List<String> labels = List.filled(4, "");
  List<Color> colors = List.filled(4, Colors.grey);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    values = ChartService()
      .getValues(widget.data)
      .map((e) => e is double ? e : double.tryParse(e.toString()) ?? 0.0)
      .toList();
    labels = ChartService()
        .getLabels(widget.data)
        .map((e) => e.toString())
        .toList();
    colors = ChartService()
      .getColors(widget.data)
      .map((e) => ChartService.parseColor(e.toString()))
      .toList();
    totalValue = ChartService.calculateTotalValue(values);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse
                          .touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 5,
                centerSpaceRadius: MediaQuery.of(context).size.height * 0.25,
                sections: showingSections(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PieChartLegend(values: values as List<double>, labels: labels as List<String>, colors: colors as List<Color>, totalValue: totalValue)
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(values.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 0.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      double percentage = values[i] / totalValue;
      return PieChartSectionData(
        color: colors[i],
        value: values[i],
        title: '${(percentage * 100).toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}
