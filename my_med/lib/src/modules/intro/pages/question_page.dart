import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';

class QuestionsPage extends StatelessWidget {
  final void Function(String? value) onGenderChanged;
  final void Function(String? value) onRelationChanged;
  final void Function(String? value) onVaccinatedChanged;
  final String gender, relationship, isVaccinated;
  final Color disableColorHeader = const Color(0xFF555555);
  final Color disableColorBody = const Color(0xFF555555);
  final double bodyBottomPadding = 32;
  final void Function(String?) onCityChanged;
  final String defaultCity;
  final Future<List<String>> Function(String?) onFind;
  final bool isFormValid;
  final void Function() onSubmitPressed;
  final String? cityErrorText;
  const QuestionsPage({
    Key? key,
    required this.onGenderChanged,
    required this.gender,
    required this.relationship,
    required this.isVaccinated,
    required this.onCityChanged,
    required this.defaultCity,
    required this.onFind,
    required this.isFormValid,
    required this.onSubmitPressed,
    required this.onRelationChanged,
    required this.onVaccinatedChanged,
    required this.cityErrorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Gender:',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: disableColorHeader),
            ),
          ),
          Row(
            children: [
              Radio(
                value: 'Female',
                groupValue: gender,
                onChanged: onGenderChanged,
              ),
              const Text('Female'),
              const SizedBox(
                width: 32,
              ),
              Radio(
                value: 'Male',
                groupValue: gender,
                onChanged: onGenderChanged,
              ),
              const Text('Male'),
              const SizedBox(
                width: 32,
              ),
              Radio(
                value: 'Others',
                groupValue: gender,
                onChanged: onGenderChanged,
              ),
              const Text('Others'),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: bodyBottomPadding),
            color: const Color(0xFFD8D8DC),
            height: 1,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Relationship Status:',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: disableColorHeader),
            ),
          ),
          Row(
            children: [
              Radio(
                value: 'Single',
                groupValue: relationship,
                onChanged: onRelationChanged,
              ),
              const Text('Single'),
              const SizedBox(
                width: 32,
              ),
              Radio(
                value: 'In rel',
                groupValue: relationship,
                onChanged: onRelationChanged,
              ),
              const Text('In rel'),
              const SizedBox(
                width: 32,
              ),
              Radio(
                value: 'Married',
                groupValue: relationship,
                onChanged: onRelationChanged,
              ),
              const Text('Married'),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: bodyBottomPadding),
            color: const Color(0xFFD8D8DC),
            height: 1,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Are You Vaccinated?',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: disableColorHeader),
            ),
          ),
          Row(
            children: [
              Radio(
                value: 'Yes',
                groupValue: isVaccinated,
                onChanged: onVaccinatedChanged,
              ),
              const Text('Yes'),
              const SizedBox(
                width: 32,
              ),
              Radio(
                value: 'No',
                groupValue: isVaccinated,
                onChanged: onVaccinatedChanged,
              ),
              const Text('No'),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: bodyBottomPadding),
            color: const Color(0xFFD8D8DC),
            height: 1,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Where Are You Living?',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: disableColorHeader),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: cityErrorText == null ? 50 : 70,
            child: DropdownSearch<String>(
              onChanged: onCityChanged,
              selectedItem: defaultCity,
              asyncItems: onFind,
              // maxHeight: 300,
              // selectionListViewProps: const SelectionListViewProps(),
              // dropDownButton: const SizedBox(),
              dropdownSearchDecoration: InputDecoration(
                errorText: cityErrorText,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Theme.of(context).errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Theme.of(context).errorColor),
                ),
                prefix: Row(
                  children: [
                    Icon(
                      Icons.location_city_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'City',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      defaultCity,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: defaultCity,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                    onPressed: (isFormValid) ? onSubmitPressed : null,
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
