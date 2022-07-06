import 'package:flutter/material.dart';

class AlarmTimming extends StatelessWidget {
  final String text;
  final int indexAlarm;
  final int value;
  final void Function(int)? onAlarmTimmingTap;

  const AlarmTimming({
    Key? key,
    required this.text,
    required this.indexAlarm,
    required this.value,
    this.onAlarmTimmingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Color(0xFF5EAFC0),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (indexAlarm == value) ? Color(0x255EAFC0) : Colors.transparent,
        ),
      ),
      onTap: () => onAlarmTimmingTap?.call(value),
    );
  }
}
