import 'package:bip_hip/utils/constants/imports.dart';

class CustomSelectionButton extends StatelessWidget {
  const CustomSelectionButton({super.key, this.onPressed, this.text, this.hintText});
  final Function()? onPressed;
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
                if (text != null)
                  Text(
                    text ?? '',
                    style: regular14TextStyle(cBlackColor),
                  ),
                if (text == null)
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
