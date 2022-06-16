import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class DrugUsagePeriod extends StatelessWidget {
  final DrugDetailModel drugDetailModel;
  const DrugUsagePeriod({
    Key? key,
    required this.drugDetailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: context.localizations.every,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12,
          color: Color(0xFF737373),
        ),
        children: [
          TextSpan(
            text: '${drugDetailModel.days} ',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Color(0xFF5EAFC0),
            ),
          ),
          TextSpan(
            text: context.localizations.hourOnce,
          ),
        ],
      ),
    );
  }
}
