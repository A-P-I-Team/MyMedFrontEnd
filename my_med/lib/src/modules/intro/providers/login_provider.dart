import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/intro/apis/auth_api.dart';

class LoginProvider extends ChangeNotifier {
  final BuildContext context;
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

  Future<void> login(BuildContext ctx) async {
    if (context.owner != null && FocusScope.of(context).hasFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
      await Future.delayed(const Duration(milliseconds: 200));
    }
    isLoading = true;
    notifyListeners();
    final ok = await AuthAPI().login(email: emailController.text, password: passwordController.text);
    isLoading = false;
    notifyListeners();
    if (context.owner != null && ok) {
      CustomSnackBar().showMessage(
        context: ctx,
        msg: "Welcome Back!",
        duration: const Duration(seconds: 2),
        bgColor: Colors.green,
        elevation: 0,
      );

      await context.router.replaceAll(const [DashboardRoute()]);
    }
  }
}
