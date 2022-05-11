import 'package:flutter/material.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/models/patient_model.dart';
import 'package:my_med/src/modules/profile/components/edit_birthday_popup.dart';
import 'package:my_med/src/modules/profile/components/edit_name_pop_up.dart';
import 'package:my_med/src/modules/profile/components/edit_sexuality_popup.dart';
import 'package:auto_route/auto_route.dart';

enum Sexuality { man, woman, other }

class ProfileProvider extends ChangeNotifier {
  final BuildContext context;
  Patient? patient = Patient(
    fullName: 'Iliya Mirzaei',
    email: 'Iliya.mi78@gmail.com',
    identification: '0024034032',
  );
  bool hasError = false;
  String _year = "";
  String _month = "";
  String _day = "";
  bool isCompleteBirthDay = false;
  Sexuality _sexuality = Sexuality.man;

  Sexuality get sexuality => _sexuality;

  ProfileProvider(this.context) {
    updatePatient();
  }

  void updatePatient() {
    //TODO API Call for get patient info
  }

  void onSexualityChange(Sexuality? sexuality) {
    if (sexuality != null) {
      _sexuality = sexuality;
      notifyListeners();
    }
  }

  void checkValidBirthDay() {
    if (_year != "" && _month != "" && _day != "") {
      // int y = int.parse(year);
      int m = int.parse(_month);
      int d = int.parse(_day);
      if (m >= 1 && m <= 6 && d >= 1 && d <= 31) {
        isCompleteBirthDay = true;
      } else if (m > 6 && m <= 11 && d >= 1 && d <= 30) {
        isCompleteBirthDay = true;
      } else if (m == 12 && d >= 1 && d <= 29) {
        isCompleteBirthDay = true;
      } else {
        isCompleteBirthDay = false;
      }
    } else {
      isCompleteBirthDay = false;
    }
  }

  void onYearChange(String year) {
    _year = year;
    checkValidBirthDay();
    notifyListeners();
  }

  void onMonthChange(String month) {
    _month = month;
    checkValidBirthDay();
    notifyListeners();
  }

  void onDayChange(String day) {
    _day = day;
    checkValidBirthDay();
    notifyListeners();
  }

  String? yearValidator(String? value) {
    if (value!.isEmpty || value.length != 4) {
      return "";
    } else {
      return null;
    }
  }

  String? monthValidator(String? value) {
    if (value!.isEmpty || int.parse(value) < 1 || int.parse(value) > 12) {
      return "";
    } else {
      return null;
    }
  }

  String? dayValidator(String? value) {
    if (value!.isEmpty || int.parse(value) < 1 || int.parse(value) > 31) {
      return "";
    } else if (value.isNotEmpty && int.parse(_month) >= 1 && int.parse(_month) <= 6 && int.parse(value) > 31) {
      return "";
    } else if (value.isNotEmpty && int.parse(_month) > 6 && int.parse(_month) < 12 && int.parse(value) > 30) {
      return "";
    } else if (value.isNotEmpty && int.parse(_month) == 12 && int.parse(value) > 29) {
      return "";
    } else {
      return null;
    }
  }

  Future<void> showEditNamePopUp() async {
    final name = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const EditNamePopUp();
      },
    );
    if (name != null) {
      //TODO API Call Change user name

      updatePatient();
      notifyListeners();
    }
  }

  Future<void> showEditBirthdayPopUp() async {
    final birthDay = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const EditBirthDayPopUp();
      },
    );
    if (birthDay != null) {
      //TODO API Call Set patient birthday
      updatePatient();
      notifyListeners();
    }
  }

  Future<void> showEditSexualityPopUp() async {
    final sexuality = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const EditSexualityPopUp();
      },
    );
    if (sexuality != null) {
      String newGender = (sexuality == "مرد") ? "M" : "F";
      //TODO set patient gender
      updatePatient();
      notifyListeners();
    }
  }

  void onNotificationTap() {
    //TODO naviagte to announcement page
  }

  void onSettingTap() {
    context.router.push(const SettingRoute());
  }
}
