import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/modules/intro/pages/Upload_photo_page.dart';
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

  Widget _pageBuilder(final BuildContext context, final int index, final SignupProvider provider) {
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
          formIsValid: provider.enableButton,
          onConfirmTap: provider.onConfirmPressed,
          emailValidation: provider.validateEmail,
          passwordConfirmValidation: provider.validateConfirmPassword,
          passwordValidation: provider.validatePassword,
        );
      case 1:
        return PersonalInformationPage(activeColor: activeColor);
      case 2:
        return PhotoPage(activeColor: activeColor);
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
                itemBuilder: (BuildContext context, int index) => _pageBuilder(context, index, provider),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
