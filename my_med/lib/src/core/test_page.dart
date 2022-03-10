import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/routing/router.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Widget? get testWidget {
    return null; // Call any page want to test.
  }

  @override
  void initState() {
    super.initState();

    if (testWidget == null) Future(toHome);
  }

  void toHome() {
    context.router.popAndPush(const SplashRoute());
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
        onPressed: toHome,
        backgroundColor: Colors.green,
        child: const Text('Test'),
      ),
    );
  }
}
