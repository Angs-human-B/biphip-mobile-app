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
    this.trailingIcon,
    this.prefixIconSize, this.onPressSuffixButton,
  });
  final Function()? onPressed, onPressSuffixButton;
  final IconData? prefixIcon, trailingIcon;
  final String? text, hintText;
  final Color? buttonColor, borderColor;
  final double? buttonHeight, prefixIconSize;
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
                        size: prefixIconSize,
                      ),
                    if (prefixIcon != null) kW8sizedBox,
                    if (text != '')
                      Text(
                        text ?? '',
                        style: regular16TextStyle(cBlackColor),
                      ),
                    if (text == '')
                      Text(
                        hintText ?? '',
                        style: regular16TextStyle(cPlaceHolderColor2),
                      ),
                  ],
                ),
                InkWell(
                  onTap:onPressSuffixButton ,
                  child: Icon(
                    trailingIcon ?? BipHip.downArrow,
                    color: (text != '') ? cBlackColor : cPlaceHolderColor2,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
