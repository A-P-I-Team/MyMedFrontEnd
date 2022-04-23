import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/components/small_edit_button.dart';

class BirthdayContainer extends StatelessWidget {
  final String birthDate;
  final void Function()? showEditBirthdayPopUp;

  const BirthdayContainer({
    Key? key,
    required this.birthDate,
    this.showEditBirthdayPopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: CustomShadow().buildBoxShadow(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 68),
              Expanded(
                child: Align(
                  child: Column(
                    children: [
                      Text(
                        birthDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF474747),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.localizations.birthday,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          color: Color(0xFF474747),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                child: SmallEditButton(
                  onTap: showEditBirthdayPopUp,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/profile_page_cake.png",
            width: 60,
            height: 60,
          ),
        ),
      ],
    );
  }
}
