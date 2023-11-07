import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class EducationBackgroundSection extends StatelessWidget {
  EducationBackgroundSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
            InfoContainer2(
              suffixText: ksEducationalBackground.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              isAddButton: true,
              suffixOnPressed: () {
               _editProfileHelper.addEducationBackground();
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < _profileController.schoolDataList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer2(
                  suffixText: checkNullOrStringNull(_profileController.schoolDataList[i].school),
                  prefixText: _profileController.schoolDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
                  subtitlePrefixText:
                      _editProfileHelper.schoolSubtitleText(_profileController.schoolDataList[i].started, _profileController.schoolDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    _editProfileHelper.editSchool(i);
                  },
                ),
              ),
            for (int i = 0; i < _profileController.collegeDataList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer2(
                  suffixText: checkNullOrStringNull(_profileController.collegeDataList[i].school),
                  prefixText: _profileController.collegeDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
                  subtitlePrefixText:
                      _editProfileHelper.schoolSubtitleText(_profileController.collegeDataList[i].started, _profileController.collegeDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    _editProfileHelper.editCollege(i);
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
