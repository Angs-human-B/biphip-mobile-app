import 'package:bip_hip/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTintContainer extends StatelessWidget {
   const CustomTintContainer({super.key, required this.width, required this.widget, required this.borderRadius,  this.height,});

  final double? height;
  final double width;
  final Widget widget;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cPrimaryTint3Color,
        borderRadius: borderRadius,
      ),
      height: height,
      width: width,
      child: widget,
    );
  }
}
