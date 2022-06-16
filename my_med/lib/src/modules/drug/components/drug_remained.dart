import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class DrugRemained extends StatelessWidget {
  const DrugRemained({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "2 ",
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Color(0xFF5EAFC0),
        ),
        children: [
          TextSpan(
            text: context.localizations.days,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Color(0xFF474747),
            ),
          ),
        ],
      ),
    );
  }
}
