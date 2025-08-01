import 'package:bip_hip/utils/constants/imports.dart';

class CategoryComponent extends StatelessWidget {
  const CategoryComponent({
    super.key,
    this.icon,
    required this.title,
    this.iconColor,
    this.iconSize,
    required this.titleStyle,
    required this.suffixWidget,
    this.prefixWidget,
    this.onPress,
  });

  final IconData? icon;
  final String title;
  final Color? iconColor;
  final double? iconSize;
  final TextStyle titleStyle;
  final Widget suffixWidget;
  final Widget? prefixWidget;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: TextButton(
        onPressed: onPress,
        style: kTextButtonStyle,
        child: Container(
          height: isDeviceScreenLarge() ? h36 : h32,
          decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, border: Border.all(color: cLineColor)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon == null && prefixWidget != null) prefixWidget!,
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    title,
                    style: titleStyle,
                  ),
                ),
                suffixWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
