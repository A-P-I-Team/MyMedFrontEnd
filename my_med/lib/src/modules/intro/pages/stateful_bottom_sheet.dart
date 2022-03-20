import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/components/text_field.dart';

class StatefulBottomSheet extends StatefulWidget {
  final TextEditingController emailController;
  final String orginalOTP;
  final void Function(bool newVal) changeOTPStatus;
  final void Function() goToNextPage;
  const StatefulBottomSheet({
    Key? key,
    required this.emailController,
    required this.orginalOTP,
    required this.changeOTPStatus,
    required this.goToNextPage,
  }) : super(key: key);

  @override
  StatefulBottomSheetState createState() => StatefulBottomSheetState();
}

class StatefulBottomSheetState extends State<StatefulBottomSheet> {
  bool isLoading = false;
  Timer? _timer;
  static const _retryTime = Duration(minutes: 2);
  Duration timeRemaining = _retryTime;

  bool get isTimerFinished => timeRemaining == Duration.zero;
  final FocusNode _focus = FocusNode();
  bool isOTPComplete = false;
  String otpVerification = '';
  String? errorText;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    showOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).viewInsets.bottom == 0) ? MediaQuery.of(context).size.height * 0.45 : MediaQuery.of(context).size.height * 0.75,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Text(
                  'Verify your email account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF60606B)),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: (isTimerFinished) ? resendOtp : null,
                      child: AnimatedCrossFade(
                        sizeCurve: Curves.easeInOut,
                        firstCurve: Curves.easeInOut,
                        secondCurve: Curves.easeInOut,
                        alignment: Alignment.centerLeft,
                        duration: const Duration(milliseconds: 500),
                        crossFadeState: isTimerFinished ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        firstChild: Text(
                          timeRemainigText,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          key: const ValueKey(#resend),
                        ),
                        secondChild: Text(
                          timeRemainigText,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          key: const ValueKey(#nosend),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Enter the 6-digit code we sent to ${widget.emailController.text}',
                style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF8E8E93)),
              ),
            ),
            const SizedBox(height: 8),
            STextField(
              errorText: errorText,
              prefix: AnimatedSwitcher(
                key: ValueKey(errorText),
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.bounceIn,
                switchOutCurve: Curves.easeOut,
                child: Icon(
                  (errorText == null) ? Icons.email_rounded : Icons.error_outline_rounded,
                  color: (errorText == null) ? Theme.of(context).primaryColor : Theme.of(context).errorColor,
                ),
              ),
              maxLength: 6,
              focusNode: _focus,
              hint: (_focus.hasFocus) ? '' : '_ _ _ _ _ _',
              hintStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Color(0xFFBCBCC0),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                errorText = null;
                if (value.length == 6) {
                  setState(() {
                    otpVerification = value;
                    isOTPComplete = true;
                  });
                } else {
                  setState(() {
                    isOTPComplete = false;
                  });
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedContainer(
              height: 55,
              width: (isLoading) ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).buttonTheme.colorScheme!.primary,
              ),
              duration: const Duration(milliseconds: 500),
              child: DefaultButton(
                isExpanded: true,
                child: (isLoading)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Confirm'),
                onPressed: (isOTPComplete)
                    ? () {
                        //TODO Call API
                        setState(() {
                          isLoading = true;
                        });
                        Future.delayed(const Duration(seconds: 2)).then(
                          (value) {
                            print("After Confirm pressed");
                            if (otpVerification == widget.orginalOTP && widget.orginalOTP.length == 6) {
                              context.router.pop();
                              widget.goToNextPage();
                              //TODO go to next step
                              widget.changeOTPStatus(true);
                            } else {
                              widget.changeOTPStatus(false);

                              setState(() {
                                errorText = 'Wrong OTP';
                              });
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                        );
                      }
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
                onPressed: () => context.router.pop(),
                child: Text(
                  'Change email account',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  String get timeRemainigText {
    if (isTimerFinished) {
      return 'Resend OTP';
    }
    final minutesRemaining = timeRemaining.inMinutes;
    final secondsRemaining = timeRemaining.inSeconds - minutesRemaining * 60;
    String value = '';
    if (minutesRemaining.toString().length == 1) {
      value += '0$minutesRemaining';
    } else {
      value += '$minutesRemaining';
    }
    value += ':';
    if (secondsRemaining.toString().length == 1) {
      value += '0$secondsRemaining';
    } else {
      value += '$secondsRemaining';
    }
    return value;
  }

  Future<void> resendOtp() async {
    print("heeyeyeeey");
    if (!isTimerFinished) return;
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    // final response = await _api.sendOtp('+98$number');
    await Future.delayed(const Duration(seconds: 2));
    if (true) {
      _restartTimer();
    } else {
      //TODO Error handling
    }
    isLoading = false;
  }

  void _restartTimer() {
    _timer?.cancel();
    setState(() {
      timeRemaining = _retryTime;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          timeRemaining -= const Duration(seconds: 1);
        });
        if (isTimerFinished) {
          _timer?.cancel();
        }
      },
    );
  }

  Future<void> showOtp() async {
    setState(() {
      isLoading = true;
    });
    // final response = await _api.sendOtp('+98$number');
    if (true) {
      // emailPageformKey.currentState?.showOtp();
      _restartTimer();
    }
    setState(() {
      isLoading = false;
    });
  }
}