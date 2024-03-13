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
      ),
    );
  }

  void kidInitialDataCoverPhoto() {
    if (kidsController.kidsData.value!.coverPhoto != null) {
      kidsController.kidViewOptionEnabled.value = true;
      kidsController.isKidProfilePhoto.value = false;
      kidsController.kidPreviewPhoto.value = kidsController.kidsData.value!.coverPhoto.toString();
    } else {
      kidsController.kidViewOptionEnabled.value = false;
    }
    kidsController.isKidProfilePicEditor.value = false;
  }

  void kidInitialDataProfilePicture() {
    if (kidsController.kidsData.value!.profilePicture != null) {
      kidsController.kidViewOptionEnabled.value = true;
      kidsController.isKidProfilePhoto.value = false;
      kidsController.kidPreviewPhoto.value = kidsController.kidsData.value!.profilePicture.toString();
    } else {
      kidsController.kidViewOptionEnabled.value = false;
    }
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
        ));
  }

  //* kid Bio edit
  void kidEditBio() {
    if (kidsController.kidsData.value!.bio == null) {
      kidsController.bioCount.value = 0;
      kidsController.kidBioEditingController.text = '';
      kidsController.kidBio.value = null;
    } else {
      //!Api Data
      kidsController.kidBio.value = kidsController.kidsData.value!.bio;
      kidsController.bioCount.value = kidsController.kidsData.value!.bio.length;
      kidsController.kidBioEditingController.text = kidsController.kidsData.value!.bio;
    }
    Get.toNamed(krKidEditBio);
  }

  void saveEditBio() async {
    kidsController.kidBio.value = kidsController.kidBioEditingController.text.trim();
    await kidsController.updateKidBio();
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
    kidsController.kidCommonEditIconData.value = iconData;
    kidsController.kidCommonEditTextEditingController = textEditingController;
    kidsController.isKidSecondaryTextfieldShown.value = showSecondaryTextfield;
    kidsController.kidCommonEditSecondaryTextEditingController = secondaryTextEditingController;
    kidsController.commonEditTextfieldHintText.value = textfieldHintText;
    kidsController.isCommonEditDatePickerShown.value = showDatePickerRow;
    kidsController.isCommonEditPrivacyShown.value = showEditPrivacy;
    kidsController.isCommonEditCheckBoxShown.value = showCheckBox;
    kidsController.isCommonEditCheckBoxSelected.value = checkBoxSelect;
    kidsController.commonEditCheckBoxText.value = checkBoxText;
    kidsController.kidFunctionFlag.value = function;
    kidsController.commonStartDate.value = startDate;
    kidsController.commonEndDate.value = endDate;
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
    }
    //  else if (functionFlag == 'EDIT COLLEGE') {
    //   // await profileController.updateCollege(profileController.collegeID.value);//!Api
    //   kidsController.kidEducationInstituteTextEditingController.clear();
    //   kidsController.kidCommonEditTextEditingController.clear();
    // }
    else if (functionFlag == 'ADD PHONE') {
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

  void checkCanKidSaveRelation() {
    if (kidsController.kidRelation.value != "") {
      kidsController.isKidRelationSaveButtonActive.value = true;
    } else {
      kidsController.isKidRelationSaveButtonActive.value = false;
    }
  }

  void resetKidRelationEditPage() {
    kidsController.temporaryKidRelationData.value = "";
    kidsController.kidRelationData.value = "";
    kidsController.temporaryKidRelationId.value = "";
    kidsController.kidRelationId.value = "";
    kidsController.isKidRelationSaveButtonActive.value = false;
    kidsController.kidRelationDataBottomSheetState.value = false;
  }

  void viewKidProfilePic() {
    if (kidsController.kidOverviewData.value?.kids?.profilePicture != null) {
      kidsController.isKidProfilePhoto.value = true;
      kidsController.kidViewOptionEnabled.value = true;
      kidsController.kidPreviewPhoto.value = kidsController.kidOverviewData.value!.kids!.profilePicture.toString();
      ll(kidsController.kidOverviewData.value!.kids!.profilePicture);
      Get.toNamed(krKidPhotoView);
    }
  }

  void viewKidCoverPhoto() {
    if (kidsController.kidOverviewData.value?.kids?.coverPhoto != null) {
      kidsController.kidViewOptionEnabled.value = true;
      kidsController.isKidProfilePhoto.value = false;
      kidsController.kidPreviewPhoto.value = kidsController.kidOverviewData.value!.kids!.coverPhoto.toString();
      ll(kidsController.kidPreviewPhoto.value);
      Get.toNamed(krKidPhotoView);
    }
  }

  void kidRelationButtonOnPressed(context) {
    kidsController.temporaryKidRelationData.value = kidsController.kidRelation.value!;
    kidsController.temporaryKidRelationId.value = kidsController.kidRelationId.value;
    if (kidsController.kidRelation.value != '') {
      kidsController.temporaryKidRelationData.value = kidsController.kidRelation.value!;
      kidsController.kidRelationDataBottomSheetState.value = true;
    } else {
      kidsController.temporaryKidRelationData.value = "";
      kidsController.kidRelationDataBottomSheetState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: kidsController.kidRelationDataBottomSheetState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        kidsController.kidRelationData.value = kidsController.temporaryKidRelationData.value;
        kidsController.kidRelationId.value = kidsController.temporaryKidRelationId.value;
        checkCanKidSaveRelation();
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksSelectRelation.tr,
      isRightButtonShow: true,
      content: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: kidsController.kidRelationMap.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: k10Padding),
            child: Obx(
              () => CustomListTile(
                itemColor: kidsController.temporaryKidRelationId.value == kidsController.kidRelationMap[index]['relation_id'] ? cPrimaryTint3Color : cWhiteColor,
                onPressed: () {
                  kidsController.temporaryKidRelationData.value = kidsController.kidRelationMap[index]['relation']!;
                  kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                  if (kidsController.temporaryKidRelationData.value == '') {
                    kidsController.kidRelationDataBottomSheetState.value = false;
                  } else {
                    kidsController.kidRelationDataBottomSheetState.value = true;
                  }
                },
                title: kidsController.kidRelationMap[index]['relation'],
                borderColor: kidsController.temporaryKidRelationId.value == kidsController.kidRelationMap[index]['relation_id'] ? cPrimaryColor : cLineColor,
                trailing: CustomRadioButton(
                  onChanged: () {
                    kidsController.temporaryKidRelationData.value = kidsController.kidRelationMap[index]['relation']!;
                    kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                    if (kidsController.temporaryKidRelationData.value == '') {
                      kidsController.kidRelationDataBottomSheetState.value = false;
                    } else {
                      kidsController.kidRelationDataBottomSheetState.value = true;
                    }
                  },
                  isSelected: kidsController.temporaryKidRelationId.value == kidsController.kidRelationMap[index]['relation_id'],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void selectKidGender(context) async {
    if (kidsController.kidGender.value != '') {
      kidsController.temporaryKidGender.value = kidsController.kidGender.value!;
      kidsController.kidGenderBottomSheetState.value = true;
    } else {
      kidsController.temporaryKidGender.value = '';
      kidsController.kidGenderBottomSheetState.value = false;
    }
    // profileController.isGenderListLoading.value = true;
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: kidsController.kidGenderBottomSheetState,
      context: context,
      content: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: kidsController.kidGenderList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: k12Padding),
                  child: Obx(
                    () => CustomListTile(
                      onPressed: () {
                        kidsController.temporaryKidGender.value = kidsController.kidGenderList[index].toString();
                        if (kidsController.temporaryKidGender.value == '') {
                          kidsController.kidGenderBottomSheetState.value = false;
                        } else {
                          kidsController.kidGenderBottomSheetState.value = true;
                        }
                      },
                      title: kidsController.kidGenderList[index].toString(),
                      titleTextStyle: regular16TextStyle(cBlackColor),
                      borderColor: kidsController.temporaryKidGender.value == kidsController.kidGenderList[index].toString() ? cPrimaryColor : cLineColor2,
                      itemColor: kidsController.temporaryKidGender.value == kidsController.kidGenderList[index].toString() ? cPrimaryTint3Color : cWhiteColor,
                      trailing: CustomRadioButton(
                        onChanged: () {
                          kidsController.temporaryKidGender.value = kidsController.kidGenderList[index];
                          if (kidsController.temporaryKidGender.value == '') {
                            kidsController.kidGenderBottomSheetState.value = false;
                          } else {
                            kidsController.kidGenderBottomSheetState.value = true;
                          }
                        },
                        isSelected: kidsController.temporaryKidGender.value == kidsController.kidGenderList[index],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        // profileController.isGenderListLoading.value = true;
        // if (profileController.temporarySelectedGender.value != '') {
        //   authenticationController.gender.value = profileController.temporarySelectedGender.value;
        //   profileController.isGenderSelected.value = true;
        // }
        kidsController.kidGender.value = kidsController.temporaryKidGender.value;
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksSelectGender.tr,
      isRightButtonShow: true,
      isScrollControlled: true,
      bottomSheetHeight: height * 0.4,
    );
    // await profileController.getGenderList();//!Api call
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

  void addKidEducationBackground() {
    resetTextEditor();
    getMethod(0);
    // kidsController.getSchoolList();//!Api call here
  }

  void editKidSchool(index) {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    // if (profileController.schoolDataList[index].started != null) {
    //   profileController.temporarySchoolStartDate.value = DateFormat("yyyy-MM-dd").format(profileController.schoolDataList[index].started!);
    // }
    // if (profileController.schoolDataList[index].ended != null) {
    //   profileController.temporarySchoolEndDate.value = DateFormat("yyyy-MM-dd").format(profileController.schoolDataList[index].ended!);
    // }
    // profileController.schoolID.value = profileController.schoolDataList[index].id!;
    // profileController.educationInstituteTextEditingController.text = profileController.schoolDataList[index].school!;
    // if (profileController.schoolDataList[index].graduated == 0) {
    //   profileController.isCurrentlyStudyingHere.value = true;
    // } else {
    //   profileController.isCurrentlyStudyingHere.value = false;
    // }
    //*For locally handle school list
    for (int i = 0; i < kidsController.kidSchoolList.length; i++) {
      kidsController.kidEducationInstituteTextEditingController.text = kidsController.kidSchoolList[i];
    }
    getMethod(1);
    // profileController.getSchoolList();//!Api call
  }

  void clearAddLanguagePage() {
    kidsController.kidSearchLanguageTextEditingController.clear();
    kidsController.addedLanguage.value = "";
    kidsController.isAddLanguageButtonEnabled.value = false;
    kidsController.isSearchLanguageSuffixIconShowing.value = false;
  }

  void checkCanAddLanguage() {
    if (kidsController.addedLanguage.value != "" && kidsController.kidSearchLanguageTextEditingController.text != "") {
      kidsController.isAddLanguageButtonEnabled.value = true;
    } else {
      kidsController.isAddLanguageButtonEnabled.value = false;
    }
  }

  String languageSorting(List languageList) {
    String result;

    switch (languageList.length) {
      case 0:
        result = '';
        break;
      case 1:
        result = languageList[0];
        break;
      case 2:
        result = '${languageList[0]} and ${languageList[1]}';
        break;
      default:
        result = languageList.sublist(0, languageList.length - 1).join(', ') + ' and ' + languageList.last;
    }
    return result;
  }
}
