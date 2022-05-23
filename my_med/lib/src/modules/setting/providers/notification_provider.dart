import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  late BuildContext context;

  bool enableAllNotifications = true;
  bool enableReminderNotifications = true;
  bool enableInAppNotifications = true;
  bool enableAdsNotification = true;

  NotificationProvider(this.context);

  void setAllNotif(bool newVal) {
    enableAllNotifications = newVal;
    notifyListeners();
  }

  void setReminderNotif(bool newVal) {
    enableReminderNotifications = newVal;
    notifyListeners();
  }

  void setInAppNotif(bool newVal) {
    enableInAppNotifications = newVal;
    notifyListeners();
  }

  void setAdsNotif(bool newVal) {
    enableAdsNotification = newVal;
    notifyListeners();
  }
}
