import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/legends/indicator.dart';
import 'package:intl/intl.dart';

class BarChartLegend extends StatefulWidget {
  List<double> values;
  List<String> labels;
  List<Color> colors;
  double totalValue;
  int touchedIndex;

  final Function(int index) onHover;

  BarChartLegend({
    super.key, 
    required this.values, 
    required this.labels, 
    required this.colors, 
    required this.totalValue, 
    required this.touchedIndex,
    required this.onHover, 
  });

  @override
  State<BarChartLegend> createState() => _BarChartLegendState();
}

class _BarChartLegendState extends State<BarChartLegend> {
  String formatVND(int value) {
    final format = NumberFormat('#,##0');
    return '${format.format(value)} VND';
  }
  
  @override
  Widget build(BuildContext context) {    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.labels.length, (index) {
        final isTouched = index == widget.touchedIndex;
        final color = isTouched? Colors.yellowAccent.withOpacity(0.3) : Colors.transparent;
        double percentage = (widget.values[index] / widget.totalValue) * 100;
        
        return Container(
          color: color,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MouseRegion(
                onEnter: (_) => widget.onHover(index),
                onExit: (_) => widget.onHover(-1),
                child: Row(
                  children: [
                    Indicator(
                      color: widget.colors[index],
                      text: "${widget.labels[index]} (${percentage.toStringAsFixed(1)}%)",
                      isSquare: false,
                    ),
                    SizedBox(width: 12,),
                    Text(formatVND(widget.values[index].toInt()), style: Theme.of(context).textTheme.labelSmall,),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}