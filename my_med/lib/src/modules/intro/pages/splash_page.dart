import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';
import 'package:my_med/src/core/routing/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    final bool ok = PreferencesService.hasToken();
    if (ok == false) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        context.router.replaceAll(const [OnboardingRoute()]);
      });
    } else {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        context.router.replaceAll(const [DashboardRoute()]);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
