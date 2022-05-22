import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/modules/intro/apis/auth_api.dart';
import 'package:my_med/src/modules/intro/components/login_input_field.dart';
import 'package:my_med/src/modules/intro/pages/stateful_bottom_sheet.dart';
import 'package:my_med/src/modules/intro/providers/forgetpassword_provider.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgetpasswordProvider>(
        create: (_) => ForgetpasswordProvider(_), child: _ForgetPasswordPage());
  }
}

class _ForgetPasswordPage extends StatelessWidget {
  // Constant Variables
  late final TextEditingController emailController;
  late final GlobalKey formKey;
  late final bool formIsValid;
  late final bool isLoading;
  final Color titleColor = const Color(0xFF31313D);
  final Color iconColorActive = const Color(0xFF6C6C70);
  final Color iconColorDeactive = const Color(0xFFD8D8DC);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ForgetpasswordProvider>();
    return Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: DefaultTextField(
                  controller: emailController,
                  label: "Email",
                  onChanged: provider.onEmailChanged,
                  validator: provider.validateEmail),
            ),
            Expanded(
              child: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: SizedBox(
                        width: double.infinity,
                        child: DefaultButton(
                          onPressed: (formIsValid)
                              ? () {
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
                                              emailController:
                                                  provider.emailController,
                                              orginalOTP:
                                                  provider.otpCode.toString(),
                                              changeOTPStatus:
                                                  provider.changeOTPStatus,
                                              goToNextPage:
                                                  provider.onNextPressed,
                                              sendOtp: AuthAPI()
                                                  .verifyEmailAccountWithOTP,
                                              setOTPCode:
                                                  provider.setNewOTPCode,
                                            );
                                          });
                                    }
                                  });
                                }
                              : null,
                          child: (isLoading)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : const Text("Verify"),
                        )),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
