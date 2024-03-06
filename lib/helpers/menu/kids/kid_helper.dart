import 'dart:io';

import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_picture_upload_content.dart';

//*kids
class KidHelper {
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();
  Widget totalKidShow() {
    if (kidsController.totalKidsCount.value == 0) {
      return const SizedBox();
    } else {
      return Text(
        '${ksTotalKids.tr}: ${kidsController.totalKidsCount.value}',
        style: semiBold14TextStyle(cBlackColor),
      );
    }
  }

  //*Edit Kids
  void checkCanEditKidInfo() {
    if ((kidsController.kidNameTextEditingController.text.trim() != '' &&
            kidsController.kidNameTextEditingController.text.trim() != kidsController.kidName.value &&
            kidsController.kidNameTextEditingController.text.trim().length > 2) ||
        (kidsController.kidAgeTextEditingController.text.trim() != '' &&
            kidsController.kidAgeTextEditingController.text.trim() != kidsController.kidAge.value &&
            kidsController.kidAgeTextEditingController.text.trim() != '0') ||
        kidsController.isKidImageChanged.value) {
      kidsController.isSaveKidButtonEnabled.value = true;
    } else {
      kidsController.isSaveKidButtonEnabled.value = false;
    }
  }

  void setupEditKid() {
    for (int i = 0; i < kidsController.kidList.length; i++) {
      if (kidsController.kidId.value == kidsController.kidList[i].id) {
        kidsController.kidNameTextEditingController.text = kidsController.kidList[i].name ?? '';
        kidsController.kidAgeTextEditingController.text = kidsController.kidList[i].age.toString();
        kidsController.kidImageLink.value = kidsController.kidList[i].profilePicture.toString();
        kidsController.kidName.value = kidsController.kidNameTextEditingController.text;
        kidsController.kidAge.value = kidsController.kidAgeTextEditingController.text;
      }
    }
    checkCanEditKidInfo();
  }

  void editKidImageFromCamera() async {
    await Get.find<GlobalController>()
        .selectImageSource(kidsController.isKidImageChanged, kidsController.kidImageLink, kidsController.kidImageFile, 'camera', true);
    checkCanEditKidInfo();
  }

  void editKidImageFromGallery() async {
    await Get.find<GlobalController>()
        .selectImageSource(kidsController.isKidImageChanged, kidsController.kidImageLink, kidsController.kidImageFile, 'gallery', true);
    checkCanEditKidInfo();
  }

  void kidEditButtonOnPressed() {
    kidsController.isSaveKidButtonEnabled.value = false;
    setupEditKid();
    Get.back();
  }

  void kidDeleteButtonOnPressed() async {
    Get.back();
    await kidsController.kidDelete();
  }
  //!Kid Profile

  void resetKidImage() {
    kidsController.profileImageFile.value = File('');
    kidsController.profileImageLink.value = '';
    kidsController.isProfileImageChanged.value = false;
    kidsController.isSharedToNewFeed.value = false;
    kidsController.coverImageFile.value = File('');
    kidsController.coverImageLink.value = '';
    kidsController.isCoverImageChanged.value = false;
  }

  //*Edit kid cover bottom sheet content
  void kidCoverPhotoUploadBottomSheet(context) {
    kidsController.isKidProfilePicEditor.value = false;
    // kidsController.kidViewOptionEnabled.value = false;
    resetKidImage();
    globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 170,
      content: KidPictureUploadContent(
        isImageChanged: kidsController.isCoverImageChanged,
        imagePath: kidsController.coverImageLink,
        imageFile: kidsController.coverImageFile,
        // isViewOptionEnabled: false.obs,
      ),
    );
  }

  //*Edit kid profile bottom sheet content
  void kidProfilePicUploadBottomSheet(context) {
    kidsController.isKidProfilePicEditor.value = true;
    kidsController.kidViewOptionEnabled.value = false;
    resetKidImage();
    globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 170,
      content: KidPictureUploadContent(
        isImageChanged: kidsController.isProfileImageChanged,
        imagePath: kidsController.profileImageLink,
        imageFile: kidsController.profileImageFile,
        // isViewOptionEnabled: false.obs,
      ),
    );
  }

  void kidInitialDataCoverPhoto() {
    // if (kidsController.userData.value!.coverPhoto != null) {
    //   profileController.viewOptionEnabled.value = true;
    //   profileController.isProfilePhoto.value = false;
    //   profileController.previewPhoto.value = profileController.userData.value!.coverPhoto.toString();
    // } else {
    // kidsController.viewOptionEnabled.value = false;//!correct
    kidsController.kidViewOptionEnabled.value = true;
    // }
    kidsController.isKidProfilePicEditor.value = false;
  }

  void kidInitialDataProfilePicture() {
    // if (kidsController.userData.value!.coverPhoto != null) {
    // kidsController.viewOptionEnabled.value = true;
    //   profileController.isProfilePhoto.value = false;
    //   profileController.previewPhoto.value = profileController.userData.value!.coverPhoto.toString();
    // } else {
    // kidsController.viewOptionEnabled.value = false;//!Correct
    kidsController.kidViewOptionEnabled.value = true;
    // }
    kidsController.isKidProfilePicEditor.value = true;
  }

  //* Kid cover photo bottom sheet content
  void kidCoverPhotoEditBottomSheet(context) {
    kidInitialDataCoverPhoto();
    resetKidImage();
    globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 210,
      content: KidPictureUploadContent(
        viewPhoto: ksViewCoverPhoto.tr,
        isImageChanged: kidsController.isCoverImageChanged,
        imagePath: kidsController.coverImageLink,
        imageFile: kidsController.coverImageFile,
        // isViewOptionEnabled: true.obs,
      ),
    );
  }

  void kidProfilePicEditBottomSheet(context) {
    kidInitialDataProfilePicture();
    resetKidImage();
    globalController.commonBottomSheet(
        context: context,
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {},
        rightText: '',
        rightTextStyle: regular14TextStyle(cBiddingColor),
        title: ksUploadImage.tr,
        isRightButtonShow: false,
        isScrollControlled: false,
        bottomSheetHeight: 210,
        content: KidPictureUploadContent(
          viewPhoto: ksViewProfilePicture.tr,
          isImageChanged: kidsController.isProfileImageChanged,
          imagePath: kidsController.profileImageLink,
          imageFile: kidsController.profileImageFile,
          // isViewOptionEnabled: true.obs,
        ));
  }

  //* kid Bio edit
  void kidEditBio() {
    if (kidsController.kidBio.value == null) {
      kidsController.bioCount.value = 0;
      kidsController.kidBioEditingController.text = '';
      kidsController.kidBio.value = '';
    } else {
      //!Api Data
      kidsController.kidBio.value = kidsController.kidBio.value;
      kidsController.bioCount.value = kidsController.kidBio.value!.length;
      kidsController.kidBioEditingController.text = kidsController.kidBio.value!;
    }
    Get.toNamed(krKidEditBio);
  }

  //*Hobbies select
  void setHobbies() async {
    // kidsController.hobbiesIndex.clear();
    Get.toNamed(krSelectHobbiesPage);
    // await profileController.getInterestList();//!Api call here
    //!Needed after api call
    // for (int j = 0; j < profileController.userData.value!.interest.length; j++) {
    //   for (int i = 0; i < globalController.interestList.length; i++) {
    //     if (globalController.interestList[i] == profileController.userData.value!.interest[j]) {
    //       globalController.interestIndex.add(i);
    //     }
    //   }
    // }
  }

  void onSelectHobbies(index) {
    if (!kidsController.hobbiesIndex.contains(index)) {
      kidsController.hobbiesIndex.add(index);
      kidsController.temporarySelectedHobbies.add(kidsController.allHobbiesList[index]);
    } else {
      kidsController.hobbiesIndex.remove(index);
      kidsController.temporarySelectedHobbies.remove(kidsController.allHobbiesList[index]);
    }
  }

  //* Common Edit page
  void commonSelectionButtonOnPressed(context) {
    // profileController.isLinkListLoading.value = true;
    kidsController.kidTemporaryEducationBackground.value = kidsController.kidEducationBackground.value;
    if (kidsController.kidTemporaryEducationBackground.value == '' &&
        (kidsController.kidCommonEditPageTitle.value == ksAddEducationalEvent ||
            kidsController.kidCommonEditPageTitle.value == ksEditSchool ||
            kidsController.kidCommonEditPageTitle.value == ksEditCollege)) {
      kidsController.editCommonSelectionBottomSheetRightButtonState.value = false;
    } else {
      kidsController.editCommonSelectionBottomSheetRightButtonState.value = true;
    }
    // commonSelectionBottomSheet(context);
  }

  //* profile edit methods
  void setEditPageValue(pageTitle, showDropDown, iconData, textEditingController, showSecondaryTextfield, secondaryTextEditingController, textfieldHintText,
      showDatePickerRow, showEditPrivacy, showCheckBox, checkBoxSelect, checkBoxText, function, startDate, endDate) {
    kidsController.kidCommonEditPageTitle.value = pageTitle;
    kidsController.isDropdownShown.value = showDropDown;
    // profileController.commonEditIconData.value = iconData;
    // profileController.commonEditTextEditingController = textEditingController;
    // profileController.isSecondaryTextfieldShown.value = showSecondaryTextfield;
    // profileController.commonEditSecondaryTextEditingController = secondaryTextEditingController;
    // profileController.commonEditTextfieldHintText.value = textfieldHintText;
    // profileController.isCommonEditDatePickerShown.value = showDatePickerRow;
    // profileController.isCommonEditPrivacyShown.value = showEditPrivacy;
    // profileController.isCommonEditCheckBoxShown.value = showCheckBox;
    // profileController.isCommonEditCheckBoxSelected.value = checkBoxSelect;
    // profileController.commonEditCheckBoxText.value = checkBoxText;
    // profileController.functionFlag.value = function;
    // profileController.commonStartDate.value = startDate;
    // profileController.commonEndDate.value = endDate;
  }

  void selectFunction(functionFlag, [index]) async {
    if (functionFlag == 'ADD SCHOOL') {
      if (kidsController.kidEducationBackground.value == 'School') {
        // await profileController.storeSchool();//!Api call
      } else {
        // await profileController.storeCollege();//!Api call
      }
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
      kidsController.kidEducationBackground.value = '';
    } else if (functionFlag == 'EDIT SCHOOL') {
      // await profileController.updateSchool(profileController.schoolID.value);//!Api call
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT COLLEGE') {
      // await profileController.updateCollege(profileController.collegeID.value);//!Api
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD PHONE') {
      // await profileController.storeContact('phone');//!Api
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT PHONE') {
      // await profileController.updateContact(profileController.phoneID.value, 'phone');//!Api
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD EMAIL') {
      // await profileController.storeContact('email');//!Api
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL') {
      // await profileController.updateContact(profileController.emailID.value, 'email');//!Api
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT SCHOOL DELETE') {
      // await profileController.deleteSchool(profileController.schoolID.value);//!Api
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT COLLEGE DELETE') {
      // await profileController.deleteCollege(profileController.collegeID.value);//!APi
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT PHONE DELETE') {
      // await profileController.deleteContact(profileController.phoneID.value);//!Api
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL DELETE') {
      // await profileController.deleteContact(profileController.emailID.value);//!Api
      kidsController.kidCommonEditTextEditingController.clear();
    }
  }

  void getMethod(methodID) {
    // profileController.showCommonEditSuffixIcon.value = false;
    // profileController.showCommonSecondaryEditSuffixIcon.value = false;
    if (methodID == 0) {
      setEditPageValue(
          ksAddEducationalEvent.tr,
          true,
          BipHip.schoolNew,
          kidsController.kidEducationInstituteTextEditingController,
          false,
          kidsController.kidEducationInstituteTextEditingController,
          'Institute name',
          true,
          true,
          true,
          kidsController.isKidCurrentlyStudyingHere.value,
          'Currently studying here',
          'ADD SCHOOL',
          '',
          '');
    } else if (methodID == 1) {
      setEditPageValue(
          ksEditSchool.tr,
          false,
          BipHip.schoolNew,
          kidsController.kidEducationInstituteTextEditingController,
          false,
          kidsController.kidEducationInstituteTextEditingController,
          ksEditSchool.tr,
          true,
          true,
          true,
          kidsController.isKidCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT SCHOOL',
          kidsController.temporaryKidSchoolStartDate.value,
          kidsController.temporaryKidSchoolEndDate.value);
    } else if (methodID == 2) {
      setEditPageValue(
          ksEditCollege.tr,
          false,
          BipHip.schoolNew,
          kidsController.kidEducationInstituteTextEditingController,
          false,
          kidsController.kidEducationInstituteTextEditingController,
          ksEditCollege.tr,
          true,
          true,
          true,
          kidsController.isKidCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT COLLEGE',
          kidsController.temporaryKidSchoolStartDate.value,
          kidsController.temporaryKidSchoolEndDate.value);
    } else if (methodID == 3) {
      setEditPageValue(ksAddPhoneNumber.tr, false, BipHip.phoneFill, kidsController.kidPhoneNumberTextEditingController, false,
          kidsController.kidPhoneNumberTextEditingController, ksPhone.tr, false, true, false, false, '', 'ADD PHONE', '', '');
    } else if (methodID == 4) {
      setEditPageValue(ksEditPhone.tr, false, BipHip.phoneFill, kidsController.kidPhoneNumberTextEditingController, false,
          kidsController.kidPhoneNumberTextEditingController, ksEditPhone.tr, false, true, false, false, '', 'EDIT PHONE', '', '');
      // Get.back();
    } else if (methodID == 5) {
      setEditPageValue(ksAddEmail.tr, false, BipHip.mail, kidsController.kidEmailTextEditingController, false, kidsController.kidEmailTextEditingController,
          ksEmail.tr, false, true, false, false, '', 'ADD EMAIL', '', '');
    } else if (methodID == 6) {
      setEditPageValue(ksEditEmail.tr, false, BipHip.mail, kidsController.kidEmailTextEditingController, false, kidsController.kidEmailTextEditingController,
          ksEditEmail.tr, false, true, false, false, '', 'EDIT EMAIL', '', '');
      // Get.back();
    }
    // else if (methodID == 15) {
    //   setEditPageValue(ksAddLink, true, BipHip.webLink, profileController.linkTextEditingController, false, profileController.emailTextEditingController,
    //       ksAddLink, false, true, false, false, '', 'ADD LINK', '', '');
    // } else if (methodID == 16) {
    //   setEditPageValue(ksEditLink.tr, true, getLinkIcon(profileController.linkSource.value), profileController.linkTextEditingController, false,
    //       profileController.linkTextEditingController, ksEditLink.tr, false, true, false, false, '', 'EDIT LINK', '', '');
    //   // Get.back();
    // } else if (methodID == 17) {
    //   setEditPageValue(
    //       ksAddWorkplace.tr,
    //       false,
    //       BipHip.officeFill,
    //       profileController.companyNameTextEditingController,
    //       true,
    //       profileController.designationTextEditingController,
    //       ksOfficeName.tr,
    //       true,
    //       true,
    //       true,
    //       profileController.isCurrentlyStudyingHere.value,
    //       ksCurrentlyWorkingHere.tr,
    //       'ADD WORKPLACE',
    //       '',
    //       '');
    // }
    Get.toNamed(krKidEditPage);
  }

  void resetTextEditor() {
    // profileController.temporaryListCommon.clear();
    kidsController.kidEducationInstituteTextEditingController.clear();
    // profileController.educationBackground.value = '';
    kidsController.kidPhoneNumberTextEditingController.clear();
    kidsController.kidEmailTextEditingController.clear();
    // profileController.commonEditPageIcon.value = null;
    kidsController.isKidCurrentlyStudyingHere.value = false;
    kidsController.enableKidSaveButton.value = false;
    kidsController.temporaryKidSchoolEndDate.value = '';
    kidsController.temporaryKidSchoolStartDate.value = '';
    // profileController.isSingleDatePicker.value = false;
  }

  //* kid Contact Section
  void kidAddPhone() {
    resetTextEditor();
    getMethod(3);
  }

  void editKidPhone(index) {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    // profileController.phoneID.value = profileController.contactDataList[index].id!;
    kidsController.kidPhoneNumberTextEditingController.text = kidsController.kidPhoneNumberList[index]!;
    getMethod(4);
  }

  void kidAddEmail() {
    resetTextEditor();
    getMethod(5);
  }

  void editKidEmail(index) {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    // profileController.emailID.value = profileController.contactDataList[index].id!;
    kidsController.kidEmailTextEditingController.text = kidsController.kidEmailList[index]!;
    getMethod(6);
  }
}
