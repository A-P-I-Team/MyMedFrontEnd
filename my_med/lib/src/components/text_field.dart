import 'package:flutter/material.dart';

class STextField extends StatelessWidget {
  final bool isDense;
  final String? hint;
  final String? label;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fillColor;
  final bool applyBorder;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final BorderRadius borderRadius;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final bool readOnly;
  final BoxConstraints? suffixIconConstraints;
  final int? maxLength;

  const STextField({
    Key? key,
    this.hint,
    this.label,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.fillColor,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.isDense = false,
    this.applyBorder = true,
    this.textAlign = TextAlign.center,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.hintStyle,
    this.readOnly = false,
    this.suffixIconConstraints,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return TextField(
      maxLength: maxLength,
      readOnly: readOnly,
      focusNode: focusNode,
      textAlign: textAlign,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        isDense: isDense,
        hintStyle: hintStyle ??
            const TextStyle(
              color: Color(0xFFBCBCC0),
            ),
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFBCBCC0)),
        floatingLabelStyle: TextStyle(color: primaryColor),
        fillColor: fillColor,
        filled: fillColor != null,
        prefixIcon: prefix != null
            ? DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFBCBCC0),
                  fontWeight: FontWeight.w600,
                ),
                child: Center(child: prefix),
              )
            : null,
        suffixIcon: suffix != null
            ? DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFBCBCC0),
                  fontWeight: FontWeight.w600,
                ),
                child: Center(child: suffix),
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 48,
          maxHeight: 48,
        ),
        suffixIconConstraints: suffixIconConstraints ??
            const BoxConstraints(
              maxWidth: 48,
              maxHeight: 48,
            ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: isDense ? 0 : 14,
        ),
        enabledBorder: applyBorder
            ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: const BorderSide(color: Color(0xFFBCBCC0)),
              )
            : InputBorder.none,
        focusedBorder: applyBorder
            ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: primaryColor),
              )
            : InputBorder.none,
      ),
    );
  }
}
