import 'package:bip_hip/utils/constants/imports.dart';

class CommonListTile extends StatelessWidget {
  const CommonListTile({super.key, required this.titleText, required this.subTitleText, required this.leadingIcon, this.onPressed});
  final String titleText, subTitleText;
  final IconData leadingIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: k8Padding),
      child: CustomListTile(
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: cNeutralColor,
          ),
          height: h28,
          width: h28,
          child: Icon(
            leadingIcon,
            color: cBlackColor,
            size: isDeviceScreenLarge() ? h18 : h14,
          ),
        ),
        title: titleText,
        titleTextStyle: semiBold16TextStyle(cBlackColor),
        subtitle: subTitleText,
        subTitleTextStyle: regular14TextStyle(cBlackColor),
        onPressed: onPressed,
      ),
    );
  }
}
