import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/components/drugs_body.dart';
import 'package:my_med/src/modules/drug/components/drugs_header.dart';
import 'package:my_med/src/modules/drug/providers/drug_details_provider.dart';
import 'package:provider/provider.dart';

class DrugDetailsPage extends StatelessWidget {
  final String drugId;
  const DrugDetailsPage({
    Key? key,
    required this.drugId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugDetailsProvider(drugId: drugId),
      child: const _DrugDetailsPage(),
    );
  }
}

class _DrugDetailsPage extends StatelessWidget {
  const _DrugDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrugDetailsProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context.localizations.drugDetails),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        child: (provider.drugDetailModel == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: DrugsHeader(
                      drugDetailModel: provider.drugDetailModel!,
                      totalDayUse:
                          provider.getTotalDayUse(provider.drugDetailModel!),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: DrugsBody(
                      prescriptionModel: provider.drugDetailModel!,
                      totalDayUse:
                          provider.getTotalDayUse(provider.drugDetailModel!),
                      onStopPrescription: () =>
                          provider.onStopPrescription(context),
                      isStartedDrug: true,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  AppBar buildAppBar(drugDetails) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFEDF5FD),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFEDF5FD),
            // minimumSize: Size(88, 50),
            elevation: 0,
            padding: const EdgeInsets.all(0),
          ),
          onPressed: () {},
          child: SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              "assets/accept_icon.svg",
              color: const Color(0xFF909090),
            ),
          ),
        )
      ],
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            drugDetails,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Color(0xFF474747),
            ),
          ),
        ),
      ),
    );
  }
}
