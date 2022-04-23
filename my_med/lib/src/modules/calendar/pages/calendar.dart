import 'package:flutter/material.dart';
import 'package:my_med/src/modules/calendar/providers/calendar_provider.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalendarProvider(),
      child: const _CalendarPage(),
    );
  }
}

class _CalendarPage extends StatelessWidget {
  const _CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
