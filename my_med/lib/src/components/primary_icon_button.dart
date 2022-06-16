import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';

class PrimaryIconButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function()? onTap;

  const PrimaryIconButton({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      primary: const Color(0xFFD7D9DA),
      minimumSize: const Size(88, 50),
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
          constraints: const BoxConstraints(maxHeight: 50),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: icon,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
