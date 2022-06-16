import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/components/drug_doz.dart';
import 'package:my_med/src/modules/drug/components/drug_remained.dart';
import 'package:my_med/src/modules/drug/components/drug_usage_period.dart';
import 'package:my_med/src/modules/drug/components/drug_usage_text.dart';
import 'package:my_med/src/modules/drug/components/drug_used.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class DrugHeaderContent extends StatelessWidget {
  final EdgeInsets padding;
  final String title;
  final DrugDetailModel drugDetailModel;
  final int totalDayUse;

  const DrugHeaderContent({
    Key? key,
    required this.padding,
    required this.title,
    required this.drugDetailModel,
    required this.totalDayUse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
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
                color: const Color(0x35737373),
              ),
            ),
          ),
          (title == context.localizations.medicationDosage)
              ? DrugDoz(
                  prescriptionModel: drugDetailModel,
                )
              : (title == context.localizations.dailyConsumption)
                  ? DrugUsageText(
                      prescriptionModel: drugDetailModel,
                    )
                  : (title == context.localizations.consumptionDuration)
                      ? DrugUsagePeriod(
                          drugDetailModel: drugDetailModel,
                        )
                      : (title == context.localizations.consumed)
                          ? DrugUsed(
                              prescriptionModel: drugDetailModel,
                              totalDayUse: totalDayUse,
                            )
                          : const DrugRemained(),
        ],
      ),
    );
  }
}
