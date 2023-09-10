import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/utils/icons/bip_hip_icons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.action,
    this.hasBackButton = true,
    required this.onBack,
  }) : super(key: key);

  final dynamic title;
  final List<Widget>? action;
  final Function()? onBack;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: kCommonElevation,
      backgroundColor: cTransparentColor,
      leadingWidth: kCommonBackSpace + k20Padding,
      centerTitle: true,
      title: title == null
          ? null
          : (title is String)
              ? Text(
                  title.toString(),
                  style: semiBold18TextStyle(cBlackColor),
                )
              : title,
      leading: hasBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: k20Padding),
              child: Center(
                child: CustomIconButton(
                  onPress: onBack,
                  iconColor: cIconColor,
                  icon: BipHip.backArrow,
                ),
              ),
            )
          : null,
      actions: action,
    );
  }
}
