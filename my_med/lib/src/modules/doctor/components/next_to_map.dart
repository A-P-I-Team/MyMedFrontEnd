import 'package:flutter/material.dart';

class NextToMap extends StatelessWidget {
  final Image image;
  final String text;

  const NextToMap({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: image,
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 8,
            color: Color(0xFF737373),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
