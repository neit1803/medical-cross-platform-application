import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_constants.dart';
import 'package:flutter_application_1/config/app_icons.dart';
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
  List<String> surfHeaders = List.generate(4, (_) => "");
  List<List<dynamic>> dataset = List.generate(4, (_) => []);

  late PageController _pageController;
  bool _showLeftArrow = false;
  bool _showRightArrow = false;

  void setDataSet() {
    for (var i = 0; i < 4; i++) {
      List<dynamic> obdatas = [];
      switch (i) {
        case 0:
          obdatas = widget.data['dsluotdichvu'];
          surfHeaders[i] = "Chart: Service List Counts";
          break;
        case 1:
          obdatas = widget.data['dsdoanhthu'];
          surfHeaders[i] = "Chart: Revenue List";
          break;
        case 2:
          obdatas = widget.data['dsdoanhthutheobs'];
          surfHeaders[i] = "Chart: Revenue by Clinical Doctor";
          break;
        case 3:
          obdatas = widget.data['dsdoanhthutheobsthuchien'];
          surfHeaders[i] = "Chart: Revenue by Performing Doctor";
          break;
      }
      List<String> colors = generateDistinctColors(obdatas.length);
      obdatas.asMap().forEach((index,value) => value.color = colors[index]);
      dataset[i] = obdatas; 
    }
    
  }

  void _goToPreviousPage() {
    setState(() {
      if (currIdx > 0) currIdx--;
    });
    _pageController.animateToPage(
      currIdx, 
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,             
    );
  }

  void _goToNextPage() {
    setState(() {
      if (currIdx < 3) currIdx++;
    });
    _pageController.animateToPage(
      currIdx, 
      duration: Duration(milliseconds: 300), 
      curve: Curves.easeInOut,              
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      currIdx = index;
    });
    _pageController.animateToPage(
      index, 
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,             
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currIdx);
    setDataSet();
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 1200;

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
              onPageChanged: _onPageChanged,
              itemCount: 4,
              controller: _pageController,
              itemBuilder: (context, index) {
                String prefHeader = widget.chart == Charts.Pie ? "Pie" : "Bar";
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$prefHeader ${surfHeaders[currIdx]}",
                          style: isSmall? Theme.of(context).textTheme.displaySmall : Theme.of(context).textTheme.displayMedium,
                          maxLines: 1,
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
                        data: dataset[index],
                      )
                    : BarChartCard(
                        data: dataset[index],
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
