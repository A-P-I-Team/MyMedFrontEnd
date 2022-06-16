import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class StopMedicationRequestButton extends StatelessWidget {
  final void Function() onStopPrescription;

  const StopMedicationRequestButton({
    Key? key,
    required this.onStopPrescription,
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
      onPressed: onStopPrescription,
      child: DecoratedBox(
        decoration: BuildButtonStyle().buttonStyle2(width: 2),
        child: Container(
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(maxHeight: 50),
          alignment: Alignment.center,
          child: Text(
            context.localizations.requestToStopMedication,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Color(0xFF47BAEB),
            ),
          ),
        ),
      ),
    );
  }
}
