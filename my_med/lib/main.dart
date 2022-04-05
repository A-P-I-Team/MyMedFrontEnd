import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';
import 'package:my_med/src/core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.initialize();
  runApp(MyMed());
}
