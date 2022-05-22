import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/regex.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';
import 'package:my_med/src/modules/intro/apis/auth_api.dart';
import 'package:my_med/src/modules/intro/pages/stateful_bottom_sheet.dart';

class ForgetpasswordProvider extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> emailPageformKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<StatefulBottomSheetState> bottomSheetKey =
      GlobalKey<StatefulBottomSheetState>();
  bool enableButtonForEmailField = false;
  final int _currentPage = 0;
  bool _isLoading = false;
  int? otpCode;
  final _authAPI = AuthAPI();
  bool isOTPRight = false;

  ForgetpasswordProvider(this.context);

  @override
  void dispose() {
    emailController.dispose();
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
    emailPageformKey.currentState!.validate();
    isEmailFormValid();
  }

  void isEmailFormValid() {
    if (emailPageformKey.currentState!.validate()) {
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

    _isLoading = true;
    notifyListeners();
    otpCode = await _authAPI.verifyEmailAccountWithOTP(
      email: emailController.text,
    );
    _isLoading = false;
    notifyListeners();
    debugPrint('$otpCode');
    changeOTPStatus(false);
    if (otpCode == null) return false;
    _isLoading = true;
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
}
