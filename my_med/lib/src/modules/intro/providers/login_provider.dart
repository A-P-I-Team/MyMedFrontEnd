import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/intro/apis/auth_api.dart';

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
    FocusScope.of(context).requestFocus(FocusNode());
    isLoading = true;
    notifyListeners();
    final ok = await AuthAPI().login(email: emailController.text, password: passwordController.text);
    isLoading = false;
    notifyListeners();
    if (ok) {
      context.router.replaceAll(const [DashboardRoute()]);
    }
  }
}
