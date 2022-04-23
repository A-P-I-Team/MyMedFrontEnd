import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class EmailContainer extends StatelessWidget {
  final String email;

  const EmailContainer({Key? key, required this.email}) : super(key: key);

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
              const SizedBox(height: 20),
              Expanded(
                child: Align(
                  child: Column(
                    children: [
                      const SizedBox(height: 68),
                      Text(
                        email,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF474747),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.localizations.phoneNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF474747),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/profile_page_email.png",
            width: 60,
            height: 60,
          ),
        ),
      ],
    );
  }
}
