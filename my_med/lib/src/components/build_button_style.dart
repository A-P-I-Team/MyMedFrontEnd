import 'package:flutter/material.dart';

class BuildButtonStyle {
  BoxDecoration buttonStyle() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF47BAEB),
          Color(0xFF76BBBB),
        ],
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  BoxDecoration buttonStyleExit() {
    return BoxDecoration(
      color: const Color(0xFFF07171),
      borderRadius: BorderRadius.circular(10),
    );
  }

  BoxDecoration buttonStyle2({double width = 1, Color borderColor = const Color(0xFF47BAEB)}) {
    return BoxDecoration(
      color: const Color(0xFFF4F4F4),
      border: Border.all(color: borderColor, width: width),
      borderRadius: BorderRadius.circular(10),
    );
  }

  BoxDecoration buttonStyleFlat() {
    return const BoxDecoration(
      color: Colors.transparent,
    );
  }
}
