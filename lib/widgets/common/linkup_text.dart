import 'package:bip_hip/utils/constants/imports.dart';

class LinkupTextRow extends StatelessWidget {
  const LinkupTextRow({
    Key? key,
    required this.prefix,
    required this.suffix,
    required this.onPressed,
    this.onPrefixPressed,
    this.prefixStyle,
    this.suffixStyle,
  }) : super(key: key);

  final String prefix;
  final String suffix;
  final Function()? onPressed;
  final Function()? onPrefixPressed;
  final TextStyle? prefixStyle, suffixStyle;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            style: kTextButtonStyle,
            onPressed: onPrefixPressed,
            child: Text(
              '$prefix  ',
              textAlign: TextAlign.center,
              style: prefixStyle ?? regular16TextStyle(cBlackColor),
            ),
          ),
          InkWell(
            onTap: onPressed,
            child: Text(
              suffix.toString(),
              textAlign: TextAlign.center,
              style: suffixStyle ?? regular16TextStyle(cPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
