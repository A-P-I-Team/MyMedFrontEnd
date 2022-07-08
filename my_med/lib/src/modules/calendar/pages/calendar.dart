import 'package:flutter/material.dart';
import 'package:my_med/src/modules/calendar/providers/calendar_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_med/src/modules/calendar/components/calendar_container.dart';
import 'package:my_med/src/modules/calendar/components/reminder_container.dart';
import 'package:my_med/src/components/custom_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalendarProvider(context),
      child: const _CalendarPage(),
    );
  }
}

class _CalendarPage extends StatelessWidget {
  const _CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar().buildSearchBar(
          provider.onSearchTap,
          provider.isSearchSelect,
          provider.searchBarController,
          provider.onSearchChanged,
          context),
      body: (provider.isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CalendarContainer(
                    getReminders: provider.findReminders,
                  ),
                ),
                Expanded(
                  child: (provider.remindersList.isEmpty)
                      ? const Center(
                          child: Text('No reminders for todoay!'),
                        )
                      : ListView.builder(
                          itemCount: provider.remindersList.length,
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          itemBuilder: (context, index) {
                            return (provider.remindersList[index].name.contains(
                                    provider.searchBarController.text))
                                ? ReminderContainer(
                                    reminderModel:
                                        provider.remindersList[index],
                                    index: index,
                                    onDismissed: provider.onDismissed,
                                  )
                                : const SizedBox();
                          },
                        ),
                ),
              ],
            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.search,
          color: Color(0xFF909090),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SvgPicture.asset("assets/saramad.svg"),
              ),
              SvgPicture.asset("assets/logo.svg"),
            ],
          ),
        )
      ],
    );
  }
}
