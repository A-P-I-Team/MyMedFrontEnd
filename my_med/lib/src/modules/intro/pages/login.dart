import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/modules/intro/components/login_input_field.dart';
import 'package:my_med/src/modules/intro/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(_),
      child: _LoginState(),
    );
  }
}

class _LoginState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            (MediaQuery.of(context).viewInsets.bottom == 0)
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: SizedBox(height: MediaQuery.of(context).size.height * 0.4, child: Image.asset("assets/login.jpg")),
                  )
                : const SizedBox(),
            Expanded(
              child: Align(
                alignment: const Alignment(0, -.4),
                child: Padding(
                  padding: const EdgeInsets.only(left: 28, right: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTextField(
                        controller: provider.emailController,
                        label: "Email",
                        onChanged: provider.isTextFieldsValid,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DefaultTextField(
                        controller: provider.passwordController,
                        obscureText: true,
                        label: "Password",
                        onChanged: provider.isTextFieldsValid,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: AnimatedContainer(
                height: 55,
                width: (provider.isLoading) ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).buttonTheme.colorScheme!.primary,
                ),
                duration: const Duration(milliseconds: 500),
                child: DefaultButton(
                  forceEnabling: provider.isLoading,
                  isExpanded: true,
                  onPressed: (provider.isButtonEnabled && provider.isLoading == false) ? provider.Login : null,
                  child: (provider.isLoading)
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
