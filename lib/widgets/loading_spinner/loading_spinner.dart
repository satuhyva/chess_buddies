import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingSpinner extends StatelessWidget {
  final backgroundColor;
  final ballColor;
  LoadingSpinner({required this.backgroundColor, required this.ballColor});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingIndicator(
      indicatorType: Indicator.ballPulse,
      colors: [ballColor],
      strokeWidth: 2,
      backgroundColor: backgroundColor,
    ));
  }
}
