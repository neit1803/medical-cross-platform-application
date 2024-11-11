import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/legends/indicator.dart';
import 'package:intl/intl.dart';

class PieChartLegend extends StatefulWidget {
  final List<double> values;
  final List<String> labels;
  List<Color> colors = [];
  double totalValue;
  
  PieChartLegend({super.key, required this.values, required this.labels, required this.colors, required this.totalValue});

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
      mainAxisSize: MainAxisSize.max,
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
          final percentage = (widget.values[index] / widget.totalValue * 100).toStringAsFixed(1);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                Expanded(flex: 1, child: Text(formatVND(widget.values[index].toInt()))),
                Expanded(flex: 1, child: Text('$percentage%')),
              ],
            ),
          );
        }),
      ],
    );
  }
}