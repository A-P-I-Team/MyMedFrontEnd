import 'package:flutter/material.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class DrugUsageText extends StatelessWidget {
  final DrugDetailModel prescriptionModel;

  const DrugUsageText({
    Key? key,
    required this.prescriptionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: prescriptionModel.fraction,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Color(0xFF5EAFC0),
        ),
      ),
    );
  }
}
