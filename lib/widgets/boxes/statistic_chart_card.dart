import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_constants.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/widgets/chart/bar_chart.dart';
import 'package:flutter_application_1/widgets/chart/pie_chart.dart';

class StatisticChartCard extends StatefulWidget {
  var chart;
  final Map data;
  StatisticChartCard({super.key, this.chart, required this.data});

  @override
  State<StatisticChartCard> createState() => _StatisticChartCardState();
}

class _StatisticChartCardState extends State<StatisticChartCard> {
  int currIdx = 0;
  List<List<double>> values = List.generate(4, (_) => []);
  List<List<String>> labels = List.generate(4, (_) => []);
  List<List<Color>> colors = List.generate(4, (_) => []);
  List<double> totalValue = List.filled(4, 0.0);
  List<String> surfHeaders = List.generate(4, (_) => "");

  bool _showLeftArrow = false;
  bool _showRightArrow = false;

  void setDataSet() {
    for (var i = 0; i < 4; i++) {
      List<dynamic> obdatas = [];
      switch (i) {
        case 0:
          obdatas = ApiService().getServiceIncomeList(widget.data);
          surfHeaders[i] = "Chart: Service List Counts";
          break;
        case 1:
          obdatas = ApiService().getRevenueList(widget.data);
          surfHeaders[i] = "Chart: Revenue List";
          break;
        case 2:
          obdatas = ApiService().getRevenueByDoctorList(widget.data);
          surfHeaders[i] = "Chart: Revenue by Clinical Doctor";
          break;
        case 3:
          obdatas = ApiService().getRevenueByPerformingDoctorList(widget.data);
          surfHeaders[i] = "Chart: Revenue by Performing Doctor";
          break;
      }

      totalValue[i] = ApiService().calculateTotalValue(obdatas);
      values[i] = ApiService().getValues(obdatas);
      labels[i] = ApiService().getTitles(obdatas);
      colors[i] = generateDistinctColors(obdatas.length);
    }
  }

  void _goToPreviousPage() {
    setState(() {
      if (currIdx > 0) currIdx--;
    });
  }

  void _goToNextPage() {
    setState(() {
      if (currIdx < 3) currIdx++;
    });
  }

  @override
  void initState() {
    super.initState();
    setDataSet();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final hoverX = event.localPosition.dx;
        setState(() {
          _showLeftArrow = hoverX < 100;
          _showRightArrow = hoverX > MediaQuery.of(context).size.width - 100;
        });
      },
      onExit: (_) {
        setState(() {
          _showLeftArrow = false;
          _showRightArrow = false;
        });
      },
      child: Stack(
        children: [
          Container(
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
            child: ExpandablePageView.builder(
              itemCount: 4,
              controller: PageController(initialPage: currIdx),
              itemBuilder: (context, index) {
                String prefHeader = widget.chart == Charts.Pie ? "Pie" : "Bar";
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$prefHeader ${surfHeaders[currIdx]}",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.bar_chart),
                          onPressed: () {
                            setState(() {
                              widget.chart = Charts.Bar;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.pie_chart),
                          onPressed: () {
                            setState(() {
                              widget.chart = Charts.Pie;
                            });
                          },
                        ),
                      ],
                    ),
                    widget.chart == Charts.Pie
                        ? PieChartCard(
                            values: values[currIdx],
                            labels: labels[currIdx],
                            colors: colors[currIdx],
                            totalValue: totalValue[currIdx],
                          )
                        : BarChartCard(
                            values: values[currIdx],
                            labels: labels[currIdx],
                            colors: colors[currIdx],
                            totalValue: totalValue[currIdx],
                          ),
                  ],
                );
              },
            ),
          ),
          if (_showLeftArrow)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: Icon(ic_arrow_left),
                onPressed: _goToPreviousPage,
              ),
            ),
          if (_showRightArrow)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: Icon(ic_arrow_right),
                onPressed: _goToNextPage,
              ),
            ),
        ],
      ),
    );
  }
}
