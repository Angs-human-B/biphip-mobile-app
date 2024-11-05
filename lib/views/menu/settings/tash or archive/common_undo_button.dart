import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';

class CommonBlueButton extends StatefulWidget {
  String title;
  IconData? icon;
  Function() ontap;
  CommonBlueButton(this.title,this.icon,this.ontap,{Key? key}) : super(key: key);

  @override
  State<CommonBlueButton> createState() => _CommonBlueButtonState();
}

class _CommonBlueButtonState extends State<CommonBlueButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.ontap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: cPrimaryTint2Color

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon != null?
              Icon(widget.icon,color: cSellingColor,): Container(),
              Normalext(widget.title, color: cSellingColor,)
            ],
          ),
        ),
      ),
    );
  }
}
