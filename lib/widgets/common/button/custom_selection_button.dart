import 'package:bip_hip/utils/constants/imports.dart';

class CustomSelectionButton extends StatelessWidget {
  const CustomSelectionButton({
    super.key,
    this.onPressed,
    this.text,
    this.hintText,
    this.prefixIcon,
    this.buttonColor,
    this.borderColor,
    this.buttonHeight,
    this.contentPadding,
  });
  final Function()? onPressed;
  final IconData? prefixIcon;
  final String? text, hintText;
  final Color? buttonColor, borderColor;
  final double? buttonHeight;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Container(
          height: buttonHeight,
          decoration:
              BoxDecoration(color: buttonColor ?? cGreyBoxColor, borderRadius: k4CircularBorderRadius, border: Border.all(color: borderColor ?? cWhiteColor)),
          child: Padding(
            padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: k12Padding, vertical: k12Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (prefixIcon != null)
                      Icon(
                        prefixIcon,
                        color: cIconColor,
                      ),
                    if (prefixIcon != null) kW8sizedBox,
                    if (text != '')
                      Text(
                        text ?? '',
                        style: regular14TextStyle(cBlackColor),
                      ),
                    if (text == '')
                      Text(
                        hintText ?? '',
                        style: regular14TextStyle(cPlaceHolderColor),
                      ),
                  ],
                ),
                Icon(
                  BipHip.downArrow,
                  color: (text != null) ? cBlackColor : cPlaceHolderColor,
                )
              ],
            ),
          ),
        ));
  }
}
