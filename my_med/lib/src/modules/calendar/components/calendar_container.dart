import 'package:my_med/src/components/calendar.dart';
import 'package:flutter/material.dart';

class CalendarContainer extends StatelessWidget {
  final Function(DateTime date) getReminders;
  CalendarContainer({
    Key? key,
    required this.getReminders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x25000000),
            offset: Offset(0, 0),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Calendar(
        getReminders: getReminders,
      ),
    );
  }
}
