import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_constants.dart';
import 'package:flutter_application_1/models/working_shift.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/services/chart_service.dart';
import 'package:flutter_application_1/widgets/calendar/calendar_header.dart';
import 'package:flutter_application_1/widgets/calendar/ultis.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorShiftCalendar extends StatefulWidget {
  String? doctorName;
  bool isFullScreen;
  bool isLightTheme;
  DoctorShiftCalendar({super.key, required this.isFullScreen, required this.isLightTheme, this.doctorName = ""}); 

  @override
  State<DoctorShiftCalendar> createState() => _DoctorShiftCalendarState();
}

class _DoctorShiftCalendarState extends State<DoctorShiftCalendar> {
  static final kToday = DateTime.now();
  late final ValueNotifier<List<WorkingShift>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<WorkingShift> _workingShifts = [];

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<WorkingShift> _getEventsForDay(DateTime day) {
    return _workingShifts.where((shift) {
      DateTime shiftDate = DateTime.parse(shift.date);
      return isSameDay(shiftDate, day);
    }).toList();
  }

  List<WorkingShift> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<WorkingShift> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDays.clear();
      _selectedDays.add(selectedDay);

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDay(selectedDay);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  Future<void> _loadWorkingShifts() async {
    try {
      _workingShifts = 
        widget.doctorName == "" ? 
        await ApiService.fetchWorkingShifts() 
        :await ApiService.fetchWorkingShiftsByDoctor(widget.doctorName!);
        
      _selectedEvents.value = _getEventsForDay(_focusedDay.value);
    } catch (e) {
      print("Error fetching working shifts: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier([]);
    _loadWorkingShifts();
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return CalendarHeader(
                isLightTheme: widget.isLightTheme,
                focusedDay: value,
                clearButtonVisible: false,
                fullScreenButtonVisible: widget.isFullScreen,
                onTodayButtonTap: () {
                  setState(() => _focusedDay.value = DateTime.now());
                },
                onClearButtonTap: () {
                  setState(() {
                    _rangeStart = null;
                    _rangeEnd = null;
                    _selectedDays.clear();
                    _selectedEvents.value = [];
                  });
                },
                onLeftArrowTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onRightArrowTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              );
            },
          ),
          Expanded(
            child: TableCalendar<WorkingShift>(
              shouldFillViewport: true,
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _focusedDay.value,
              headerVisible: false,
              selectedDayPredicate: (day) => _selectedDays.contains(day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: (day) => _getEventsForDay(day),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onCalendarCreated: (controller) => _pageController = controller,
              onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() => _calendarFormat = format);
                }
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade300,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade600,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                markerBuilder: (context, date, events) {
                  bool hasEvents = events.isNotEmpty;
                  return Positioned(
                    bottom: 1,
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: hasEvents ? Colors.green : Colors.transparent,
                    ),
                  );
                },
                headerTitleBuilder: (context, day) {
                  return Column(
                    children: [
                      Text(day.year.toString()),
                      const SizedBox(height: 15,),
                      Text(day.month.toString()),
                    ],
                  );
                },
                dowBuilder: (context, day) {
                  final text = DateFormat.E().format(day);
                  return Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          if (!widget.isFullScreen)
            Expanded(
              child: ValueListenableBuilder<List<WorkingShift>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  List<Color> colors = generateDistinctColors(value.length).map((e) => ChartService.parseColor(e),).toList();
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      WorkingShift  ws = value[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors[index],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text('${ws.startShift} - ${ws.endShift} (${ws.room}): ${ws.doctorName}'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
