import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/schedule/doctor_shift_screen.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;
  final bool fullScreenButtonVisible;
  bool isLightTheme;

  CalendarHeader({
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
    required this.fullScreenButtonVisible,
    required this.isLightTheme,
  });

  @override
  Widget build(BuildContext context) {
    // final headerText = DateFormat.yMMM().format(focusedDay);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          const SizedBox(width: 16.0),
          Row(
            children: [
              Text(
                DateFormat.y().format(focusedDay),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              if (fullScreenButtonVisible)
                  IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorShiftScreen(isLightTheme: this.isLightTheme,),),
                    );
                  }, 
                  icon: const Icon(Icons.fullscreen),
                )
            ],
          ),
          const SizedBox(width: 5,),
          Row(
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  minimumSize: WidgetStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: onTodayButtonTap,
                child: Text(
                  DateFormat.MMMM().format(focusedDay),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 30,
                  ),
                ),
              ),
              if (clearButtonVisible)
                IconButton(
                  icon: const Icon(Icons.clear, size: 20.0),
                  visualDensity: VisualDensity.compact,
                  onPressed: onClearButtonTap,
                ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: onLeftArrowTap,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: onRightArrowTap,
              ),
            ],
          )
        ],
      ),
    );
  }
}