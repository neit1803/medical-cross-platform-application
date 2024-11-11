import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarChartLegend extends StatefulWidget {
  List<double> values;
  List<String> labels;
  List<Color> colors;
  double totalValue;

  BarChartLegend({super.key, required this.values, required this.labels, required this.colors, required this.totalValue});

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
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.labels.length, (index) {
          double percentage = (widget.values[index] / widget.totalValue) * 100;
      
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 5,
                backgroundColor: widget.colors[index],
              ),
              const SizedBox(width: 8),
              Text(
                "${widget.labels[index]} (${percentage.toStringAsFixed(1)}%)",
                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              Text(
                '${formatVND(widget.values[index].toInt())}',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          );
        }),
      ),
    );
  }
}