import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';

class ConsumptionDurationText extends StatelessWidget {
  final ActivePrescriptionModel medication;

  const ConsumptionDurationText({
    Key? key,
    required this.medication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${medication.consumptionDuration} ',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Color(0xFF5EAFC0),
        ),
        children: [
          TextSpan(
            text: context.localizations.hourOnce,
          ),
        ],
      ),
    );
  }
}
