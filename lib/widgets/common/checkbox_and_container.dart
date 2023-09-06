

import 'package:bip_hip/utils/constants/colors.dart';
import 'package:bip_hip/utils/constants/strings.dart';
import 'package:bip_hip/utils/constants/styles.dart';
import 'package:bip_hip/widgets/common/custom_checkbox.dart';
import 'package:bip_hip/widgets/common/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxAndContainer extends StatelessWidget {
  const CheckBoxAndContainer({
    Key? key,
    required this.onTapCheckBox,
    required this.onPressForgetButton,
    required this.isChecked,
  }) : super(key: key);

  final Function(bool?) onTapCheckBox;
  final VoidCallback onPressForgetButton;
  final RxBool isChecked;

  @override
  Widget build(BuildContext context) {
    var textStyle = regular14TextStyle(cPrimaryColor);
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicWidth(
            child: CustomCheckBox(
              value: isChecked.value,
              onChanged: onTapCheckBox,
              label: ksRememberMe.tr,
              textStyle: regular14TextStyle(cBlackColor),
            ),
          ),
          CustomTextButton(
            onPressed: onPressForgetButton,
            textStyle: textStyle,
            text: ksForgotPassword.tr,
          ),
        ],
      ),
    );
  }
}
