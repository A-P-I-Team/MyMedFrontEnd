import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';

class ApiError {
  final String message;
  final int code;

  ApiError({
    required this.message,
    this.code = 0,
  });
}

class APIErrorMessage {
  final String serverMessage = 'Problem communicating with server!';
  final String timeoutMessage = 'Timeout connection!';

  void onTimeout(BuildContext context) {
    CustomSnackBar().showMessage(
      context: context,
      content: Text(timeoutMessage),
      bgColor: Theme.of(context).errorColor,
    );
  }

  void onDisconnect(BuildContext context) {
    CustomSnackBar().showMessage(
      context: context,
      content: Text(serverMessage),
      bgColor: Theme.of(context).errorColor,
    );
  }

  void onAPIError(BuildContext context, String message,) {
    CustomSnackBar().showMessage(
      context: context,
      content: Text(message),
      bgColor: Theme.of(context).errorColor,
    );
  }
}
