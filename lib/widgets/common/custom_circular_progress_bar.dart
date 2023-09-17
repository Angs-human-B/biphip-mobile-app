import 'package:bip_hip/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({super.key, required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
                    animateFromLastPercent: false,
                    radius: 10.0,
                    lineWidth: 2.0,
                    animation: true,
                    percent: percent,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: cPrimaryColor,
                  );
  }
}