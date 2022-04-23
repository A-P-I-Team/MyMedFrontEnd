import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/components/small_edit_button.dart';

class SexualityContainer extends StatelessWidget {
  final String sex;
  final void Function()? showEditSexualityPopUp;

  const SexualityContainer({
    Key? key,
    required this.sex,
    this.showEditSexualityPopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String sexuality = (sex == 'M')
        ? context.localizations.man
        : (sex == 'F')
            ? context.localizations.woman
            : context.localizations.otherGender;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
                  child: Column(
                    children: [
                      Text(
                        sexuality,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF474747),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.localizations.sexuality,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF474747),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SmallEditButton(
                    onTap: showEditSexualityPopUp,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/profile_page_gender.png",
            width: 60,
            height: 60,
          ),
        ),
      ],
    );
  }
}
