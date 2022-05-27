import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/dashboard/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(context),
      child: const _DashboardPage(),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: provider.screens[provider.bottomNavigationIndex],
      bottomNavigationBar: buildBottomNavigationBar(
        context,
        provider.bottomNavigationIndex,
        provider.setBottomNavigationIndex,
      ),
    );
  }

  buildBottomNavigationBar(
    BuildContext context,
    int bottomNavigationIndex,
    void Function(int value) setBottomNavigationIndex,
  ) {
    List<BottomNavigationBarItem> itemsNavigationBottomItem = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/profile_navigation_icon.svg",
          color: const Color(0xFF909090),
        ),
        activeIcon: SvgPicture.asset(
          "assets/profile_navigation_icon.svg",
          color: const Color(0xFF5EAFC0),
        ),
        label: context.localizations.profile,
        backgroundColor: Colors.white,
      ),
      BottomNavigationBarItem(
        label: context.localizations.drugs,
        icon: SvgPicture.asset(
          "assets/drug_navigation_icon.svg",
          color: const Color(0xFF909090),
        ),
        activeIcon: SvgPicture.asset(
          "assets/drug_navigation_icon.svg",
          color: const Color(0xFF5EAFC0),
        ),
        backgroundColor: Colors.white,
      ),
      BottomNavigationBarItem(
        label: context.localizations.home,
        icon: SvgPicture.asset(
          "assets/home_navigation_icon.svg",
          color: const Color(0xFF909090),
        ),
        activeIcon: SvgPicture.asset(
          "assets/home_navigation_icon.svg",
          color: const Color(0xFF5EAFC0),
        ),
        backgroundColor: Colors.white,
      ),
      BottomNavigationBarItem(
        label: context.localizations.calendar,
        icon: SvgPicture.asset(
          "assets/calendar_navigation_icon.svg",
          color: const Color(0xFF909090),
        ),
        activeIcon: SvgPicture.asset(
          "assets/calendar_navigation_icon.svg",
          color: const Color(0xFF5EAFC0),
        ),
        backgroundColor: Colors.white,
      ),
      BottomNavigationBarItem(
        label: context.localizations.doctors,
        icon: SvgPicture.asset(
          "assets/doctors_navigation_icon.svg",
          color: const Color(0xFF909090),
        ),
        activeIcon: SvgPicture.asset(
          "assets/doctors_navigation_icon.svg",
          color: const Color(0xFF5EAFC0),
        ),
        backgroundColor: Colors.white,
      ),
    ];
    return BottomNavigationBar(
      items: itemsNavigationBottomItem,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      selectedItemColor: const Color(0xFF5EAFC0),
      unselectedItemColor: const Color(0xFF909090),
      elevation: 10,
      currentIndex: bottomNavigationIndex,
      onTap: setBottomNavigationIndex,
    );
  }
}
