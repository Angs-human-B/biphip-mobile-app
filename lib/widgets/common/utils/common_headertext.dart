import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/const.dart';

class HeaderText extends StatelessWidget {
  String title;
  HeaderText(this.title, {Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 33.sp,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
