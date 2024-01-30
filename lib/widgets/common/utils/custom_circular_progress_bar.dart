import 'package:bip_hip/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({super.key, required this.percent, this.radius, this.lineWidth, this.centerWidget});

  final double percent;
  final double? radius, lineWidth;
  final Widget? centerWidget;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animateFromLastPercent: false,
      backgroundColor: cLineColor,
      radius: radius ?? 10.0,
      lineWidth: lineWidth ?? 2.0,
      animation: true,
      percent: percent,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: cPrimaryColor,
      center: centerWidget,
    );
  }
}
