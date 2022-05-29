import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/regex.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';
import 'package:my_med/src/modules/intro/apis/auth_api.dart';
import 'package:my_med/src/modules/intro/pages/stateful_bottom_sheet.dart';

class ForgetpasswordProvider extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> verifyFormKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<StatefulBottomSheetState> bottomSheetKey =
      GlobalKey<StatefulBottomSheetState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> changePassPageFormKey = GlobalKey<FormState>();
  bool enableButtonForChangePassPage = false;
  bool enableButtonForEmailField = false;
  final int _currentPage = 0;
  bool isLoading = false;
  int? otpCode;
  final _authAPI = AuthAPI();
  bool isOTPRight = false;

  ForgetpasswordProvider(this.context);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void isTextFieldsValid(String value) {
    if (emailController.text.isNotEmpty) {
      isButtonEnabled = true;
    } else {
      isButtonEnabled = false;
    }
    notifyListeners();
  }

  Future<void> forgetpassword(BuildContext ctx) async {}

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    } else if (CredentialRegex().validEmail.hasMatch(value) == false) {
      return "Email should be in this format: example@ex.com";
    } else if (value.length > 253) {
      return "Your email address should be less than 253 characters";
    }
    return null;
  }

  void onEmailChanged(String value) {
    verifyFormKey.currentState!.validate();
    isEmailFormValid();
  }

  void isEmailFormValid() {
    if (verifyFormKey.currentState!.validate()) {
      enableButtonForEmailField = true;
    } else {
      enableButtonForEmailField = false;
    }
    notifyListeners();
  }

  void changeOTPStatus(bool newVal) {
    isOTPRight = newVal;
    notifyListeners();
  }

  void onNextPressed() {
    notifyListeners();
  }

  void setNewOTPCode(int newOTPCode) {
    otpCode = newOTPCode;
    notifyListeners();
  }

  Future<bool> onConfirmPressed({BuildContext? ctx}) async {
    if (context.owner != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }

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
            Text('You Have Successfuly Signed Up'),
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

  Future<bool> onSetNewPasswordConfirmPressed({BuildContext? ctx}) async {
    if (context.owner != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    _authAPI.setNewPassword(
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        email: emailController.text);
    isLoading = false;
    notifyListeners();
    if (otpCode == null) return false;
    isLoading = true;
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
}
