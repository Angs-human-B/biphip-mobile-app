import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/shimmer/profile/gender_shimmer.dart';
import 'package:bip_hip/shimmer/profile/link_list_shimmer_view.dart';
import 'package:bip_hip/shimmer/profile/relation_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/edit_page_bottom_sheet_content.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/gender_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/relationship_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EditProfileHelper {
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final GlobalController globalController = Get.find<GlobalController>();

  void resetTextEditor() {
    profileController.tempListCommon.clear();
    profileController.homeTownTextEditingController.clear();
    profileController.presentAddressTextEditingController.clear();
    profileController.educationInstituteTextEditingController.clear();
    profileController.educationBackground.value = '';
    profileController.companyNameTextEditingController.clear();
    profileController.designationTextEditingController.clear();
    profileController.phoneTextEditingController.clear();
    profileController.emailTextEditingController.clear();
    profileController.linkTextEditingController.clear();
    profileController.commonEditPageIcon.value = null;
    profileController.isCurrentlyLiveHere.value = false;
    profileController.isCurrentlyStudyingHere.value = false;
    profileController.isCurrentlyWorkingHere.value = false;
    profileController.enableSaveButton.value = false;
    profileController.tempSchoolEndDate.value = '';
    profileController.tempSchoolStartDate.value = '';
    profileController.tempWorkplaceEndDate.value = '';
    profileController.tempWorkplaceStartDate.value = '';
    profileController.isSingleDatePicker.value = false;
  }

  //* profile edit methods
  void setEditPageValue(pageTitle, showDropDown, iconData, textEditingController, showSecondaryTextfield, secondaryTextEditingController, textfieldHintText,
      showDatePickerRow, showEditPrivacy, showCheckBox, checkBoxSelect, checkBoxText, function, startDate, endDate) {
    profileController.commonEditPageTitle.value = pageTitle;
    profileController.isDropdownShown.value = showDropDown;
    profileController.commonEditIconData.value = iconData;
    profileController.commonEditTextEditingController = textEditingController;
    profileController.isSecondaryTextfieldShown.value = showSecondaryTextfield;
    profileController.commonEditSecondaryTextEditingController = secondaryTextEditingController;
    profileController.commonEditTextfieldHintText.value = textfieldHintText;
    profileController.isCommonEditDatePickerShown.value = showDatePickerRow;
    profileController.isCommonEditPrivacyShown.value = showEditPrivacy;
    profileController.isCommonEditCheckBoxShown.value = showCheckBox;
    profileController.isCommonEditCheckBoxSelected.value = checkBoxSelect;
    profileController.commonEditCheckBoxText.value = checkBoxText;
    profileController.functionFlag.value = function;
    profileController.commonStartDate.value = startDate;
    profileController.commonEndDate.value = endDate;
  }

  void selectFunction(functionFlag, [index]) async {
    if (functionFlag == 'HOMETOWN') {
      await profileController.setHometown();
      profileController.homeTownTextEditingController.clear();
    } else if (functionFlag == 'EDIT HOMETOWN') {
      await profileController.setHometown();
      profileController.homeTownTextEditingController.clear();
    } else if (functionFlag == 'ADD PRESENT') {
      await profileController.setCity();
      profileController.commonEditTextEditingController.clear();
      profileController.presentAddressTextEditingController.clear();
    } else if (functionFlag == 'EDIT PRESENT') {
      await profileController.updateCity(profileController.cityID.value);
      profileController.presentAddressTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD SCHOOL') {
      if (profileController.educationBackground.value == 'School') {
        await profileController.storeSchool();
      } else {
        await profileController.storeCollege();
      }
      profileController.commonEditTextEditingController.clear();
      profileController.educationInstituteTextEditingController.clear();
      profileController.educationBackground.value = '';
    } else if (functionFlag == 'EDIT SCHOOL') {
      await profileController.updateSchool(profileController.schoolID.value);
      profileController.educationInstituteTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT COLLEGE') {
      await profileController.updateCollege(profileController.collegeID.value);
      profileController.educationInstituteTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD WORKPLACE') {
      await profileController.storeWork();
      profileController.companyNameTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
      profileController.commonEditSecondaryTextEditingController.clear();
      profileController.isCommonEditCheckBoxSelected.value = false;
    } else if (functionFlag == 'EDIT WORKPLACE') {
      await profileController.updateWork(profileController.officeID.value);
      profileController.companyNameTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
      profileController.commonEditSecondaryTextEditingController.clear();
      profileController.isCommonEditCheckBoxSelected.value = false;
    } else if (functionFlag == 'ADD PHONE') {
      await profileController.storeContact('phone');
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT PHONE') {
      await profileController.updateContact(profileController.phoneID.value, 'phone');
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD EMAIL') {
      await profileController.storeContact('email');
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL') {
      await profileController.updateContact(profileController.emailID.value, 'email');
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD LINK') {
      await profileController.storeLink(profileController.linkSource.value);
      profileController.linkTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
      profileController.linkSource.value = '';
    } else if (functionFlag == 'EDIT LINK') {
      await profileController.updateLink(profileController.linkID.value, profileController.linkSource.value);
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT HOMETOWN DELETE') {
      await profileController.deleteCity(profileController.hometownData.value!.id);
      profileController.homeTownTextEditingController.clear();
    } else if (functionFlag == 'EDIT PRESENT DELETE') {
      await profileController.deleteCity(profileController.cityID.value);
      profileController.commonEditTextEditingController.clear();
      profileController.presentAddressTextEditingController.clear();
    } else if (functionFlag == 'EDIT SCHOOL DELETE') {
      await profileController.deleteSchool(profileController.schoolID.value);
      profileController.educationInstituteTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT COLLEGE DELETE') {
      await profileController.deleteCollege(profileController.collegeID.value);
      profileController.educationInstituteTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT WORKPLACE DELETE') {
      await profileController.deleteWork(profileController.officeID.value);
      profileController.companyNameTextEditingController.clear();
      profileController.commonEditTextEditingController.clear();
      profileController.commonEditSecondaryTextEditingController.clear();
      profileController.isCommonEditCheckBoxSelected.value = false;
    } else if (functionFlag == 'EDIT PHONE DELETE') {
      await profileController.deleteContact(profileController.phoneID.value);
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL DELETE') {
      await profileController.deleteContact(profileController.emailID.value);
      profileController.commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT LINK DELETE') {
      await profileController.deleteLink(profileController.linkID.value);
      profileController.commonEditTextEditingController.clear();
    }
  }

  void getMethod(methodID) {
    profileController.showCommonEditSuffixIcon.value = false;
    profileController.showCommonSecondaryEditSuffixIcon.value = false;
    if (methodID == 0) {
      profileController.homeID.value = profileController.hometownData.value!.id!;
      profileController.homeTownTextEditingController.text = profileController.hometownData.value!.city!;
      setEditPageValue(ksEditHometownAddress.tr, false, BipHip.location, profileController.homeTownTextEditingController, false,
          profileController.homeTownTextEditingController, ksEditHometownAddress.tr, false, true, false, false, 'checkBoxText', 'EDIT HOMETOWN', '', '');
    } else if (methodID == 1) {
      setEditPageValue(ksAddPresentAddress.tr, false, BipHip.location, profileController.presentAddressTextEditingController, false,
          profileController.presentAddressTextEditingController, ksAddLocation.tr, false, true, false, true, ksCurrentlyLivingHere.tr, 'ADD PRESENT', '', '');
    } else if (methodID == 2) {
      profileController.presentAddressTextEditingController.text = profileController.currentCityData.value!.city!;
      setEditPageValue(
          ksEditPresentAddress.tr,
          false,
          BipHip.location,
          profileController.presentAddressTextEditingController,
          false,
          profileController.presentAddressTextEditingController,
          ksEditLocation.tr,
          false,
          true,
          false,
          profileController.isCurrentlyLiveHere.value,
          ksCurrentlyLivingHere.tr,
          'EDIT PRESENT',
          '',
          '');
    } else if (methodID == 3) {
      setEditPageValue(ksAddOtherAddress.tr, false, BipHip.location, profileController.presentAddressTextEditingController, false,
          profileController.presentAddressTextEditingController, ksAddLocation.tr, true, true, true, false, ksCurrentlyLivingHere.tr, 'ADD PRESENT', '', '');
    } else if (methodID == 4) {
      setEditPageValue(ksEditAddress.tr, false, BipHip.location, profileController.presentAddressTextEditingController, false,
          profileController.presentAddressTextEditingController, ksEditLocation.tr, true, true, true, false, ksCurrentlyLivingHere.tr, 'EDIT PRESENT', '', '');
    } else if (methodID == 5) {
      setEditPageValue(
          ksAddEducationalEvent.tr,
          true,
          BipHip.schoolNew,
          profileController.educationInstituteTextEditingController,
          false,
          profileController.educationInstituteTextEditingController,
          'Institute name',
          true,
          true,
          true,
          profileController.isCurrentlyStudyingHere.value,
          'Currently studying here',
          'ADD SCHOOL',
          '',
          '');
    } else if (methodID == 6) {
      setEditPageValue(
          ksEditSchool.tr,
          false,
          BipHip.schoolNew,
          profileController.educationInstituteTextEditingController,
          false,
          profileController.educationInstituteTextEditingController,
          ksEditSchool.tr,
          true,
          true,
          true,
          profileController.isCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT SCHOOL',
          profileController.tempSchoolStartDate.value,
          profileController.tempSchoolEndDate.value);
    } else if (methodID == 7) {
      setEditPageValue(
          ksEditCollege.tr,
          false,
          BipHip.schoolNew,
          profileController.educationInstituteTextEditingController,
          false,
          profileController.educationInstituteTextEditingController,
          ksEditCollege.tr,
          true,
          true,
          true,
          profileController.isCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT COLLEGE',
          profileController.tempSchoolStartDate.value,
          profileController.tempSchoolEndDate.value);
    } else if (methodID == 8) {
      setEditPageValue(ksAddWorkplace.tr, false, BipHip.officeFill, profileController.companyNameTextEditingController, true,
          profileController.designationTextEditingController, ksOfficeName.tr, true, true, false, true, ksCurrentlyWorkingHere.tr, 'ADD WORKPLACE', '', '');
    } else if (methodID == 9) {
      setEditPageValue(ksAddHomeTownAddress.tr, false, BipHip.location, profileController.homeTownTextEditingController, false,
          profileController.homeTownTextEditingController, ksEnterHometownAddress.tr, false, true, false, false, '', 'HOMETOWN', '', '');
    } else if (methodID == 10) {
      setEditPageValue(
          ksEditWorkplace.tr,
          false,
          BipHip.officeFill,
          profileController.companyNameTextEditingController,
          true,
          profileController.designationTextEditingController,
          ksEditWorkplace.tr,
          true,
          true,
          true,
          profileController.isCurrentlyWorkingHere.value,
          ksCurrentlyWorkingHere.tr,
          'EDIT WORKPLACE',
          profileController.tempWorkplaceStartDate.value,
          profileController.tempWorkplaceEndDate.value);
      // Get.back();
    } else if (methodID == 11) {
      setEditPageValue(ksAddPhoneNumber.tr, false, BipHip.phoneFill, profileController.phoneTextEditingController, false,
          profileController.phoneTextEditingController, ksPhone.tr, false, true, false, false, '', 'ADD PHONE', '', '');
    } else if (methodID == 12) {
      setEditPageValue(ksEditPhone.tr, false, BipHip.phoneFill, profileController.phoneTextEditingController, false,
          profileController.phoneTextEditingController, ksEditPhone.tr, false, true, false, false, '', 'EDIT PHONE', '', '');
      // Get.back();
    } else if (methodID == 13) {
      setEditPageValue(ksAddEmail.tr, false, BipHip.mail, profileController.emailTextEditingController, false, profileController.emailTextEditingController,
          ksEmail.tr, false, true, false, false, '', 'ADD EMAIL', '', '');
    } else if (methodID == 14) {
      setEditPageValue(ksEditEmail.tr, false, BipHip.mail, profileController.emailTextEditingController, false, profileController.emailTextEditingController,
          ksEditEmail.tr, false, true, false, false, '', 'EDIT EMAIL', '', '');
      // Get.back();
    } else if (methodID == 15) {
      setEditPageValue(ksAddLink, true, BipHip.webLink, profileController.linkTextEditingController, false, profileController.emailTextEditingController,
          ksAddLink, false, true, false, false, '', 'ADD LINK', '', '');
    } else if (methodID == 16) {
      setEditPageValue(ksEditLink.tr, true, getLinkIcon(profileController.linkSource.value), profileController.linkTextEditingController, false,
          profileController.linkTextEditingController, ksEditLink.tr, false, true, false, false, '', 'EDIT LINK', '', '');
      // Get.back();
    } else if (methodID == 17) {
      setEditPageValue(
          ksAddWorkplace.tr,
          false,
          BipHip.officeFill,
          profileController.companyNameTextEditingController,
          true,
          profileController.designationTextEditingController,
          ksOfficeName.tr,
          true,
          true,
          true,
          profileController.isCurrentlyStudyingHere.value,
          ksCurrentlyWorkingHere.tr,
          'ADD WORKPLACE',
          '',
          '');
    }
    Get.toNamed(krEdit);
  }

  IconData getLinkIcon(String type) {
    if (type.toLowerCase() == "facebook") {
      return BipHip.facebook;
    } else if (type.toLowerCase() == "linkedin") {
      return BipHip.linkedin;
    } else if (type.toLowerCase() == "twitter") {
      return BipHip.twitterX;
    } else if (type.toLowerCase() == "instagram") {
      return BipHip.instagram;
    } else if (type.toLowerCase() == "twitch") {
      return BipHip.twitchFill;
    } else if (type.toLowerCase() == "youtube") {
      return BipHip.youtube;
    } else if (type.toLowerCase() == "snapchat") {
      return BipHip.snapchatFill;
    } else if (type.toLowerCase() == "whatsapp") {
      return BipHip.whatsappFill;
    } else {
      return BipHip.webLink;
    }
  }

  void resetEditAboutPage() {
    profileController.isGenderSelected.value = false;
    profileController.showEditRelationshipStatus.value = false;
    profileController.relationshipStatus.value = '';
    profileController.tempSelectedGender.value = '';
    profileController.selectedGender.value = '';
  }

  void checkSaveButtonActive() {
    if (profileController.functionFlag.value.contains('LINK')) {
      if (profileController.commonEditTextEditingController.text.trim() != '' && profileController.linkSource.value != '') {
        profileController.enableSaveButton.value = true;
      } else {
        profileController.enableSaveButton.value = false;
      }
    } else if (profileController.functionFlag.value == 'ADD SCHOOL') {
      if (profileController.commonEditTextEditingController.text.trim() != '' && profileController.educationBackground.value != '') {
        profileController.enableSaveButton.value = true;
      } else {
        profileController.enableSaveButton.value = false;
      }
    } else if (profileController.functionFlag.value.contains('EMAIL')) {
      if (profileController.commonEditTextEditingController.text.trim() != '' && profileController.commonEditTextEditingController.text.isValidEmail) {
        profileController.enableSaveButton.value = true;
      } else {
        profileController.enableSaveButton.value = false;
      }
    } else if (profileController.functionFlag.value.contains('WORKPLACE')) {
      if (profileController.commonEditTextEditingController.text.trim() != '') {
        if (!profileController.isCommonEditCheckBoxSelected.value) {
          if (profileController.commonStartDate.value == '' && profileController.commonEndDate.value == '') {
            profileController.enableSaveButton.value = true;
          } else if (profileController.commonStartDate.value != '' && profileController.commonEndDate.value == '') {
            profileController.enableSaveButton.value = false;
          } else if (profileController.commonStartDate.value != '' && profileController.commonEndDate.value != '') {
            profileController.enableSaveButton.value = true;
          } else if (profileController.commonStartDate.value == '' && profileController.commonEndDate.value != '') {
            profileController.enableSaveButton.value = false;
          }
        } else {
          if (profileController.commonStartDate.value != '') {
            profileController.enableSaveButton.value = true;
          } else {
            profileController.enableSaveButton.value = false;
          }
        }
      } else {
        profileController.enableSaveButton.value = false;
      }
    } else {
      if (profileController.commonEditTextEditingController.text.trim() != '') {
        profileController.enableSaveButton.value = true;
      } else {
        profileController.enableSaveButton.value = false;
      }
    }
  }

  //* Place Edit Methods
  void setHometown() {
    resetTextEditor();
    profileController.getCityList();
    getMethod(9);
  }

  void editHometown() {
    profileController.enableSaveButton.value = true;
    getMethod(0);
    profileController.getCityList();
  }

  void setCurrentCity() {
    resetTextEditor();
    getMethod(1);
    Get.toNamed(krEdit);
    profileController.getCityList();
  }

  void editCurrentCity() {
    profileController.enableSaveButton.value = true;
    profileController.isCurrentlyLiveHere.value = true;
    profileController.cityID.value = profileController.currentCityData.value!.id!;
    getMethod(2);
    profileController.getCityList();
  }

  void setOtherCity() {
    resetTextEditor();
    profileController.isSingleDatePicker.value = true;
    getMethod(3);
    Get.toNamed(krEdit);
    profileController.getCityList();
  }

  void editOtherCity(index) {
    profileController.cityID.value = profileController.otherCityList[index].id!;
    profileController.presentAddressTextEditingController.text = profileController.otherCityList[index].city!;
    profileController.enableSaveButton.value = true;
    profileController.isSingleDatePicker.value = true;
    getMethod(4);
    profileController.getCityList();
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
    resetTextEditor();
    getMethod(5);
    profileController.getSchoolList();
  }

  void editSchool(index) {
    resetTextEditor();
    profileController.enableSaveButton.value = true;
    if (profileController.schoolDataList[index].started != null) {
      profileController.tempSchoolStartDate.value = DateFormat("yyyy-MM-dd").format(profileController.schoolDataList[index].started!);
    }
    if (profileController.schoolDataList[index].ended != null) {
      profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(profileController.schoolDataList[index].ended!);
    }
    profileController.schoolID.value = profileController.schoolDataList[index].id!;
    profileController.educationInstituteTextEditingController.text = profileController.schoolDataList[index].school!;
    if (profileController.schoolDataList[index].graduated == 0) {
      profileController.isCurrentlyStudyingHere.value = true;
    } else {
      profileController.isCurrentlyStudyingHere.value = false;
    }
    getMethod(6);
    profileController.getSchoolList();
  }

  void editCollege(index) {
    resetTextEditor();
    profileController.enableSaveButton.value = true;
    if (profileController.collegeDataList[index].started != null) {
      profileController.tempSchoolStartDate.value = DateFormat("yyyy-MM-dd").format(profileController.collegeDataList[index].started!);
    }
    if (profileController.collegeDataList[index].ended != null) {
      profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(profileController.collegeDataList[index].ended!);
    }
    profileController.collegeID.value = profileController.collegeDataList[index].id!;
    profileController.educationInstituteTextEditingController.text = profileController.collegeDataList[index].school!;
    if (profileController.collegeDataList[index].graduated == 0) {
      profileController.isCurrentlyStudyingHere.value = true;
    } else {
      profileController.isCurrentlyStudyingHere.value = false;
    }
    getMethod(7);
    profileController.getSchoolList();
  }

  //* Relationship Section
  void setRelationshipStatus(context) async {
    profileController.isRelationListLoading.value = true;
    profileController.tempRelationshipStatus.value = '';
    if (profileController.relationshipStatus.value != '') {
      profileController.tempRelationshipStatus.value = profileController.relationshipStatus.value;
    } else if (profileController.userData.value!.relation != null) {
      profileController.tempRelationshipStatus.value = checkNullOrStringNull(profileController.userData.value!.relation);
    }
    if (profileController.tempRelationshipStatus.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      globalController.isBottomSheetRightButtonActive.value = true;
    }
    relationshipBottomSheet(context);
    await profileController.getRelationshipList();
  }

  void relationshipBottomSheet(context) {
    globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => profileController.isRelationListLoading.value
            ? const RelationshipStatusListShimmer()
            : RelationshipStatusListContent(
                profileController: profileController,
              ),
      ),
      isScrollControlled: true,
      bottomSheetHeight: height * 0.6,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (profileController.tempRelationshipStatus.value != '') {
          profileController.relationshipStatus.value = profileController.tempRelationshipStatus.value;
          profileController.showEditRelationshipStatus.value = true;
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
    profileController.relationshipStatus.value = '';
    profileController.showEditRelationshipStatus.value = false;
  }

  void saveRelationshipStatus() async {
    await profileController.storeUserSetting('relationship', profileController.relationshipStatus.value);
    profileController.showEditRelationshipStatus.value = false;
    profileController.relationshipStatus.value = '';
  }

  void selectBottomSheetRelationshipContent(index) {
    profileController.tempRelationshipStatus.value = profileController.relationshipStatusList[index];
    if (profileController.tempRelationshipStatus.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      globalController.isBottomSheetRightButtonActive.value = true;
    }
  }

  //* Gender Section
  void selectGender(context) async {
    profileController.isGenderListLoading.value = true;
    profileController.tempSelectedGender.value = checkNullOrStringNull(profileController.userData.value!.gender);
    if (profileController.selectedGender.value != '') {
      profileController.tempSelectedGender.value = profileController.selectedGender.value;
    }
    genderBottomSheet(context);
    await profileController.getGenderList();
  }

  void genderBottomSheet(context) {
    globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => profileController.isGenderListLoading.value
            ? const GenderListShimmer()
            : GenderListContent(
                profileController: profileController,
              ),
      ),
      isScrollControlled: true,
      bottomSheetHeight: isDeviceScreenLarge() ? 255 : 240,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (profileController.tempSelectedGender.value != '') {
          profileController.selectedGender.value = profileController.tempSelectedGender.value;
          profileController.isGenderSelected.value = true;
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
    profileController.selectedGender.value = '';
    profileController.isGenderSelected.value = false;
  }

  void saveGender() async {
    await profileController.storeUserSetting('gender', profileController.selectedGender.value);
    profileController.selectedGender.value = '';
    profileController.isGenderSelected.value = false;
  }

  //* Birthday Section
  void editBirthday() {
    authenticationController.birthDay.value = DateFormat("yyyy-MM-dd").format(profileController.userData.value!.dob!);
    profileController.isRouteFromAboutInfo.value = true;
    Get.toNamed(krSelectBirthday);
  }

  //* Profession Section
  void setProfession() async {
    profileController.isRouteFromAboutInfo.value = true;
    globalController.professionIndex.value = -1;
    Get.toNamed(krSelectProfession);
    await profileController.getProfessionList();
  }

  void editProfession() async {
    globalController.professionIndex.value = -1;
    profileController.isRouteFromAboutInfo.value = true;
    Get.toNamed(krSelectProfession);
    await profileController.getProfessionList();
    for (int i = 0; i < globalController.professionList.length; i++) {
      if (globalController.professionList[i] == profileController.userData.value!.profession[0]) {
        globalController.professionIndex.value = i;
      }
    }
  }

  //* Interest section
  void setInterest() async {
    globalController.interestIndex.clear();
    profileController.isRouteFromAboutInfo.value = true;
    Get.toNamed(krSelectInterest);
    await profileController.getInterestList();
    for (int j = 0; j < profileController.userData.value!.interest.length; j++) {
      for (int i = 0; i < globalController.interestList.length; i++) {
        if (globalController.interestList[i] == profileController.userData.value!.interest[j]) {
          globalController.interestIndex.add(i);
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
    resetTextEditor();
    profileController.isSingleDatePicker.value = true;
    getMethod(8);
    profileController.getCompanyList();
    profileController.getPositionList();
  }

  void editCurrentWorkplace() {
    resetTextEditor();
    profileController.isSingleDatePicker.value = true;
    profileController.enableSaveButton.value = true;
    if (profileController.currentWorkplace.value!.started != null) {
      profileController.tempWorkplaceStartDate.value = DateFormat("yyyy-MM-dd").format(profileController.currentWorkplace.value!.started!);
    }
    if (profileController.currentWorkplace.value!.ended != null) {
      profileController.tempWorkplaceEndDate.value = DateFormat("yyyy-MM-dd").format(profileController.currentWorkplace.value!.ended!);
    }
    profileController.officeID.value = profileController.currentWorkplace.value!.id!;
    profileController.companyNameTextEditingController.text = profileController.currentWorkplace.value!.company!;
    profileController.designationTextEditingController.text = profileController.currentWorkplace.value!.position ?? '';
    if (profileController.currentWorkplace.value!.isCurrent == 1) {
      profileController.isCurrentlyWorkingHere.value = true;
    } else {
      profileController.isCurrentlyWorkingHere.value = false;
    }
    getMethod(10);
    profileController.getCompanyList();
    profileController.getPositionList();
  }

  void addPreviousWorkplace() {
    resetTextEditor();
    getMethod(17);
    profileController.getCompanyList();
    profileController.getPositionList();
  }

  void editPreviousWorkplace(index) {
    resetTextEditor();
    profileController.enableSaveButton.value = true;
    profileController.getCompanyList();
    profileController.getPositionList();
    if (profileController.workplaceDataList[index].started != null) {
      profileController.tempWorkplaceStartDate.value = DateFormat("yyyy-MM-dd").format(profileController.workplaceDataList[index].started!);
    }
    if (profileController.workplaceDataList[index].ended != null) {
      profileController.tempWorkplaceEndDate.value = DateFormat("yyyy-MM-dd").format(profileController.workplaceDataList[index].ended!);
    }
    profileController.officeID.value = profileController.workplaceDataList[index].id!;
    profileController.companyNameTextEditingController.text = profileController.workplaceDataList[index].company!;
    profileController.designationTextEditingController.text = profileController.workplaceDataList[index].position ?? '';
    if (profileController.workplaceDataList[index].isCurrent == 1) {
      profileController.isCurrentlyWorkingHere.value = true;
    } else {
      profileController.isCurrentlyWorkingHere.value = false;
    }
    getMethod(10);
  }

  //* Contact Section
  void addPhone() {
    resetTextEditor();
    getMethod(11);
  }

  void editPhone(index) {
    resetTextEditor();
    profileController.enableSaveButton.value = true;
    profileController.phoneID.value = profileController.contactDataList[index].id!;
    profileController.phoneTextEditingController.text = profileController.contactDataList[index].value!;
    getMethod(12);
  }

  void addEmail() {
    resetTextEditor();
    getMethod(13);
  }

  void editEmail(index) {
    resetTextEditor();
    profileController.enableSaveButton.value = true;
    profileController.emailID.value = profileController.contactDataList[index].id!;
    profileController.emailTextEditingController.text = profileController.contactDataList[index].value!;
    getMethod(14);
  }

  //* Website Section
  void addWebsite() {
    resetTextEditor();
    profileController.linkSource.value = '';
    profileController.commonEditPageIcon.value = null;
    getMethod(15);
  }

  void editWebsite(index) {
    resetTextEditor();
    profileController.enableSaveButton.value = true;
    profileController.commonEditPageIcon.value = null;
    profileController.linkTextEditingController.text = profileController.linkDataList[index].link!;
    profileController.linkID.value = profileController.linkDataList[index].id!;
    profileController.linkSource.value = profileController.linkDataList[index].type!;
    getMethod(16);
  }

  //* Common Edit page
  void commonSelectionButtonOnPressed(context) {
    profileController.isLinkListLoading.value = true;
    profileController.tempLinkSource.value = profileController.linkSource.value;
    profileController.tempEducationBackground.value = profileController.educationBackground.value;
    if (profileController.tempLinkSource.value == '' &&
        (profileController.commonEditPageTitle.value == ksAddLink || profileController.commonEditPageTitle.value == ksEditLink)) {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else if (profileController.tempEducationBackground.value == '' &&
        (profileController.commonEditPageTitle.value == ksAddEducationalEvent ||
            profileController.commonEditPageTitle.value == ksEditSchool ||
            profileController.commonEditPageTitle.value == ksEditCollege)) {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      globalController.isBottomSheetRightButtonActive.value = true;
    }
    commonSelectionBottomSheet(context);
    profileController.getLinkList();
  }

  void commonSelectionBottomSheet(context) {
    globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => (profileController.commonEditPageTitle.value == ksAddLink || profileController.commonEditPageTitle.value == ksEditLink)
            ? (profileController.isLinkListLoading.value ? const LinkListContentShimmer() : LinkListContent(profileController: profileController))
            : EducationBackgroundContent(
                profileController: profileController,
              ),
      ),
      isScrollControlled: true,
      bottomSheetHeight:
          (profileController.commonEditPageTitle.value == ksAddLink || profileController.commonEditPageTitle.value == ksEditLink) ? height * 0.9 : 200,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (profileController.commonEditPageTitle.value == ksAddLink || profileController.commonEditPageTitle.value == ksEditLink) {
          profileController.linkSource.value = profileController.tempLinkSource.value;
          profileController.commonEditPageIcon.value = getLinkIcon(profileController.linkSource.value);
        } else {
          profileController.educationBackground.value = profileController.tempEducationBackground.value;
        }
        checkSaveButtonActive();
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: (profileController.commonEditPageTitle.value == ksAddLink || profileController.commonEditPageTitle.value == ksEditLink)
          ? ksSelectLinkSource.tr
          : ksSelectEducationInstitute.tr,
      isRightButtonShow: true,
    );
  }

  void commonTextfieldSuffixOnPressed() {
    profileController.commonEditTextEditingController.clear();
    profileController.showCommonEditSuffixIcon.value = false;
    checkSaveButtonActive();
  }

  void commonTextfieldOnChanged() {
    if (profileController.commonEditTextEditingController.text != '') {
      profileController.showCommonEditSuffixIcon.value = true;
    } else {
      profileController.showCommonEditSuffixIcon.value = false;
    }
    if (profileController.commonEditTextfieldHintText.value == ksEmail.tr || profileController.commonEditTextfieldHintText.value == ksEditEmail.tr) {
      if (!profileController.commonEditTextEditingController.text.isValidEmail) {
        profileController.commonEditTextFieldErrorText.value = ksInvalidEmailErrorMessage.tr;
      } else {
        profileController.commonEditTextFieldErrorText.value = '';
      }
    }
    checkSaveButtonActive();
  }

  void commonSecondaryTextfieldSuffixOnPressed() {
    profileController.commonEditSecondaryTextEditingController.clear();
    checkSaveButtonActive();
    profileController.showCommonSecondaryEditSuffixIcon.value = false;
  }

  void commonSecondaryTextfieldOnChanged() {
    checkSaveButtonActive();
    if (profileController.commonEditSecondaryTextEditingController.text.isNotEmpty) {
      profileController.showCommonSecondaryEditSuffixIcon.value = true;
    } else {
      profileController.showCommonSecondaryEditSuffixIcon.value = false;
    }
  }

  void startDateButtonOnPressed(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: height * 0.4,
          child: CupertinoDatePicker(
            initialDateTime: profileController.commonStartDate.value != '' ? DateTime.parse(profileController.commonStartDate.value) : DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              profileController.commonStartDate.value = DateFormat("yyyy-MM-dd").format(value);
              checkSaveButtonActive();
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
            initialDateTime: profileController.commonEndDate.value != '' ? DateTime.parse(profileController.commonEndDate.value) : DateTime.now(),
            onDateTimeChanged: (value) {
              profileController.commonEndDate.value = DateFormat("yyyy-MM-dd").format(value);
              checkSaveButtonActive();
            },
          ),
        );
      },
    );
  }

  void commonCheckBoxOnChanged() {
    profileController.isCommonEditCheckBoxSelected.value = !profileController.isCommonEditCheckBoxSelected.value;
    if (!profileController.functionFlag.contains('PRESENT')) {
      if (profileController.isCommonEditCheckBoxSelected.value) {
        profileController.isSingleDatePicker.value = true;
        profileController.commonEndDate.value = '';
      } else {
        profileController.isSingleDatePicker.value = false;
      }
    }
    checkSaveButtonActive();
  }

  void onSelectEducationBottomSheet(index) {
    profileController.tempEducationBackground.value = profileController.educationBackgroundList[index];
    if (profileController.tempEducationBackground.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      globalController.isBottomSheetRightButtonActive.value = true;
    }
  }

  void onSelectLinkBottomSheet(index) {
    profileController.tempLinkSource.value = profileController.linkSourceList[index];
    if (profileController.tempLinkSource.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      globalController.isBottomSheetRightButtonActive.value = true;
    }
  }
}
