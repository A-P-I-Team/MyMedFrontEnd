import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';
import 'package:my_med/src/core/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_med/src/core/local_database/hive_db.dart';
import 'package:my_med/src/utils/local_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.initialize();
  await Hive.initFlutter();
  HiveDB().registerHiveAdapters();
  await HiveDB().initAppDBs();
  await LocalNotificationAPI().initi(initScheduled: true);
  runApp(const MyMed());
}
