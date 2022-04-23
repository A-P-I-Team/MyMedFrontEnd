import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/providers/profile_provider.dart';

class SexualityRadio extends StatelessWidget {
  final Sexuality sexuality;
  final void Function(Sexuality?)? onSexualityChange;

  const SexualityRadio({
    Key? key,
    this.sexuality = Sexuality.man,
    this.onSexualityChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(context.localizations.man),
            leading: Radio<Sexuality>(
              value: Sexuality.man,
              groupValue: sexuality,
              onChanged: onSexualityChange,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(context.localizations.woman),
            leading: Radio<Sexuality>(
              value: Sexuality.woman,
              groupValue: sexuality,
              onChanged: onSexualityChange,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(context.localizations.otherGender),
            leading: Radio<Sexuality>(
              value: Sexuality.woman,
              groupValue: sexuality,
              onChanged: onSexualityChange,
            ),
          ),
        ),
      ],
    );
  }
}
