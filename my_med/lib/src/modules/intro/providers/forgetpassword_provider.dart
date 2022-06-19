import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/components/utils/regex.dart';
import 'package:my_med/src/core/routing/router.dart';
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
    context.router.push(ChangePasswordRoute(email: emailController.text));
  }

  void setNewOTPCode(int newOTPCode) {
    otpCode = newOTPCode;
    notifyListeners();
  }

  Future<bool> onConfirmPressed({BuildContext? ctx}) async {
    if (context.owner != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    isLoading = true;
    notifyListeners();
    otpCode = await AuthAPI().verifyEmailAccountWithOTP(email: emailController.text, resetPassword: true,
    onAPIError: (message) => APIErrorMessage().onAPIError(context, message));
    debugPrint(otpCode.toString());
    isLoading = false;
    notifyListeners();
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

  

}
