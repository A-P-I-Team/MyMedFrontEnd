import 'package:auto_route/auto_route.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReminderContainer extends StatelessWidget {
  
  final ReminderModel reminderModel;
  final int index;
  final void Function(DismissDirection, int)? onDismissed;

  const ReminderContainer({
    Key? key,
    required this.reminderModel,
    required this.index,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: ColoredBox(
        color: Color(0xFF3EDAA2),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                SvgPicture.asset("assets/accept_icon.svg"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    context.localizations.iConsumed,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryBackground: ColoredBox(
        color: Color(0xFFF07171),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                SvgPicture.asset("assets/reject_icon.svg"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    context.localizations.iDidNotConsumed,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (direction) => onDismissed?.call(direction, index),
      child: Container(
        height: 80,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: CustomShadow().buildBoxShadow(),
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              decoration: BoxDecoration(
                color: (reminderModel.taken == null)
                    ? Colors.white
                    : (reminderModel.taken == true)
                        ? Color(0xFF3EDAA2)
                        : Color(0xFFF07171),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image(image: AssetImage('assets/drug_image.png')),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              reminderModel.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFF474747),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                reminderModel.consumptionAmount +
                                    ' ' +
                                    reminderModel.consumptionMethod,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Color(0xFF474747),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      convertToIsoTime(
                              reminderModel.timeToTake.hour.toString()) +
                          ':' +
                          convertToIsoTime(
                              reminderModel.timeToTake.minute.toString()),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: (reminderModel.taken == true)
                            ? Color(0xFF3EDAA2)
                            : (reminderModel.taken == null)
                                ? Color(0xFF5EAFC0)
                                : Color(0xFFF07171),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.router.push(
                          DrugDetailsRoute(drugId: ''
                            
                          ),
                        );
                      },
                      color: Color(0xFFBABBBC),
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertToIsoTime(String time) {
    if (time.length == 1) return '0' + time;
    return time;
  }
}
