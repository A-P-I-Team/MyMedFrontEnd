import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/utils/dialog_title.dart';

class EditNamePopUp extends StatefulWidget {
  const EditNamePopUp({Key? key}) : super(key: key);

  @override
  _EditNamePopUpState createState() => _EditNamePopUpState();
}

class _EditNamePopUpState extends State<EditNamePopUp> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: DialogTitle().buildDialogTitle(
        context.localizations.firstNameAndLastName,
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
            Navigator.of(context).pop(name);
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

  Container buildContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7F9),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: context.localizations.firstNameAndLastName,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFFBABBBC),
            ),
            border: InputBorder.none,
          ),
          textAlign: TextAlign.justify,
          onChanged: (value) {
            name = value;
          },
        ),
      ),
    );
  }
}
