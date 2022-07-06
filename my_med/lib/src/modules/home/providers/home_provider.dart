import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/core/routing/router.dart';
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

  void getActivePrescription() {
    //TODO API call
    isLoading = false;
    if (isDisposed) return;
    notifyListeners();
  }

  void addReminders() {
    DateTime date = DateTime.now();
    remindersList.clear();
    for (final item in activePrescriptionList) {
      for (final rem in item.reminders) {
        if (rem.timeToTake.year == date.year &&
            rem.timeToTake.month == date.month &&
            rem.timeToTake.day == date.day) remindersList.add(rem);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isDisposed) return;
      notifyListeners();
    });
  }

  void onSearchTap() {
    isSearchSelect = !isSearchSelect;
    searchBarController.clear();
    notifyListeners();
  }

  void onSearchChanged(String? value) {
    notifyListeners();
  }

  void onDismissed(DismissDirection direction, int index) async {
    final choosedReminder = remindersList[index];

    if (direction == DismissDirection.endToStart) {
      remindersList[index].taken = false;
      callUseDrug(choosedReminder, false, index);
    } else {
      callUseDrug(choosedReminder, true, index);
      remindersList[index].taken = true;
    }
    final modifiedReminder = remindersList[index];
    remindersList.removeAt(index);
    remindersList.add(modifiedReminder);
    notifyListeners();
  }

  Future<void> callUseDrug(
    ReminderModel choosedReminder,
    bool isUsed,
    int index,
  ) async {
    //TODO API call
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
