import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_med/src/modules/intro/providers/signup_provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late SignupProvider sut;
  final MockBuildContext _context = MockBuildContext();
  setUp(() {
    sut = SignupProvider(_context);
  });

  test('Sign Up Page Initializing Test', () {
    // setup

    // run

    // verify (result)
    expect(sut.isLoading, false);
    expect(sut.cityList, []);
    expect(sut.isOTPRight, false);
    expect(sut.canPressNext, false);
    expect(sut.gender, 'Female');
    expect(sut.city, '');
    expect(sut.relationship, 'Single');
    expect(sut.vaccinated, 'Yes');
  });

  test('Sign Up Credentials Page [Email Validation] Test', () {
    // setup
    sut.emailController.text = "jkdskkdsa";
    // run
    String? str = sut.validateEmail(sut.emailController.text);
    // verify (result)
    bool res = (str == null) ? true : false;
    expect(res, false);
  });

  test('Sign Up Credentials Page [Email Validation] Test', () {
    // setup
    sut.emailController.text = 'dsja@nkdscom';
    // run
    String? str = sut.validateEmail(sut.emailController.text);

    // verify (result)
    bool res = (str == null) ? true : false;

    expect(res, false);
  });

  test('Sign Up Credentials Page [Password Validation] Test', () {
    // setup
    sut.passwordController.text = 'ab654321';
    // run
    String? str = sut.validatePassword(sut.passwordController.text);
    // verify (result)
    bool res = (str == null) ? true : false;

    expect(res, false);
  });

  test('Sign Up Credentials Page [Confirm Password Validation] Test', () {
    // setup
    sut.passwordController.text = "Ab654321";
    sut.confirmPasswordController.text = "Ab6543211";
    // run
    String? str = sut.validateConfirmPassword(sut.confirmPasswordController.text);
    // verify (result)
    bool res = (str == null) ? true : false;

    expect(res, false);
  });

  test('Sign Up Credentials Page [Success] Test', () {
    // setup
    sut.emailController.text = "user@example.com";
    sut.passwordController.text = "Ab654321";
    sut.confirmPasswordController.text = "Ab654321";
    // run
    String? e = sut.validateEmail(sut.emailController.text);
    String? p = sut.validatePassword(sut.passwordController.text);
    String? cp = sut.validateConfirmPassword(sut.confirmPasswordController.text);

    bool res = false;
    if (e == null && p == null && cp == null) {
      res = true;
    }
    // verify (result)
    expect(res, true);
  });

  test('Sign Up Credentials Page [Confirm Button Pressing] Test', () async {
    // setup
    sut.emailController.text = "userfluttertest@example.com";
    sut.passwordController.text = "Ab654321";
    sut.confirmPasswordController.text = "Ab654321";
    sut.currentPage = 0;
    // run
    sut.enableButtonForEmailPage = true;

    bool result = await sut.onConfirmPressed();
    sut.dispose();

    // verify (result)
    expect(result, true);
  });

  test('Sign Up Credentials Page [OTP Verification] Test', () async {
    // setup
    sut.emailController.text = "userfluttertest@example.com";
    sut.passwordController.text = "Ab654321";
    sut.confirmPasswordController.text = "Ab654321";
    sut.currentPage = 0;
    // run
    sut.enableButtonForEmailPage = true;

    bool result = false;
    await sut.onConfirmPressed();
    result = sut.otpCode == -111111;

    // verify (result)
    expect(result, false);
  });

  test('Sign Up Credentials Page [Send New OTP] Test', () async {
    // setup
    sut.emailController.text = "userfluttertest@example.com";
    sut.passwordController.text = "Ab654321";
    sut.confirmPasswordController.text = "Ab654321";
    sut.currentPage = 0;
    // run
    sut.enableButtonForEmailPage = true;

    sut.setNewOTPCode(123456);

    // verify (result)
    expect(sut.otpCode, 123456);
  });

  test('Sign Up Personal Info Page [Form Validation BDay] Test', () {
    // setup
    sut.firstNameController.text = 'dsa';
    sut.lastNameController.text = 'dbjs';
    sut.birthdateController.text = '';
    sut.ssnController.text = '0123456789';
    sut.currentPage = 1;
    // run
    sut.isPersonalInformationValid();

    // verify (result)
    expect(sut.enableButtonForPersonalInformationPage, false);
  });

  test('Sign Up Personal Info Page [Form Validation SSN] Test', () {
    // setup
    sut.firstNameController.text = 'dsa';
    sut.lastNameController.text = 'dbjs';
    sut.birthdateController.text = '2000-12-12';
    sut.ssnController.text = '123456789';
    sut.currentPage = 1;
    // run
    sut.isPersonalInformationValid();

    // verify (result)
    expect(sut.enableButtonForPersonalInformationPage, false);
  });

  test('Sign Up Personal Info Page [Can Press Next - Failure] Test', () {
    // setup
    sut.firstNameController.text = '';
    sut.lastNameController.text = 'dbjs';
    sut.birthdateController.text = '2000-12-12';
    sut.ssnController.text = '0123456789';
    sut.currentPage = 1;
    // run
    sut.onFirstnameChanged('temp');
    sut.onlastNameChanged('temp');
    sut.onbirthdayChanged('temp');
    sut.onSSNChanged('temp');
    sut.updateState();

    // verify (result)
    expect(sut.canPressNext, false);
  });

  test('Sign Up Personal Info Page [Can Press Next - Success] Test', () {
    // setup
    sut.firstNameController.text = 'dsa';
    sut.lastNameController.text = 'dbjs';
    sut.birthdateController.text = '2000-12-12';
    sut.ssnController.text = '0123456789';
    sut.currentPage = 1;
    // run
    sut.isPersonalInformationValid();

    // verify (result)
    expect(sut.canPressNext, true);
  });

  test('Sign Up Personal Info Page [Title] Test', () {
    // setup
    sut.currentPage = 1;
    // run

    // verify (result)
    expect(sut.pageTitle, 'Personal Information');
    expect(sut.confirmButtonText, 'Confirm');
  });

  test('Sign Up Personal Info Page [On Back Pressing] Test', () {
    // setup
    sut.currentPage = 1;
    // run
    sut.onBackPressed();

    // verify (result)
    expect(sut.currentPage, 0);
  });

  test('Sign Up Personal Info Page [On Next Pressing] Test', () {
    // setup
    sut.currentPage = 1;
    // run
    sut.onNextPressed();

    // verify (result)
    expect(sut.currentPage, 2);
  });

  test('Sign Up Form Page [On Form Validation] Test', () {
    // setup
    sut.onVaccinatedChanged('No');
    sut.onRelationshipChanged('Married');
    sut.onCityChanged('Karaj');
    sut.onGenderChanged('Male');
    sut.currentPage = 3;

    // run

    // verify (result)
    expect(sut.canPressNext, true);
  });

  test('Sign Up Form Page [Getting City] Test', () async {
    // setup
    await sut.onFindCity('temp');
    sut.currentPage = 3;

    // run

    // verify (result)
    expect(sut.cityList, isNotNull);
  });
}
