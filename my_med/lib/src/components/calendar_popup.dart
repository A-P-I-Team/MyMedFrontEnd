import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/components/build_gradient.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/models/date.dart';
import 'package:my_med/src/utils/dialog_title.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarPopUp extends StatefulWidget {
  const CalendarPopUp({Key? key}) : super(key: key);

  @override
  State<CalendarPopUp> createState() => _CalendarPopUpState();
}

class _CalendarPopUpState extends State<CalendarPopUp> {
  int daySelected = Jalali.now().day;
  int monthSelected = Jalali.now().month;
  int yearSelected = Jalali.now().year;
  final List<String> _monthList = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند'
  ];

  final List<String> _monthListMiladi = [
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
    'Jan',
    'Feb'
  ];

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        title: DialogTitle().buildDialogTitle(context.localizations.selectDate),
        contentPadding: const EdgeInsets.all(0),
        content: buildCalendarContent(context),
        actions: [
          buildCalendarDialogActions(context),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Row buildCalendarDialogActions(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            final date = MyDate(
                year: yearSelected, month: monthSelected, day: daySelected);
            Navigator.of(context).pop(date);
          },
          child: Container(
            width: 80,
            height: 40,
            decoration: BuildButtonStyle().buttonStyleFlat(),
            alignment: Alignment.center,
            child: Text(
              context.localizations.registerButtonText,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color(0xFF5EAFC0),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 80,
            height: 40,
            decoration: BuildButtonStyle().buttonStyleFlat(),
            alignment: Alignment.center,
            child: Text(context.localizations.cancel),
          ),
        )
      ],
    );
  }

  int daysNumberPerMonth(int monthSelected) {
    return (monthSelected <= 6)
        ? 31
        : (monthSelected <= 11)
            ? 30
            : 29;
  }

  SizedBox buildCalendar(BuildContext context, StateSetter setState) {
    int startDay = Jalali(yearSelected, monthSelected, 1).weekDay - 1;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        crossAxisCount: 7,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: List.generate(
          daysNumberPerMonth(monthSelected) + startDay,
          (index) => (index < startDay)
              ? const SizedBox(
                  width: 20,
                  height: 20,
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      daySelected = index - startDay + 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: (daySelected == (index - startDay + 1))
                          ? BuildGradient().buildLinearGradient()
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        (index - startDay + 1).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: (daySelected == (index - startDay + 1))
                              ? Colors.white
                              : const Color(0xFF474747),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  StatefulBuilder buildCalendarContent(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.white,
          child: Column(
            children: [
              buildSelectMonthRow(context, setState),
              buildDaysOfWeek(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildCalendar(context, setState),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding buildDaysOfWeek() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.saturday,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFFBABBBC),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.sunday,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color(0xFFBABBBC),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.monday,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFFBABBBC),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.tuesday,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFFBABBBC),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.wednesday,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFFBABBBC),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.thursday,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFFBABBBC),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.friday,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFFBABBBC),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildSelectMonthRow(BuildContext context, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              (monthSelected == 1) ? decreaseYear() : decreaseMonth();
            });
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFBABBBC),
          ),
        ),
        Text(
          (context.localizations.localeName == "fa")
              ? "$yearSelected ${_monthList[monthSelected - 1]}"
              : "$yearSelected ${_monthListMiladi[monthSelected - 1]}",
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(0xFF474747),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              (monthSelected == 12) ? increaseYear() : increaseMonth();
            });
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFBABBBC),
          ),
        ),
      ],
    );
  }

  increaseYear() {
    yearSelected++;
    monthSelected = 1;
    daySelected = 1;
  }

  increaseMonth() {
    monthSelected++;
    daySelected = 1;
  }

  decreaseYear() {
    yearSelected--;
    monthSelected = 12;
    daySelected = 1;
  }

  decreaseMonth() {
    monthSelected--;
    daySelected = 1;
  }
}
