import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final BoxDecoration boxDecoration;
  final Color textColor;
  final String buttonText;
  final String decisionPopup;
  final void Function(String)? onCustomButtonTap;

  const CustomButton({
    Key? key,
    required this.boxDecoration,
    required this.textColor,
    this.buttonText = '',
    this.decisionPopup = '',
    this.onCustomButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCustomButtonTap?.call(decisionPopup),
      child: Container(
        decoration: boxDecoration,
        width: 90,
        height: 40,
        alignment: Alignment.center,
        child: Text.rich(
          TextSpan(
            text: buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
