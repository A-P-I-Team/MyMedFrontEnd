import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/dashboard/pages/dashboard_page.dart';

class LoginProvider extends ChangeNotifier {
  final BuildContext context;
  Duration timeRemaining = _retryTime;
  static const _retryTime = Duration(minutes: 2);
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;

  LoginProvider(this.context);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void isTextFieldsValid(String value) {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isButtonEnabled = true;
    } else {
      isButtonEnabled = false;
    }
    notifyListeners();
  }

  Future<void> login() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
    if (true) {
      context.router.push(const DashboardRoute());
    } else {
      //TODO Error Handling
    }
  }
}
