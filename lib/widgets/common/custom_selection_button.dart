import 'package:bip_hip/utils/constants/imports.dart';

class CustomSelectionButton extends StatelessWidget {
  const CustomSelectionButton({super.key, this.onPressed, this.text, this.hintText, this.prefixIcon});
  final Function()? onPressed;
  final IconData? prefixIcon;
  final String? text;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Container(
          decoration: BoxDecoration(
            color: cGreyBoxColor,
            borderRadius: k4CircularBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k12Padding, vertical: k12Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (prefixIcon != null)
                  Icon(
                    prefixIcon,
                    color: cIconColor,
                  ),
                if (prefixIcon != null) kW4sizedBox,
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
