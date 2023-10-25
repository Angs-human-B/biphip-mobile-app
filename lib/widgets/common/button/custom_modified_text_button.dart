import 'package:bip_hip/utils/constants/imports.dart';

class CustomTextButtonV2 extends StatelessWidget {
  const CustomTextButtonV2({
    required this.onPressed,
    required this.text,
    required this.textStyle,
    Key? key,
    this.suffixWidget,
    this.prefixWidget,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final TextStyle textStyle;
  final Widget? suffixWidget, prefixWidget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? kEmptySizedBox,
          kW4sizedBox,
          Text(
            text.toString(),
            style: textStyle,
          ),
          if (suffixWidget != null) kW4sizedBox,
          suffixWidget ?? kEmptySizedBox,
        ],
      ),
    );
  }
}
