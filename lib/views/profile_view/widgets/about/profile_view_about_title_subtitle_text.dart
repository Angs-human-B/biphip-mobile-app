import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewAboutTitleSubtitleText extends StatelessWidget {
  const ProfileViewAboutTitleSubtitleText({super.key, required this.title, this.subTitle});
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: regular16TextStyle(cBlackColor),
        ),
        kH4sizedBox,
        if (subTitle != null)
          Text(
            subTitle!,
            style: regular12TextStyle(cSmallBodyTextColor),
          ),
      ],
    );
  }
}
