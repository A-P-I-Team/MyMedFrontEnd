import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_med/src/modules/setting/providers/notification_provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late NotificationProvider sut;
  final MockBuildContext context = MockBuildContext();
  setUp(() {
    sut = NotificationProvider(context);
  });

  test(
    'Notification Page Initializing Test',
    () {
      expect(sut.enableAllNotifications, true);
      expect(sut.enableReminderNotifications, true);
      expect(sut.enableInAppNotifications, true);
      expect(sut.enableAdsNotification, true);
    },
  );

  test(
    'Language Page [setAllNotif] Test',
    () {
      const bool newVal = false;
      sut.setAllNotif(newVal);
      expect(sut.enableAllNotifications, newVal);
    },
  );

  test(
    'Language Page [setReminderNotif] Test',
    () {
      const bool newVal = false;
      sut.setReminderNotif(newVal);
      expect(sut.enableReminderNotifications, newVal);
    },
  );

  test(
    'Language Page [setInAppNotif] Test',
    () {
      const bool newVal = false;
      sut.setInAppNotif(newVal);
      expect(sut.enableInAppNotifications, newVal);
    },
  );

  test(
    'Language Page [setAdsNotif] Test',
    () {
      const bool newVal = false;
      sut.setAdsNotif(newVal);
      expect(sut.enableAdsNotification, newVal);
    },
  );
}
