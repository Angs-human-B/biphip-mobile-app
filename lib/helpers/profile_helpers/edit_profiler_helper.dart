import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/shimmer_views/profile/gender_shimmer.dart';
import 'package:bip_hip/shimmer_views/profile/relation_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/gender_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/relationship_section.dart';
import 'package:intl/intl.dart';

class EditProfileHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  //* Place Edit Methods
  void setHometown() {
    _profileController.resetTextEditor();
    _profileController.getCityList();
    _profileController.getMethod(9);
  }

  void editHometown() {
    _profileController.enableSaveButton.value = true;
    _profileController.getMethod(0);
    _profileController.getCityList();
  }

  void setCurrentCity() {
    _profileController.resetTextEditor();
    _profileController.getMethod(1);
    Get.toNamed(krEdit);
    _profileController.getCityList();
  }

  void editCurrentCity() {
    _profileController.enableSaveButton.value = true;
    _profileController.isCurrentlyLiveHere.value = true;
    _profileController.cityID.value = _profileController.currentCityData.value!.id!;
    _profileController.getMethod(2);
    _profileController.getCityList();
  }

  void setOtherCity() {
    _profileController.resetTextEditor();
    _profileController.isSingleDatePicker.value = true;
    _profileController.getMethod(3);
    Get.toNamed(krEdit);
    _profileController.getCityList();
  }

  void editOtherCity(index) {
    _profileController.cityID.value = _profileController.otherCityList[index].id!;
    _profileController.presentAddressTextEditingController.text = _profileController.otherCityList[index].city!;
    _profileController.enableSaveButton.value = true;
    _profileController.isSingleDatePicker.value = true;
    _profileController.getMethod(4);
    _profileController.getCityList();
  }

  //* Education Section

  String? schoolSubtitleText(DateTime? startDate, DateTime? endDate) {
    if (startDate != null && endDate != null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} - ${DateFormat("dd MMMM, yyyy").format(endDate)}';
    } else if (startDate == null && endDate != null) {
      ll(endDate.year);
      return 'School year ${endDate.year}';
    } else if (startDate != null && endDate == null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} to present';
    } else {
      return null;
    }
  }

  void addEducationBackground() {
    _profileController.resetTextEditor();
    _profileController.getMethod(5);
    _profileController.getSchoolList();
  }

  void editSchool(index) {
    _profileController.resetTextEditor();
    _profileController.enableSaveButton.value = true;
    if (_profileController.schoolDataList[index].started != null) {
      _profileController.tempSchoolStartDate.value = DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[index].started!);
    }
    if (_profileController.schoolDataList[index].ended != null) {
      _profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[index].ended!);
    }
    _profileController.schoolID.value = _profileController.schoolDataList[index].id!;
    _profileController.educationInstituteTextEditingController.text = _profileController.schoolDataList[index].school!;
    if (_profileController.schoolDataList[index].graduated == 0) {
      _profileController.isCurrentlyStudyingHere.value = true;
    } else {
      _profileController.isCurrentlyStudyingHere.value = false;
    }
    _profileController.getMethod(6);
    _profileController.getSchoolList();
  }

  void editCollege(index) {
    _profileController.resetTextEditor();
    _profileController.enableSaveButton.value = true;
    if (_profileController.collegeDataList[index].started != null) {
      _profileController.tempSchoolStartDate.value = DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[index].started!);
    }
    if (_profileController.collegeDataList[index].ended != null) {
      _profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[index].ended!);
    }
    _profileController.collegeID.value = _profileController.collegeDataList[index].id!;
    _profileController.educationInstituteTextEditingController.text = _profileController.collegeDataList[index].school!;
    if (_profileController.collegeDataList[index].graduated == 0) {
      _profileController.isCurrentlyStudyingHere.value = true;
    } else {
      _profileController.isCurrentlyStudyingHere.value = false;
    }
    _profileController.getMethod(7);
    _profileController.getSchoolList();
  }

  //* Relationship Section
  void setRelationshipStatus(context) async {
    _profileController.isRelationListLoading.value = true;
    _profileController.tempRelationshipStatus.value = '';
    if (_profileController.relationshipStatus.value != '') {
      _profileController.tempRelationshipStatus.value = _profileController.relationshipStatus.value;
    } else if (_profileController.userData.value!.relation != null) {
      _profileController.tempRelationshipStatus.value = checkNullOrStringNull(_profileController.userData.value!.relation);
    }
    if (_profileController.tempRelationshipStatus.value == '') {
      _globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      _globalController.isBottomSheetRightButtonActive.value = true;
    }
    relationshipBottomSheet(context);
    await _profileController.getRelationshipList();
  }

  void relationshipBottomSheet(context) {
    _globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => _profileController.isRelationListLoading.value
            ? const RelationshipStatusListShimmer()
            : RelationshipStatusListContent(
                profileController: _profileController,
              ),
      ),
      isScrollControlled: true,
      bottomSheetHeight: height * 0.6,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (_profileController.tempRelationshipStatus.value != '') {
          _profileController.relationshipStatus.value = _profileController.tempRelationshipStatus.value;
          _profileController.showEditRelationshipStatus.value = true;
        }
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksSelectRelationshipStatus.tr,
      isRightButtonShow: true,
    );
  }

  void resetRelationshipStatus() {
    _profileController.relationshipStatus.value = '';
    _profileController.showEditRelationshipStatus.value = false;
  }

  void saveRelationshipStatus() async {
    await _profileController.storeUserSetting('relationship', _profileController.relationshipStatus.value);
    _profileController.showEditRelationshipStatus.value = false;
    _profileController.relationshipStatus.value = '';
  }

  void selectBottomSheetRelationshipContent(index) {
    _profileController.tempRelationshipStatus.value = _profileController.relationshipStatusList[index];
    if (_profileController.tempRelationshipStatus.value == '') {
      _globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      _globalController.isBottomSheetRightButtonActive.value = true;
    }
  }

  //* Gender Section
  void selectGender(context) async {
    _profileController.isGenderListLoading.value = true;
    _profileController.tempSelectedGender.value = checkNullOrStringNull(_profileController.userData.value!.gender);
    if (_profileController.selectedGender.value != '') {
      _profileController.tempSelectedGender.value = _profileController.selectedGender.value;
    }
    genderBottomSheet(context);
    await _profileController.getGenderList();
  }

  void genderBottomSheet(context) {
    _globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => _profileController.isGenderListLoading.value
            ? const GenderListShimmer()
            : GenderListContent(
                profileController: _profileController,
              ),
      ),
      isScrollControlled: true,
      bottomSheetHeight: isDeviceScreenLarge() ? 255 : 240,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (_profileController.tempSelectedGender.value != '') {
          _profileController.selectedGender.value = _profileController.tempSelectedGender.value;
          _profileController.isGenderSelected.value = true;
        }
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksSelectGender.tr,
      isRightButtonShow: true,
    );
  }

  void resetGender() {
    _profileController.selectedGender.value = '';
    _profileController.isGenderSelected.value = false;
  }

  void saveGender() async {
    await _profileController.storeUserSetting('gender', _profileController.selectedGender.value);
    _profileController.selectedGender.value = '';
    _profileController.isGenderSelected.value = false;
  }
}
