
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutWork extends StatelessWidget {
  const ProileViewAboutWork({super.key});

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
              ksWork.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            const ProfileViewAboutTitleSubtitleText(
              title: "Work at Genie Infotech",
              subTitle: "26 October, 2022 - Present",
            ),
            kH16sizedBox,
            const ProfileViewAboutTitleSubtitleText(
              title: "Work at Genie Infotech",
              subTitle: "12 August, 2018 - 26, September, 2022",
            ),
          ],
        ),
      ),
    );
  }
}

