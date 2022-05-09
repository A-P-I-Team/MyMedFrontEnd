import 'package:auto_route/auto_route.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:flutter/material.dart';

import '../../../components/button.dart';
import '../components/login_input_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<ForgetPasswordProvider>(
      // create: (_) => ForgetPasswordProvider(),
      // child: _ForgetPasswordState(),
    // );
    return const Scaffold();
  }
}

class _ForgetPasswordState extends StatefulWidget {
  @override
  State<_ForgetPasswordState> createState() => _ForgetPasswordStateState();
}

class _ForgetPasswordStateState extends State<_ForgetPasswordState> {
  double _height = 0;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ForgetPasswordProvider>();
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) {
          _height = 0;
        } else {
          _height = MediaQuery.of(context).size.height * 0.4;
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  height: _height,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Image.asset("assets/login.jpg"),
                  ),
                ),
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
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate,
                  child: Padding(
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
                        //Here---------------------------------------------
                        onPressed: (provider.isButtonEnabled && provider.isLoading == false) ? () => provider.login(context) : null,
                        child: (provider.isLoading)
                            ? const Center(
                                child: CircularProgressIndicator(color: Colors.white),
                              )
                            : const Text(
                                'Confirm Email',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}