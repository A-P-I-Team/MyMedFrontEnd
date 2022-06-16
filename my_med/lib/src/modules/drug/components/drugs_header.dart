import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/components/drug_header_content.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class DrugsHeader extends StatelessWidget {
  final DrugDetailModel drugDetailModel;
  final int totalDayUse;

  const DrugsHeader({
    Key? key,
    required this.drugDetailModel,
    required this.totalDayUse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Color(0xFFEDF5FD),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                drugDetailModel.medicine,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF474747),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: context.localizations.period,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF474747)),
                  children: [
                    TextSpan(
                      text: totalDayUse.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF5EAFC0),
                      ),
                    ),
                    TextSpan(text: context.localizations.days)
                  ],
                ),
              ),
            ],
          ),
          DrugHeaderContent(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            title: context.localizations.medicationDosage,
            drugDetailModel: drugDetailModel,
            totalDayUse: totalDayUse,
          ),
          DrugHeaderContent(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            title: context.localizations.dailyConsumption,
            drugDetailModel: drugDetailModel,
            totalDayUse: totalDayUse,
          ),
          DrugHeaderContent(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            title: context.localizations.consumptionDuration,
            drugDetailModel: drugDetailModel,
            totalDayUse: totalDayUse,
          ),
        ],
      ),
    );
  }
}
