import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';

class SettingCard extends StatelessWidget {
  final String cardText;
  final bool enableShadow;
  final Widget leadingWidget;
  final Widget actionWidget;
  final bool enableActionWidget;
  final void Function()? onTap;
  const SettingCard({
    Key? key,
    required this.cardText,
    this.enableShadow = true,
    this.leadingWidget = const SizedBox(),
    this.actionWidget = const SizedBox(),
    this.enableActionWidget = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 49,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: (enableShadow == false) ? [] : CustomShadow().buildBoxShadow(offset: const Offset(0, 0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.center, child: actionWidget),
                  const SizedBox(width: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      cardText,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: (enableActionWidget) ? const Color(0xFFF07171) : const Color(0xFF474747),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            leadingWidget,
          ],
        ),
      ),
    );
  }
}
