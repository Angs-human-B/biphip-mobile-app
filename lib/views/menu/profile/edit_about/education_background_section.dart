import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class EducationBackgroundSection extends StatelessWidget {
  EducationBackgroundSection({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            InfoContainer(
              suffixText: ksEducationalBackground.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              isAddButton: true,
              suffixOnPressed: () {
                editProfileHelper.addEducationBackground();
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < profileController.schoolDataList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: checkNullOrStringNull(profileController.schoolDataList[i].school),
                  prefixText: profileController.schoolDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
                  subtitlePrefixText:
                      editProfileHelper.schoolSubtitleText(profileController.schoolDataList[i].started, profileController.schoolDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    editProfileHelper.editSchool(i);
                  },
                ),
              ),
            for (int i = 0; i < profileController.collegeDataList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: checkNullOrStringNull(profileController.collegeDataList[i].school),
                  prefixText: profileController.collegeDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
                  subtitlePrefixText:
                      editProfileHelper.schoolSubtitleText(profileController.collegeDataList[i].started, profileController.collegeDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    editProfileHelper.editCollege(i);
                  },
                ),
              ),
            kH4sizedBox
          ],
        ),
      ),
    );
  }
}
