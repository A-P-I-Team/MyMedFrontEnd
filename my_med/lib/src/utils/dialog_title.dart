import 'package:flutter/material.dart';

class DialogTitle {
  Container buildDialogTitle(
    String title, {
    Color backgroundColor = const Color(0xFFF5F7F9),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: backgroundColor,
      ),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Color(0xFF474747),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
