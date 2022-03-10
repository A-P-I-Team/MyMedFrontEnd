// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final validUsername = RegExp(r'^[a-zA-Z0-9@+-_.]+$');
  final String? label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(String) onChanged;

  DefaultTextField({
    Key? key,
    this.obscureText = false,
    this.label,
    this.validator,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 15),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      validator: validator,
    );
  }
}
