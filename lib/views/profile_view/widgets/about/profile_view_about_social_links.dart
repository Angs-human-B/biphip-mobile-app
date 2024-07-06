import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutSocialLinks extends StatelessWidget {
  const ProileViewAboutSocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(k20Padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ksWebsiteAndSocialLinks.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            const ProfileViewAboutTitleSubtitleText(
              title: "wahidmurad",
              subTitle: "Instagram",
            ),
            kH16sizedBox,
            const ProfileViewAboutTitleSubtitleText(
              title: "wahidmurad",
              subTitle: "Facebook",
            ),
          ],
        ),
      ),
    );
  }
}
