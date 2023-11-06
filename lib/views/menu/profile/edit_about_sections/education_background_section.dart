import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:intl/intl.dart';

class EducationBackgroundSection extends StatelessWidget {
  EducationBackgroundSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();

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
                _profileController.resetTextEditor();
                _profileController.getMethod(5);
                _profileController.getSchoolList();
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < _profileController.schoolDataList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer2(
                  suffixText: checkNullOrStringNull(_profileController.schoolDataList[i].school),
                  prefixText: _profileController.schoolDataList[i].ended != null ? 'Studied at' : 'Studies at',
                  subtitlePrefixText:
                      _profileController.schoolSubtitleText(_profileController.schoolDataList[i].started, _profileController.schoolDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    _profileController.resetTextEditor();
                    _profileController.enableSaveButton.value = true;
                    if (_profileController.schoolDataList[i].started != null) {
                      _profileController.tempSchoolStartDate.value = DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[i].started!);
                    }
                    if (_profileController.schoolDataList[i].ended != null) {
                      _profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[i].ended!);
                    }
                    _profileController.schoolID.value = _profileController.schoolDataList[i].id!;
                    _profileController.educationInstituteTextEditingController.text = _profileController.schoolDataList[i].school!;
                    if (_profileController.schoolDataList[i].graduated == 0) {
                      _profileController.isCurrentlyStudyingHere.value = true;
                    } else {
                      _profileController.isCurrentlyStudyingHere.value = false;
                    }
                    _profileController.getMethod(6);
                    _profileController.getSchoolList();
                  },
                ),
              ),
            for (int i = 0; i < _profileController.collegeDataList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer2(
                  suffixText: checkNullOrStringNull(_profileController.collegeDataList[i].school),
                  prefixText: _profileController.collegeDataList[i].ended != null ? 'Studied at' : 'Studies at',
                  subtitlePrefixText:
                      _profileController.schoolSubtitleText(_profileController.collegeDataList[i].started, _profileController.collegeDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    _profileController.resetTextEditor();
                    _profileController.enableSaveButton.value = true;
                    if (_profileController.collegeDataList[i].started != null) {
                      _profileController.tempSchoolStartDate.value = DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[i].started!);
                    }
                    if (_profileController.collegeDataList[i].ended != null) {
                      _profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[i].ended!);
                    }
                    _profileController.collegeID.value = _profileController.collegeDataList[i].id!;
                    _profileController.educationInstituteTextEditingController.text = _profileController.collegeDataList[i].school!;
                    if (_profileController.collegeDataList[i].graduated == 0) {
                      _profileController.isCurrentlyStudyingHere.value = true;
                    } else {
                      _profileController.isCurrentlyStudyingHere.value = false;
                    }
                    _profileController.getMethod(7);
                    _profileController.getSchoolList();
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
