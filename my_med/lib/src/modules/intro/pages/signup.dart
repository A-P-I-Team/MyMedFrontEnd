import 'package:flutter/material.dart';
import 'package:my_med/src/modules/intro/apis/auth_api.dart';
import 'package:my_med/src/modules/intro/pages/upload_photo_page.dart';
import 'package:my_med/src/modules/intro/pages/stateful_bottom_sheet.dart';
import 'package:my_med/src/modules/intro/pages/email_page.dart';
import 'package:my_med/src/modules/intro/pages/personal_information_page.dart';
import 'package:my_med/src/modules/intro/pages/question_page.dart';
import 'package:my_med/src/modules/intro/providers/signup_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupProvider>(
      create: (_) => SignupProvider(_),
      child: _SignUpPage(),
    );
  }
}

class _SignUpPage extends StatelessWidget {
  final Color titleColor = const Color(0xFF31313D);
  final Color iconColorActive = const Color(0xFF6C6C70);
  final Color iconColorDeactive = const Color(0xFFD8D8DC);

  Widget _pageBuilder(BuildContext context, final int index, SignupProvider provider) {
    final activeColor = Theme.of(context).textTheme.headline6!.color!;
    switch (index) {
      case 0:
        return EmailPage(
          emailController: provider.emailController,
          passwordController: provider.passwordController,
          onEmailChnaged: provider.onEmailChanged,
          onPasswordChanged: provider.onPasswordChanged,
          formKey: provider.emailPageformKey,
          confirmPasswordController: provider.confirmPasswordController,
          onConfirmPasswordChanged: provider.onConfirmPasswordChanged,
          emailValidation: provider.validateEmail,
          passwordConfirmValidation: provider.validateConfirmPassword,
          passwordValidation: provider.validatePassword,
          formIsValid: provider.enableButtonForEmailPage,
          onConfirmTap: () {
            provider.onConfirmPressed().then((value) {
              if (provider.otpCode != null) {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    isDismissible: false,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    )),
                    builder: (_) {
                      return StatefulBottomSheet(
                        key: provider.bottomSheetKey,
                        emailController: provider.emailController,
                        orginalOTP: provider.otpCode.toString(),
                        changeOTPStatus: provider.changeOTPStatus,
                        goToNextPage: provider.onNextPressed,
                        sendOtp: AuthAPI().verifyEmailAccountWithOTP,
                        setOTPCode: provider.setNewOTPCode,
                      );
                    });
              }
            });
          },
          isLoading: provider.isLoading,
        );
      case 1:
        return PersonalInformationPage(
          activeColor: activeColor,
          firstNameController: provider.firstNameController,
          lastNameController: provider.lastNameController,
          birthdayController: provider.birthdateController,
          isFormValid: provider.enableButtonForPersonalInformationPage,
          onConfirmTap: provider.onConfirmPressed,
          onBirthChanged: provider.onbirthdayChanged,
          onFirstNameChanged: provider.onFirstnameChanged,
          onLastNameChanged: provider.onlastNameChanged,
          updateStat: provider.updateState,
          onSSNChanged: provider.onSSNChanged,
          ssnController: provider.ssnController,
        );
      case 2:
        return PhotoPage(
          activeColor: activeColor,
          isButtonEnable: provider.enableButtonForUploadPhotoPage,
          onConfirmPressed: provider.onConfirmPressed,
        );
      case 3:
        return (provider.isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : QuestionsPage(
                onGenderChanged: provider.onGenderChanged,
                gender: provider.gender,
                isVaccinated: provider.vaccinated,
                relationship: provider.relationship,
                defaultCity: provider.city,
                onCityChanged: provider.onCityChanged,
                onFind: provider.onFindCity,
                isFormValid: provider.isQuestionsFormValid,
                onSubmitPressed: provider.onConfirmPressed,
                onRelationChanged: provider.onRelationshipChanged,
                onVaccinatedChanged: provider.onVaccinatedChanged,
              );
    }
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                IconButton(
                  iconSize: 40,
                  color: iconColorActive,
                  disabledColor: iconColorDeactive,
                  icon: const Icon(Icons.arrow_left_rounded),
                  onPressed: provider.canPressBack ? provider.onBackPressed : null,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Step ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '${provider.currentPage + 1}',
                            ),
                            TextSpan(
                              text: ' of ${provider.registerPageCount}',
                              style: TextStyle(
                                fontSize: 14,
                                color: iconColorDeactive,
                              ),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 22,
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      AnimatedDefaultTextStyle(
                        curve: provider.animationCurve,
                        duration: provider.animationDuration,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        child: Text(provider.pageTitle),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  color: iconColorActive,
                  disabledColor: iconColorDeactive,
                  icon: const Icon(Icons.arrow_right_rounded),
                  onPressed: provider.canPressNext ? provider.onNextPressed : null,
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: provider.pageController,
                itemCount: provider.registerPageCount,
                onPageChanged: (_) => FocusScope.of(context).unfocus(),
                itemBuilder: (_, int index) => _pageBuilder(context, index, provider),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
