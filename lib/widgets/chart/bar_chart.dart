import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/services/chart_service.dart';
import 'package:flutter_application_1/widgets/legends/bar_chart_legend.dart';
import 'dart:math';

class BarChartCard extends StatefulWidget {
  final List<dynamic> data;

  const BarChartCard({super.key, required this.data});

  @override
  State<BarChartCard> createState() => _BarChartCardState();
}

class _BarChartCardState extends State<BarChartCard> {
  late List<double> values;
  late List<String> labels;
  late List<Color> colors;
  late double totalValue;
  late double highestPercentage;

  int touchedIndex = -1;
  bool isExpanded = true;

  Offset legendPosition = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
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
    highestPercentage = (values.reduce(max) / totalValue) * 100;
  }

  void _handleLegendHover(int index) {
    setState(() {
      touchedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double legendCardWidth = MediaQuery.of(context).size.width * 0.2;
    double paddingCard = 16.0;
    
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: EdgeInsets.all(paddingCard),
        child: Stack(
          children: [
            _buildBarChart(),
            Positioned(
              top: 0,
              left: legendPosition.dx,
              child: Draggable(
                axis: Axis.horizontal,
                onDragEnd: (details) {
                  setState(() {
                    legendPosition = details.offset;
                  });
                },
                feedback: _buildLegend(legendCardWidth),
                childWhenDragging: Container(),
                child: _buildLegend(legendCardWidth),
              ),
            ),
            // _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: highestPercentage + 10,
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
              final percentage =
                  ((values[groupIndex] / totalValue) * 100).toStringAsFixed(1);
              return BarTooltipItem(
                "$percentage%",
                TextStyle(color: colors[groupIndex]),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: _bottomTitles),
          leftTitles: AxisTitles(sideTitles: _leftTitles),
          topTitles: AxisTitles(sideTitles: _hiddenTitles),
          rightTitles: AxisTitles(sideTitles: _hiddenTitles),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            strokeWidth: 1,
            dashArray: [2, 10],
          ),
          drawVerticalLine: false,
        ),
        barGroups: _showingSections(),
      ),
    );
  }

  Widget _buildLegend(double legendCardWidth) {
    final visibleItems = isExpanded ? labels.length : 2;

    return SizedBox(
      width: legendCardWidth,
      child: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio: 0.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BarChartLegend(
                colors: isExpanded ? colors : colors.sublist(0, visibleItems),
                labels: isExpanded ? labels : labels.sublist(0, visibleItems),
                values: isExpanded ? values : values.sublist(0, visibleItems),
                totalValue: totalValue,
                touchedIndex: touchedIndex,
                onHover: _handleLegendHover,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      }, 
                      icon: Icon(isExpanded? ic_arrow_up : ic_arrow_down),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.resolveWith((states) { 
                          return const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(0), // top corner square
                              bottom: Radius.circular(18), // bottom corner rounded
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),     
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _showingSections() {
    return List.generate(values.length, (index) {
      final isTouched = index == touchedIndex;
      final percentage = double.parse(((values[index] / totalValue) * 100).toStringAsFixed(1));
      final toY = isTouched ? percentage + 3 : percentage;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: toY,
            width: MediaQuery.of(context).size.width < 1200? 10 : 50,
            color: colors[index],
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    });
  }

  SideTitles get _hiddenTitles => SideTitles(
    showTitles: false,
    getTitlesWidget: (_, __) => const SizedBox.shrink(),
  );

  SideTitles get _leftTitles => SideTitles(
    reservedSize: 40,
    showTitles: true,
    getTitlesWidget: (value, meta) {
      if (value % 5 != 0) return const SizedBox.shrink();
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(value.toString(), style: Theme.of(context).textTheme.labelMedium,),
      );
    },
  );

  SideTitles get _bottomTitles => SideTitles(
    reservedSize: 30,
    showTitles: true,
    getTitlesWidget: (value, meta) {
      final isTouched = value == touchedIndex;
      final style = isTouched? Theme.of(context).textTheme.labelMedium : TextStyle(fontSize: 0);
      if (value.toInt() >= labels.length) return const SizedBox.shrink();
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          labels[value.toInt()],
          style: style,
        ), 
      );
    },
  );
}
