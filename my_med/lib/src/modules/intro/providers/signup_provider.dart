// ignore_for_file: join_return_with_assignment

import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/regex.dart';
import 'package:my_med/src/models/date.dart';
import 'package:my_med/src/modules/intro/models/register_controller.dart';

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
  bool enableButton = false;

  SignupProvider(this.context);

  @override
  void dispose() {
    pageController.dispose();
    registerController.nameController.dispose();
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
    bool value = currentPage == 0 && emailPageformKey.currentState != null && emailPageformKey.currentState!.validate();
    // bool value = currentPage == 0 && registerController.nameController.text.isNotEmpty && registerController.birthDate != null;
    // value |= currentPage == 2 && registerController.photo != null;
    return value;
  }

  bool get canPressConfirm {
    if (_isLoading) return false;
    bool value = canPressNext;
    value |= currentPage == 3 && registerController.areQuestionsAnswered;
    return value;
  }

  String get pageTitle {
    switch (currentPage) {
      case 0:
        return "Email";
      case 1:
        return "Enter your personal information";
      case 2:
        return "Upload your photo";
      default:
        return "Answer the questions";
    }
  }

  String get confirmButtonText {
    if (currentPage + 1 == registerPageCount) {
      return "Submit & finish";
    } else {
      return "Confirm";
    }
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
    isFormValid();
  }

  void onPasswordChanged(String value) {
    emailPageformKey.currentState!.validate();
    isFormValid();
  }

  void onConfirmPasswordChanged(String value) {
    emailPageformKey.currentState!.validate();
    isFormValid();
  }

  void setupPhoto(final Uint8List? photo, final String? path) {
    registerController.photo = photo;
    registerController.photoPath = path;
    notifyListeners();
  }

  void onBackPressed() {
    if (currentPage <= 0) {
      context.router.pop();
    } else {
      _currentPage--;
      pageController.animateToPage(
        _currentPage,
        curve: _animationCurve,
        duration: _animationDuration,
      );
    }
    notifyListeners();
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
    if (currentPage == registerPageCount) {
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

  void isFormValid() {
    if (emailPageformKey.currentState!.validate()) {
      enableButton = true;
    } else {
      enableButton = false;
    }
    notifyListeners();
  }
}
