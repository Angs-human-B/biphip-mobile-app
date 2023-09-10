import 'package:bip_hip/utils/constants/imports.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final GestureTapCallback? onPressed;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? buttonColor, borderColor;
  final bool isCircularHead;
  final IconData? labelIcon;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    Key? key,
    this.buttonColor = cPrimaryColor,
    this.borderColor,
    required this.label,
    required this.onPressed,
    this.buttonWidth,
    this.labelIcon,
    this.buttonHeight,
    this.isCircularHead = false,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: isCircularHead ? BorderRadius.circular(50) : BorderRadius.circular(k4BorderRadius),
              side: BorderSide(color: (buttonColor == cWhiteColor) ? (borderColor ?? cPrimaryColor) : cTransparentColor, width: 1),
            )),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return cPlaceHolderColor;
              }
              return buttonColor!;
            }),
            splashFactory: InkRipple.splashFactory,
          ),
          child: SizedBox(
            height: buttonHeight ?? (height > kSmallDeviceSizeLimit ? (kButtonHeight) : (kButtonHeight - 4)),
            width: buttonWidth ?? width * .5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label.toString(), textAlign: TextAlign.center, style: textStyle),
                if (labelIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(left: k4Padding),
                    child: Icon(
                      labelIcon!,
                      color: cWhiteColor,
                      size: screenWiseSize(kIconSize18, 4),
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
