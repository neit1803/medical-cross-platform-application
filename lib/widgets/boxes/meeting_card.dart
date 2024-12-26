import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/models/appointment.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class MeetingCard extends StatefulWidget {
  BuildContext context;
  bool isSmall;

  MeetingCard({super.key, required this.context, required this.isSmall});

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  int currIdx = 0;
  int formatedSz = 0;
  DateTime date = DateTime.now();
  late List<Appointment> rawData;
  List<List<Appointment>> formatedData = List.generate(2, (_) => []);
  
  late PageController _pageController;

  void setDataSet(){
    rawData = [
      Appointment(id: "1", title: "Patient A Regular Checkup", dateTime: DateTime.parse('2024-12-23 20:18:04Z')),
      Appointment(id: "2", title: "Patient B Follow-up Visit", dateTime: DateTime.parse('2024-03-21 08:18:04Z')),
      Appointment(id: "3", title: "Patient C Specialist Consultation", dateTime: DateTime.parse('2024-12-20 13:18:04Z')),
      Appointment(id: "4", title: "Patient D Vaccination Appointment", dateTime: DateTime.parse('2019-01-12 15:18:04Z')),
      Appointment(id: "5", title: "Patient D Vaccination Appointment", dateTime: DateTime.parse('2019-01-12 15:18:04Z')),
      Appointment(id: "6", title: "Patient D Vaccination Appointment", dateTime: DateTime.parse('2019-01-12 15:18:04Z')),
    ];
    formatedData = rawData.slices(4).toList();
  }

  void _goToPreviousPage() {
    setState(() {
      if (currIdx > 0) currIdx--;
    });
    _pageController.animateToPage(
      currIdx, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,             
    );
  }

  void _goToNextPage()  {
    setState(() {
      if (currIdx < formatedData.length - 1) currIdx++;
    });
    _pageController.animateToPage(
      currIdx, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeInOut,              
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      currIdx = index;
    });
    _pageController.animateToPage(
      index, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,             
    );
  }

  Future<void> _showDateTimePicker() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100), 
      );

      if (pickedDate != null && pickedDate != date) {
        setState(() {
          date = pickedDate;
        });
        print(date);
      }
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
    DateTime now = DateTime.now();
    bool isToday= date.year == now.year &&
                    date.month == now.month &&
                    date.day == now.day;

    return Container(
      padding: EdgeInsets.all(widget.isSmall? 8:16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(  
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Appointments",
                  style: TextStyle(
                    fontSize: widget.isSmall? 16:20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    minimumSize: WidgetStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: _showDateTimePicker,
                  child: Text(
                    DateFormat('MMM, d, E').format(date),
                    style: TextStyle(
                      fontSize: widget.isSmall? 14:16,
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                isToday? 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.isSmall? 4:8, vertical: widget.isSmall? 2:4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "TODAY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.isSmall? 10:12,
                      ),
                    ),
                  )
                  : Container(),
                const Spacer(),
                IconButton(        
                  onPressed: (){rawData.isNotEmpty? _goToPreviousPage() : null;}, 
                  icon: const Icon(ic_arrow_left),
                  color: Colors.grey[500],  
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 0.5)
                      )
                    )
                  ),
                ),
                const SizedBox(width: 5,),
                IconButton(
                  onPressed: (){rawData.isNotEmpty? _goToNextPage() : null;}, 
                  icon: const Icon(ic_arrow_right),
                  color: Colors.grey[500],    
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 0.5)
                      )
                    )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            rawData.isNotEmpty?
            Expanded(
              child: SingleChildScrollView(
                child: ExpandablePageView.builder(
                  onPageChanged: _onPageChanged,
                  itemCount: 4,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return LayoutGrid(
                      columnSizes: [1.fr],
                      rowSizes: const [auto,auto,auto,auto],
                      rowGap: 15,
                      children: [
                        ...List.generate(formatedData[currIdx].length, (index) {
                          Color color;
                          switch(index) {
                            case 0:
                              color = Theme.of(context).colorScheme.secondary;
                              break;
                            case 1: 
                              color = Theme.of(context).colorScheme.onTertiary;
                              break;
                            case 2:
                              color = Theme.of(context).colorScheme.tertiary;
                              break;
                            default:
                              color = Theme.of(context).colorScheme.primary;
                              break;
                          }
                                
                          return Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 0.5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 6,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12)
                                    )
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:10, left: 10, right: 5, bottom: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              formatedData[currIdx][index].title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis, 
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontSize: widget.isSmall? 12:16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "${formatedData[currIdx][index].dateTime.hour}:${formatedData[currIdx][index].dateTime.minute}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis, 
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: widget.isSmall? 12:16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    );
                  }
                ),
              ),
            )
            : Expanded(
              child: Center(
                child: Opacity(
                  opacity: 0.4,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_outlined, size: widget.isSmall? 30:50,),
                      SizedBox(width: 5,),
                      Text("No Appointments", style: widget.isSmall? Theme.of(context).textTheme.displaySmall : Theme.of(context).textTheme.displayMedium ,)
                    ],
                  ),
                ),
              ),
            ),          
            const Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape:  WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(0),
                            bottom: Radius.circular(12), 
                          ),
                        )
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Text(
                        "See full calendar  >",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}