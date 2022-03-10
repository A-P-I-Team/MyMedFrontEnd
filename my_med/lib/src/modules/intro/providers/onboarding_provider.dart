import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final pageCount = 3;
  final controller = PageController();

  void onDotClicked(final int index) {
    controller.animateToPage(
      index,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
