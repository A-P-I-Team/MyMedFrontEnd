import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/modules/intro/components/login_input_field.dart';
import 'package:my_med/src/modules/intro/providers/changepassword_provider.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordProvider>(
      create: (_) => ChangePasswordProvider(),
      child: _ChangePasswordPage(),
    );
  }
}

class _ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChangePasswordProvider>();
    return Scaffold(
        body: Form(
      key: provider.changePassPageFormKey,
      child: Column(
        children: [
          DefaultTextField(
            label: "Password",
            controller: provider.passwordController,
            onChanged: provider.onPasswordChanged,
            validator: provider.validatePassword,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          DefaultTextField(
            label: "Confirm Password",
            controller: provider.confirmPasswordController,
            onChanged: provider.onConfirmPasswordChanged,
            validator: provider.validateConfirmPassword,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          DefaultButton(
            child: (provider.isLoading)
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
                  )
                : const Text("Verify"),
            onPressed: (provider.enableButtonForChangePassPage)
                ? () {
                    provider.onConfirmPressed().then((value) {});
                  }
                : null,
          )
        ],
      ),
    ));
  }
}
