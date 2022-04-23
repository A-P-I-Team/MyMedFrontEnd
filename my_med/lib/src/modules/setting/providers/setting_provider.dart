import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/profile/components/exit_popup.dart';

class SettingProvider extends ChangeNotifier {
  final BuildContext context;

  SettingProvider(this.context);

  void popSettingPage() {
    context.router.pop();
  }

  void onLanguageTap() {
    context.router.push(const LanguageRoute());
  }

  void onNotificationTap() {
    context.router.push(const NotificationRoute());
  }

  void onAboutUsTap() {
    context.router.push(const AboutUsRoute());
  }

  Future<void> showExitPopUp() async {
    final isExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ExitPopUp();
      },
    );
    if (isExit ?? false) {
      await PreferencesService.logout();
      context.router.replaceAll([const SplashRoute()]);
    }
  }
}
