import 'dart:io';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/kid_overview_model.dart';
import 'package:bip_hip/shimmers/menu/family/relation_content_shimmer.dart';
import 'package:bip_hip/shimmers/profile/gender_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_picture_upload_content.dart';
import 'package:bip_hip/views/menu/kids/widgets/kids_all_relation_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
      //*Api Data
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
    kidsController.temporarySelectedHobbies.clear();
    kidsController.hobbiesIndex.clear();
    await kidsController.getAllHobbiesList();
    Get.toNamed(krSelectHobbiesPage);
    kidsController.temporarySelectedHobbies.addAll(kidsController.kidsData.value!.hobbies);
  }

  void onSelectHobbies(index) {
    if (kidsController.temporarySelectedHobbies.contains(kidsController.temporaryHobbiesList[index])) {
      kidsController.hobbiesIndex.remove(index);
      kidsController.temporarySelectedHobbies.remove(kidsController.temporaryHobbiesList[index]);
    } else {
      kidsController.hobbiesIndex.add(index);
      kidsController.temporarySelectedHobbies.add(kidsController.temporaryHobbiesList[index]);
    }
  }

  //* Common Edit page
  void commonSelectionButtonOnPressed(context) {
    kidsController.kidTemporaryEducationBackground.value = kidsController.kidEducationBackground.value;
    if (kidsController.kidTemporaryEducationBackground.value == '' &&
        (kidsController.kidCommonEditPageTitle.value == ksAddEducationalEvent ||
            kidsController.kidCommonEditPageTitle.value == ksEditSchool ||
            kidsController.kidCommonEditPageTitle.value == ksEditCollege)) {
      kidsController.editCommonSelectionBottomSheetRightButtonState.value = false;
    } else {
      kidsController.editCommonSelectionBottomSheetRightButtonState.value = true;
    }
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
      await kidsController.storeSchool();
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
      kidsController.kidEducationBackground.value = '';
    } else if (functionFlag == 'EDIT SCHOOL') {
      await kidsController.updateSchool(kidsController.schoolID.value);
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
    }
    else if (functionFlag == 'ADD PHONE') {
      await kidsController.storeContact('phone');
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT PHONE') {
      await kidsController.updateContact(kidsController.phoneID.value, 'phone');
      kidsController.kidCommonEditTextEditingController.clear();
    }  else if (functionFlag == 'ADD EMAIL') {
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL') {
      await kidsController.updateContact(kidsController.emailID.value, 'email');
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT SCHOOL DELETE') {
      await kidsController.deleteSchool(kidsController.schoolID.value);
      kidsController.kidEducationInstituteTextEditingController.clear();
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT PHONE DELETE') {
      kidsController.kidCommonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL DELETE') {
      kidsController.kidCommonEditTextEditingController.clear();
    }
  }

  void getMethod(methodID) {
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
      setEditPageValue(ksAddPhoneNumber.tr, false, BipHip.phoneFill, kidsController.kidPhoneNumberTextEditingController, false,
          kidsController.kidPhoneNumberTextEditingController, ksPhone.tr, false, true, false, false, '', 'ADD PHONE', '', '');
    } else if (methodID == 3) {
      setEditPageValue(ksEditPhone.tr, false, BipHip.phoneFill, kidsController.kidPhoneNumberTextEditingController, false,
          kidsController.kidPhoneNumberTextEditingController, ksEditPhone.tr, false, true, false, false, '', 'EDIT PHONE', '', '');
    } else if (methodID == 4) {
      setEditPageValue(ksAddEmail.tr, false, BipHip.mail, kidsController.kidEmailTextEditingController, false, kidsController.kidEmailTextEditingController,
          ksEmail.tr, false, true, false, false, '', 'ADD EMAIL', '', '');
    } else if (methodID == 5) {
      setEditPageValue(ksEditEmail.tr, false, BipHip.mail, kidsController.kidEmailTextEditingController, false, kidsController.kidEmailTextEditingController,
          ksEditEmail.tr, false, true, false, false, '', 'EDIT EMAIL', '', '');
    }
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
    kidsController.temporaryRelation.value = "";
    kidsController.kidRelation.value = "";
    kidsController.kidRelationId.value = -1;
    kidsController.isKidRelationSaveButtonActive.value = false;
    kidsController.relationBottomSheetRightButtonState.value = false;
  }

  void viewKidProfilePic() {
    if (kidsController.kidOverviewData.value?.kids?.profilePicture != null) {
      kidsController.isKidProfilePhoto.value = true;
      kidsController.kidViewOptionEnabled.value = true;
      kidsController.kidPreviewPhoto.value = kidsController.kidOverviewData.value!.kids!.profilePicture.toString();
      Get.toNamed(krKidPhotoView);
    }
  }

  void viewKidCoverPhoto() {
    if (kidsController.kidOverviewData.value?.kids?.coverPhoto != null) {
      kidsController.kidViewOptionEnabled.value = true;
      kidsController.isKidProfilePhoto.value = false;
      kidsController.kidPreviewPhoto.value = kidsController.kidOverviewData.value!.kids!.coverPhoto.toString();
      Get.toNamed(krKidPhotoView);
    }
  }

  void kidRelationButtonOnPressed(context) {
    kidsController.temporaryRelation.value = kidsController.kidRelation.value!;
    if (kidsController.kidRelation.value != '') {
      kidsController.temporaryRelation.value = kidsController.kidRelation.value!;
      kidsController.relationBottomSheetRightButtonState.value = true;
    } else {
      kidsController.temporaryRelation.value = "";
      kidsController.relationBottomSheetRightButtonState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: kidsController.relationBottomSheetRightButtonState,
      context: context,
      bottomSheetHeight: height * 0.9,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        kidsController.kidRelation.value = kidsController.temporaryRelation.value;
        for (int index = 0; index < kidsController.relationList.length; index++) {
          if (kidsController.temporaryRelation.value == kidsController.relationList[index].name) {
            kidsController.kidRelationId.value = kidsController.relationList[index].id;
          }
        }
        checkCanKidSaveRelation();
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksSelectRelation.tr,
      isRightButtonShow: true,
      content: Obx(() => kidsController.isRelationListLoading.value ? const RelationContentShimmer() : KidsAllRelationContent()),
    );
  }

  void selectKidGender(context) async {
    if (kidsController.kidGender.value != '') {
      kidsController.temporaryKidGender.value = kidsController.kidGender.value ?? "";
      kidsController.kidGenderBottomSheetState.value = true;
    } else {
      kidsController.temporaryKidGender.value = '';
      kidsController.kidGenderBottomSheetState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: kidsController.kidGenderBottomSheetState,
      context: context,
      content: Obx(() => kidsController.isGenderListLoading.value
          ? const GenderListShimmer()
          : Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: kidsController.genderList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: k12Padding),
                        child: Obx(() => CustomListTile(
                              onPressed: () {
                                kidsController.temporaryKidGender.value = kidsController.genderList[index].toString();
                                if (kidsController.temporaryKidGender.value == '') {
                                  kidsController.kidGenderBottomSheetState.value = false;
                                } else {
                                  kidsController.kidGenderBottomSheetState.value = true;
                                }
                              },
                              title: kidsController.genderList[index].toString(),
                              titleTextStyle: regular16TextStyle(cBlackColor),
                              borderColor: kidsController.temporaryKidGender.value == kidsController.genderList[index].toString() ? cPrimaryColor : cLineColor2,
                              itemColor:
                                  kidsController.temporaryKidGender.value == kidsController.genderList[index].toString() ? cPrimaryTint3Color : cWhiteColor,
                              trailing: CustomRadioButton(
                                onChanged: () {
                                  kidsController.temporaryKidGender.value = kidsController.genderList[index];
                                  if (kidsController.temporaryKidGender.value == '') {
                                    kidsController.kidGenderBottomSheetState.value = false;
                                  } else {
                                    kidsController.kidGenderBottomSheetState.value = true;
                                  }
                                },
                                isSelected: kidsController.temporaryKidGender.value == kidsController.genderList[index],
                              ),
                            )),
                      );
                    }),
              ],
            )),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        kidsController.isGenderListLoading.value = true;
        if (kidsController.temporaryKidGender.value != '') {
          kidsController.kidGender.value = kidsController.temporaryKidGender.value;
          kidsController.isKidGenderSelected.value = true;
        }
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
    await kidsController.getKidGenderList();
  }

  void resetTextEditor() {
    kidsController.kidEducationInstituteTextEditingController.clear();
    kidsController.kidPhoneNumberTextEditingController.clear();
    kidsController.kidEmailTextEditingController.clear();
    kidsController.isKidCurrentlyStudyingHere.value = false;
    kidsController.enableKidSaveButton.value = false;
    kidsController.temporaryKidSchoolEndDate.value = '';
    kidsController.temporaryKidSchoolStartDate.value = '';
  }

  //* kid Contact Section
  void kidAddPhone() {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    getMethod(2);
  }

  void editKidPhone(Contact contactData) {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    kidsController.phoneID.value = contactData.id!;
    kidsController.kidPhoneNumberTextEditingController.text = contactData.value!;
    getMethod(3);
  }

  void kidAddEmail() {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    getMethod(4);
  }

  void editKidEmail(Contact contactData) {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    kidsController.emailID.value = contactData.id!;
    kidsController.kidEmailTextEditingController.text = contactData.value!;
    getMethod(5);
  }

  void addKidEducationBackground() {
    resetTextEditor();
    getMethod(0);
    kidsController.getSchoolList();
  }

  void saveHobbies() async {
    await kidsController.setHobbies(kidsController.selectedHobbies);
  }

  void editKidSchool(index) {
    resetTextEditor();
    kidsController.enableKidSaveButton.value = true;
    if (kidsController.kidSchoolList[index].started != null) {
      kidsController.temporaryKidSchoolStartDate.value = DateFormat("yyyy-MM-dd").format(kidsController.kidSchoolList[index].started!);
    }
    if (kidsController.kidSchoolList[index].ended != null) {
      kidsController.temporaryKidSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(kidsController.kidSchoolList[index].ended!);
    }
    kidsController.schoolID.value = kidsController.kidSchoolList[index].id!;
    kidsController.kidEducationInstituteTextEditingController.text = kidsController.kidSchoolList[index].school!;
    if (kidsController.kidSchoolList[index].graduated == 0) {
      kidsController.isCurrentlyStudyingHere.value = true;
    } else {
      kidsController.isCurrentlyStudyingHere.value = false;
    }
    getMethod(1);
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

  void startDateButtonOnPressed(context) {
    kidsController.temporaryCommonStartDate.value = '';
    if (kidsController.commonStartDate.value != '') {
      kidsController.temporaryCommonStartDate.value = kidsController.commonStartDate.value;
    }
    kidsController.commonEditStartDateBottomSheetRightButtonState.value = false;
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: kidsController.commonEditStartDateBottomSheetRightButtonState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        kidsController.commonStartDate.value = kidsController.temporaryCommonStartDate.value;
        if (kidsController.commonEndDate.value != '') {
          if (DateTime.parse(kidsController.commonStartDate.value).isAfter(DateTime.parse(kidsController.commonEndDate.value))) {
            kidsController.commonEndDate.value = '';
          }
        }
        checkSaveButtonActive();
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksStartDate,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          maximumDate: DateTime.now().add(const Duration(minutes: 30)),
          initialDateTime: kidsController.temporaryCommonStartDate.value != '' ? DateTime.parse(kidsController.temporaryCommonStartDate.value) : DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            kidsController.commonEditStartDateBottomSheetRightButtonState.value = true;
            kidsController.temporaryCommonStartDate.value = DateFormat("yyyy-MM-dd").format(value);
          },
        ),
      ),
    );
  }

  void endDateButtonOnPressed(context) {
    kidsController.temporaryCommonEndDate.value = '';
    if (kidsController.commonEndDate.value != "") {
      kidsController.temporaryCommonEndDate.value = kidsController.commonEndDate.value;
    }
    kidsController.commonEditEndDateBottomSheetRightButtonState.value = false;
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: kidsController.commonEditEndDateBottomSheetRightButtonState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        kidsController.commonEndDate.value = kidsController.temporaryCommonEndDate.value;
        checkSaveButtonActive();
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksEndDate,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          minimumDate: (kidsController.commonStartDate.value != "" ? DateTime.parse(kidsController.commonStartDate.value) : null),
          maximumDate: DateTime.now().add(const Duration(minutes: 30)),
          initialDateTime: kidsController.commonEndDate.value != ''
              ? (DateTime.parse(kidsController.temporaryCommonEndDate.value))
              : (kidsController.commonStartDate.value != "" ? DateTime.parse(kidsController.commonStartDate.value) : DateTime.now()),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            kidsController.commonEditEndDateBottomSheetRightButtonState.value = true;
            kidsController.temporaryCommonEndDate.value = DateFormat("yyyy-MM-dd").format(value);
          },
        ),
      ),
    );
  }

  void commonSecondaryTextfieldSuffixOnPressed() {
    kidsController.kidCommonEditSecondaryTextEditingController.clear();
    checkSaveButtonActive();
    kidsController.showCommonSecondaryEditSuffixIcon.value = false;
  }

  void checkSaveButtonActive() {
    if (kidsController.kidFunctionFlag.value == 'ADD SCHOOL') {
      if (kidsController.kidEducationBackground.value != '') {
        kidsController.enableKidSaveButton.value = true;
      } else {
        kidsController.enableKidSaveButton.value = false;
      }
    } else if (kidsController.kidFunctionFlag.value.contains('EMAIL')) {
      if (kidsController.kidCommonEditTextEditingController.text.trim() != '' && kidsController.kidCommonEditTextEditingController.text.isValidEmail) {
        kidsController.enableKidSaveButton.value = true;
      } else {
        kidsController.enableKidSaveButton.value = false;
      }
    } else {
      if (kidsController.kidCommonEditTextEditingController.text.trim() != '') {
        kidsController.enableKidSaveButton.value = true;
      } else {
        kidsController.enableKidSaveButton.value = false;
      }
    }
  }

  String? schoolSubtitleText(DateTime? startDate, DateTime? endDate) {
    if (startDate != null && endDate != null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} - ${DateFormat("dd MMMM, yyyy").format(endDate)}';
    } else if (startDate == null && endDate != null) {
      return 'School year ${endDate.year}';
    } else if (startDate != null && endDate == null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} to present';
    } else {
      return null;
    }
  }

  void commonCheckBoxOnChanged() {
    kidsController.isCommonEditCheckBoxSelected.value = !kidsController.isCommonEditCheckBoxSelected.value;
    if (!kidsController.kidFunctionFlag.contains('PRESENT')) {
      if (kidsController.isCommonEditCheckBoxSelected.value) {
        kidsController.isSingleDatePicker.value = true;
        kidsController.commonEndDate.value = '';
      } else {
        kidsController.isSingleDatePicker.value = false;
      }
    }
    checkSaveButtonActive();
  }
}
