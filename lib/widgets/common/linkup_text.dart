import 'package:bip_hip/utils/constants/colors.dart';
import 'package:bip_hip/utils/constants/styles.dart';
import 'package:flutter/material.dart';

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
              style: prefixStyle ?? medium12TextStyle(cBlackColor).copyWith(fontSize: 16),
            ),
          ),
          InkWell(
            onTap: onPressed,
            child: Text(
              suffix.toString(),
              textAlign: TextAlign.center,
              style: suffixStyle ?? medium12TextStyle(cPrimaryColor).copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
