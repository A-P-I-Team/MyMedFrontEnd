import 'package:flutter/material.dart';
import 'package:my_med/src/modules/intro/pages/Upload_photo_page.dart';
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
            provider.onConfirmPressed();
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
                  );
                });
            // provider.onConfirmPressed().then((value) {
            //   (provider.bottomSheetKey.currentState == null) ? print("nulll") : print("noooo");
            //   provider.bottomSheetKey.currentState!.showOtp();
            // });

            // showModalBottomSheet(
            //   isDismissible: false,
            //   context: context,
            //   shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(32),
            //     topRight: Radius.circular(32),
            //   )),
            //   builder: (BuildContext context) {
            //     print("renderrrr");
            //     return SizedBox(
            //       height: MediaQuery.of(context).size.height * 0.4,
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 25,
            //           vertical: 20,
            //         ),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: <Widget>[
            //             Row(
            //               children: [
            //                 const Text(
            //                   'Verify your email account',
            //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF60606B)),
            //                 ),
            //                 Expanded(
            //                   child: Align(
            //                     alignment: Alignment.centerRight,
            //                     child: TextButton(
            //                       onPressed: Provider.of<SignupProvider>(
            //                         context,
            //                       ).resendOtp,
            //                       child: AnimatedCrossFade(
            //                         sizeCurve: Curves.easeInOut,
            //                         firstCurve: Curves.easeInOut,
            //                         secondCurve: Curves.easeInOut,
            //                         alignment: Alignment.centerLeft,
            //                         duration: const Duration(milliseconds: 500),
            //                         crossFadeState: Provider.of<SignupProvider>(
            //                           context,
            //                         ).isTimerFinished
            //                             ? CrossFadeState.showFirst
            //                             : CrossFadeState.showSecond,
            //                         firstChild: Text(
            //                           Provider.of<SignupProvider>(
            //                             context,
            //                           ).timeRemainigText,
            //                           style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            //                           key: const ValueKey(#resend),
            //                         ),
            //                         secondChild: Text(
            //                           Provider.of<SignupProvider>(
            //                             context,
            //                           ).timeRemainigText,
            //                           style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            //                           key: const ValueKey(#nosend),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(height: 8),
            //             SizedBox(
            //               width: double.infinity,
            //               child: Text(
            //                 'Enter the 6-digit code we sent to ${provider.emailController.text}',
            //                 style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF8E8E93)),
            //               ),
            //             ),
            //             const SizedBox(height: 8),
            //             const DefaultButton(
            //               isExpanded: true,
            //               child: Text('Confirm'),
            //             ),
            //             const SizedBox(height: 24),
            //             TextButton(
            //                 onPressed: () {},
            //                 child: Text(
            //                   'Change email account',
            //                   style: TextStyle(
            //                     color: Theme.of(context).primaryColor,
            //                     fontWeight: FontWeight.w700,
            //                     fontSize: 16,
            //                   ),
            //                 ))
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );
          },
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
        );
      case 2:
        return PhotoPage(
          activeColor: activeColor,
          isButtonEnable: provider.enableButtonForUploadPhotoPage,
        );
      case 3:
        return const QuestionsPage();
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
