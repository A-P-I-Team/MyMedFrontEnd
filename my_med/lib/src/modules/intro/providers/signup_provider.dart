import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/regex.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/models/date.dart';
import 'package:my_med/src/modules/intro/apis/auth_api.dart';
import 'package:my_med/src/modules/intro/models/city_model.dart';
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

  final _authAPI = AuthAPI();
  bool _isLoading = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  bool enableButtonForPersonalInformationPage = false;
  bool enableButtonForUploadPhotoPage = false;
  String? ssnErrorText;

  ///*** Credentials ***/
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> emailPageformKey = GlobalKey<FormState>();
  final GlobalKey<StatefulBottomSheetState> bottomSheetKey = GlobalKey<StatefulBottomSheetState>();
  bool enableButtonForEmailPage = false;

  bool isOTPRight = false;

  int? otpCode;
  void setNewOTPCode(int newOTPCode) {
    otpCode = newOTPCode;
    notifyListeners();
  }

  ///*** Credentials  - End ***/

  ///*** Question FORM ***/
  String gender = 'Female', relationship = 'Single', vaccinated = 'Yes', city = 'California';
  bool isQuestionsFormValid = true;
  List<CityModel> cityList = [];

  void onGenderChanged(String? newGender) {
    gender = newGender!;
    notifyListeners();
  }

  void onCityChanged(String? newCity) {
    city = newCity!;
    notifyListeners();
  }

  void onRelationshipChanged(String? newRelationship) {
    relationship = newRelationship!;
    notifyListeners();
  }

  void onVaccinatedChanged(String? newVaccinated) {
    vaccinated = newVaccinated!;
    notifyListeners();
  }

  Future<List<String>> onFindCity(String? filter) async {
    _isLoading = true;
    notifyListeners();
    cityList = await _authAPI.getCities();
    _isLoading = false;
    notifyListeners();
    return List.generate(cityList.length, (index) => cityList[index].cityName);
  }

  ///*** Question FORM - END ***/

  SignupProvider(this.context);

  @override
  void dispose() {
    pageController.dispose();
    registerController.nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    birthdateController.dispose();
    ssnController.dispose();
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
    } else if (currentPage == 3 && isQuestionsFormValid) {
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

  void onSSNChanged(String value) {
    if (value.length < 10) {
      ssnErrorText = 'The SSN should be a 10 digit number!';
      notifyListeners();
    } else {
      ssnErrorText = null;
      notifyListeners();
    }
    isPersonalInformationValid();
  }

  void updateState() {
    notifyListeners();
  }

  void setupPhoto({required File profilePhotoFile, required final String? path, final Uint8List? photo}) {
    registerController.profilePhotoFile = profilePhotoFile;
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
    if (currentPage + 1 < registerPageCount) {
      _currentPage++;
      pageController.animateToPage(
        _currentPage,
        curve: _animationCurve,
        duration: _animationDuration,
      );
    } else if (currentPage + 1 == registerPageCount) {
      onConfirmPressed();
    }
    notifyListeners();
  }

  void onBirthDateChanged(final Date newDate) {
    registerController.birthDate = newDate;
    notifyListeners();
  }

  // void onAnswerSelected(final int questionIndex, final int? answerIndex) {
  //   registerController.questions[questionIndex].selectedAnswer = answerIndex;
  //   notifyListeners();
  // }

  Future<bool> onConfirmPressed() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (currentPage == 0) {
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
      return true;
    } else if (currentPage + 1 == registerPageCount) {
      _isLoading = true;
      notifyListeners();
      final ok = await _authAPI.registerUser(
        email: emailController.text,
        birthday: birthdateController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: gender,
        password: passwordController.text,
        ssn: ssnController.text,
        profilePicFile: registerController.profilePhotoFile!,
        isVaccinated: vaccinated,
        relationshipStatus: relationship,
        userCityID: cityList.firstWhere((element) => element.cityName == city).id.toString(),
      );
      _isLoading = false;
      notifyListeners();
      if (ok == false) return false;
      context.router.popAndPush(const LoginRoute());
      return true;
    } else {
      onNextPressed();
      return true;
    }
  }

  void isPersonalInformationValid() {
    if (firstNameController.text.isNotEmpty && firstNameController.text.length <= 50 && lastNameController.text.isNotEmpty && lastNameController.text.length <= 50 && birthdateController.text.isNotEmpty && ssnController.text.length == 10) {
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
