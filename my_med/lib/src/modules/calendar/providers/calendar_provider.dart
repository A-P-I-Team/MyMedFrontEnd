import 'dart:io';

import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/modules/home/apis/Pharmaceutical_api.dart';

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
    date = DateTime(date.year, date.month, date.day);
    remindersList.clear();

    for (final item in activePrescriptionList) {
      for (final rem in item.reminders) {
        if (rem.dateTime.year == date.year &&
            rem.dateTime.month == date.month &&
            rem.dateTime.day == date.day) {
          remindersList.add(rem);
        }
      }
    }
    sortReminders();
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

  void onDismissed(DismissDirection direction, int index) {
    final chosenReminder = remindersList[index];
    if (chosenReminder.dateTime
        .isAfter(DateTime.now().add(const Duration(minutes: 31)))) {
      errorHandler('Time not reached!');
      notifyListeners();
      return;
    }

    if (direction == DismissDirection.endToStart) {
      remindersList[index].status = false;
      callUseDrug(chosenReminder, false, index);
    } else {
      callUseDrug(chosenReminder, true, index);
      remindersList[index].status = true;
    }
    final modifiedReminder = remindersList[index];
    remindersList.removeAt(index);
    remindersList.add(modifiedReminder);
    notifyListeners();
  }

  Future<void> callUseDrug(
    ReminderModel chosenReminder,
    bool isUsed,
    int index,
  ) {
    final oldReminderStatusState = chosenReminder.status;
    return Pharmaceutical()
        .useDrug(
      reminderID: chosenReminder.id,
      isUsed: isUsed,
      context: context,
      onTimeout: () => APIErrorMessage().onTimeout(context),
      onDisconnect: () => APIErrorMessage().onDisconnect(context),
      onAPIError: (message) => APIErrorMessage().onAPIError(context, message),
    )
        .then(
      (ok) {
        if (isDisposed) return;
        if (!ok) {
          remindersList = remindersList.map<ReminderModel>(
            (e) {
              if (e.id == chosenReminder.id) {
                e.status = oldReminderStatusState;
              }
              return e;
            },
          ).toList();
          sortReminders();
          notifyListeners();
        }
      },
    );
  }

  void errorHandler(String errorMessage) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar().customShowMessage(
        message: errorMessage,
        isAndroid: Platform.isAndroid,
        color: Colors.red,
      ),
    );
  }

  void sortReminders() {
    remindersList.sort((reminder1, reminder2) =>
        reminder1.dateTime.compareTo(reminder2.dateTime));

    int index = 0;
    for (var i = 0; i < remindersList.length; i++) {
      final item = remindersList[index];
      if (item.status != null) {
        remindersList.remove(item);
        remindersList.add(item);
      } else {
        index++;
      }
    }
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
