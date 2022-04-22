import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/dashboard/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardProvider>(
      create: (_) => DashboardProvider(),
      child: const _DashboardPage(),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            PreferencesService.logout();
            context.router.replaceAll(const [OnboardingRoute()]).then((value) {
              CustomSnackBar().showMessage(
                context: context,
                content: const Text('Exit Successfully'),
                duration: const Duration(seconds: 4),
                elevation: 0,
              );
            });
          },
          child: const Text('Exit'),
        ),
      ),
    );
  }
}
