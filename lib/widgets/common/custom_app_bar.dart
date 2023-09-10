import 'package:bip_hip/utils/constants/imports.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.action,
    this.hasBackButton = true,
    required this.onBack,
    this.containerColor,
    this.iconColor,
    this.titleColor,
    this.appBarColor,
  }) : super(key: key);

  final dynamic title;
  final List<Widget>? action;
  final Function()? onBack;
  final bool hasBackButton;
  final Color? containerColor, iconColor;
  final Color? titleColor;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: kCommonElevation,
      backgroundColor: appBarColor ?? cWhiteColor,
      leadingWidth: kCommonBackSpace,
      titleSpacing: hasBackButton ? 0 : h20,
      title: (title is String)
          ? Text(
              title.toString(),
              style: semiBold18TextStyle(titleColor ?? cBlackColor),
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
