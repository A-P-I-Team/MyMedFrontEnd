import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/components/text_field.dart';

class PersonalInformationPage extends StatelessWidget {
  final Color activeColor;
  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController birthdayController;
  final void Function(String) onBirthChanged;
  final void Function(String) onFirstNameChanged;
  final void Function(String) onLastNameChanged;
  final bool isFormValid;
  final void Function() onConfirmTap;
  final void Function() updateStat;

  const PersonalInformationPage({
    Key? key,
    required this.activeColor,
    required this.lastNameController,
    required this.firstNameController,
    required this.birthdayController,
    required this.isFormValid,
    required this.onConfirmTap,
    required this.onBirthChanged,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.updateStat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: STextField(
                  onChanged: onFirstNameChanged,
                  label: "First Name",
                  key: const ValueKey(#firstName),
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  prefix: Icon(
                    Icons.person_outline_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  controller: firstNameController,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: STextField(
                  onChanged: onLastNameChanged,
                  label: "Last Name",
                  key: const ValueKey(#lastName),
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  controller: lastNameController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            canRequestFocus: false,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime(2000, 1, 1),
                firstDate: DateTime(1980, 1, 1),
                lastDate: DateTime.now().subtract(
                  const Duration(days: 720),
                ),
              ).then((date) {
                birthdayController.text = date.toString().split(' ')[0];
                updateStat();
              });
            },
            child: AbsorbPointer(
              child: STextField(
                onChanged: onBirthChanged,
                readOnly: true,
                hint: "Birthday",
                // label: "Birthday",
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                key: const ValueKey(#age),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.datetime,
                prefix: Icon(
                  Icons.event,
                  color: Theme.of(context).primaryColor,
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 120,
                  maxHeight: 48,
                ),
                suffix: const Text(
                  'YYYY-MM-DD',
                  style: TextStyle(
                    color: Color(0xFFBCBCC0),
                  ),
                ),
                controller: birthdayController,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                    onPressed: (isFormValid) ? onConfirmTap : null,
                    child: const Text("Confirm"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
