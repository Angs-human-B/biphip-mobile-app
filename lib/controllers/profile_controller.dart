import 'dart:io';
import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/models/common/common_error_model.dart';
import 'package:bip_hip/models/common/common_list_models.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/profile/common_user_layer_model.dart';
import 'package:bip_hip/models/profile/profile_overview_model.dart';
// import 'package:bip_hip/models/profile/profile_overview_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/family/family.dart';
import 'package:bip_hip/views/profile/menu/friends/friends.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();
  final RxBool showAllEditOption = RxBool(true);
  final RxBool isSupportButtonPressed = RxBool(false);
  final RxBool isSettingButtonPressed = RxBool(false);
  final RxInt interestCatagoriesIndex = RxInt(0);
  final RxBool isInterestSelected = RxBool(false);
  final RxString profileImageLink = RxString('');
  final Rx<File> profileImageFile = File('').obs;
  final Rx<File> newProfileImageFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxString coverImageLink = RxString('');
  final Rx<File> coverImageFile = File('').obs;
  final Rx<File> newCoverImageFile = File('').obs;
  final RxBool isCoverImageChanged = RxBool(false);
  final TextEditingController bioEditingController = TextEditingController();
  final TextEditingController firstNameEditingController = TextEditingController();
  final TextEditingController lastNameEditingController = TextEditingController();
  final RxInt bioCount = 0.obs;
  final RxString bio = RxString('');
  final RxString photoLink = RxString('');
  late VideoPlayerController videoPlayerController;
  final RxString videoUrl = RxString('');
  final RxBool isSharedToNewFeed = RxBool(false);
  final RxBool isProfilePicEditor = RxBool(true);
  final Rx<IconData?> commonEditPageIcon = Rx<IconData?>(null);
  final RxList tapAbleButtonState = RxList([true, false, false]);
  final RxList tapAbleButtonText = RxList(["All", "Received", "Pending"]);
  final RxBool isEditProfileLoading = RxBool(false);
  final RxBool isProfileSeeMore = RxBool(false);

  void playVideo(
    String videoUrl, {
    bool init = false,
  }) {
    // if(index<0 || index>= videos.length){
    //   return;
    // }
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..addListener(() {})
      ..setLooping(true)
      ..initialize().then((value) => videoPlayerController.play());
  }

  final RxList relationList = RxList([
    "Father",
    "Mother",
    "Daughter",
    "Son",
    "Sister",
    "Brother",
    "Auntie",
    "Uncle",
    "Niece",
    "Nephew",
  ]);
  final RxList relationListState = RxList([
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ]);

  final RxString relation = RxString("");

  void relationStatusChange(index) {
    for (int i = 0; i < relationListState.length; i++) {
      if (index == i) {
        relationListState[i] = true;
      } else {
        relationListState[i] = false;
      }
    }
  }

  void selectRelationTextChange() {
    for (int i = 0; i < relationListState.length; i++) {
      if (relationListState[i]) {
        relation.value = relationList[i];
        break;
      }
    }
  }

  void initializeSelectedRelationText() {
    for (int i = 0; i < relationListState.length; i++) {
      if (relationList[i] == relation.value) {
        relationListState[i] = true;
      } else {
        relationListState[i] = false;
      }
    }
  }

  void initializeRelationText() {
    relation.value = "";
  }

  //*For tapAble button
  void toggleType(int index) {
    for (int i = 0; i < 3; i++) {
      if (index == i) {
        tapAbleButtonState[i] = true;
      } else {
        tapAbleButtonState[i] = false;
      }
    }
  }

  void resetTapButtonData() {
    tapAbleButtonState.clear();
    tapAbleButtonState.addAll([true, false, false]);
  }

  //*Search
  final TextEditingController searchController = TextEditingController();
  RxBool isCloseIconVisible = RxBool(false);

  //*Friends
  RxList allFriendsLists = RxList(friendsList);
  RxList receivedFriendLists = RxList(friendsList);
  RxList pendingFriendLists = RxList(friendsList);
  RxList addFriendLists = RxList(addFriendList);

  //*friends page list data show
  StatelessWidget allReceivedPendingFriendsView() {
    if (tapAbleButtonState[0] == true) {
      return AllFriendList();
    } else if (tapAbleButtonState[1] == true) {
      return ReceivedFriendList();
    } else {
      return PendingFriendList();
    }
  }

  //*Family
  RxList allFamilyLists = RxList(friendsList);
  RxList receivedFamilyLists = RxList(friendsList);
  RxList pendingFamilyLists = RxList(friendsList);
  RxList addFamilyLists = RxList(addFriendList);

  //*friends page list data show
  StatelessWidget allReceivedPendingFamilyView() {
    if (tapAbleButtonState[0] == true) {
      return AllFamilyList();
    } else if (tapAbleButtonState[1] == true) {
      return ReceivedFamilyList();
    } else {
      return PendingFamilyList();
    }
  }

  void clearBio() {
    bioCount.value = 0;
    bioEditingController.clear();
  }

  void resetImage() {
    profileImageFile.value = File('');
    profileImageLink.value = '';
    isProfileImageChanged.value = false;
    isSharedToNewFeed.value = false;
    coverImageFile.value = File('');
    coverImageLink.value = '';
    isCoverImageChanged.value = false;
  }

  //-----------------
  // !Edit About info
  //-----------------
  TextEditingController commonEditTextEditingController = TextEditingController();
  TextEditingController commonEditSecondaryTextEditingController = TextEditingController();
  TextEditingController tempCommonEditSecondaryTextEditingController = TextEditingController();
  RxString commonEditTextfieldHintText = RxString('');
  RxBool isCommonEditDatePickerShown = RxBool(false);
  RxBool isCommonEditPrivacyShown = RxBool(false);
  RxBool isCommonEditCheckBoxShown = RxBool(false);
  RxBool isCommonEditCheckBoxSelected = RxBool(false);
  RxBool isDropdownShown = RxBool(false);
  RxBool isSecondaryTextfieldShown = RxBool(false);
  RxBool isRouteFromAboutInfo = RxBool(false);
  RxString commonEditCheckBoxText = RxString('');
  RxString commonEditPageTitle = RxString('');
  Rx<IconData> commonEditIconData = Rx<IconData>(BipHip.add);
  RxString functionFlag = RxString('');
  final TextEditingController homeTownTextEditingController = TextEditingController();
  final RxString homeTown = RxString('');
  final RxInt homeID = RxInt(-1);
  final RxInt cityID = RxInt(-1);
  final TextEditingController presentAddressTextEditingController = TextEditingController();
  final TextEditingController educationInstituteTextEditingController = TextEditingController();
  final TextEditingController companyNameTextEditingController = TextEditingController();
  TextEditingController designationTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController linkTextEditingController = TextEditingController();
  final RxString commonStartDate = RxString('');
  final RxString commonEndDate = RxString('');
  final RxString joiningYearEducation = RxString('');
  final RxString leavingYearEducation = RxString('');
  final RxString joiningYearJob = RxString('');
  final RxString leavingYearJob = RxString('');
  final RxBool isCurrentlyLiveHere = RxBool(false);
  final RxBool isCurrentlyStudyingHere = RxBool(false);
  final RxBool isCurrentlyWorkingHere = RxBool(false);
  final List<String> cityList = [];
  final List<String> companyList = [];
  final List<String> schoolList = [];
  final RxString birthday = RxString('');
  // final RxBool showEditAddress = RxBool(false);
  final RxBool showEditRelationshipStatus = RxBool(false);
  final RxString commonEditTextFieldErrorText = RxString('');
  final RxBool showCommonEditSuffixIcon = RxBool(false);
  final RxBool showCommonSecondaryEditSuffixIcon = RxBool(false);
  // final RxBool showAddSchool = RxBool(false);
  final RxInt cityListIndex = RxInt(-1);
  final RxList relationshipStatusList = RxList([]);
  final RxList genderList = RxList([]);
  final List<String> positionList = [];

  final RxList friendActionList = RxList([
    {'icon': BipHip.unfriend, 'action': 'Unfriend', 'actionSubtitle': 'Remove your friend'},
    {'icon': BipHip.unFollow, 'action': 'Unfollow', 'actionSubtitle': 'Unfollow your friend'},
    {'icon': BipHip.removeFamily, 'action': 'Add Family', 'actionSubtitle': 'Add your family'}
  ]);
  final RxString friendActionSelect = RxString('');
  final RxList educationBackgroundList = RxList(['School', 'College']);
  final RxList linkSourceList = RxList([]);
  final RxString relationshipStatus = RxString('');
  final RxString selectedGender = RxString('');
  final RxString tempSelectedGender = RxString('');
  final RxBool isGenderSelected = RxBool(false);
  final RxString tempRelationshipStatus = RxString('');
  final RxInt schoolID = RxInt(-1);
  final RxList collegeList = RxList([]);
  final RxInt collegeID = RxInt(-1);
  final RxList<Map> officeList = RxList<Map>([]);
  final RxInt officeID = RxInt(-1);
  final RxList phoneList = RxList([]);
  final RxInt phoneID = RxInt(-1);
  final RxList emailList = RxList([]);
  final RxInt emailID = RxInt(-1);
  final RxString educationBackground = RxString('');
  final RxString tempEducationBackground = RxString('');
  final RxString linkSource = RxString('');
  final RxString tempLinkSource = RxString('');
  final RxInt linkID = RxInt(-1);
  final RxInt deleteIndex = RxInt(-1);
  final RxBool viewOptionEnabled = RxBool(false);
  final RxString previewPhoto = RxString('');
  final RxBool isProfilePhoto = RxBool(true);
  final RxList<String> tempListCommon = RxList<String>([]);
  final RxBool enableSaveButton = RxBool(false);
  final RxString tempSchoolStartDate = RxString('');
  final RxString tempSchoolEndDate = RxString('');
  final RxString tempWorkplaceStartDate = RxString('');
  final RxString tempWorkplaceEndDate = RxString('');

  void setEditPageValue(pageTitle, showDropDown, iconData, textEditingController, showSecondaryTextfield, secondaryTextEditingController, textfieldHintText,
      showDatePickerRow, showEditPrivacy, showCheckBox, checkBoxSelect, checkBoxText, function, startDate, endDate) {
    commonEditPageTitle.value = pageTitle;
    isDropdownShown.value = showDropDown;
    commonEditIconData.value = iconData;
    commonEditTextEditingController = textEditingController;
    isSecondaryTextfieldShown.value = showSecondaryTextfield;
    commonEditSecondaryTextEditingController = secondaryTextEditingController;
    commonEditTextfieldHintText.value = textfieldHintText;
    isCommonEditDatePickerShown.value = showDatePickerRow;
    isCommonEditPrivacyShown.value = showEditPrivacy;
    isCommonEditCheckBoxShown.value = showCheckBox;
    isCommonEditCheckBoxSelected.value = checkBoxSelect;
    commonEditCheckBoxText.value = checkBoxText;
    functionFlag.value = function;
    commonStartDate.value = startDate;
    commonEndDate.value = endDate;
  }

  void resetTextEditor() {
    tempListCommon.clear();
    homeTownTextEditingController.clear();
    presentAddressTextEditingController.clear();
    educationInstituteTextEditingController.clear();
    educationBackground.value = '';
    companyNameTextEditingController.clear();
    designationTextEditingController.clear();
    phoneTextEditingController.clear();
    emailTextEditingController.clear();
    linkTextEditingController.clear();
    commonEditPageIcon.value = null;
    isCurrentlyLiveHere.value = false;
    isCurrentlyStudyingHere.value = false;
    isCurrentlyWorkingHere.value = false;
    enableSaveButton.value = false;
    tempSchoolEndDate.value = '';
    tempSchoolStartDate.value = '';
    tempWorkplaceEndDate.value = '';
    tempWorkplaceStartDate.value = '';
  }

  void selectFunction(functionFlag, [index]) async {
    if (functionFlag == 'HOMETOWN') {
      await setHometown();
      homeTownTextEditingController.clear();
    } else if (functionFlag == 'EDIT HOMETOWN') {
      await setHometown();
      homeTownTextEditingController.clear();
    } else if (functionFlag == 'ADD PRESENT') {
      await setCity();
      commonEditTextEditingController.clear();
      presentAddressTextEditingController.clear();
    } else if (functionFlag == 'EDIT PRESENT') {
      ll(cityID.value);
      await updateCity(cityID.value);
      presentAddressTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD SCHOOL') {
      if (educationBackground.value == 'School') {
        await storeSchool();
      } else {
        await storeCollege();
      }
      commonEditTextEditingController.clear();
      educationInstituteTextEditingController.clear();
      educationBackground.value = '';
    } else if (functionFlag == 'EDIT SCHOOL') {
      await updateSchool(schoolID.value);
      educationInstituteTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT COLLEGE') {
      await updateCollege(collegeID.value);
      educationInstituteTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD WORKPLACE') {
      await storeWork();
      companyNameTextEditingController.clear();
      commonEditTextEditingController.clear();
      commonEditSecondaryTextEditingController.clear();
      isCommonEditCheckBoxSelected.value = false;
    } else if (functionFlag == 'EDIT WORKPLACE') {
      await updateWork(officeID.value);
      companyNameTextEditingController.clear();
      commonEditTextEditingController.clear();
      commonEditSecondaryTextEditingController.clear();
      isCommonEditCheckBoxSelected.value = false;
    } else if (functionFlag == 'ADD PHONE') {
      await storeContact('phone');
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT PHONE') {
      await updateContact(phoneID.value, 'phone');
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD EMAIL') {
      await storeContact('email');
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL') {
      await updateContact(emailID.value, 'email');
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD LINK') {
      await storeLink(linkSource.value);
      linkTextEditingController.clear();
      commonEditTextEditingController.clear();
      linkSource.value = '';
    } else if (functionFlag == 'EDIT LINK') {
      ll(linkSource);
      await updateLink(linkID.value, linkSource.value);
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT HOMETOWN DELETE') {
      await deleteCity(hometownData.value!.id);
      homeTownTextEditingController.clear();
    } else if (functionFlag == 'EDIT PRESENT DELETE') {
      await deleteCity(cityID.value);
      commonEditTextEditingController.clear();
      presentAddressTextEditingController.clear();
    } else if (functionFlag == 'EDIT SCHOOL DELETE') {
      await deleteSchool(schoolID.value);
      educationInstituteTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT COLLEGE DELETE') {
      await deleteCollege(collegeID.value);
      educationInstituteTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT WORKPLACE DELETE') {
      await deleteWork(officeID.value);
      companyNameTextEditingController.clear();
      commonEditTextEditingController.clear();
      commonEditSecondaryTextEditingController.clear();
      isCommonEditCheckBoxSelected.value = false;
    } else if (functionFlag == 'EDIT PHONE DELETE') {
      await deleteContact(phoneID.value);
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL DELETE') {
      await deleteContact(emailID.value);
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT LINK DELETE') {
      await deleteLink(linkID.value);
      commonEditTextEditingController.clear();
    }
  }

  IconData getLinkIcon(String type) {
    if (type.toLowerCase() == "facebook") {
      return BipHip.facebook;
    } else if (type.toLowerCase() == "linkedin") {
      return BipHip.linkedin;
    } else if (type.toLowerCase() == "twitter") {
      return BipHip.twitter;
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
    isGenderSelected.value = false;
    showEditRelationshipStatus.value = false;
    relationshipStatus.value = '';
    tempSelectedGender.value = '';
    selectedGender.value = '';
  }

  void getMethod(methodID) {
    showCommonEditSuffixIcon.value = false;
    showCommonSecondaryEditSuffixIcon.value = false;
    if (methodID == 0) {
      homeID.value = hometownData.value!.id!;
      homeTownTextEditingController.text = hometownData.value!.city!;
      setEditPageValue(ksEditHometownAddress.tr, false, BipHip.location, homeTownTextEditingController, false, homeTownTextEditingController,
          ksEditHometownAddress.tr, false, true, false, false, 'checkBoxText', 'EDIT HOMETOWN', '', '');
      // Get.back();
    } else if (methodID == 1) {
      setEditPageValue(ksAddPresentAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksAddLocation.tr, false, true, false, true, ksCurrentlyLivingHere.tr, 'ADD PRESENT', '', '');
    } else if (methodID == 2) {
      presentAddressTextEditingController.text = currentCityData.value!.city!;
      setEditPageValue(ksEditPresentAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksEditLocation.tr, false, true, false, isCurrentlyLiveHere.value, ksCurrentlyLivingHere.tr, 'EDIT PRESENT', '', '');
      // Get.back();
    } else if (methodID == 3) {
      setEditPageValue(ksAddOtherAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksAddLocation.tr, false, true, true, false, ksCurrentlyLivingHere.tr, 'ADD PRESENT', '', '');
    } else if (methodID == 4) {
      setEditPageValue(ksEditPresentAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksEditLocation.tr, false, true, true, false, ksCurrentlyLivingHere.tr, 'EDIT PRESENT', '', '');
      // Get.back();
    } else if (methodID == 5) {
      setEditPageValue('Add Educational Event', true, BipHip.schoolNew, educationInstituteTextEditingController, false, educationInstituteTextEditingController,
          'Institute name', true, true, true, isCurrentlyStudyingHere.value, 'Currently studying here', 'ADD SCHOOL', '', '');
    } else if (methodID == 6) {
      setEditPageValue(
          ksEditSchool.tr,
          false,
          BipHip.schoolNew,
          educationInstituteTextEditingController,
          false,
          educationInstituteTextEditingController,
          ksEditSchool.tr,
          true,
          true,
          true,
          isCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT SCHOOL',
          tempSchoolStartDate.value,
          tempSchoolEndDate.value);
      // Get.back();
    } else if (methodID == 7) {
      setEditPageValue(
          ksEditCollege.tr,
          false,
          BipHip.schoolNew,
          educationInstituteTextEditingController,
          false,
          educationInstituteTextEditingController,
          ksEditCollege.tr,
          true,
          true,
          true,
          isCurrentlyStudyingHere.value,
          ksCurrentlyStudyingHere.tr,
          'EDIT COLLEGE',
          tempSchoolStartDate.value,
          tempSchoolEndDate.value);
      // Get.back();
    } else if (methodID == 8) {
      setEditPageValue(ksAddWorkplace.tr, false, BipHip.officeFill, companyNameTextEditingController, true, designationTextEditingController, ksOfficeName.tr,
          true, true, true, isCurrentlyStudyingHere.value, ksCurrentlyWorkingHere.tr, 'ADD WORKPLACE', '', '');
    } else if (methodID == 9) {
      setEditPageValue(ksAddHomeTownAddress.tr, false, BipHip.location, homeTownTextEditingController, false, homeTownTextEditingController,
          ksEnterHometownAddress.tr, false, true, false, false, '', 'HOMETOWN', '', '');
    } else if (methodID == 10) {
      setEditPageValue(
          ksEditWorkplace.tr,
          false,
          BipHip.officeFill,
          companyNameTextEditingController,
          true,
          designationTextEditingController,
          ksEditWorkplace.tr,
          true,
          true,
          true,
          isCurrentlyWorkingHere.value,
          ksCurrentlyWorkingHere.tr,
          'EDIT WORKPLACE',
          tempWorkplaceStartDate.value,
          tempWorkplaceEndDate.value);
      // Get.back();
    } else if (methodID == 11) {
      setEditPageValue(ksAddPhoneNumber.tr, false, BipHip.phoneFill, phoneTextEditingController, false, phoneTextEditingController, ksPhone.tr, false, true,
          false, false, '', 'ADD PHONE', '', '');
    } else if (methodID == 12) {
      setEditPageValue(ksEditPhone.tr, false, BipHip.phoneFill, phoneTextEditingController, false, phoneTextEditingController, ksEditPhone.tr, false, true,
          false, false, '', 'EDIT PHONE', '', '');
      // Get.back();
    } else if (methodID == 13) {
      setEditPageValue(ksAddEmail.tr, false, BipHip.mail, emailTextEditingController, false, emailTextEditingController, ksEmail.tr, false, true, false, false,
          '', 'ADD EMAIL', '', '');
    } else if (methodID == 14) {
      setEditPageValue(ksEditEmail.tr, false, BipHip.mail, emailTextEditingController, false, emailTextEditingController, ksEditEmail.tr, false, true, false,
          false, '', 'EDIT EMAIL', '', '');
      // Get.back();
    } else if (methodID == 15) {
      setEditPageValue(ksAddLink, true, BipHip.webLink, linkTextEditingController, false, emailTextEditingController, ksAddLink, false, true, false, false, '',
          'ADD LINK', '', '');
    } else if (methodID == 16) {
      setEditPageValue(ksEditLink.tr, true, getLinkIcon(linkSource.value), linkTextEditingController, false, linkTextEditingController, ksEditLink.tr, false,
          true, false, false, '', 'EDIT LINK', '', '');
      // Get.back();
    }
    Get.toNamed(krEdit);
  }

  void clearDataList() {
    otherCityList.clear();
    schoolDataList.clear();
    collegeDataList.clear();
    contactDataList.clear();
    emailDataList.clear();
    phoneDataList.clear();
    linkDataList.clear();
  }

  bool buttonActivation(String functionFlag) {
    if (functionFlag.contains('LINK')) {
      if (commonEditTextEditingController.text.trim() != '' && linkSource.value != '') {
        return true;
      } else {
        return false;
      }
    } else if (functionFlag == 'ADD SCHOOL') {
      if (commonEditTextEditingController.text.trim() != '' && educationBackground.value != '') {
        return true;
      } else {
        return false;
      }
    } else if (functionFlag.contains('EMAIL')) {
      if (commonEditTextEditingController.text.trim() != '' && commonEditTextEditingController.text.isValidEmail) {
        return true;
      } else {
        return false;
      }
    } else {
      if (commonEditTextEditingController.text.trim() != '') {
        return true;
      } else {
        return false;
      }
    }
  }

  void checkSaveButtonActive() {
    if (functionFlag.contains('LINK')) {
      if (commonEditTextEditingController.text.trim() != '' && linkSource.value != '') {
        enableSaveButton.value = true;
      } else {
        enableSaveButton.value = false;
      }
    } else if (functionFlag == 'ADD SCHOOL') {
      if (commonEditTextEditingController.text.trim() != '' && educationBackground.value != '') {
        enableSaveButton.value = true;
      } else {
        enableSaveButton.value = false;
      }
    } else if (functionFlag.contains('EMAIL')) {
      if (commonEditTextEditingController.text.trim() != '' && commonEditTextEditingController.text.isValidEmail) {
        enableSaveButton.value = true;
      } else {
        enableSaveButton.value = false;
      }
    } else {
      if (commonEditTextEditingController.text.trim() != '') {
        enableSaveButton.value = true;
      } else {
        enableSaveButton.value = false;
      }
    }
  }

  //* Profile overview API Implementation
  Rx<ProfileOverviewModel?> profileData = Rx<ProfileOverviewModel?>(null);
  Rx<User?> userData = Rx<User?>(null);
  Rx<CurrentCity?> hometownData = Rx<CurrentCity?>(null);
  Rx<CurrentCity?> currentCityData = Rx<CurrentCity?>(null);
  Rx<Workplace?> currentWorkplace = Rx<Workplace?>(null);
  RxBool isProfileLoading = RxBool(false);
  Future<void> getProfileOverview() async {
    try {
      isProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetProfileOverView,
      ) as CommonDM;
      if (response.success == true) {
        clearDataList();
        workplaceDataList.clear();
        profileData.value = ProfileOverviewModel.fromJson(response.data);
        userData.value = profileData.value!.user;
        hometownData.value = profileData.value!.hometown;
        currentCityData.value = profileData.value!.currentCity;
        currentWorkplace.value = profileData.value!.currentWorkplace;
        schoolDataList.addAll(profileData.value!.school);
        collegeDataList.addAll(profileData.value!.college);
        contactDataList.addAll(profileData.value!.contacts);
        for (int i = 0; i < contactDataList.length; i++) {
          if (contactDataList[i].type == 'email') {
            emailDataList.add(contactDataList[i]);
          } else {
            phoneDataList.add(contactDataList[i]);
          }
        }
        linkDataList.addAll(profileData.value!.links);
        workplaceDataList.addAll(profileData.value!.workplaces);
        otherCityList.addAll(profileData.value!.cities);
        isProfileLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getProfileOverview error: $e');
    }
  }

  //* Set Hometown API Implementation
  Future<void> setHometown() async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'city': homeTownTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSetHomeTown,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        hometownData.value = CurrentCity.fromJson(response.data);
        otherCityList.add(CurrentCity.fromJson(response.data));
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('setHometown error: $e');
    }
  }

  //* set city API Implementation
  RxList<CurrentCity> otherCityList = RxList<CurrentCity>([]);
  Future<void> setCity() async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'city': presentAddressTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: isCommonEditCheckBoxSelected.value ? kuSetCurrentCity : kuOtherCity,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        if (isCommonEditCheckBoxSelected.value) {
          currentCityData.value = CurrentCity.fromJson(response.data);
          otherCityList.add(CurrentCity.fromJson(response.data));
        } else {
          otherCityList.add(CurrentCity.fromJson(response.data));
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('setCity error: $e');
    }
  }

  //* update city API Implementation
  Future<void> updateCity(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'city': presentAddressTextEditingController.text.trim(),
        // 'is_current': isCommonEditCheckBoxSelected.value ? '1' : '0'
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateCity,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < otherCityList.length; i++) {
          if (otherCityList[i].id == id) {
            otherCityList[i] = CurrentCity.fromJson(response.data);
          }
          if (currentCityData.value!.id == id) {
            currentCityData.value = CurrentCity.fromJson(response.data);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('updateCity error: $e');
    }
  }

  //* delete city API Implementation
  Future<void> deleteCity(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteCity/$id',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < otherCityList.length; i++) {
          if (otherCityList[i].id == id) {
            otherCityList.removeAt(i);
          }
          if (currentCityData.value?.id == id) {
            currentCityData.value = null;
          }
          if (hometownData.value?.id == id) {
            hometownData.value = null;
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('deleteCity error: $e');
    }
  }

  //* store school API Implementation
  RxList<College> schoolDataList = RxList<College>([]);
  Future<void> storeSchool() async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreSchool,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        schoolDataList.add(College.fromJson(response.data));
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeSchool error: $e');
    }
  }

  //* update school API Implement
  Future<void> updateSchool(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateSchool,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < schoolDataList.length; i++) {
          if (schoolDataList[i].id == id) {
            schoolDataList[i] = College.fromJson(response.data);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('updateSchool error: $e');
    }
  }

  //* delete school API Implementation
  Future<void> deleteSchool(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteSchool/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < schoolDataList.length; i++) {
          if (schoolDataList[i].id == id) {
            schoolDataList.removeAt(i);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('deleteSchool error: $e');
    }
  }

  //* store college API Implementation
  RxList<College> collegeDataList = RxList<College>([]);
  Future<void> storeCollege() async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreCollege,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        collegeDataList.add(College.fromJson(response.data));
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeCollege error: $e');
    }
  }

  //* update college API Implement
  Future<void> updateCollege(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateCollege,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < collegeDataList.length; i++) {
          if (collegeDataList[i].id == id) {
            collegeDataList[i] = College.fromJson(response.data);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('updateCollege error: $e');
    }
  }

  //* delete college API Implementation
  Future<void> deleteCollege(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteCollege/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < collegeDataList.length; i++) {
          if (collegeDataList[i].id == id) {
            collegeDataList.removeAt(i);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('deleteCollege error: $e');
    }
  }

  //* store workplace API Implementation
  RxList<Workplace> workplaceDataList = RxList<Workplace>([]);
  Future<void> storeWork() async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'company': companyNameTextEditingController.text.trim(),
        'position': designationTextEditingController.text.trim(),
        'is_current': isCommonEditCheckBoxSelected.value ? '1' : '0',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreWork,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        workplaceDataList.add(Workplace.fromJson(response.data));
        if (isCommonEditCheckBoxSelected.value) {
          currentWorkplace.value = Workplace.fromJson(response.data);
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeWork error: $e');
    }
  }

  //* update work API Implement
  Future<void> updateWork(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'company': companyNameTextEditingController.text.trim(),
        'position': designationTextEditingController.text.trim(),
        'is_current': isCommonEditCheckBoxSelected.value ? '1' : '0',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      ll(body);
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateWork,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < workplaceDataList.length; i++) {
          if (workplaceDataList[i].id == id) {
            workplaceDataList[i] = Workplace.fromJson(response.data);
          }
          if (isCommonEditCheckBoxSelected.value) {
            currentWorkplace.value = Workplace.fromJson(response.data);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('updateWork error: $e');
    }
  }

//* delete college API Implementation
  Future<void> deleteWork(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteWork/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < workplaceDataList.length; i++) {
          if (workplaceDataList[i].id == id) {
            workplaceDataList.removeAt(i);
          }
          if (currentWorkplace.value?.id == id) {
            currentWorkplace.value = null;
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('deleteWork error: $e');
    }
  }

  //* store contact API Implementation
  RxList<Contact> contactDataList = RxList<Contact>([]);
  RxList<Contact> emailDataList = RxList<Contact>([]);
  RxList<Contact> phoneDataList = RxList<Contact>([]);
  Future<void> storeContact(type) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'type': type,
        'value': type == 'phone' ? phoneTextEditingController.text.trim() : emailTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreContact,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        emailDataList.clear();
        phoneDataList.clear();
        contactDataList.add(Contact.fromJson(response.data));
        for (int i = 0; i < contactDataList.length; i++) {
          if (contactDataList[i].type == 'email') {
            emailDataList.add(contactDataList[i]);
          } else {
            phoneDataList.add(contactDataList[i]);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeContact error: $e');
    }
  }

  //* update contact API Implementation
  Future<void> updateContact(id, type) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'type': type,
        'value': type == 'phone' ? phoneTextEditingController.text.trim() : emailTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateContact,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < contactDataList.length; i++) {
          if (contactDataList[i].id == id) {
            contactDataList[i] = Contact.fromJson(response.data);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('updateContact error: $e');
    }
  }

  //* delete contact API Implementation
  Future<void> deleteContact(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteContact/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        emailDataList.clear();
        phoneDataList.clear();
        for (int i = 0; i < contactDataList.length; i++) {
          if (contactDataList[i].id == id) {
            contactDataList.removeAt(i);
          }
        }
        for (int i = 0; i < contactDataList.length; i++) {
          if (contactDataList[i].type == 'email') {
            emailDataList.add(contactDataList[i]);
          } else {
            phoneDataList.add(contactDataList[i]);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('deleteContact error: $e');
    }
  }

  //* store link API Implementation
  RxList<Link> linkDataList = RxList<Link>([]);
  Future<void> storeLink(type) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'type': type,
        'link': linkTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreLink,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        linkDataList.add(Link.fromJson(response.data));
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeLink error: $e');
    }
  }

  //* update link API Implementation
  Future<void> updateLink(id, type) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'type': type.toString(),
        'link': linkTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateLink,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < linkDataList.length; i++) {
          if (linkDataList[i].id == id) {
            linkDataList[i] = Link.fromJson(response.data);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('updateLink error: $e');
    }
  }

  //* delete link API Implementation
  Future<void> deleteLink(id) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteLink/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < linkDataList.length; i++) {
          if (linkDataList[i].id == id) {
            linkDataList.removeAt(i);
          }
        }
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('deleteContact error: $e');
    }
  }

  //* update bio API Implementation
  Rx<CommonUserDataModel?> commonUserLayeredData = Rx<CommonUserDataModel?>(null);
  RxBool isBioLoading = RxBool(false);
  Future<void> updateBio([isUpdate = true]) async {
    try {
      isBioLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'bio': bioEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateBio,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        ll(userData.value!.bio);
        if (isUpdate) {
          Get.back();
        }
        clearBio();
        isBioLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBioLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isBioLoading.value = false;
      ll('updateBio error: $e');
    }
  }

  //* update bio API Implementation
  Future<void> updateDOB() async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'dob': birthday.value,
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateDateOfBirth,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isEditProfileLoading.value = false;
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        ll(userData.value!.dob);
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('updateDOB error: $e');
    }
  }

  //* upload profile photo
  Future<void> uploadProfileAndCover(File imageFile, String type, [isFromProfile = true]) async {
    try {
      if (isFromProfile == true) {
        isImageUploadPageLoading.value = true;
      }
      String? token = await _spController.getBearerToken();
      var response = await _apiController.mediaUpload(
        url: type == 'profile' ? kuSetProfilePicture : kuSetCoverPhoto,
        token: token,
        key: 'image',
        value: imageFile.path,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data.toString());
        CommonUserDataModel commonUserDataModel = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserDataModel.user;
        var rememberMe = await _spController.getRememberMe();
        if (rememberMe == true) {
          await _spController.saveUserList({
            "email": userData.value!.email.toString(),
            "name": userData.value!.fullName.toString(),
            "first_name": userData.value!.firstName.toString(),
            "last_name": userData.value!.lastName.toString(),
            "image_url": userData.value!.profilePicture.toString(),
            "token": token.toString(),
          });
        }
        await _spController.saveUserImage(userData.value!.profilePicture.toString());
        await _globalController.getUserInfo();
        if (isFromProfile == true) {
          Get.back();
          isImageUploadPageLoading.value = false;
        } else {
          Get.offAllNamed(krHome);
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        if (isFromProfile == true) {
          isImageUploadPageLoading.value = false;
        }
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      if (isFromProfile == true) {
        isImageUploadPageLoading.value = false;
      }
      ll('uploadProfilePicture error: $e');
    }
  }

  //* store user settings API Implementation
  Future<void> storeUserSetting(key, value) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {'key': key.toString(), 'value': value.toString()};
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSetGeneralSetting,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;

        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeUserSetting error: $e');
    }
  }

  //* name change API Implementation
  RxBool isChangeNameLoading = RxBool(false);
  Future<void> changeName() async {
    try {
      isChangeNameLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'first_name': firstNameEditingController.text.trim(),
        'last_name': lastNameEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateUserFullName,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data);
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        var rememberMe = await _spController.getRememberMe();
        if (rememberMe == true) {
          await _spController.saveUserList({
            "email": userData.value!.email.toString(),
            "name": userData.value!.fullName.toString(),
            "first_name": userData.value!.firstName.toString(),
            "last_name": userData.value!.lastName.toString(),
            "image_url": userData.value!.profilePicture.toString(),
            "token": token.toString(),
          });
        }
        await _spController.saveUserFirstName(userData.value!.firstName.toString());
        await _spController.saveUserLastName(userData.value!.lastName.toString());
        await _spController.saveUserName(userData.value!.fullName.toString());
        await _globalController.getUserInfo();
        isChangeNameLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isChangeNameLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isChangeNameLoading.value = false;
      ll('changeName error: $e');
    }
  }

  //* get profession list API
  Rx<ProfessionListModel?> professionListData = Rx<ProfessionListModel?>(null);
  RxBool isProfessionListLoading = RxBool(false);
  Future<void> getProfessionList() async {
    try {
      isProfessionListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllProfessions,
      ) as CommonDM;
      if (response.success == true) {
        _globalController.professionList.clear();
        professionListData.value = ProfessionListModel.fromJson(response.data);
        _globalController.professionList.addAll(professionListData.value!.professions);
        isProfessionListLoading.value = false;
      } else {
        isProfessionListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfessionListLoading.value = false;
      ll('getProfessionList error: $e');
    }
  }

  //* get interest list API
  Rx<InterestListModel?> interestListData = Rx<InterestListModel?>(null);
  RxBool isInterestListLoading = RxBool(false);
  RxList tempInterestList = RxList([]);
  Future<void> getInterestList() async {
    try {
      isInterestListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllInterests,
      ) as CommonDM;
      if (response.success == true) {
        tempInterestList.clear();
        _globalController.interestList.clear();
        interestListData.value = InterestListModel.fromJson(response.data);
        tempInterestList.addAll(interestListData.value!.interests);
        for (int i = 0; i < tempInterestList.length; i++) {
          if (!_globalController.interestList.contains(tempInterestList[i])) {
            _globalController.interestList.add(tempInterestList[i]);
          }
        }
        isInterestListLoading.value = false;
      } else {
        isInterestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isInterestListLoading.value = false;
      ll('getInterestList error: $e');
    }
  }

  //* set profession API implementation
  Future<void> setProfession(profession) async {
    List professionList = [];
    professionList.add(profession);
    ll(professionList);
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {'key': 'profession', 'value': professionList};
      ll(body);
      var response = await _apiController.commonPostDio(
        url: kuSetGeneralSetting,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data);
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('setProfession error: $e');
    }
  }

  //* set profession API implementation
  Future<void> setInterest(interest) async {
    ll(interest);
    try {
      isEditProfileLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {'key': 'interest', 'value': interest};
      ll(body);
      var response = await _apiController.commonPostDio(
        url: kuSetGeneralSetting,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data);
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        isEditProfileLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('setInterest error: $e');
    }
  }

  //* get gender list API
  Rx<GenderListModel?> genderListData = Rx<GenderListModel?>(null);
  RxBool isGenderListLoading = RxBool(false);
  Future<void> getGenderList() async {
    try {
      isGenderListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllGenders,
      ) as CommonDM;
      if (response.success == true) {
        genderList.clear();
        genderListData.value = GenderListModel.fromJson(response.data);
        genderList.addAll(genderListData.value!.genders);
        isGenderListLoading.value = false;
      } else {
        isGenderListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isGenderListLoading.value = false;
      ll('getGenderList error: $e');
    }
  }

  //* get relationship list API
  Rx<RelationshipListModel?> relationshipListData = Rx<RelationshipListModel?>(null);
  RxBool isRelationListLoading = RxBool(false);
  Future<void> getRelationshipList() async {
    try {
      isRelationListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllRelationShips,
      ) as CommonDM;
      if (response.success == true) {
        relationshipStatusList.clear();
        relationshipListData.value = RelationshipListModel.fromJson(response.data);
        relationshipStatusList.addAll(relationshipListData.value!.relationships);
        isRelationListLoading.value = false;
      } else {
        isRelationListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isRelationListLoading.value = false;
      ll('getRelationshipList error: $e');
    }
  }

  //* get position list API
  Rx<PositionListModel?> positionListData = Rx<PositionListModel?>(null);
  RxList<String> temp = RxList<String>();
  Future<void> getPositionList() async {
    try {
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllPositions,
      ) as CommonDM;
      if (response.success == true) {
        positionList.clear();
        temp.clear();
        positionListData.value = PositionListModel.fromJson(response.data);
        positionList.addAll(positionListData.value!.positions);
        temp.addAll(positionList);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getPositionList error: $e');
    }
  }

  final RxBool isImageUploadPageLoading = RxBool(false);
  bool showSeeMore() {
    if (emailDataList.length + phoneDataList.length + linkDataList.length > 3) {
      return true;
    } else {
      return false;
    }
  }

  //* Get link api implementation
  Rx<LinkListModel?> linkListData = Rx<LinkListModel?>(null);
  RxBool isLinkListLoading = RxBool(false);
  Future<void> getLinkList() async {
    try {
      isLinkListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllLinkTypes,
      ) as CommonDM;
      if (response.success == true) {
        linkSourceList.clear();
        linkListData.value = LinkListModel.fromJson(response.data);
        linkSourceList.addAll(linkListData.value!.linkTypes);
        isLinkListLoading.value = false;
      } else {
        isLinkListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isLinkListLoading.value = false;
      ll('getLinkList error: $e');
    }
  }

  //* Get city list api implementation
  Rx<CityListModel?> cityListData = Rx<CityListModel?>(null);
  Future<void> getCityList() async {
    try {
      isLinkListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllCities,
      ) as CommonDM;
      if (response.success == true) {
        cityList.clear();
        cityListData.value = CityListModel.fromJson(response.data);
        cityList.addAll(cityListData.value!.cities);
        tempListCommon.addAll(cityList);
        isLinkListLoading.value = false;
      } else {
        isLinkListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isLinkListLoading.value = false;
      ll('getCityList error: $e');
    }
  }

  //* Get city list api implementation
  Rx<CompanyListModel?> companyListData = Rx<CompanyListModel?>(null);
  Future<void> getCompanyList() async {
    try {
      isLinkListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllCompanies,
      ) as CommonDM;
      if (response.success == true) {
        companyList.clear();
        companyListData.value = CompanyListModel.fromJson(response.data);
        companyList.addAll(companyListData.value!.companies);
        tempListCommon.addAll(companyList);
        isLinkListLoading.value = false;
      } else {
        isLinkListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isLinkListLoading.value = false;
      ll('getCompanyList error: $e');
    }
  }

  //* Get school list api implementation
  Rx<SchoolListModel?> schoolListData = Rx<SchoolListModel?>(null);
  Future<void> getSchoolList() async {
    try {
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllSchools,
      ) as CommonDM;
      if (response.success == true) {
        schoolList.clear();
        schoolListData.value = SchoolListModel.fromJson(response.data);
        schoolList.addAll(schoolListData.value!.schools);
        tempListCommon.addAll(schoolList);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getSchoolList error: $e');
    }
  }
}
