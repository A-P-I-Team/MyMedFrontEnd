import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';

class ActivePrescriptionComponent extends StatelessWidget {
  final ActivePrescriptionModel activePrescription;
  final int totalDayUse;
  final void Function(String)? checkId;
  final bool Function(String) isSelectedId;

  const ActivePrescriptionComponent({
    Key? key,
    required this.activePrescription,
    required this.totalDayUse,
    this.checkId,
    required this.isSelectedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key(activePrescription.id),
      onTap: () => checkId?.call(activePrescription.id),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        padding: const EdgeInsets.all(8.0),
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0x10909090),
          ),
          boxShadow: (isSelectedId(activePrescription.id))
              ? CustomShadow().buildBoxShadow(
                  offset: const Offset(0, 0),
                  shadowColor: const Color(0xFF47BAEB))
              : CustomShadow().buildBoxShadow(offset: const Offset(0, 0)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          activePrescription.medicine,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF474747),
                              overflow: TextOverflow.clip),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '(${activePrescription.dosage})',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "${context.localizations.period} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color(0xFF474747),
                            ),
                            children: [
                              TextSpan(
                                text: "$totalDayUse",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF5EAFC0),
                                ),
                              ),
                              TextSpan(
                                text: " ${context.localizations.days}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              activePrescription.doctorStart.toString().split(' ')[0],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF474747),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
