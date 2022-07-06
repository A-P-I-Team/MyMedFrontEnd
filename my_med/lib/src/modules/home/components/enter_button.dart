import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class EnterButton extends StatelessWidget {
  final void Function()? onEnterTap;
  final bool isLoading;

  const EnterButton({
    Key? key,
    this.onEnterTap,
    required this.isLoading,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: onEnterTap,
        child: DecoratedBox(
          decoration: BuildButtonStyle().buttonStyle(),
          child: Container(
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints(maxHeight: 50),
            alignment: Alignment.center,
            child: (isLoading)
                ? const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    context.localizations.registerButtonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
