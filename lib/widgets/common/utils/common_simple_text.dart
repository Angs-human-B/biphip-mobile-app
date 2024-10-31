import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/const.dart';

class Normalext extends StatelessWidget {
  String title;
  Color color;
  TextAlign txtAlign;
  double fontSize;
  double height;
  FontWeight weight;
  Normalext(this.title, {this.color = Colors.black, this.txtAlign = TextAlign.justify, this.fontSize = h16,this.height = 1.5,this.weight = FontWeight.normal, Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      // maxLines: 5,
      textAlign: txtAlign,
      title,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: weight,
        color: color,
        height: height
      ),
    );
  }
}
