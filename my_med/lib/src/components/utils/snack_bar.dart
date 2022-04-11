import 'package:flutter/material.dart';

class CustomSnackBar {
  void showMessage({
    required BuildContext context,
    required String msg,
    Color? bgColor,
    Duration duration = const Duration(seconds: 1),
    SnackBarBehavior? snackBarBehavior,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? width,
    double? elevation,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    var snackBar = SnackBar(
      content: Text(msg),

      dismissDirection: DismissDirection.down,
      backgroundColor: bgColor,
      duration: duration,
      behavior: snackBarBehavior,
      margin: margin,
      padding: padding,
      width: width,
      elevation: elevation,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
