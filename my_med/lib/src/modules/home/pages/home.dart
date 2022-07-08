import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/components/custom_app_bar.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/home/components/empty_container.dart';
import 'package:my_med/src/modules/home/components/home_button.dart';
import 'package:my_med/src/modules/home/components/reminder_container.dart';
import 'package:my_med/src/modules/home/components/show_name.dart';
import 'package:my_med/src/modules/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(context),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar().buildSearchBar(
          provider.onSearchTap,
          provider.isSearchSelect,
          provider.searchBarController,
          provider.onSearchChanged,
          context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            (provider.isLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (provider.remindersList.isEmpty)
                    ? const EmptyContainer()
                    : ListView.builder(
                        itemCount: provider.remindersList.length,
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: const EdgeInsets.only(top: 190),
                        itemBuilder: (context, index) {
                          return (provider.remindersList[index].name
                                  .contains(provider.searchBarController.text))
                              ? ReminderContainer(
                                  index: index,
                                  reminderModel: provider.remindersList[index],
                                  onDismissed: provider.onDismissed,
                                )
                              : const SizedBox();
                        },
                      ),
            Container(
              height: 188,
              decoration: BoxDecoration(
                boxShadow:
                    CustomShadow().buildBoxShadow(offset: const Offset(0, 2)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 16, left: 16),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 91,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0x25909090),
                          ),
                          boxShadow: CustomShadow()
                              .buildBoxShadow(offset: const Offset(0, 0)),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: SvgPicture.asset("assets/drug.svg"),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 150,
                      child: ShowName(
                        hasError: provider.hasError,
                        patient: provider.userProfile,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 160,
                      child: Text(
                        (provider.remindersList.isEmpty)
                            ? context.localizations.noDrugForUse
                            : context.localizations.youHaveTakenNFromMMedicines(
                                context.watch<HomeProvider>().consumedCount,
                                context.watch<HomeProvider>().totalCount,
                              ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFF474747),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      width: MediaQuery.of(context).size.width - 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              context.localizations.currentMedicationList,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFF474747),
                              ),
                            ),
                          ),
                          HomeButton(
                            text: context.localizations.addReminder,
                            onTap: provider.onAddReminderTap,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
