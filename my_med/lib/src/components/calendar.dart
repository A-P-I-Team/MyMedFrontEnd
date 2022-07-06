import 'package:my_med/src/components/build_gradient.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Calendar extends StatefulWidget {
  final Function(DateTime date) getReminders;

  Calendar({Key? key, required this.getReminders}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int daySelected = Jalali.now().day;
  int monthSelected = Jalali.now().month;
  int yearSelected = Jalali.now().year;

  int daySelectedNew = Jalali.now().day;
  int monthSelectedNew = Jalali.now().month;
  int yearSelectedNew = Jalali.now().year;

  List<String> monthListJalali = [
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

  List<String> monthListMiladi = [
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
  void initState() {
    final jalaliDate = Jalali.now();
    widget.getReminders(
        DateTime(jalaliDate.year, jalaliDate.month, jalaliDate.day));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSelectMonthRow(context, setState),
        buildDaysOfWeek(context),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildCalendar(context, setState),
          ),
        ),
      ],
    );
  }

  SizedBox buildCalendar(BuildContext context, StateSetter setState) {
    int startDay = Jalali(yearSelected, monthSelected, 1).weekDay - 1;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 360,
      child: GridView.count(
          crossAxisCount: 7,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: List.generate(
            daysNumberPerMonth(monthSelected) + startDay,
            (index) => (index < startDay)
                ? SizedBox(
                    width: 20,
                    height: 20,
                  )
                : GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          daySelected = index - startDay + 1;
                        },
                      );
                      if (mounted) {
                        widget.getReminders(
                          DateTime(
                            yearSelected,
                            monthSelected,
                            daySelected,
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: (daySelected == (index - startDay + 1))
                            ? BuildGradient().buildLinearGradient()
                            : null,
                      ),
                      child: Center(
                        child: new Text(
                          (index - startDay + 1).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: (daySelected == (index - startDay + 1))
                                ? Colors.white
                                : Color(0xFF474747),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),

    );
  }

  Padding buildDaysOfWeek(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.localizations.saturday,
                style: TextStyle(
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
                style: TextStyle(
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
                context.localizations.monday,
                style: TextStyle(
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
                style: TextStyle(
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
                style: TextStyle(
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
                style: TextStyle(
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
                style: TextStyle(
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
              (monthSelected == 12) ? increaseYear() : increaseMonth();
            });
            if (mounted) {
              widget.getReminders(
                DateTime(
                  yearSelected,
                  monthSelected,
                  daySelected,
                ),
              );
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFBABBBC),
          ),
        ),
        (context.watch<LocalizationProvider>().locale == Locale('en'))
            ? Text(
                "$yearSelected " + monthListMiladi[monthSelected - 1],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF474747),
                ),
              )
            : Text(
                "$yearSelected " + monthListJalali[monthSelected - 1],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF474747),
                ),
              ),
        IconButton(
          onPressed: () {
            setState(() {
              (monthSelected == 1) ? decreaseYear() : decreaseMonth();
            });
            if (mounted) {
              widget.getReminders(
                DateTime(
                  yearSelected,
                  monthSelected,
                  daySelected,
                ),
              );
            }
          },
          icon: Icon(
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

  int daysNumberPerMonth(int monthSelected) {
    return (monthSelected <= 6)
        ? 31
        : (monthSelected <= 11)
            ? 30
            : 29;
  }
}
