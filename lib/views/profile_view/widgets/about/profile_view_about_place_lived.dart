import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutPlaceLived extends StatelessWidget {
  const ProileViewAboutPlaceLived({super.key});

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
              ksPlaceLived.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            ProfileViewAboutTitleSubtitleText(
              title: "Mirpur, Dhaka, Bangladesh",
              subTitle: ksHomeTown.tr,
            ),
            kH16sizedBox,
            const ProfileViewAboutTitleSubtitleText(
              title: "Uttara, Dhaka, Bangladesh",
              subTitle: "Current city",
            ),
            kH16sizedBox,
            const ProfileViewAboutTitleSubtitleText(
              title: "Badda, Dhaka, Bangladesh",
              subTitle: "Moved in October 30, 2024",
            ),
          ],
        ),
      ),
    );
  }
}

