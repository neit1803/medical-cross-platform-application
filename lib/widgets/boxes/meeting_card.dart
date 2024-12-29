import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/features/appointment/bloc/appointment_bloc.dart';
import 'package:flutter_application_1/features/appointment/bloc/appointment_event.dart';
import 'package:flutter_application_1/features/appointment/bloc/appointment_state.dart';
import 'package:flutter_application_1/models/appointment.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late PageController _pageController;
  int currIdx = 0;
  DateTime date = DateTime.now();

  void _fetchAppointments(DateTime date) {
    context.read<AppointmentBloc>().add(FetchAppointments(date));
  }

  void _goToPreviousPage(int pageCount) {
    if (currIdx > 0) {
      setState(() => currIdx--);
      _pageController.animateToPage(
        currIdx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage(int pageCount) {
    if (currIdx < pageCount - 1) {
      setState(() => currIdx++);
      _pageController.animateToPage(
        currIdx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
        currIdx = 0;
      });
      _fetchAppointments(date);
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
    _fetchAppointments(date);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool isToday= date.year == now.year &&
                    date.month == now.month &&
                    date.day == now.day;

    return BlocBuilder <AppointmentBloc, AppointmentState> (
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AppointmentLoaded) {
          final appointments = state.formattedAppointments;

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
                        onPressed: (){_goToPreviousPage(appointments.length);}, 
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
                        onPressed: (){ _goToNextPage(appointments.length);}, 
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
                  appointments.isNotEmpty?
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
                              ...List.generate(appointments[currIdx].length, (index) {
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
                                                    appointments[currIdx][index].title,
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
                                                    // Sử dụng định dạng 24 giờ
                                                    DateFormat('HH:mm').format(appointments[currIdx][index].dateTime),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis, 
                                                    style: TextStyle(
                                                      color: Colors.grey.shade500,
                                                      fontSize: widget.isSmall ? 12 : 16,
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
        } else {
          return Center(child: Text('Failed to load data'));
        }
      },
    );
  }
}