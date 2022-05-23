import 'package:flutter/material.dart';
import 'package:my_med/src/components/build_button_style.dart';
import 'package:my_med/src/utils/dialog_title.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class ExitPopUp extends StatefulWidget {
  const ExitPopUp({Key? key}) : super(key: key);

  @override
  State<ExitPopUp> createState() => _ExitPopUpState();
}

class _ExitPopUpState extends State<ExitPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: DialogTitle().buildDialogTitle(
        context.localizations.logout,
        backgroundColor: const Color(0x45F07171),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: buildContent(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Row buildStopMedicationDialogActions(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
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
        )
      ],
    );
  }

  SizedBox buildContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.localizations.logoutDoubleCheckQuestion,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Color(0xFF474747),
                ),
              ),
            ),
            exitAccountButton(),
            cancelButton(),
          ],
        ),
      ),
    );
  }

  exitAccountButton() {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      primary: const Color(0xFFD7D9DA),
      minimumSize: const Size(88, 40),
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
        child: ElevatedButton(
          style: raisedButtonStyle,
          onPressed: () {
            setState(() {
              Navigator.of(context).pop(true);
            });
          },
          child: DecoratedBox(
            decoration: BuildButtonStyle().buttonStyleExit(),
            child: Container(
              padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(maxHeight: 40),
              alignment: Alignment.center,
              child: Text(
                context.localizations.logout,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  cancelButton() {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      primary: const Color(0xFFD7D9DA),
      minimumSize: const Size(88, 40),
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
        child: ElevatedButton(
          style: raisedButtonStyle,
          onPressed: () {
            setState(() {
              Navigator.of(context).pop(false);
            });
          },
          child: DecoratedBox(
            decoration: BuildButtonStyle()
                .buttonStyle2(width: 1, borderColor: const Color(0xFFD7D9DA)),
            child: Container(
              padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(maxHeight: 40),
              alignment: Alignment.center,
              child: Text(
                context.localizations.cancel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF5EAFC0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
