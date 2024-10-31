import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/const.dart';

class HeaderText extends StatelessWidget {
  String title;
  Color color;
  HeaderText(this.title, {this.color = Colors.black, Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      // softWrap: true,
      // overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 31.sp,
          fontWeight: FontWeight.bold,
        color: color
      ),
    );
  }
}
