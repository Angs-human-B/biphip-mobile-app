import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutSocialLinks extends StatelessWidget {
  const ProileViewAboutSocialLinks({super.key, required this.title});
  final List<Link?> title;

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
          ],
        ),
      ),
    );
  }
}
