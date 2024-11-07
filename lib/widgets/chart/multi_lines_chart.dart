import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MultiLineChart extends StatefulWidget {

  MultiLineChart({super.key});

  @override
  State<MultiLineChart> createState() => _MultiLineChartState();
}

class _MultiLineChartState extends State<MultiLineChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 8,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(sideTitles: _bottomTitles),
          leftTitles: AxisTitles(sideTitles: _leftTitles),
          topTitles: AxisTitles(sideTitles: _topTitles),
          rightTitles: AxisTitles(sideTitles: _rightTitles),
        ),
        gridData: FlGridData(
          show: true,
          checkToShowHorizontalLine: (value) {
            if (value % 1 != 0) 
              return false;
            return true;
          },
          checkToShowVerticalLine: (value) {
            if (value % 1 != 0) 
              return false;
            return true;
          },
        ),
        borderData: FlBorderData(show: false),
        lineBarsData:[
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 2),
              FlSpot(2, 3.5),
              FlSpot(3, 6.7),
              FlSpot(4, 4),
              FlSpot(5, 5.5),
              FlSpot(6, 7),
              FlSpot(7, 5),
              FlSpot(8, 6.5),
              FlSpot(9, 6),
              FlSpot(10, 7.5),
              FlSpot(11, 5),
            ],
            isCurved: true,
            color: Colors.blueAccent,
            belowBarData: BarAreaData(
              show: true,
              color:Colors.blueAccent.withOpacity(0.3),
            ),
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: [
              FlSpot(0, 1.5),
              FlSpot(1, 1.8),
              FlSpot(2, 2.8),
              FlSpot(3, 4.0),
              FlSpot(4, 3.2),
              FlSpot(5, 4.8),
              FlSpot(6, 5.2),
              FlSpot(7, 4.2),
              FlSpot(8, 5.5),
              FlSpot(9, 4.8),
              FlSpot(10, 6),
              FlSpot(11, 4.5),
            ],
            isCurved: true,
            color: Colors.purpleAccent,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.purpleAccent.withOpacity(0.3),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
       if (value % 1 != 0) {
        return Container();
      }
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = 'Jan';
          break;
        case 1:
          text = 'Feb';
          break;
        case 2:
          text = 'Mar';
          break;
        case 3:
          text = 'Apr';
          break;
        case 4:
          text = 'May';
          break;
        case 5:
          text = 'Jun';
          break;
        case 6:
          text = 'Jul';
          break;
        case 7:
          text = 'Aug';
          break;
        case 8:
          text = 'Sep';
          break;
        case 9:
          text = 'Oct';
          break;
        case 10:
          text = 'Nov';
          break;
        case 11:
          text = 'Dec';
          break;
        default:
          text = '';
          break;
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text),
      );
    },
  );

  SideTitles get _leftTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      if (value == 0) {
        return Text('\$${value.toInt()}');
      }
      if (value % 1 == 0) {
        return Text('\$${value.toInt()}k');
      }
      return Container();
    }  
  );

  SideTitles get _topTitles => SideTitles(
    showTitles: false,
    getTitlesWidget: (value, meta) {
      return const SizedBox.shrink();
    }  
  );

  SideTitles get _rightTitles => SideTitles(
    showTitles: false,
    getTitlesWidget: (value, meta) {
      return const SizedBox.shrink();
    }  
  );

}

