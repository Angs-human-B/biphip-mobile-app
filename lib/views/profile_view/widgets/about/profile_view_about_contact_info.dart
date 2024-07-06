import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutContactInfo extends StatelessWidget {
  const ProileViewAboutContactInfo({super.key});

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
              ksContactInfo.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            ProfileViewAboutTitleSubtitleText(
              title: "01993144278",
              subTitle: ksPhone.tr,
            ),
            kH16sizedBox,
            ProfileViewAboutTitleSubtitleText(
              title: "wahidmurad2000@gmail.com",
              subTitle: ksEmail.tr,
            ),
          ],
        ),
      ),
    );
  }
}

