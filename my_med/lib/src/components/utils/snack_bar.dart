import 'package:flutter/material.dart';

class CustomSnackBar {
  void showMessage({
    required BuildContext context,
    required Widget content,
    Color? bgColor,
    Duration duration = const Duration(seconds: 1),
    SnackBarBehavior? snackBarBehavior,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? width,
    double? elevation,
    RoundedRectangleBorder? shape,
    DismissDirection dismissDirection = DismissDirection.down,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    var snackBar = SnackBar(
      content: content,
      dismissDirection: dismissDirection,
      backgroundColor: bgColor,
      duration: duration,
      behavior: snackBarBehavior,
      margin: margin,
      padding: padding,
      width: width,
      elevation: elevation,
      shape: shape,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
