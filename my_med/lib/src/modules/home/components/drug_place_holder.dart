import 'package:flutter/material.dart';

class DrugPlaceHolder extends StatelessWidget {
  final String imageAddress;

  const DrugPlaceHolder({
    Key? key,
    required this.imageAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF5F7F9),
          ),
          child: Image.asset(imageAddress),
        ),
      ),
    );
  }
}
