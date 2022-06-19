import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';

class BoxContainer extends StatelessWidget {
  final Image image;
  final String title;
  final String data;
  final String action;
  final void Function()? onTap;

  const BoxContainer({
    Key? key,
    required this.image,
    required this.title,
    required this.data,
    required this.action,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: CustomShadow().buildBoxShadow(),
        ),
        padding: const EdgeInsets.all(8.0),
        width: 100,
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: image,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 8,
                          color: Color(0xFF474747),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        data,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Color(0xFF5EAFC0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
