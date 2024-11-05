import 'package:bip_hip/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/common/utils/common_simple_text.dart';

class CommonWhiteButton extends StatefulWidget {
  String title;
  IconData? icon;
  Function() ontap;
  CommonWhiteButton(this.title,this.icon,this.ontap,{Key? key}) : super(key: key);

  @override
  State<CommonWhiteButton> createState() => _CommonWhiteButtonState();
}

class _CommonWhiteButtonState extends State<CommonWhiteButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.ontap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cGreyBoxColor

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon != null?
              Icon(widget.icon,color: Colors.black87,): Container(),
              Normalext(widget.title, color: Colors.black87,)
            ],
          ),
        ),
      ),
    );
  }
}
