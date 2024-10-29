import 'package:bip_hip/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({super.key, required this.percent, this.radius, this.lineWidth, this.centerWidget, this.backgroundColor, this.progressColor, this.linearGradient});

  final double percent;
  final double? radius, lineWidth;
  final Widget? centerWidget;
  final Color? backgroundColor, progressColor;
  final LinearGradient? linearGradient;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animateFromLastPercent: false,
      backgroundColor: backgroundColor ?? cLineColor,
      radius: radius ?? 10.0,
      lineWidth: lineWidth ?? 2.0,
      animation: true,
      percent: percent,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: progressColor ?? cPrimaryColor,
      center: centerWidget,
      linearGradient: linearGradient,
    );
  }
}
