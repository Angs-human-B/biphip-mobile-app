import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutBasicInfo extends StatelessWidget {
  const ProileViewAboutBasicInfo({super.key, required this.gender, required this.dateOfBirth, this.languages});
  final String gender, dateOfBirth;
  final List<String>? languages;

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
              title: gender,
              subTitle: ksGender.tr,
            ),
            kH16sizedBox,
              ProfileViewAboutTitleSubtitleText(
                title: dateOfBirth,
                subTitle: ksBirthday.tr,
              ),
            if (Get.find<ProfileViewController>().profileViewType.value != "store" && languages != null)
              Padding(
                padding: const EdgeInsets.only(top: k16Padding),
                child: ProfileViewAboutTitleSubtitleText(
                  title: languages!.isNotEmpty ? languages!.join(", ") : "",
                  subTitle: ksLanguages.tr,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
