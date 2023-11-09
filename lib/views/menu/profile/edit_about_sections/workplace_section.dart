import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class WorkplaceSection extends StatelessWidget {
  WorkplaceSection({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          kH16sizedBox,
          Text(
            ksWork.tr,
            style: semiBold18TextStyle(cBlackColor),
          ),
          kH12sizedBox,
          if (profileController.currentWorkplace.value == null)
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                suffixText: ksCurrentWorkplace.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  editProfileHelper.addCurrentWorkplace();
                },
              ),
            ),
          if (profileController.currentWorkplace.value != null)
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                prefixText: profileController.currentWorkplace.value!.position == null ? null : '${profileController.currentWorkplace.value!.position} at',
                suffixText: checkNullOrStringNull(profileController.currentWorkplace.value!.company),
                subtitlePrefixText: editProfileHelper.currentWorkSubtitleText(profileController.currentWorkplace.value!.started),
                isAddButton: false,
                suffixOnPressed: () async {
                  editProfileHelper.editCurrentWorkplace();
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: k12Padding),
            child: InfoContainer2(
              suffixText: ksPreviousWorkPlaces.tr,
              isAddButton: true,
              suffixOnPressed: () {
                editProfileHelper.addPreviousWorkplace();
              },
            ),
          ),
          for (int i = 0; i < profileController.workplaceDataList.length; i++)
            if (profileController.workplaceDataList[i].isCurrent != 1)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer2(
                  prefixText: profileController.workplaceDataList[i].position == null ? null : 'Former ${profileController.workplaceDataList[i].position} at',
                  suffixText: profileController.workplaceDataList[i].company!,
                  subtitlePrefixText: editProfileHelper.previousWorkSubtitleText(
                      profileController.workplaceDataList[i].started, profileController.workplaceDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    editProfileHelper.editPreviousWorkplace(i);
                  },
                ),
              ),
          kH4sizedBox,
        ]),
      ),
    );
  }
}
