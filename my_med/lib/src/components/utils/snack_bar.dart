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

  SnackBar customShowMessage({
    required String message,
    required bool isAndroid,
    required Color color,
    EdgeInsets? margin,
    Icon icon = const Icon(
      Icons.close_rounded,
      color: Colors.white,
    ),
  }) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: icon,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.clip,
              maxLines: 20,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection:
          isAndroid ? DismissDirection.horizontal : DismissDirection.vertical,
      elevation: 10,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: margin,
    );
  }
}
