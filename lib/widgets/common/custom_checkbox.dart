import 'package:bip_hip/utils/constants/colors.dart';
import 'package:bip_hip/utils/constants/const.dart';
import 'package:bip_hip/utils/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?> onChanged;
  final TextStyle textStyle;

  const CustomCheckBox({
    required this.value,
    required this.label,
    required this.onChanged,
    required this.textStyle,
    Key? key,
  }) : super(key: key);

  Widget _buildCheckBox() {
    return Container(
      width: height > kSmallDeviceSizeLimit ? h18 : h14,
      height: height > kSmallDeviceSizeLimit ? h18 : h14,
      decoration: !value
          ? BoxDecoration(
              border: kMainBoxBorder,
              borderRadius: BorderRadius.circular(k5BorderRadius),
              color: cWhiteColor,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(k5BorderRadius),
              color: cPrimaryColor,
            ),
      child: Icon(
        Icons.check,
        color: cWhiteColor,
        size: height > kSmallDeviceSizeLimit ? kIconSize14 : kIconSize12,
      ),
    );
  }

  Widget _buildLabel() {
    return Expanded(
      child: Text(
        label.toString(),
        textAlign: TextAlign.justify,
        style: textStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        color: cTransparentColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCheckBox(),
              const SizedBox(width: 10),
              _buildLabel(),
              kEmptySizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
