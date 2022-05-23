import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/utils/dialog_title.dart';

class EditBirthDayPopUp extends StatefulWidget {
  const EditBirthDayPopUp({Key? key}) : super(key: key);

  @override
  _EditBirthDayPopUpState createState() => _EditBirthDayPopUpState();
}

class _EditBirthDayPopUpState extends State<EditBirthDayPopUp> {
  String _birthDay = "";
  final formKeyYearTextFromField = GlobalKey<FormState>();
  final formKeyMonthTextFromField = GlobalKey<FormState>();
  final formKeyDayTextFromField = GlobalKey<FormState>();
  String year = "";
  String month = "";
  String day = "";
  bool isCompleteBirthDay = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: DialogTitle().buildDialogTitle(
        context.localizations.birthday,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      contentPadding: const EdgeInsets.all(0),
      content: buildContent(context),
      actions: [
        buildStopMedicationDialogActions(context),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Row buildStopMedicationDialogActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 80,
            height: 40,
            decoration: BuildButtonStyle().buttonStyleFlat(),
            alignment: Alignment.center,
            child: Text(context.localizations.cancel),
          ),
        ),
        GestureDetector(
          onTap: () {
            _birthDay = year + "-" + month + "-" + day;
            Navigator.of(context).pop(_birthDay);
          },
          child: Container(
            width: 80,
            height: 40,
            decoration: BuildButtonStyle().buttonStyleFlat(),
            alignment: Alignment.center,
            child: Text(
              context.localizations.confirm,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color(0xFF5EAFC0),
              ),
            ),
          ),
        )
      ],
    );
  }

  InputDecoration createInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      // errorText: _validate ? "Enter valid $result" : null,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF5EAFC0), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDB2A2A), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      errorStyle: const TextStyle(),
      fillColor: const Color(0xFFF5F7F9),
      hintTextDirection: TextDirection.rtl,
      hintText: hintText,
      counterText: "",
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w300,
        color: Color(0xFF909090),
      ),
    );
  }

  SizedBox buildContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKeyYearTextFromField,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length != 4) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                  maxLength: 4,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: createInputDecoration(context.localizations.year),
                  onChanged: (value) => {
                    setState(
                      () {
                        year = value;
                        if (formKeyYearTextFromField.currentState!.validate()) {}
                        checkValidBirthDay();
                      },
                    )
                  },
                ),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKeyMonthTextFromField,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || int.parse(value) < 1 || int.parse(value) > 12) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                  maxLength: 2,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: createInputDecoration(context.localizations.month),
                  onChanged: (value) => {
                    setState(
                      () {
                        month = value;
                        if (formKeyMonthTextFromField.currentState!.validate()) {}
                        checkValidBirthDay();
                      },
                    )
                  },
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKeyDayTextFromField,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || int.parse(value) < 1 || int.parse(value) > 31) {
                      return "";
                    } else if (value.isNotEmpty && int.parse(month) >= 1 && int.parse(month) <= 6 && int.parse(value) > 31) {
                      return "";
                    } else if (value.isNotEmpty && int.parse(month) > 6 && int.parse(month) < 12 && int.parse(value) > 30) {
                      return "";
                    } else if (value.isNotEmpty && int.parse(month) == 12 && int.parse(value) > 29) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                  maxLength: 2,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: createInputDecoration(context.localizations.day),
                  onChanged: (value) => {
                    setState(
                      () {
                        day = value;
                        if (formKeyDayTextFromField.currentState!.validate()) {}
                        checkValidBirthDay();
                      },
                    )
                  },
                ),
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  void checkValidBirthDay() {
    if (year != "" && month != "" && day != "") {
      int m = int.parse(month);
      int d = int.parse(day);
      if (m >= 1 && m <= 6 && d >= 1 && d <= 31) {
        isCompleteBirthDay = true;
      } else if (m > 6 && m <= 11 && d >= 1 && d <= 30) {
        isCompleteBirthDay = true;
      } else if (m == 12 && d >= 1 && d <= 29) {
        isCompleteBirthDay = true;
      } else {
        isCompleteBirthDay = false;
      }
    } else {
      isCompleteBirthDay = false;
    }
  }
}
