import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/components/build_Input_decoration.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/home/components/active_prescription_component.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/modules/home/providers/active_prescription_provider.dart';
import 'package:provider/provider.dart';

class ActivePrescriptionPage extends StatelessWidget {
  const ActivePrescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivePrescriptionProvider(context: context),
      child: const _ActivePrescriptionPage(),
    );
  }
}

class _ActivePrescriptionPage extends StatelessWidget {
  const _ActivePrescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivePrescriptionProvider>();
    return Scaffold(
      appBar: buildAppBar(context, provider),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: provider.searchBarController,
                onChanged: provider.onSearchedValueChanged,
                decoration: BuildInputDecoration().createInputDecoration(
                  (context.localizations.searchDrug),
                  const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: provider.activePrescriptionList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = provider.activePrescriptionList[index];
                return (provider.activePrescriptionList[index].medicine
                        .contains(provider.searchBarController.text))
                    ? ActivePrescriptionComponent(
                        activePrescription: ActivePrescriptionModel(
                          id: item.id,
                          medicine: item.medicine,
                          dosage: item.dosage,
                          start: item.start,
                          reminders: item.reminders,
                          notify: item.notify,
                          days: item.days,
                          consumptionDuration: item.consumptionDuration,
                          fraction: item.fraction,
                          period: item.period,
                          prescription: item.prescription,
                          takenno: item.takenno,
                        ),
                        totalDayUse: provider.getTotalDayUse(item),
                        isSelectedId: provider.isSelectedId,
                        checkId: provider.checkId,
                      )
                    : const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(
    BuildContext context,
    ActivePrescriptionProvider provider,
  ) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.all(0),
          ),
          onPressed: provider.onReminderAcceptTap,
          child: SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              "assets/accept_icon.svg",
              color: const Color(0xFF909090),
            ),
          ),
        )
      ],
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            context.localizations.addReminder,
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
