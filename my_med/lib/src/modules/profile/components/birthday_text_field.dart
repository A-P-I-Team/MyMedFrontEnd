import 'package:flutter/material.dart';

class BirthDayTextField extends StatelessWidget {
  final Key formKeyYearTextFromField;
  final Key formKeyMonthTextFromField;
  final Key formKeyDayTextFromField;
  final void Function(String)? onYearChange;
  final void Function(String)? onMonthChange;
  final void Function(String)? onDayChange;
  final String? Function(String?)? yearValidator;
  final String? Function(String?)? monthValidator;
  final String? Function(String?)? dayValidator;

  const BirthDayTextField({
    Key? key,
    required this.formKeyYearTextFromField,
    required this.formKeyMonthTextFromField,
    required this.formKeyDayTextFromField,
    this.onYearChange,
    this.onMonthChange,
    this.onDayChange,
    this.yearValidator,
    this.monthValidator,
    this.dayValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKeyYearTextFromField,
              child: TextFormField(
                validator: yearValidator,
                maxLength: 4,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                decoration: createInputDecoration("سال"),
                onChanged: onYearChange,
              ),
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKeyMonthTextFromField,
              child: TextFormField(
                validator: monthValidator,
                maxLength: 2,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                decoration: createInputDecoration("ماه"),
                onChanged: onMonthChange,
              ),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKeyDayTextFromField,
              child: TextFormField(
                validator: dayValidator,
                maxLength: 2,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                decoration: createInputDecoration("روز"),
                onChanged: onDayChange,
              ),
            ),
          ),
          flex: 1,
        )
      ],
    );
  }

  InputDecoration createInputDecoration(String hintText) {
    return InputDecoration(
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
      hintTextDirection: TextDirection.rtl,
      hintText: hintText,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300,
        color: Color(0xFF909090),
      ),
    );
  }
}
