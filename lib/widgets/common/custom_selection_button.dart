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
            padding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k16Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                const Icon(BipHip.downArrow)
              ],
            ),
          ),
        ));
  }
}
