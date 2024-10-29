import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_work_education_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';

class ProileViewAboutWork extends StatelessWidget {
  const ProileViewAboutWork({super.key, required this.workplaceList});
  final List<Work?> workplaceList;

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
            for (int i = 0; i < workplaceList.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: k16Padding),
                child: ProfileViewAboutTitleSubtitleText(
                  title: "Work at ${workplaceList[i]!.company}",
                  subTitle: Get.find<ProfileViewController>().workEducationSubTitleText(workplaceList[i]?.started, workplaceList[i]?.ended),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
