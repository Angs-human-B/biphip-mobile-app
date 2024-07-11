import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_work_education_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class ProileViewAboutEducationBackground extends StatelessWidget {
  const ProileViewAboutEducationBackground({super.key, required this.collegeList, required this.schoolList});
  final List<College?> collegeList;
  final List<College?> schoolList;

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
              ksEducationBackground.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            for (int i = 0; i < collegeList.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: k16Padding),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "studied at ", style: regular16TextStyle(cSmallBodyTextColor)),
                      TextSpan(text: collegeList[i]!.school, style: regular16TextStyle(cBlackColor)),
                    ],
                  ),
                ),
              ),
            kH4sizedBox,
            for (int i = 0; i < collegeList.length; i++)
              Text(
                Get.find<ProfileViewController>().workEducationSubTitleText(collegeList[i]?.started, collegeList[i]?.ended),
                style: regular10TextStyle(cSmallBodyTextColor),
              ),
            for (int i = 0; i < schoolList.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: k16Padding),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "studied at ", style: regular16TextStyle(cSmallBodyTextColor)),
                      TextSpan(text: "${schoolList[i]!.school}", style: regular16TextStyle(cBlackColor)),
                    ],
                  ),
                ),
              ),
            kH4sizedBox,
            for (int i = 0; i < schoolList.length; i++)
              Text(
                Get.find<ProfileViewController>().workEducationSubTitleText(schoolList[i]?.started, schoolList[i]?.ended),
                style: regular10TextStyle(cSmallBodyTextColor),
              ),
          ],
        ),
      ),
    );
  }
}
