import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/legends/indicator.dart';
import 'package:intl/intl.dart';

class PieChartLegend extends StatefulWidget {
  int touchedIndex;
  final List<double> values;
  final List<String> labels;
  List<Color> colors = [];
  double totalValue;

  final Function(int index) onHover;
  
  PieChartLegend({
    super.key, 
    required this.values, 
    required this.labels, 
    required this.colors, 
    required this.totalValue, 
    required this.touchedIndex,
    required this.onHover,  
  });

  @override
  State<PieChartLegend> createState() => _PieChartLegendState();
}

class _PieChartLegendState extends State<PieChartLegend> {
  String formatVND(int value) {
    final format = NumberFormat('#,##0');
    return '${format.format(value)} VND';
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          children: [
            Expanded(flex: 2, child: Text('Label', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text('%', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        const Divider(),
        ...List.generate(widget.values.length, (index) {
          final isTouched = index == widget.touchedIndex;
          final fontStyle = isTouched ? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.labelSmall;
          final color = isTouched? Colors.yellowAccent.withOpacity(0.3) : Colors.transparent;
          final percentage = (widget.values[index] / widget.totalValue * 100).toStringAsFixed(1);
          
          return MouseRegion(
            onEnter: (_) => widget.onHover(index),
            onExit: (_) => widget.onHover(-1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                color: color,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Indicator(
                        color: widget.colors[index],
                        text: widget.labels[index],
                        isSquare: true,
                      ),
                    ),
                    Expanded(
                      flex: 1, 
                      child: Text(
                        formatVND(widget.values[index].toInt()),
                        style:  fontStyle,
                      )
                    ),
                    Expanded(
                      flex: 1, 
                      child: Text(
                        '$percentage%', 
                        style: fontStyle,
                      )
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}