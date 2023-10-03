import 'package:bip_hip/utils/constants/imports.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    required this.textStyle,
    this.isIconExits,
    this.icon,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final TextStyle textStyle;
  final bool? isIconExits;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toString(),
              style: textStyle,
            ),
            if (isIconExits != null) kW4sizedBox,
            if (isIconExits != null)
              Icon(
                icon,
                size: 18,
                color: cPrimaryColor,
              )
          ],
        ),
      ),
    );
  }
}
