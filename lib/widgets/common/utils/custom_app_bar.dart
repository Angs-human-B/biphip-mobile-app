import 'package:bip_hip/utils/constants/imports.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.action,
    this.hasBackButton = true,
    required this.onBack,
    this.iconColor,
    this.titleColor,
    this.appBarColor,
    this.isCenterTitle,
  }) : super(key: key);

  final dynamic title;
  final List<Widget>? action;
  final Function()? onBack;
  final bool hasBackButton;
  final bool? isCenterTitle;
  final Color? iconColor;
  final Color? titleColor;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: isCenterTitle ?? true,
      automaticallyImplyLeading: false,
      elevation: kCommonElevation,
      backgroundColor: appBarColor ?? cWhiteColor,
      leadingWidth: kCommonBackSpace,
      title: (title is String)
          ? Text(
              title.toString(),
              style: semiBold18TextStyle(titleColor ?? cBlackColor),
            )
          : title,
      leading: hasBackButton
          ? Center(
              child: CustomIconButton(
                onPress: onBack,
                iconColor: iconColor ?? cBlackColor,
                icon: BipHip.leftArrow,
              ),
            )
          : null,
      actions: action,
    );
  }
}
