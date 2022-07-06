import 'package:flutter/material.dart';

class BuildGradient {
  LinearGradient buildLinearGradient() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF47BAEB),
        Color(0xFF76BBBB),
      ],
    );
  }
}
