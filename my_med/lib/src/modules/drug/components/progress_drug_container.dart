import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/components/drug_header_content.dart';
import 'package:my_med/src/modules/drug/components/next_reminder_text.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressDrugContainer extends StatelessWidget {
  final DrugDetailModel prescriptionModel;
  final int totalDayUse;

  const ProgressDrugContainer({
    Key? key,
    required this.prescriptionModel,
    required this.totalDayUse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: CustomShadow().buildBoxShadow(),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 1000,
            radius: 50,
            lineWidth: 10,
            percent: 0.75,
            progressColor: const Color(0xFF5EAFC0),
            backgroundColor: const Color(0xFFEDF5FD),
            center: const Text(
              "75%",
              style: TextStyle(
                color: Color(0xFF50C2A0),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      context.localizations.courseProgress,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Color(0xFF474747),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DrugHeaderContent(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      title: context.localizations.consumed,
                      drugDetailModel: prescriptionModel,
                      totalDayUse: totalDayUse,
                    ),
                  ),
                  Expanded(
                    child: DrugHeaderContent(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      title: context.localizations.remaining,
                      drugDetailModel: prescriptionModel,
                      totalDayUse: totalDayUse,
                    ),
                  ),
                  Expanded(
                    child: NextReminderText(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      title: context.localizations.nextReminder,
                      drugDetailModel: prescriptionModel,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
