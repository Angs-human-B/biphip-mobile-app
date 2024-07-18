import 'package:bip_hip/models/profile_view/kid/profile_view_kid_overview_model.dart';
import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutSocialLinks extends StatelessWidget {
  const ProileViewAboutSocialLinks({super.key, required this.title, required this.privacyLink});
  final List<Link?> title;
  final List<PrivacyLink?> privacyLink;
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
            for (int i = 0; i < title.length; i++)
              if (title[i]?.type.toString().toLowerCase() != "phone" && title[i]?.type.toString().toLowerCase() != "email")
                Padding(
                  padding: const EdgeInsets.only(top: k16Padding),
                  child: ProfileViewAboutTitleSubtitleText(
                    title: title[i]?.link ?? "",
                    subTitle: title[i]?.type,
                  ),
                ),
            if (privacyLink.isNotEmpty)
              for (int i = 0; i < privacyLink.length; i++)
                if (privacyLink[i]?.facebook != null)
                  Padding(
                    padding: const EdgeInsets.only(top: k16Padding),
                    child: ProfileViewAboutTitleSubtitleText(
                      title: privacyLink[i]?.facebook ?? "",
                      subTitle: privacyLink[i]!.facebook!.toLowerCase().contains("facebook") ? "Facebook" : "",
                    ),
                  ),
            if (privacyLink.isNotEmpty)
              for (int i = 0; i < privacyLink.length; i++)
                if (privacyLink[i]?.twitter != null)
                  Padding(
                    padding: const EdgeInsets.only(top: k16Padding),
                    child: ProfileViewAboutTitleSubtitleText(
                      title: privacyLink[i]?.twitter ?? "",
                      subTitle: privacyLink[i]!.twitter!.toLowerCase().contains("twitter") ? "Twitter" : "",
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
