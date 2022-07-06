import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/models/profile_model.dart';

class ShowName extends StatelessWidget {
  final bool hasError;
  final UserProfileModel? patient;

  const ShowName({
    Key? key,
    required this.hasError,
    this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Center(
        child: Text(
          context.localizations.checkInternetConnection,
        ),
      );
    } else if (patient == null) {
      return const Center(
        child: SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return Text(
      context.localizations
          .helloFullName('${patient!.firstName} ${patient!.lastName}'),
      textDirection: (context.localizations.localeName == "fa")
          ? TextDirection.rtl
          : TextDirection.ltr,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xFF474747),
      ),
    );
  }
}
