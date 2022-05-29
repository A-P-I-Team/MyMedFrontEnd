import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/modules/intro/components/login_input_field.dart';
import 'package:my_med/src/modules/intro/providers/changepassword_provider.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  final String email;
  const ChangePasswordPage({
    Key? key,
    required this.email,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordProvider>(
      create: (_) => ChangePasswordProvider(
        context: context,
        email: email,
      ),
      child: _ChangePasswordPage(),
    );
  }
}

class _ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChangePasswordProvider>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: provider.changePassPageFormKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DefaultTextField(
                  label: "Password",
                  obscureText: true,
                  controller: provider.passwordController,
                  onChanged: provider.onPasswordChanged,
                  validator: provider.validatePassword,
                ),
                const SizedBox(height: 24),
                DefaultTextField(
                  label: "Confirm Password",
                  obscureText: true,
                  controller: provider.confirmPasswordController,
                  onChanged: provider.onConfirmPasswordChanged,
                  validator: provider.validateConfirmPassword,
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: DefaultButton(
                      isExpanded: true,
                      onPressed: (provider.enableButtonForChangePassPage)
                          ? () => provider.onSetNewPasswordConfirmPressed()
                          : null,
                      child: (provider.isLoading)
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text("Verify"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
