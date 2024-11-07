import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/chart/multi_lines_chart.dart';

class RevenueChart extends StatefulWidget {
  double height;
  BuildContext context;
  RevenueChart({super.key, required this.context, required this.height});

  @override
  State<RevenueChart> createState() => _RevenueChartState();
}

class _RevenueChartState extends State<RevenueChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          ListTile(
            title: Text("Revenue analytics", style: Theme.of(context).textTheme.displayLarge,),
            trailing: DropdownButton<String>(
              style: Theme.of(context).textTheme.bodyLarge,
              value: "Month",
              items: ["Day", "Month", "Year"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.blueAccent,
                ),
                SizedBox(width: 5,),
                Text("Revenue", style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(width: 15,),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.purpleAccent,
                ),
                SizedBox(width: 5,),
                Text("Expenses", style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Expanded(child: MultiLineChart())
        ],
      ),
    );
  }
}