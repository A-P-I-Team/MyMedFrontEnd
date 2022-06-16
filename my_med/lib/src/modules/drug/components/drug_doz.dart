import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class DrugDoz extends StatelessWidget {
  final DrugDetailModel prescriptionModel;

  const DrugDoz({
    Key? key,
    required this.prescriptionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${prescriptionModel.dosage} ',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Color(0xFF5EAFC0),
        ),
        children: [
          TextSpan(
            text: context.localizations.miligram,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Color(0xFF737373),
            ),
          ),
        ],
      ),
    );
  }
}
