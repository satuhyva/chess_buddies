import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedDot extends StatefulWidget {
  final Color dotColor;

  const AnimatedDot({Key? key, required this.dotColor}) : super(key: key);

  @override
  AnimatedDotState createState() => AnimatedDotState();
}

class AnimatedDotState extends State<AnimatedDot> {
  static const SMALL = 25.0;
  static const BIG = 35.0;
  var dimension = 25.0;

// TODO: HOW TO STOP THE TIMER LATER ON???
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (dimension < BIG) {
          dimension = BIG;
        } else {
          dimension = SMALL;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color _color = widget.dotColor;
    final BorderRadiusGeometry _borderRadius = BorderRadius.circular(25);

    return AnimatedContainer(
      // Use the properties stored in the State class.
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      // Define how long the animation should take.
      duration: const Duration(seconds: 1),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
    );
  }
}
