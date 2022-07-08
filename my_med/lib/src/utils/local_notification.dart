import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationAPI {
  static final _notification = FlutterLocalNotificationsPlugin();

  Future<void> showScheduledNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime dateTime,
  }) async {
    _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        dateTime,
        tz.local,
      ),
      await _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payload,
    );
  }

  Future<NotificationDetails> _notificationDetails() async =>
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '#0',
          'MyMed',
          channelDescription: 'Local Notifications for Doctora app',
          importance: Importance.max,
        ),
        iOS: IOSNotificationDetails(),
      );

  Future initi({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const setting = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _notification.initialize(
      setting,
      onSelectNotification: ((payload) => {}),
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  Future<void> removeNotification(int id) async {
    await _notification.cancel(id);
  }

  Future<void> removeAllNotification() async {
    await _notification.cancelAll();
  }
}
