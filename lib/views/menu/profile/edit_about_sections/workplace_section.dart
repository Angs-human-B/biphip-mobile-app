import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:intl/intl.dart';

class WorkplaceSection extends StatelessWidget {
  WorkplaceSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();

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
                  _profileController.resetTextEditor();
                  _profileController.isSingleDatePicker.value = true;
                  _profileController.getMethod(8);
                  _profileController.getCompanyList();
                },
              ),
            ),
          if (_profileController.currentWorkplace.value != null)
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                prefixText: _profileController.currentWorkplace.value!.position == null ? null : '${_profileController.currentWorkplace.value!.position} at',
                suffixText: checkNullOrStringNull(_profileController.currentWorkplace.value!.company),
                subtitlePrefixText: _profileController.currentWorkSubtitleText(_profileController.currentWorkplace.value!.started),
                isAddButton: false,
                suffixOnPressed: () async {
                  _profileController.resetTextEditor();
                  _profileController.isSingleDatePicker.value = true;
                  _profileController.enableSaveButton.value = true;
                  if (_profileController.currentWorkplace.value!.started != null) {
                    _profileController.tempWorkplaceStartDate.value = DateFormat("yyyy-MM-dd").format(_profileController.currentWorkplace.value!.started!);
                  }
                  if (_profileController.currentWorkplace.value!.ended != null) {
                    _profileController.tempWorkplaceEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.currentWorkplace.value!.ended!);
                  }
                  _profileController.officeID.value = _profileController.currentWorkplace.value!.id!;
                  _profileController.companyNameTextEditingController.text = _profileController.currentWorkplace.value!.company!;
                  _profileController.designationTextEditingController.text = _profileController.currentWorkplace.value!.position ?? '';
                  if (_profileController.currentWorkplace.value!.isCurrent == 1) {
                    _profileController.isCurrentlyWorkingHere.value = true;
                  } else {
                    _profileController.isCurrentlyWorkingHere.value = false;
                  }
                  _profileController.getMethod(10);
                  _profileController.getCompanyList();
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: k12Padding),
            child: InfoContainer2(
              suffixText: ksPreviousWorkPlaces.tr,
              isAddButton: true,
              suffixOnPressed: () async {
                _profileController.resetTextEditor();
                _profileController.getMethod(17);
                _profileController.getCompanyList();
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
                  subtitlePrefixText: _profileController.previousWorkSubtitleText(
                      _profileController.workplaceDataList[i].started, _profileController.workplaceDataList[i].ended),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    _profileController.resetTextEditor();
                    _profileController.enableSaveButton.value = true;
                    _profileController.getCompanyList();
                    if (_profileController.workplaceDataList[i].started != null) {
                      _profileController.tempWorkplaceStartDate.value = DateFormat("yyyy-MM-dd").format(_profileController.workplaceDataList[i].started!);
                    }
                    if (_profileController.workplaceDataList[i].ended != null) {
                      _profileController.tempWorkplaceEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.workplaceDataList[i].ended!);
                    }
                    _profileController.officeID.value = _profileController.workplaceDataList[i].id!;
                    _profileController.companyNameTextEditingController.text = _profileController.workplaceDataList[i].company!;
                    _profileController.designationTextEditingController.text = _profileController.workplaceDataList[i].position ?? '';
                    if (_profileController.workplaceDataList[i].isCurrent == 1) {
                      _profileController.isCurrentlyWorkingHere.value = true;
                    } else {
                      _profileController.isCurrentlyWorkingHere.value = false;
                    }
                    _profileController.getMethod(10);
                  },
                ),
              ),
          kH4sizedBox,
        ]),
      ),
    );
  }
}
