import 'package:bip_hip/utils/constants/imports.dart';

class OutLinedButton extends StatelessWidget {
  const OutLinedButton({
    super.key,
    this.onPress,
    required this.buttonText,
    this.widget,
    this.buttonColor,
    required this.borderColor,
    this.buttonTextStyle,
    this.buttonHeight,
    this.buttonWidth,
    this.borderRadius,
    this.mainAxisAlignment,
    this.radius,
    this.backgroundImage,
    this.suffixWidget,
  });

  final Function()? onPress;
  final String buttonText;
  final Widget? widget, suffixWidget;
  final Color? buttonColor;
  final Color borderColor;
  final TextStyle? buttonTextStyle;
  final double? buttonHeight, buttonWidth, radius;
  final BorderRadiusGeometry? borderRadius;
  final MainAxisAlignment? mainAxisAlignment;
  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: kTextButtonStyle,
      child: Container(
        height: buttonHeight ?? h44,
        width: buttonWidth ?? width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? k4CircularBorderRadius,
          color: buttonColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (backgroundImage != null)
                    CircleAvatar(
                      radius: radius ?? 12,
                      backgroundImage: backgroundImage ?? const AssetImage(kiProfileDefaultImageUrl),
                    ),
                  if (suffixWidget != null) suffixWidget ?? kEmptySizedBox,
                  if (backgroundImage != null) kW8sizedBox,
                  Text(
                    buttonText,
                    style: buttonTextStyle ?? medium16TextStyle(borderColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  kW4sizedBox,
                  widget ?? kEmptySizedBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
