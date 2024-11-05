import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/const.dart';

class HeaderText extends StatelessWidget {
  String title;
  Color color;
  double fontSize;
  HeaderText(this.title, {this.color = Colors.black, this.fontSize = 17.71428571428571, Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      // softWrap: true,
      // overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        color: color
      ),
    );
  }
}
