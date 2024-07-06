import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewAboutTitleSubtitleText extends StatelessWidget {
  const ProfileViewAboutTitleSubtitleText({super.key, required this.title, required this.subTitle});
  final String title, subTitle;

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
        Text(
          subTitle,
          style: regular12TextStyle(cSmallBodyTextColor),
        ),
      ],
    );
  }
}
