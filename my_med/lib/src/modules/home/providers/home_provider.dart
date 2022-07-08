import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/home/apis/Pharmaceutical_api.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/modules/profile/apis/profile_apis.dart';
import 'package:my_med/src/modules/profile/models/profile_model.dart';

class HomeProvider extends ChangeNotifier {
  final BuildContext context;
  UserProfileModel? userProfile;
  bool hasError = false;
  int consumedCount = 1;
  int totalCount = 4;
  bool isSearchSelect = false;
  bool isDisposed = false;
  bool isLoading = true;
  TextEditingController searchBarController = TextEditingController();
  List<ActivePrescriptionModel> activePrescriptionList = [];
  List<ReminderModel> remindersList = [];

  HomeProvider(this.context) {
    getUser();
    getActivePrescription();
  }

  Future<void> getUser() async {
    userProfile = await ProfileAPI().getUserProfile(
      onTimeout: () => APIErrorMessage().onTimeout(context),
      onDisconnect: () => APIErrorMessage().onDisconnect(context),
      onAPIError: () => APIErrorMessage().onDisconnect(context),
    );
    if (isDisposed) return;
    notifyListeners();
  }

  Future<void> getActivePrescription() async {
    isLoading = true;
    notifyListeners();
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
          addReminders();
          setTakenMedicines();
        }
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void setTakenMedicines() {
    totalCount = remindersList
        .where((element) => element.status != true)
        .toList()
        .length;
    consumedCount = remindersList.length - totalCount;
  }

  void addReminders() {
    DateTime date = DateTime.now();
    remindersList.clear();
    for (final item in activePrescriptionList) {
      for (final rem in item.reminders) {
        if (rem.dateTime.year == date.year &&
            rem.dateTime.month == date.month &&
            rem.dateTime.day == date.day) {
          if (rem.dateTime.hour < DateTime.now().hour ||
              (rem.dateTime.hour == DateTime.now().hour &&
                  rem.dateTime.minute < DateTime.now().minute)) {
            rem.status = false;
          }
          remindersList.add(rem);
        }
      }
    }
    sortReminders();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isDisposed) return;
      notifyListeners();
    });
  }

  void sortReminders() => remindersList.sort((reminder1, reminder2) =>
      reminder1.dateTime.compareTo(reminder2.dateTime));

  void onSearchTap() {
    isSearchSelect = !isSearchSelect;
    searchBarController.clear();
    notifyListeners();
  }

  void onSearchChanged(String? value) {
    notifyListeners();
  }

  void onDismissed(DismissDirection direction, int index) {
    final chosenReminder = remindersList[index];

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

  void callUseDrug(
    ReminderModel chosenReminder,
    bool isUsed,
    int index,
  ) {
    final oldReminderStatusState = chosenReminder.status;
    Pharmaceutical()
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
        } else {
          consumedCount++;
        }
        if (isDisposed) return;
        notifyListeners();
      },
    );
  }

  void onAddReminderTap() {
    context.router.push(const ActivePrescriptionRoute());
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
