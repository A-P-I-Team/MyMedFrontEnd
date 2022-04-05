import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter/material.dart';

class LoadingCirclesBuilder extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double opacity;

  const LoadingCirclesBuilder({
    Key? key,
    this.color,
    this.opacity = .1,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: -width / 2,
              child: LoadingCircles(
                color: color,
                opacity: opacity,
              ),
            ),
            child,
          ],
        );
      },
    );
  }
}

class LoadingCircles extends StatefulWidget {
  final Color? color;
  final double opacity;

  const LoadingCircles({
    Key? key,
    this.color,
    this.opacity = .1,
  }) : super(key: key);

  @override
  _LoadingCirclesState createState() => _LoadingCirclesState();
}

class _LoadingCirclesState extends State<LoadingCircles> {
  final random = Random();
  late double critPoint1;
  late double critPoint2;
  late double critPoint3;

  late final Timer timer1;
  late final Timer timer2;
  late final Timer timer3;

  final duration1 = const Duration(milliseconds: 2000);
  final duration2 = const Duration(milliseconds: 2500);
  final duration3 = const Duration(milliseconds: 3000);

  double width = 0;

  @override
  void initState() {
    refreshValues(index: null);
    timer1 = Timer.periodic(
      duration1,
      (timer) => refreshValues(index: 1),
    );
    timer2 = Timer.periodic(
      duration2,
      (timer) => refreshValues(index: 2),
    );
    timer3 = Timer.periodic(
      duration3,
      (timer) => refreshValues(index: 3),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer1.cancel();
    timer2.cancel();
    timer3.cancel();
    super.dispose();
  }

  void refreshValues({required final int? index}) {
    void setValue1() {
      critPoint1 = .4 + random.nextDouble() * .2;
    }

    void setValue2() {
      critPoint2 = .6 + random.nextDouble() * .15;
    }

    void setValue3() {
      critPoint3 = .75 + random.nextDouble() * .2;
    }

    final isForced = index == null;
    if (isForced) {
      setValue1();
      setValue2();
      setValue3();
      Future(() => refreshValues(index: 1));
      Future(() => refreshValues(index: 2));
      Future(() => refreshValues(index: 3));
    } else if (index == 1) {
      setValue1();
    } else if (index == 2) {
      setValue2();
    } else if (index == 3) {
      setValue3();
    }
    setState(() {});
  }

  Widget _circleBuilder({
    required final BuildContext context,
    required final Duration duration,
    required final double critPoint,
  }) {
    final Color color = widget.color ?? Theme.of(context).splashColor;
    return ClipOval(
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.easeInOut,
        width: critPoint * width,
        height: critPoint * width,
        color: color.withOpacity(widget.opacity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        width = constraints.maxWidth;
        return SizedBox(
          height: width,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _circleBuilder(
                  context: context,
                  duration: duration1,
                  critPoint: critPoint1,
                ),
                _circleBuilder(
                  context: context,
                  duration: duration2,
                  critPoint: critPoint2,
                ),
                _circleBuilder(
                  context: context,
                  duration: duration3,
                  critPoint: critPoint3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
