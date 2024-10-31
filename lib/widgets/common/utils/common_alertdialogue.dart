import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/const.dart';
import '../../../utils/constants/styles.dart';
import '../../../utils/icons/bip_hip_icons.dart';
import '../button/custom_icon_button.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    this.title,
    required this.addContent,
    this.hasCloseBtn = false,
    this.hasDivider = true,
    this.actions,
    this.onClose,
    this.horizontalContentPadding,
    this.verticalContentPadding,
    Key? key,
  }) : super(key: key);

  final String? title;
  final Widget? addContent;
  final bool hasCloseBtn, hasDivider;
  final List<Widget>? actions;
  final Function()? onClose;
  final double? horizontalContentPadding;
  final double? verticalContentPadding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: cWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(h10),
      ),
      elevation: 0,
      titlePadding: EdgeInsets.zero,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(h10),
        child: Container(
          // height: 120.h,
          // width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(h10),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: k16Padding),
                      child: Center(
                        child: HeaderText(
                          title.toString(),
                        ),
                      ),
                    ),
                  if (hasCloseBtn)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CustomIconButton(
                        hasBorder: false,
                        onPress: onClose,
                        icon: BipHip.circleCross,
                        size: height > kSmallDeviceSizeLimit ? kIconSize20 : kIconSize16,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalContentPadding ?? k16Padding,
        vertical: verticalContentPadding ?? k10Padding,
      ),
      insetPadding: const EdgeInsets.all(k20Padding),
      content: addContent,
      actions: actions,
    );
  }
}
