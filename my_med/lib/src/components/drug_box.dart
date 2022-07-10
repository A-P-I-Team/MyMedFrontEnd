import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/models/drug_model.dart';
import 'package:provider/provider.dart';

class DrugBox extends StatelessWidget {
  final DrugModel drug;
  final void Function(DrugModel)? onTap;

  const DrugBox({
    Key? key,
    required this.drug,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x10909090),
        ),
        boxShadow: CustomShadow().buildBoxShadow(offset: const Offset(0, 0)),
      ),
      child: Directionality(
        textDirection:
            (context.read<LocalizationProvider>().locale == const Locale('en'))
                ? TextDirection.rtl
                : TextDirection.ltr,
        child: Row(
          children: [
            IconButton(
              onPressed: () => onTap?.call(drug),
              color: const Color(0xFFBABBBC),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Text(
              (drug.consumptionStart == null)
                  ? context.localizations.notStarted
                  : drug.consumptionStart!.split('T')[0],
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF474747),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '(${drug.dosage})',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                          color: Color(0xFF909090),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        drug.medicine,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF474747),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: context.localizations.period,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Color(0xFF474747),
                          ),
                          children: [
                            TextSpan(
                              text: ' ${drug.days} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF5EAFC0),
                              ),
                            ),
                            TextSpan(
                              text: context.localizations.daily,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      (drug.isActive != null && drug.isActive!)
                          ? SvgPicture.asset(
                              "assets/bell.svg",
                              color: const Color(0xFF5EAFC0),
                              width: 20,
                              height: 20,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
