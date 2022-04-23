import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarColumn extends StatelessWidget {
  final String fullName;
  final String identification;

  const AvatarColumn({
    Key? key,
    required this.fullName,
    required this.identification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          SvgPicture.asset("assets/avatar.svg"),
          const SizedBox(height: 8),
          Text(
            fullName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF474747),
            ),
          ),
          Text(
            identification,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF474747),
            ),
          ),
        ],
      ),
    );
  }
}
