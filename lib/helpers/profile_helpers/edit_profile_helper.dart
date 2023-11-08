import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/shimmer_views/profile/gender_shimmer.dart';
import 'package:bip_hip/shimmer_views/profile/link_list_shimmer_view.dart';
import 'package:bip_hip/shimmer_views/profile/relation_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/edit_page_bottom_sheet_content.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/gender_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/relationship_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EditProfileHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  //* Place Edit Methods
  void setHometown() {
    _profileController.resetTextEditor();
    _profileController.getCityList();
    getMethod(9);
  }

  void editHometown() {
    _profileController.enableSaveButton.value = true;
    getMethod(0);
    _profileController.getCityList();
  }

  void setCurrentCity() {
    _profileController.resetTextEditor();
    getMethod(1);
    Get.toNamed(krEdit);
    _profileController.getCityList();
  }

  void editCurrentCity() {
    _profileController.enableSaveButton.value = true;
    _profileController.isCurrentlyLiveHere.value = true;
    _profileController.cityID.value = _profileController.currentCityData.value!.id!;
    getMethod(2);
    _profileController.getCityList();
  }

  void setOtherCity() {
    _profileController.resetTextEditor();
    _profileController.isSingleDatePicker.value = true;
    getMethod(3);
    Get.toNamed(krEdit);
    _profileController.getCityList();
  }

  void editOtherCity(index) {
    _profileController.cityID.value = _profileController.otherCityList[index].id!;
    _profileController.presentAddressTextEditingController.text = _profileController.otherCityList[index].city!;
    _profileController.enableSaveButton.value = true;
    _profileController.isSingleDatePicker.value = true;
    getMethod(4);
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
    getMethod(5);
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
    getMethod(6);
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
    getMethod(7);
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

  //* Birthday Section
  void editBirthday() {
    _authenticationController.birthDay.value = DateFormat("yyyy-MM-dd").format(_profileController.userData.value!.dob!);
    _profileController.isRouteFromAboutInfo.value = true;
    Get.toNamed(krSelectBirthday);
  }

  //* Profession Section
  void setProfession() async {
    _profileController.isRouteFromAboutInfo.value = true;
    _globalController.professionIndex.value = -1;
    Get.toNamed(krSelectProfession);
    await _profileController.getProfessionList();
  }

  void editProfession() async {
    _globalController.professionIndex.value = -1;
    _profileController.isRouteFromAboutInfo.value = true;
    Get.toNamed(krSelectProfession);
    await _profileController.getProfessionList();
    for (int i = 0; i < _globalController.professionList.length; i++) {
      if (_globalController.professionList[i] == _profileController.userData.value!.profession[0]) {
        _globalController.professionIndex.value = i;
      }
    }
  }

  //* Interest section
  void setInterest() async {
    _globalController.interestIndex.clear();
    _profileController.isRouteFromAboutInfo.value = true;
    Get.toNamed(krSelectInterest);
    await _profileController.getInterestList();
    for (int j = 0; j < _profileController.userData.value!.interest.length; j++) {
      for (int i = 0; i < _globalController.interestList.length; i++) {
        if (_globalController.interestList[i] == _profileController.userData.value!.interest[j]) {
          _globalController.interestIndex.add(i);
        }
      }
    }
  }

  //* Workplace section
  String? currentWorkSubtitleText(DateTime? startDate) {
    if (startDate != null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} - present';
    } else {
      return null;
    }
  }

  String? previousWorkSubtitleText(DateTime? startDate, DateTime? endDate) {
    if (startDate != null && endDate != null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} - ${DateFormat("dd MMMM, yyyy").format(endDate)}';
    } else {
      return null;
    }
  }

  void addCurrentWorkplace() {
    _profileController.resetTextEditor();
    _profileController.isSingleDatePicker.value = true;
    getMethod(8);
    _profileController.getCompanyList();
  }

  void editCurrentWorkplace() {
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
    getMethod(10);
    _profileController.getCompanyList();
  }

  void addPreviousWorkplace() {
    _profileController.resetTextEditor();
    getMethod(17);
    _profileController.getCompanyList();
  }

  void editPreviousWorkplace(index) {
    _profileController.resetTextEditor();
    _profileController.enableSaveButton.value = true;
    _profileController.getCompanyList();
    if (_profileController.workplaceDataList[index].started != null) {
      _profileController.tempWorkplaceStartDate.value = DateFormat("yyyy-MM-dd").format(_profileController.workplaceDataList[index].started!);
    }
    if (_profileController.workplaceDataList[index].ended != null) {
      _profileController.tempWorkplaceEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.workplaceDataList[index].ended!);
    }
    _profileController.officeID.value = _profileController.workplaceDataList[index].id!;
    _profileController.companyNameTextEditingController.text = _profileController.workplaceDataList[index].company!;
    _profileController.designationTextEditingController.text = _profileController.workplaceDataList[index].position ?? '';
    if (_profileController.workplaceDataList[index].isCurrent == 1) {
      _profileController.isCurrentlyWorkingHere.value = true;
    } else {
      _profileController.isCurrentlyWorkingHere.value = false;
    }
    getMethod(10);
  }

  //* Contact Section
  void addPhone() {
    _profileController.resetTextEditor();
    getMethod(11);
  }

  void editPhone(index) {
    _profileController.resetTextEditor();
    _profileController.enableSaveButton.value = true;
    _profileController.phoneID.value = _profileController.contactDataList[index].id!;
    _profileController.phoneTextEditingController.text = _profileController.contactDataList[index].value!;
    getMethod(12);
  }

  void addEmail() {
    _profileController.resetTextEditor();
    getMethod(13);
  }

  void editEmail(index) {
    _profileController.resetTextEditor();
    _profileController.enableSaveButton.value = true;
    _profileController.emailID.value = _profileController.contactDataList[index].id!;
    _profileController.emailTextEditingController.text = _profileController.contactDataList[index].value!;
    getMethod(14);
  }

  //* Website Section
  void addWebsite() {
    _profileController.resetTextEditor();
    _profileController.linkSource.value = '';
    _profileController.commonEditPageIcon.value = null;
    getMethod(15);
  }

  void editWebsite(index) {
    _profileController.resetTextEditor();
    _profileController.enableSaveButton.value = true;
    _profileController.commonEditPageIcon.value = null;
    _profileController.linkTextEditingController.text = _profileController.linkDataList[index].link!;
    _profileController.linkID.value = _profileController.linkDataList[index].id!;
    _profileController.linkSource.value = _profileController.linkDataList[index].type!;
    getMethod(16);
  }

  //* Common Edit page
  void commonSelectionButtonOnPressed(context) {
    _profileController.isLinkListLoading.value = true;
    _profileController.tempLinkSource.value = _profileController.linkSource.value;
    _profileController.tempEducationBackground.value = _profileController.educationBackground.value;
    if (_profileController.tempLinkSource.value == '' &&
        (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)) {
      _globalController.isBottomSheetRightButtonActive.value = false;
    } else if (_profileController.tempEducationBackground.value == '' &&
        (_profileController.commonEditPageTitle.value == ksAddEducationalEvent ||
            _profileController.commonEditPageTitle.value == ksEditSchool ||
            _profileController.commonEditPageTitle.value == ksEditCollege)) {
      _globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      _globalController.isBottomSheetRightButtonActive.value = true;
    }
    commonSelectionBottomSheet(context);
    _profileController.getLinkList();
  }

  void commonSelectionBottomSheet(context) {
    _globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
            ? (_profileController.isLinkListLoading.value ? const LinkListContentShimmer() : LinkListContent(profileController: _profileController))
            : EducationBackgroundContent(
                profileController: _profileController,
              ),
      ),
      isScrollControlled: true,
      bottomSheetHeight:
          (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink) ? height * 0.9 : 200,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink) {
          _profileController.linkSource.value = _profileController.tempLinkSource.value;
          _profileController.commonEditPageIcon.value = _profileController.getLinkIcon(_profileController.linkSource.value);
        } else {
          _profileController.educationBackground.value = _profileController.tempEducationBackground.value;
        }
        _profileController.checkSaveButtonActive();
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
          ? ksSelectLinkSource.tr
          : ksSelectEducationInstitute.tr,
      isRightButtonShow: true,
    );
  }

  void commonTextfieldSuffixOnPressed() {
    _profileController.commonEditTextEditingController.clear();
    _profileController.showCommonEditSuffixIcon.value = false;
    _profileController.checkSaveButtonActive();
  }

  void commonTextfieldOnChanged() {
    if (_profileController.commonEditTextEditingController.text != '') {
      _profileController.showCommonEditSuffixIcon.value = true;
    } else {
      _profileController.showCommonEditSuffixIcon.value = false;
    }
    if (_profileController.commonEditTextfieldHintText.value == ksEmail.tr || _profileController.commonEditTextfieldHintText.value == ksEditEmail.tr) {
      if (!_profileController.commonEditTextEditingController.text.isValidEmail) {
        _profileController.commonEditTextFieldErrorText.value = ksInvalidEmailErrorMessage.tr;
      } else {
        _profileController.commonEditTextFieldErrorText.value = '';
      }
    }
    _profileController.checkSaveButtonActive();
  }

  void commonSecondaryTextfieldSuffixOnPressed() {
    _profileController.commonEditSecondaryTextEditingController.clear();
    _profileController.checkSaveButtonActive();
    _profileController.showCommonSecondaryEditSuffixIcon.value = false;
  }

  void commonSecondaryTextfieldOnChanged() {
    _profileController.checkSaveButtonActive();
    if (_profileController.commonEditSecondaryTextEditingController.text.isNotEmpty) {
      _profileController.showCommonSecondaryEditSuffixIcon.value = true;
    } else {
      _profileController.showCommonSecondaryEditSuffixIcon.value = false;
    }
  }

  void startDateButtonOnPressed(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: height * 0.4,
          child: CupertinoDatePicker(
            initialDateTime: _profileController.commonStartDate.value != '' ? DateTime.parse(_profileController.commonStartDate.value) : DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              _profileController.commonStartDate.value = DateFormat("yyyy-MM-dd").format(value);
              _profileController.checkSaveButtonActive();
            },
          ),
        );
      },
    );
  }

  void endDateButtonOnPressed(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: height * 0.4,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            // maximumDate: DateTime.now(),
            initialDateTime: _profileController.commonEndDate.value != '' ? DateTime.parse(_profileController.commonEndDate.value) : DateTime.now(),
            onDateTimeChanged: (value) {
              _profileController.commonEndDate.value = DateFormat("yyyy-MM-dd").format(value);
              _profileController.checkSaveButtonActive();
            },
          ),
        );
      },
    );
  }

  void commonCheckBoxOnChanged() {
    _profileController.isCommonEditCheckBoxSelected.value = !_profileController.isCommonEditCheckBoxSelected.value;
    if (!_profileController.functionFlag.contains('PRESENT')) {
      if (_profileController.isCommonEditCheckBoxSelected.value) {
        _profileController.isSingleDatePicker.value = true;
        _profileController.commonEndDate.value = '';
      } else {
        _profileController.isSingleDatePicker.value = false;
      }
    }
    _profileController.checkSaveButtonActive();
  }

  void onSelectEducationBottomSheet(index) {
    _profileController.tempEducationBackground.value = _profileController.educationBackgroundList[index];
    if (_profileController.tempEducationBackground.value == '') {
      _globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      _globalController.isBottomSheetRightButtonActive.value = true;
    }
  }

  void onSelectLinkBottomSheet(index) {
    _profileController.tempLinkSource.value = _profileController.linkSourceList[index];
    if (_profileController.tempLinkSource.value == '') {
      _globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      _globalController.isBottomSheetRightButtonActive.value = true;
    }
  }

  //* profile edit methods
  void setEditPageValue(pageTitle, showDropDown, iconData, textEditingController, showSecondaryTextfield, secondaryTextEditingController, textfieldHintText,
      showDatePickerRow, showEditPrivacy, showCheckBox, checkBoxSelect, checkBoxText, function, startDate, endDate) {
    _profileController.commonEditPageTitle.value = pageTitle;
    _profileController.isDropdownShown.value = showDropDown;
    _profileController.commonEditIconData.value = iconData;
    _profileController.commonEditTextEditingController = textEditingController;
    _profileController.isSecondaryTextfieldShown.value = showSecondaryTextfield;
    _profileController.commonEditSecondaryTextEditingController = secondaryTextEditingController;
    _profileController.commonEditTextfieldHintText.value = textfieldHintText;
    _profileController.isCommonEditDatePickerShown.value = showDatePickerRow;
    _profileController.isCommonEditPrivacyShown.value = showEditPrivacy;
    _profileController.isCommonEditCheckBoxShown.value = showCheckBox;
    _profileController.isCommonEditCheckBoxSelected.value = checkBoxSelect;
    _profileController.commonEditCheckBoxText.value = checkBoxText;
    _profileController.functionFlag.value = function;
    _profileController.commonStartDate.value = startDate;
    _profileController.commonEndDate.value = endDate;
  }

  void getMethod(methodID) {
    _profileController.showCommonEditSuffixIcon.value = false;
    _profileController.showCommonSecondaryEditSuffixIcon.value = false;
    if (methodID == 0) {
      _profileController.homeID.value = _profileController.hometownData.value!.id!;
      _profileController.homeTownTextEditingController.text = _profileController.hometownData.value!.city!;
      setEditPageValue(ksEditHometownAddress.tr, false, BipHip.location, _profileController.homeTownTextEditingController, false, _profileController.homeTownTextEditingController,
          ksEditHometownAddress.tr, false, true, false, false, 'checkBoxText', 'EDIT HOMETOWN', '', '');
    } else if (methodID == 1) {
      setEditPageValue(ksAddPresentAddress.tr, false, BipHip.location, _profileController.presentAddressTextEditingController, false, _profileController.presentAddressTextEditingController,
          ksAddLocation.tr, false, true, false, true, ksCurrentlyLivingHere.tr, 'ADD PRESENT', '', '');
    } else if (methodID == 2) {
      _profileController.presentAddressTextEditingController.text = _profileController.currentCityData.value!.city!;
      setEditPageValue(ksEditPresentAddress.tr, false, BipHip.location, _profileController.presentAddressTextEditingController, false, _profileController.presentAddressTextEditingController,
          ksEditLocation.tr, false, true, false, _profileController.isCurrentlyLiveHere.value, ksCurrentlyLivingHere.tr, 'EDIT PRESENT', '', '');
    } else if (methodID == 3) {
      setEditPageValue(ksAddOtherAddress.tr, false, BipHip.location, _profileController.presentAddressTextEditingController, false, _profileController.presentAddressTextEditingController,
          ksAddLocation.tr, true, true, true, false, ksCurrentlyLivingHere.tr, 'ADD PRESENT', '', '');
    } else if (methodID == 4) {
      setEditPageValue(ksEditAddress.tr, false, BipHip.location, _profileController.presentAddressTextEditingController, false, _profileController.presentAddressTextEditingController,
          ksEditLocation.tr, true, true, true, false, ksCurrentlyLivingHere.tr, 'EDIT PRESENT', '', '');
    } else if (methodID == 5) {
      setEditPageValue(
          ksAddEducationalEvent.tr,
          true,
          BipHip.schoolNew,
          _profileController.educationInstituteTextEditingController,
          false,
          _profileController.educationInstituteTextEditingController,
          'Institute name',
          true,
          true,
          true,
          _profileController.isCurrentlyStudyingHere.value,
          'Currently studying here',
          'ADD SCHOOL',
          '',
          '');
    } else if (methodID == 6) {
      setEditPageValue(
          ksEditSchool.tr,
          false,
          BipHip.schoolNew,
          _profileController.educationInstituteTextEditingController,
          false,
          _profileController.educationInstituteTextEditingController,
          ksEditSchool.tr,
          true,
          true,
          true,
          _profileController.isCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT SCHOOL',
          _profileController.tempSchoolStartDate.value,
          _profileController.tempSchoolEndDate.value);
    } else if (methodID == 7) {
      setEditPageValue(
          ksEditCollege.tr,
          false,
          BipHip.schoolNew,
          _profileController.educationInstituteTextEditingController,
          false,
          _profileController.educationInstituteTextEditingController,
          ksEditCollege.tr,
          true,
          true,
          true,
          _profileController.isCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT COLLEGE',
          _profileController.tempSchoolStartDate.value,
          _profileController.tempSchoolEndDate.value);
    } else if (methodID == 8) {
      setEditPageValue(ksAddWorkplace.tr, false, BipHip.officeFill, _profileController.companyNameTextEditingController, true, _profileController.designationTextEditingController, ksOfficeName.tr,
          true, true, false, true, ksCurrentlyWorkingHere.tr, 'ADD WORKPLACE', '', '');
    } else if (methodID == 9) {
      setEditPageValue(ksAddHomeTownAddress.tr, false, BipHip.location, _profileController.homeTownTextEditingController, false, _profileController.homeTownTextEditingController,
          ksEnterHometownAddress.tr, false, true, false, false, '', 'HOMETOWN', '', '');
    } else if (methodID == 10) {
      setEditPageValue(
          ksEditWorkplace.tr,
          false,
          BipHip.officeFill,
          _profileController.companyNameTextEditingController,
          true,
          _profileController.designationTextEditingController,
          ksEditWorkplace.tr,
          true,
          true,
          true,
          _profileController.isCurrentlyWorkingHere.value,
          ksCurrentlyWorkingHere.tr,
          'EDIT WORKPLACE',
          _profileController.tempWorkplaceStartDate.value,
          _profileController.tempWorkplaceEndDate.value);
      // Get.back();
    } else if (methodID == 11) {
      setEditPageValue(ksAddPhoneNumber.tr, false, BipHip.phoneFill, _profileController.phoneTextEditingController, false, _profileController.phoneTextEditingController, ksPhone.tr, false, true,
          false, false, '', 'ADD PHONE', '', '');
    } else if (methodID == 12) {
      setEditPageValue(ksEditPhone.tr, false, BipHip.phoneFill, _profileController.phoneTextEditingController, false, _profileController.phoneTextEditingController, ksEditPhone.tr, false, true,
          false, false, '', 'EDIT PHONE', '', '');
      // Get.back();
    } else if (methodID == 13) {
      setEditPageValue(ksAddEmail.tr, false, BipHip.mail, _profileController.emailTextEditingController, false, _profileController.emailTextEditingController, ksEmail.tr, false, true, false, false,
          '', 'ADD EMAIL', '', '');
    } else if (methodID == 14) {
      setEditPageValue(ksEditEmail.tr, false, BipHip.mail, _profileController.emailTextEditingController, false, _profileController.emailTextEditingController, ksEditEmail.tr, false, true, false,
          false, '', 'EDIT EMAIL', '', '');
      // Get.back();
    } else if (methodID == 15) {
      setEditPageValue(ksAddLink, true, BipHip.webLink, _profileController.linkTextEditingController, false, _profileController.emailTextEditingController, ksAddLink, false, true, false, false, '',
          'ADD LINK', '', '');
    } else if (methodID == 16) {
      setEditPageValue(ksEditLink.tr, true, _profileController.getLinkIcon(_profileController.linkSource.value), _profileController.linkTextEditingController, false, _profileController.linkTextEditingController, ksEditLink.tr, false,
          true, false, false, '', 'EDIT LINK', '', '');
      // Get.back();
    } else if (methodID == 17) {
      setEditPageValue(ksAddWorkplace.tr, false, BipHip.officeFill, _profileController.companyNameTextEditingController, true, _profileController.designationTextEditingController, ksOfficeName.tr,
          true, true, true, _profileController.isCurrentlyStudyingHere.value, ksCurrentlyWorkingHere.tr, 'ADD WORKPLACE', '', '');
    }
    Get.toNamed(krEdit);
  }
}
