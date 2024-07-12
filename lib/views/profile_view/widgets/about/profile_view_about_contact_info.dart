import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutContactInfo extends StatelessWidget {
  const ProileViewAboutContactInfo({
    super.key,
    required this.title,
  });
  final List<Contact?> title;

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
            for (int i = 0; i < title.length; i++)
              if (title[i]?.type.toString().toLowerCase() == "phone")
                ProfileViewAboutTitleSubtitleText(
                  title: title[i]?.value ?? ksNA.tr,
                ),
            // kH4sizedBox,
            Text(
              ksPhone.tr,
              style: regular12TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            for (int i = 0; i < title.length; i++)
              if (title[i]?.type.toString().toLowerCase() == "email")
                ProfileViewAboutTitleSubtitleText(
                  title: title[i]?.value ?? ksNA.tr,
                  // subTitle: ksEmail.tr,
                ),
            kH4sizedBox,
            Text(
              ksEmail.tr,
              style: regular12TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
