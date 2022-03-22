import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/intro/pages/onboarding.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Widget? get testWidget {
    // ignore: prefer_const_constructors
    return null; // Call any page want to test.
  }

  @override
  void initState() {
    super.initState();

    if (testWidget == null) Future(toHome);
  }

  void toHome() {
    context.router.replaceAll(const [SplashRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: testWidget,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 0,
        onPressed: () {},
        backgroundColor: Colors.green.shade100,
        child: const Text('Test'),
      ),
    );
  }
}
