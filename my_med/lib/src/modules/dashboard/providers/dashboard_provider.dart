import 'package:flutter/cupertino.dart';
import 'package:my_med/src/modules/calendar/pages/calendar.dart';
import 'package:my_med/src/modules/doctor/pages/doctor.dart';
import 'package:my_med/src/modules/drug/pages/drug.dart';
import 'package:my_med/src/modules/home/pages/home.dart';
import 'package:my_med/src/modules/profile/pages/profile_page.dart';

class DashboardProvider extends ChangeNotifier {
  final BuildContext context;

  DashboardProvider(this.context);

  final screens = [
    ProfilePage(),
    DrugPage(),
    HomePage(),
    CalendarPage(),
    DoctorPage(),
  ];

  int _bottomNavigationIndex = 2;

  int get bottomNavigationIndex => _bottomNavigationIndex;

  void setBottomNavigationIndex(int value) {
    _bottomNavigationIndex = value;
    notifyListeners();
  }

  void onSearchBarChanged(String? searchedText) {}
}
