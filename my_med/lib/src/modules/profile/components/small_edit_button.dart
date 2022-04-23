import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class SmallEditButton extends StatelessWidget {
  final void Function()? onTap;

  const SmallEditButton({
    Key? key,
    required this.onTap,
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

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 95,
        height: 30,
        child: ElevatedButton(
          style: raisedButtonStyle,
          onPressed: onTap,
          child: DecoratedBox(
            decoration: BuildButtonStyle().buttonStyle(),
            child: Container(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.center,
              child: Text(
                context.localizations.smallEditButton,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
