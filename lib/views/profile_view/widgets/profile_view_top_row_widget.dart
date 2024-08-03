import 'dart:math';
import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewTopRowWidget extends StatelessWidget {
  const ProfileViewTopRowWidget(
      {super.key,
      required this.buttonText,
      required this.messageButtonText,
      required this.buttonIcon,
      required this.messageIcon,
      this.buttonOnPressed,
      this.messageButtonOnPressed,
      this.profileActionButtonOnPressed});
  final String buttonText, messageButtonText;
  final IconData buttonIcon, messageIcon;
  final VoidCallback? buttonOnPressed, messageButtonOnPressed, profileActionButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        children: [
          CustomElevatedButton(
            label: buttonText,
            onPressed: buttonOnPressed,
            buttonHeight: h32,
            buttonWidth: (width - 132) / 2,
            prefixIcon: buttonIcon,
            prefixIconColor: cWhiteColor,
          ),
          kW12sizedBox,
          CustomElevatedButton(
            label: messageButtonText,
            onPressed: messageButtonOnPressed,
            buttonHeight: h32,
            buttonWidth: (width - 100) / 2,
            buttonColor: cWhiteColor,
            borderColor: cPrimaryColor,
            prefixIcon: messageIcon,
            prefixIconColor: cPrimaryColor,
            textStyle: semiBold14TextStyle(cPrimaryColor),
          ),
          kW12sizedBox,
          InkWell(
            onTap: profileActionButtonOnPressed,
            child: Container(
              width: 52,
              height: h32,
              decoration: BoxDecoration(
                color: cWhiteColor,
                borderRadius: BorderRadius.circular(k4BorderRadius),
                border: Border.all(width: 1, color: cPrimaryColor),
              ),
              child: Transform.rotate(
                angle: pi / 2,
                child: const Icon(
                  BipHip.system,
                  color: cPrimaryColor,
                  size: kIconSize20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
