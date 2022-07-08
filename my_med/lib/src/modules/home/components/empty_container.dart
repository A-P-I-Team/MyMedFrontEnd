import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/pages/drug.dart';
import 'package:my_med/src/modules/home/components/home_button.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 200),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Image.asset("assets/empty_reminder.png"),
                  const SizedBox(height: 24),
                  Text(
                    context.localizations.noActiveReminders,
                  ),
                ],
              ),
            ),
            Flexible(
              child: HomeButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DrugPage(),
                  ),
                ),
                text: context.localizations.seeDrug,
                hasIcon: false,
                height: 60,
                width: 300,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
