import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';

class MiniButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const MiniButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      primary: const Color(0xFFD7D9DA),
      minimumSize: const Size(95, 30),
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: onTap,
      child: DecoratedBox(
        decoration: BuildButtonStyle().buttonStyle(),
        child: Container(
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(maxHeight: 30, maxWidth: 95),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
