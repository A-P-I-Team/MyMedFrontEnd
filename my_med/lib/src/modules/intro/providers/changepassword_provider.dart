import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';

class ChangePasswordProvider extends ChangeNotifier
{
  ChangePasswordProvider(this.context);

  late final BuildContext context;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> changePassPageFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool enableButtonForChangePassPage = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    } else if (value.length > 30) {
      return "Your password should be less than 30 characters";
    } else if (value.length < 8) {
      return "Your password should be at least 8 charaters";
    } else if (value.contains(RegExp(r"[A-Z]")) == false) {
      return "Your password must contain at least one uppercase letter";
    } else if (value.contains(RegExp(r"[0-9]")) == false) {
      return "Your password must contain at least one digit";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "Please re-write your password";
    } else if (value != passwordController.text) {
      return "Your password does not match!";
    }
    return null;
  }

  void onPasswordChanged(String value) {
    changePassPageFormKey.currentState!.validate();
    // isEmailFormValid();
  }

  void onConfirmPasswordChanged(String value) {
    changePassPageFormKey.currentState!.validate();
    // isEmailFormValid();
  }

   Future<bool> onConfirmPressed({BuildContext? ctx}) async {
    if (context.owner != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    isLoading = true;
    notifyListeners();
    notifyListeners();

    if (ctx != null) {
      CustomSnackBar().showMessage(
        context: ctx,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.85,
            left: 24,
            right: 24),
        content: SizedBox(
          height: 25,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text('Your Password Successfuly Changed'),
          ]),
        ),
        duration: const Duration(seconds: 3),
        bgColor: Colors.green,
        snackBarBehavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.startToEnd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );
    }
    return true;
  }
}