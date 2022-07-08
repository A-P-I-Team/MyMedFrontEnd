import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/home/components/alarm_timming.dart';
import 'package:my_med/src/modules/home/components/custom_button.dart';
import 'package:my_med/src/modules/home/components/drug_details.dart';
import 'package:my_med/src/modules/home/components/enter_button.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/modules/home/providers/active_prescription_details_provider.dart';
import 'package:provider/provider.dart';

enum DrugActions { dosage, consumptionAmount, consumptionDuration }

// enum ConsumptionMethod { afterFood, doesNotMatter, beforeFood, withFood }

// Map<ConsumptionMethod, String> consumptionMethods = {
//   ConsumptionMethod.doesNotMatter: "does not matter",
//   ConsumptionMethod.beforeFood: "before food",
//   ConsumptionMethod.withFood: "with food",
//   ConsumptionMethod.afterFood: "after food",
// };

class ActivePrescriptionDetailsPage extends StatelessWidget {
  final ActivePrescriptionModel activePrescriptionModel;

  const ActivePrescriptionDetailsPage({
    Key? key,
    required this.activePrescriptionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivePrescriptionDetailsProvider(
        context: context,
        activePrescriptionModel: activePrescriptionModel,
      ),
      child: const _ActivePrescriptionDetailsPage(),
    );
  }
}

class _ActivePrescriptionDetailsPage extends StatelessWidget {
  const _ActivePrescriptionDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivePrescriptionDetailsProvider>();
    final selectedTime = provider.selectedTime;
    return Scaffold(
      appBar: buildAppBar(provider.onEnterTap, context),
      resizeToAvoidBottomInset: false,
      body: (provider.isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDF5FD),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider
                                    .activePrescriptionDetailModel!.medicine,
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
                                      text:
                                          ' ${provider.getTotalDayUse(provider.activePrescriptionModel)}',
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
                          DrugDetails(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              title: context.localizations.medicationDosage,
                              actions: DrugActions.dosage,
                              activePrescriptionModel:
                                  provider.activePrescriptionModel),
                          DrugDetails(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            title: context.localizations.dailyConsumption,
                            actions: DrugActions.consumptionAmount,
                            activePrescriptionModel:
                                provider.activePrescriptionModel,
                          ),
                          DrugDetails(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            title: context.localizations.consumptionDuration,
                            actions: DrugActions.consumptionDuration,
                            activePrescriptionModel:
                                provider.activePrescriptionModel,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 8),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/bag.svg",
                                    color: const Color(0xFF76BBBB),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    context.localizations.startReminders,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF474747),
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: CustomButton(
                                        boxDecoration: (provider
                                                .savedCalendarDialogData)
                                            ? BuildButtonStyle().buttonStyle()
                                            : BuildButtonStyle().buttonStyle2(),
                                        textColor:
                                            (provider.savedCalendarDialogData)
                                                ? Colors.white
                                                : const Color(0xFF909090),
                                        buttonText: (context
                                                    .localizations.localeName ==
                                                "fa")
                                            ? "${provider.daySelectedNew} ${provider.monthList[provider.monthSelectedNew - 1]}"
                                            : "${DateTime.now().day} ${provider.monthListMiladi[DateTime.now().month - 1]}",
                                        decisionPopup: "Calendar",
                                        onCustomButtonTap:
                                            provider.onCustomButtonTap,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: CustomButton(
                                        boxDecoration: (provider
                                                .savedClockDialogData)
                                            ? BuildButtonStyle().buttonStyle()
                                            : BuildButtonStyle().buttonStyle2(),
                                        textColor:
                                            (provider.savedClockDialogData)
                                                ? Colors.white
                                                : const Color(0xFF909090),
                                        buttonText: selectedTime,
                                        decisionPopup: "Time",
                                        onCustomButtonTap:
                                            provider.onCustomButtonTap,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // Expanded(
                        //   flex: 2,
                        //   child: Row(
                        //     children: const [
                        //       Expanded(
                        //         child: DrugPlaceHolder(
                        //           imageAddress: "assets/pill.png",
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: DrugPlaceHolder(
                        //           imageAddress: "assets/caps.png",
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: DrugPlaceHolder(
                        //           imageAddress: "assets/ing.png",
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: DrugPlaceHolder(
                        //           imageAddress: "assets/amp.png",
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: SvgPicture.asset(
                                      "assets/bell.svg",
                                      color: const Color(0xFF76BBBB),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    context.localizations.reminder,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF474747),
                                    ),
                                  ),
                                ],
                              ),
                              Switch.adaptive(
                                value: provider.isReminderOn,
                                onChanged: provider.onReminderChange,
                                activeColor: const Color(0xFF76BBBB),
                                activeTrackColor: const Color(0xFFF4F4F4),
                                inactiveTrackColor: const Color(0xFFF4F4F4),
                              ),
                            ],
                          ),
                        ),
                        // getAlarmTiming(context, provider),
                        Expanded(
                          flex: 1,
                          child: Padding(
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
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: Text(
                                    (provider.activePrescriptionDetailModel!
                                                .description ==
                                            '')
                                        ? context.localizations.noDescription
                                        : provider
                                            .activePrescriptionDetailModel!
                                            .description,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xFF737373),
                                    ),
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: EnterButton(
                            onEnterTap: () => provider.onEnterTap(),
                            isLoading: provider.isLoadingButton,
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

  Expanded getAlarmTiming(
      BuildContext context, ActivePrescriptionDetailsProvider provider) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: AlarmTimming(
              value: 0,
              text: context.localizations.fiveMin,
              indexAlarm: provider.indexAlarm,
              onAlarmTimmingTap: provider.onAlarmTimmingTap,
            ),
          ),
          Expanded(
            child: AlarmTimming(
              value: 1,
              text: context.localizations.tenMin,
              indexAlarm: provider.indexAlarm,
              onAlarmTimmingTap: provider.onAlarmTimmingTap,
            ),
          ),
          Expanded(
            child: AlarmTimming(
              value: 2,
              text: context.localizations.fifteenMin,
              indexAlarm: provider.indexAlarm,
              onAlarmTimmingTap: provider.onAlarmTimmingTap,
            ),
          ),
          Expanded(
            child: AlarmTimming(
              value: 3,
              text: context.localizations.twenyMin,
              indexAlarm: provider.indexAlarm,
              onAlarmTimmingTap: provider.onAlarmTimmingTap,
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(void Function() onCheckMarkPressed, BuildContext ctx) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFEDF5FD),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFEDF5FD),
            elevation: 0,
            padding: const EdgeInsets.all(0),
          ),
          onPressed: () => onCheckMarkPressed(),
          child: const Icon(
            Icons.check,
            size: 25,
            color: Color(0xFF909090),
          ),
        )
      ],
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            ctx.localizations.addReminder,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Color(0xFF474747),
            ),
          ),
        ),
      ),
    );
  }
}
