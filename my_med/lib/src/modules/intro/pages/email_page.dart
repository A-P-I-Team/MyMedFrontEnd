import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/modules/intro/components/login_input_field.dart';

class EmailPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function(String) onEmailChnaged;
  final void Function(String) onPasswordChanged;
  final void Function(String) onConfirmPasswordChanged;
  final void Function() onConfirmTap;
  final bool formIsValid;
  final GlobalKey formKey;
  final String? Function(String?) emailValidation;
  final String? Function(String?) passwordValidation;
  final String? Function(String?) passwordConfirmValidation;
  final bool isLoading;
  const EmailPage({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onEmailChnaged,
    required this.onPasswordChanged,
    required this.formKey,
    required this.confirmPasswordController,
    required this.onConfirmPasswordChanged,
    required this.onConfirmTap,
    required this.formIsValid,
    required this.emailValidation,
    required this.passwordValidation,
    required this.passwordConfirmValidation,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextField(
                    controller: emailController,
                    label: "Email",
                    onChanged: onEmailChnaged,
                    validator: emailValidation,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DefaultTextField(
                    controller: passwordController,
                    obscureText: true,
                    label: "Password",
                    onChanged: onPasswordChanged,
                    validator: passwordValidation,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DefaultTextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    label: "Confirm Password",
                    onChanged: onPasswordChanged,
                    validator: passwordConfirmValidation,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: DefaultButton(
                      onPressed: (formIsValid) ? onConfirmTap : null,
                      child: (isLoading)
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : const Text("Verify"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
