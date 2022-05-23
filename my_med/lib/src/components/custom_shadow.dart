import 'package:flutter/material.dart';

class CustomShadow {
  List<BoxShadow> buildBoxShadow({
    double blurRadius = 2,
    double spreadRadius = 0,
    Offset offset = const Offset(0, 0),
    Color shadowColor = const Color(0xFF909090),
  }) {
    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: blurRadius, // soften the shadow
        spreadRadius: spreadRadius, //extend the shadow
        offset: offset,
      )
    ];
  }
}
