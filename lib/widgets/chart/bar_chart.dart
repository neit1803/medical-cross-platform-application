import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/legends/bar_chart_legend.dart';
import 'dart:math';

import 'package:flutter_application_1/widgets/legends/indicator.dart';

class BarChartCard extends StatefulWidget {
  List<double> values;
  List<String> labels;
  List<Color> colors;
  double totalValue;
  
  BarChartCard({super.key, required this.values, required this.labels, required this.colors, required this.totalValue});

  @override
  State<BarChartCard> createState() => _BarChartCardState();
}
class _BarChartCardState extends State<BarChartCard> {
  double highestPercentage = 0;
  int touchedIndex = -1;
  
  
  @override
  void initState() {
    // TODO: implement initState
    highestPercentage = widget.values.reduce(max) / widget.totalValue;
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          children: [
            BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: ((double.parse(highestPercentage.toStringAsFixed(2))) * 100 + 10),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                  touchTooltipData: BarTouchTooltipData(
                    tooltipRoundedRadius: 0,
                    tooltipMargin: 0,
                    fitInsideVertically: true,
                    fitInsideHorizontally: true,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final text = double.parse(((widget.values[groupIndex] / widget.totalValue) * 100).toStringAsFixed(1));
                      return BarTooltipItem(
                        // "${widget.values[groupIndex]}", 
                        "${text} \%",
                        TextStyle(color: widget.colors[groupIndex]),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: _rightTitles),
                  leftTitles: AxisTitles(sideTitles: _leftTitles),
                  topTitles: AxisTitles(sideTitles: _topTitles),
                  rightTitles: AxisTitles(sideTitles: _rightTitles),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  // getDrawingVerticalLine: (value) =>                      
                  //   value != 1 ?FlLine(color: Colors.white.withOpacity(0.1), strokeWidth: 1) : FlLine(color: Colors.black, strokeWidth: 1),
                  // drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    
                    return FlLine(
                      color: Colors.black.withOpacity(0.5),
                      strokeWidth: 1,
                      dashArray: [2,10]
                    );
                  },
                  drawVerticalLine: false,
                ),
                barGroups: showingSections(),  
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: BarChartLegend(
                colors: widget.colors,
                labels: widget.labels,
                values: widget.values,
                totalValue: widget.totalValue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> showingSections() {
    return List.generate(widget.values.length, (index) {
    final isTouched = index == touchedIndex;
    final fontSize = isTouched ? 16.0 : 12.0;
    final itemVal = double.parse(((widget.values[index] / widget.totalValue) * 100).toStringAsFixed(1));
    final toY = isTouched? (itemVal + 3) : itemVal;
    // const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    // double percentage = widget.values[index] / widget.totalValue;
      return BarChartGroupData(
        x: index, 
        barRods: [
          BarChartRodData(
            toY: toY,
            width: 50,
            color: widget.colors[index],
            borderRadius: BorderRadius.zero,
          ),
        ]
      );
    });
  }

  SideTitles get _rightTitles => SideTitles(
    showTitles: false,
    getTitlesWidget: (value, meta) {
      return const SizedBox.shrink();
    }  
  );
  
  SideTitles get _topTitles => SideTitles(
    showTitles: false,
    getTitlesWidget: (value, meta) {
      return const SizedBox.shrink();
    }  
  );

  SideTitles get _leftTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      if (value % 5 != 0) {
        return Container();
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(value.toString()), 
      );
    }  
  );

  SideTitles get _bottomTitles => SideTitles(
    reservedSize: 30,
    showTitles: true,
    getTitlesWidget: (value, meta) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          '${widget.labels[value.toInt()]}',
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold,  
            fontSize: 12
          ),
        ), 
      );
    }  
  );
}
