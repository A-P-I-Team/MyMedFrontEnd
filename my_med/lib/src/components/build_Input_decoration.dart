import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildInputDecoration {
  InputDecoration createInputDecoration(String hintText, Icon? icon) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(8),
      filled: true,
      // errorText: _validate ? "Enter valid $result" : null,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF5EAFC0), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDB2A2A), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      errorStyle: TextStyle(),
      fillColor: Color(0xFFF5F7F9),
      hintText: hintText,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300,
        color: Color(0xFF909090),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: SvgPicture.asset("assets/search_icon.svg"),
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
