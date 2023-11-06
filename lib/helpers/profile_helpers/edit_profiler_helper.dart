import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
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
}
