import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class NextReminderText extends StatelessWidget {
  final EdgeInsets padding;
  final String title;
  final DrugDetailModel drugDetailModel;

  const NextReminderText({
    Key? key,
    required this.padding,
    required this.title,
    required this.drugDetailModel,
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
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Color(0xFF474747),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(),
            ),
          ),
          Text.rich(
            TextSpan(
              text: context.localizations.nextReminderTextIn,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color(0xFF737373),
              ),
              children: [
                const TextSpan(
                  text: " 3 ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF5EAFC0),
                  ),
                ),
                TextSpan(
                  text: context.localizations.hour,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
