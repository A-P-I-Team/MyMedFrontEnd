import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/components/email_container.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/components/birthday_container.dart';
import 'package:my_med/src/modules/profile/components/sexuality_container.dart';
import 'package:my_med/src/modules/profile/components/small_edit_button.dart';
import 'package:my_med/src/modules/profile/models/profile_model.dart';

class InformationContainer extends StatelessWidget {
  final UserProfileModel patient;
  final void Function()? showEditNamePopUp;
  final void Function()? showEditBirthdayPopUp;
  final void Function()? showEditSexualityPopUp;

  const InformationContainer({
    Key? key,
    required this.patient,
    this.showEditNamePopUp,
    this.showEditBirthdayPopUp,
    this.showEditSexualityPopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = patient.email.toString();
    String fullName = '${patient.firstName} ${patient.lastName}';
    String dateOfBirth = patient.birthdate;
    String gender = patient.gender ?? "---";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        physics: const BouncingScrollPhysics(),
        children: [
          EmailContainer(
            email: email,
          ),
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
                  const SizedBox(height: 8),
                  Image.asset(
                    "assets/profile_page_id_card.png",
                    width: 60,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF474747),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.localizations.firstNameAndLastName,
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
                      onTap: showEditNamePopUp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BirthdayContainer(
            birthDate: dateOfBirth,
            showEditBirthdayPopUp: showEditBirthdayPopUp,
          ),
          SexualityContainer(
            sex: gender,
            showEditSexualityPopUp: showEditSexualityPopUp,
          ),
        ],
      ),
    );
  }
}
