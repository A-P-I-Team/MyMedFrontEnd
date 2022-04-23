import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/utils/dialog_title.dart';

class EditSexualityPopUp extends StatefulWidget {
  const EditSexualityPopUp({Key? key}) : super(key: key);

  @override
  _EditSexualityPopUpState createState() => _EditSexualityPopUpState();
}

class _EditSexualityPopUpState extends State<EditSexualityPopUp> {
  String sexuality = "زن";
  Set<String> sexualitySet = {"مرد", "زن"};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: DialogTitle().buildDialogTitle(context.localizations.sexuality),
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
            Navigator.of(context).pop(sexuality);
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
        ),
      ],
    );
  }

  Container buildContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: ListTile(
              minLeadingWidth: 20,
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                context.localizations.man,
                overflow: TextOverflow.visible,
              ),
              leading: SizedBox(
                width: 30,
                child: Radio<String>(
                  value: sexualitySet.elementAt(0),
                  groupValue: sexuality,
                  onChanged: (String? value) {
                    setState(() {
                      sexuality = value!;
                    });
                  },
                ),
              ),
            ),
          ),
          Flexible(
            child: ListTile(
              minLeadingWidth: 20,
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                context.localizations.woman,
                overflow: TextOverflow.visible,
              ),
              leading: SizedBox(
                width: 30,
                child: Radio<String>(
                  value: sexualitySet.elementAt(1),
                  groupValue: sexuality,
                  onChanged: (String? value) {
                    setState(() {
                      sexuality = value!;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
