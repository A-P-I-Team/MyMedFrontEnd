import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/components/primary_icon_button.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/components/doctor_details_container.dart';
import 'package:my_med/src/modules/drug/components/progress_drug_container.dart';
// import 'package:my_med/src/modules/drug/components/stop_medication_request_button.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class DrugsBody extends StatelessWidget {
  final DrugDetailModel prescriptionModel;
  final int totalDayUse;
  final void Function() onStopPrescription;
  final bool isStartedDrug;

  const DrugsBody({
    Key? key,
    required this.prescriptionModel,
    required this.totalDayUse,
    required this.onStopPrescription,
    required this.isStartedDrug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 27.0),
            child: Row(
              children: [
                Text(
                  context.localizations.doctorDescription,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF474747),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(
                      prescriptionModel.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF737373),
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BuildDoctorDetailsContainer(
                    prescriptionModel: prescriptionModel,
                  ),
                ),
                Flexible(
                    child: (isStartedDrug)
                        ? ProgressDrugContainer(
                            prescriptionModel: prescriptionModel,
                          )
                        : const SizedBox()),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              if (!isStartedDrug)
                PrimaryIconButton(
                  title: context.localizations.addReminder,
                  icon: SvgPicture.asset("assets/bell.svg"),
                ),
              if (!isStartedDrug)
                const SizedBox(
                  height: 16,
                ),
              // StopMedicationRequestButton(
              //   onStopPrescription: onStopPrescription,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
