import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profiler_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class WorkplaceSection extends StatelessWidget {
  WorkplaceSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
          if (_profileController.currentWorkplace.value == null)
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                suffixText: ksCurrentWorkplace.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  _editProfileHelper.addCurrentWorkplace();
                },
              ),
            ),
          if (_profileController.currentWorkplace.value != null)
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                prefixText: _profileController.currentWorkplace.value!.position == null ? null : '${_profileController.currentWorkplace.value!.position} at',
                suffixText: checkNullOrStringNull(_profileController.currentWorkplace.value!.company),
                subtitlePrefixText: _editProfileHelper.currentWorkSubtitleText(_profileController.currentWorkplace.value!.started),
                isAddButton: false,
                suffixOnPressed: () async {
                  _editProfileHelper.editCurrentWorkplace();
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: k12Padding),
            child: InfoContainer2(
              suffixText: ksPreviousWorkPlaces.tr,
              isAddButton: true,
              suffixOnPressed: () {
                _editProfileHelper.addPreviousWorkplace();
              },
            ),
          ),
          for (int i = 0; i < _profileController.workplaceDataList.length; i++)
            if (_profileController.workplaceDataList[i].isCurrent != 1)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer2(
                  prefixText: _profileController.workplaceDataList[i].position == null ? null : 'Former ${_profileController.workplaceDataList[i].position} at',
                  suffixText: _profileController.workplaceDataList[i].company!,
                  subtitlePrefixText: _editProfileHelper.previousWorkSubtitleText(
                      _profileController.workplaceDataList[i].started, _profileController.workplaceDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    _editProfileHelper.editPreviousWorkplace(i);
                  },
                ),
              ),
          kH4sizedBox,
        ]),
      ),
    );
  }
}
