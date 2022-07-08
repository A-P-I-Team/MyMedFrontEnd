import 'package:flutter/cupertino.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/modules/home/apis/Pharmaceutical_api.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarProvider extends ChangeNotifier {
  BuildContext context;
  bool isSearchSelect = false;
  TextEditingController searchBarController = TextEditingController();
  List<ActivePrescriptionModel> activePrescriptionList = [];
  List<ReminderModel> remindersList = [];
  bool isLoading = true;
  int selectedYear = -1;
  int selectedMonth = -1;
  int selectedDay = -1;
  bool isDisposed = false;

  CalendarProvider(this.context) {
    getAllActivePrescriptionsList();
  }

  void findReminders(DateTime date) {
    date = Jalali(date.year, date.month, date.day).toDateTime();
    remindersList.clear();

    for (final item in activePrescriptionList) {
      for (final rem in item.reminders) {
        if (rem.dateTime.year == date.year &&
            rem.dateTime.month == date.month &&
            rem.dateTime.day == date.day) remindersList.add(rem);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getAllActivePrescriptionsList() async {
    isLoading = true;

    Pharmaceutical()
        .getActivePrescription(
      onTimeout: () => APIErrorMessage().onTimeout(context),
      onDisconnect: () => APIErrorMessage().onDisconnect(context),
      onAPIError: () => APIErrorMessage().onDisconnect(context),
    )
        .then(
      (value) {
        if (isDisposed) return;

        if (value.isEmpty) {
          activePrescriptionList = [];
        } else {
          activePrescriptionList =
              value.where((element) => element.reminders.isNotEmpty).toList();
        }
        isLoading = false;
        if (isDisposed) return;
        notifyListeners();
      },
    );
  }

  void onDismissed(DismissDirection direction, int index) async {
    final choosedReminder = remindersList[index];

    if (direction == DismissDirection.endToStart) {
      remindersList[index].status = false;
      callUseDrug(choosedReminder, false, index);
    } else {
      callUseDrug(choosedReminder, true, index);
      remindersList[index].status = true;
    }
    final modifiedReminder = remindersList[index];
    remindersList.removeAt(index);
    remindersList.add(modifiedReminder);
    notifyListeners();
  }

  Future<void> callUseDrug(
      ReminderModel choosedReminder, bool isUsed, int index) {
    return Pharmaceutical().useDrug(choosedReminder.id, isUsed, context).then(
      (ok) {
        if (isDisposed) return;
        if (!ok) {
          remindersList = remindersList.map<ReminderModel>(
            (e) {
              if (e.id == choosedReminder.id) {
                e.status = choosedReminder.status;
              }
              return e;
            },
          ).toList();
        }
      },
    );
  }

  void onSearchTap() {
    isSearchSelect = !isSearchSelect;
    searchBarController.clear();
    notifyListeners();
  }

  void onSearchChanged(String? value) {
    notifyListeners();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
