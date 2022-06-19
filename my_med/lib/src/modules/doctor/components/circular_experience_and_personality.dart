import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';

class CircularExperienceAndPersonality extends StatelessWidget {
  final Image image;
  final TextSpan textSpan;
  final String bottomTitle;

  const CircularExperienceAndPersonality({
    Key? key,
    required this.image,
    required this.textSpan,
    required this.bottomTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: CustomShadow().buildBoxShadow(),
        shape: BoxShape.circle,
      ),
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: image,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text.rich(
                textSpan,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                bottomTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 8,
                  color: Color(0xFF474747),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
