import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutBasicInfo extends StatelessWidget {
  const ProileViewAboutBasicInfo({super.key});

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
              ksBasicInfo.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            ProfileViewAboutTitleSubtitleText(
              title: "Male",
              subTitle: ksGender.tr,
            ),
            kH16sizedBox,
            ProfileViewAboutTitleSubtitleText(
              title: "January 10, 1998",
              subTitle: ksBirthday.tr,
            ),
            kH16sizedBox,
            ProfileViewAboutTitleSubtitleText(
              title: "Bangla and English",
              subTitle: ksLanguages.tr,
            ),
          ],
        ),
      ),
    );
  }
}

