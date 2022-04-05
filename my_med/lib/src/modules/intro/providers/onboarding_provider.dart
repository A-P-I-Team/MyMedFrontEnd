import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final pageCount = 3;
  final controller = PageController();
  bool animateIsDone = false;

  void onDotClicked(final int index) {
    animateIsDone = false;
    if (controller.hasClients) {
      controller.animateToPage(
        index,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
      );
      animateIsDone = true;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
