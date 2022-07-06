import 'package:flutter/material.dart';
import 'package:my_med/src/modules/home/components/consumption_amount_text.dart';
import 'package:my_med/src/modules/home/components/consumption_duration_text.dart';
import 'package:my_med/src/modules/home/components/drug_doz_text.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/modules/home/pages/active_prescription_details_page.dart';

class DrugDetails extends StatelessWidget {
  final EdgeInsets padding;
  final String title;
  final DrugActions actions;
  final ActivePrescriptionModel activePrescriptionModel;

  const DrugDetails({
    Key? key,
    required this.padding,
    required this.title,
    required this.actions,
    required this.activePrescriptionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Color(0xFF474747),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 1,
                color: Color(0x35737373),
              ),
            ),
          ),
          (actions == DrugActions.dosage)
              ? DrugDozText(
                  medication: activePrescriptionModel,
                )
              : (actions == DrugActions.consumptionAmount)
                  ? ConsumptionAmountText(
                      medication: activePrescriptionModel,
                    )
                  : ConsumptionDurationText(
                      medication: activePrescriptionModel,
                    ),
        ],
      ),
    );
  }
}
