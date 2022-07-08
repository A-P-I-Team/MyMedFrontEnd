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
      Future.delayed(const Duration(seconds: 1)).then((_) {
        context.router.replaceAll(const [OnboardingRoute()]);
      });
    } else {
      Future.delayed(const Duration(seconds: 1)).then((_) {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: 180,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image(
                    image: Image.asset(
                      'assets/launcher_icon_blue_red.png',
                      fit: BoxFit.cover,
                    ).image,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'My Med',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
