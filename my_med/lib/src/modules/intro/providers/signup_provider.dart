import 'dart:async';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/regex.dart';
import 'package:my_med/src/models/date.dart';
import 'package:my_med/src/modules/intro/models/register_controller.dart';
import 'package:my_med/src/modules/intro/pages/stateful_bottom_sheet.dart';

class SignupProvider extends ChangeNotifier {
  final BuildContext context;
  final _animationCurve = Curves.easeInOut;
  final _animationDuration = const Duration(milliseconds: 350);

  int _currentPage = 0;
  final int registerPageCount = 4;
  final pageController = PageController();
  final registerController = RegisterController();

  // final _api = AuthApi();
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> emailPageformKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  bool enableButtonForEmailPage = false;
  bool isOTPRight = false;
  bool enableButtonForPersonalInformationPage = false;
  bool enableButtonForUploadPhotoPage = false;

  final GlobalKey<StatefulBottomSheetState> bottomSheetKey = GlobalKey<StatefulBottomSheetState>();

  SignupProvider(this.context);

  @override
  void dispose() {
    pageController.dispose();
    registerController.nameController.dispose();
    //TODO disposing controllers
    super.dispose();
  }

  bool get isLoading => _isLoading;

  int get currentPage => _currentPage;

  Curve get animationCurve => _animationCurve;
  Duration get animationDuration => _animationDuration;

  bool get canPressBack {
    return !_isLoading;
  }

  bool get canPressNext {
    if (_isLoading) return false;
    bool value = false;
    if (currentPage == 0 && isOTPRight) {
      value = true;
    } else if (currentPage == 1 && enableButtonForPersonalInformationPage) {
      value = true;
    } else if (currentPage == 2 && enableButtonForUploadPhotoPage) {
      value = true;
    }

    return value;
  }

  String get pageTitle {
    switch (currentPage) {
      case 0:
        return "Credentials";
      case 1:
        return "Personal Information";
      case 2:
        return "Upload Your Photo";
      default:
        return "Fill The Form";
    }
  }

  String get confirmButtonText {
    if (currentPage + 1 == registerPageCount) {
      return "Submit & finish";
    } else {
      return "Confirm";
    }
  }

  void changeOTPStatus(bool newVal) {
    isOTPRight = newVal;
    notifyListeners();
  }

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

  void onEmailChanged(String value) {
    emailPageformKey.currentState!.validate();
    isEmailFormValid();
  }

  void onPasswordChanged(String value) {
    emailPageformKey.currentState!.validate();
    isEmailFormValid();
  }

  void onConfirmPasswordChanged(String value) {
    emailPageformKey.currentState!.validate();
    isEmailFormValid();
  }

  void onFirstnameChanged(String value) {
    isPersonalInformationValid();
  }

  void onlastNameChanged(String value) {
    isPersonalInformationValid();
  }

  void onbirthdayChanged(String value) {
    isPersonalInformationValid();
  }

  void setupPhoto(final Uint8List? photo, final String? path) {
    registerController.photo = photo;
    registerController.photoPath = path;
    enableButtonForUploadPhotoPage = true;
    notifyListeners();
  }

  void onBackPressed() {
    if (currentPage <= 0) {
      context.router.pop();
    } else {
      _currentPage--;
      pageController
          .animateToPage(
            _currentPage,
            curve: _animationCurve,
            duration: _animationDuration,
          )
          .then((value) => notifyListeners());
    }
  }

  void onNextPressed() {
    if (currentPage < registerPageCount) {
      _currentPage++;
      pageController.animateToPage(
        _currentPage,
        curve: _animationCurve,
        duration: _animationDuration,
      );
    }
    notifyListeners();
  }

  void onBirthDateChanged(final Date newDate) {
    registerController.birthDate = newDate;
    notifyListeners();
  }

  void onAnswerSelected(final int questionIndex, final int? answerIndex) {
    registerController.questions[questionIndex].selectedAnswer = answerIndex;
    notifyListeners();
  }

  Future<void> onConfirmPressed() async {
    if (currentPage == 0) {
      FocusScope.of(context).requestFocus(FocusNode());
      changeOTPStatus(false);
      return;
    } else if (currentPage == registerPageCount) {
      if (!registerController.areQuestionsAnswered) return;
      _isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 2));
      // final response = await _api.register(registerController);
      _isLoading = false;
      notifyListeners();
      // if (response) context.vRouter.to('/login');
    } else {
      onNextPressed();
    }
  }

  // void buildBottomSheet(BuildContext context) {

  // }

  void isPersonalInformationValid() {
    if (firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && birthdateController.text.isNotEmpty) {
      enableButtonForPersonalInformationPage = true;
    } else {
      enableButtonForPersonalInformationPage = false;
    }
    notifyListeners();
  }

  void isEmailFormValid() {
    if (emailPageformKey.currentState!.validate()) {
      enableButtonForEmailPage = true;
    } else {
      enableButtonForEmailPage = false;
    }
    notifyListeners();
  }
}
