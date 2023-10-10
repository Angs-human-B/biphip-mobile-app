import 'dart:io';
import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/models/common/common_error_model.dart';
import 'package:bip_hip/models/profile/profile_overview_model.dart';
// import 'package:bip_hip/models/profile/profile_overview_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/family.dart';
import 'package:bip_hip/views/profile/menu/friends.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();
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
  final RxInt bioCount = 0.obs;
  final RxString bio = RxString('');
  final RxString photoLink = RxString('');
  late VideoPlayerController videoPlayerController;
  final RxString videoUrl = RxString('');
  final RxBool isSharedToNewFeed = RxBool(false);
  final RxBool isProfilePicEditor = RxBool(true);

  final RxList tapAbleButtonState = RxList([true, false, false]);
  final RxList tapAbleButtonText = RxList(["All", "Received", "Pending"]);

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
  RxString commonEditTextfieldHintText = RxString('');
  RxBool isCommonEditDatePickerShown = RxBool(false);
  RxBool isCommonEditPrivacyShown = RxBool(false);
  RxBool isCommonEditCheckBoxShown = RxBool(false);
  RxBool isCommonEditCheckBoxSelected = RxBool(false);
  RxBool isDropdownShown = RxBool(false);
  RxBool isSecondaryTextfieldShown = RxBool(false);
  RxBool isRouteFromAboutInfo = RxBool(false);
  RxString selectedProfession = RxString('');
  RxList selectedInterests = RxList([]);
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
  final TextEditingController designationTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController linkTextEditingController = TextEditingController();
  final RxString startDateAddress = RxString('');
  final RxString endDateAddress = RxString('');
  final RxString joiningYearEducation = RxString('');
  final RxString leavingYearEducation = RxString('');
  final RxString joiningYearJob = RxString('');
  final RxString leavingYearJob = RxString('');
  final RxBool isCurrentlyLiveHere = RxBool(false);
  final RxBool isCurrentlyStudyingHere = RxBool(false);
  final RxBool isCurrentlyWorkingHere = RxBool(false);
  final RxList cityList = RxList([]);
  final RxString birthday = RxString('');
  // final RxBool showEditAddress = RxBool(false);
  final RxBool showEditRelationshipStatus = RxBool(false);
  // final RxBool showAddSchool = RxBool(false);
  final RxInt cityListIndex = RxInt(-1);
  final RxList relationshipStatusList = RxList([
    'Single',
    'In a relationship',
    'Engaged',
    'Married',
    'In a civil partnership',
    'In a domestic partnership',
    'In an open relationship',
    'It\'s complicated',
    'Separated',
    'Divorced',
    'Widowed'
  ]);
  final RxList educationBackgroundList = RxList(['School', 'College']);
  final RxList linkSourceList = RxList(['Facebook', 'LinkedIn', 'Twitter', 'Website']);
  final RxString relationshipStatus = RxString('');
  final RxString tempRelationshipStatus = RxString('');
  final RxList schoolList = RxList([]);
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
  final RxString linkSource = RxString('');
  final RxInt linkID = RxInt(-1);
  final RxInt deleteIndex = RxInt(-1);

  void setEditPageValue(pageTitle, showDropDown, iconData, textEditingController, showSecondaryTextfield, secondaryTextEditingController, textfieldHintText,
      showDatePickerRow, showEditPrivacy, showCheckBox, checkBoxSelect, checkBoxText, function) {
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
      cityList[cityListIndex.value] = commonEditTextEditingController.text;
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
      cityList.removeAt(index);
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
    } else {
      return BipHip.webLink;
    }
  }

  void getMethod(methodID) {
    if (methodID == 0) {
      homeID.value = hometownData.value!.id!;
      homeTownTextEditingController.text = hometownData.value!.city!;
      setEditPageValue(ksEditHometownAddress.tr, false, BipHip.location, homeTownTextEditingController, false, homeTownTextEditingController,
          ksEditHometownAddress.tr, false, true, false, false, 'checkBoxText', 'EDIT HOMETOWN');
      Get.back();
    } else if (methodID == 1) {
      setEditPageValue(ksAddPresentAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksAddLocation.tr, true, true, true, isCurrentlyLiveHere.value, ksCurrentlyLivingHere.tr, 'ADD PRESENT');
    } else if (methodID == 2) {
      presentAddressTextEditingController.text = currentCityData.value!.city!;
      setEditPageValue(ksEditPresentAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksEditLocation.tr, true, true, true, isCurrentlyLiveHere.value, ksCurrentlyLivingHere.tr, 'EDIT PRESENT');
      Get.back();
    } else if (methodID == 3) {
      setEditPageValue(ksAddOtherAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksAddLocation.tr, true, true, true, isCurrentlyLiveHere.value, ksCurrentlyLivingHere.tr, 'ADD PRESENT');
    } else if (methodID == 4) {
      setEditPageValue(ksEditPresentAddress.tr, false, BipHip.location, presentAddressTextEditingController, false, presentAddressTextEditingController,
          ksEditLocation.tr, true, true, true, isCurrentlyLiveHere.value, ksCurrentlyLivingHere.tr, 'EDIT PRESENT');
      Get.back();
    } else if (methodID == 5) {
      setEditPageValue('Add Educational Event', true, BipHip.schoolNew, educationInstituteTextEditingController, false, educationInstituteTextEditingController,
          'Institute name', true, true, true, isCurrentlyStudyingHere.value, 'Currently studying here', 'ADD SCHOOL');
    } else if (methodID == 6) {
      setEditPageValue(ksEditSchool.tr, false, BipHip.schoolNew, educationInstituteTextEditingController, false, educationInstituteTextEditingController,
          ksEditSchool.tr, true, true, true, isCurrentlyStudyingHere.value, ksCurrentlyStudyingHere.tr, 'EDIT SCHOOL');
      Get.back();
    } else if (methodID == 7) {
      setEditPageValue(ksEditCollege.tr, false, BipHip.schoolNew, educationInstituteTextEditingController, false, educationInstituteTextEditingController,
          ksEditCollege.tr, true, true, true, isCurrentlyStudyingHere.value, ksCurrentlyStudyingHere.tr, 'EDIT COLLEGE');
      Get.back();
    } else if (methodID == 8) {
      setEditPageValue(ksAddWorkplace.tr, false, BipHip.officeFill, companyNameTextEditingController, true, designationTextEditingController, ksOfficeName.tr,
          true, true, true, isCurrentlyStudyingHere.value, ksCurrentlyWorkingHere.tr, 'ADD WORKPLACE');
    } else if (methodID == 9) {
      setEditPageValue(ksAddHomeTownAddress.tr, false, BipHip.location, homeTownTextEditingController, false, homeTownTextEditingController,
          ksEnterHometownAddress.tr, false, true, false, false, '', 'HOMETOWN');
    } else if (methodID == 10) {
      setEditPageValue(ksEditWorkplace.tr, false, BipHip.officeFill, companyNameTextEditingController, true, designationTextEditingController,
          ksEditWorkplace.tr, true, true, true, isCurrentlyWorkingHere.value, ksCurrentlyWorkingHere.tr, 'EDIT WORKPLACE');
      Get.back();
    } else if (methodID == 11) {
      setEditPageValue(ksAddPhoneNumber.tr, false, BipHip.phoneFill, phoneTextEditingController, false, phoneTextEditingController, ksPhone.tr, false, true,
          false, false, '', 'ADD PHONE');
    } else if (methodID == 12) {
      setEditPageValue(ksEditPhone.tr, false, BipHip.phoneFill, phoneTextEditingController, false, phoneTextEditingController, ksEditPhone.tr, false, true,
          false, false, '', 'EDIT PHONE');
    } else if (methodID == 13) {
      setEditPageValue(ksAddEmail.tr, false, BipHip.mail, emailTextEditingController, false, emailTextEditingController, ksEmail.tr, false, true, false, false,
          '', 'ADD EMAIL');
    } else if (methodID == 14) {
      setEditPageValue(ksEditEmail.tr, false, BipHip.mail, emailTextEditingController, false, emailTextEditingController, ksEditEmail.tr, false, true, false,
          false, '', 'EDIT EMAIL');
    } else if (methodID == 15) {
      setEditPageValue(
          ksAddLink, true, BipHip.webLink, linkTextEditingController, false, emailTextEditingController, ksAddLink, false, true, false, false, '', 'ADD LINK');
    } else if (methodID == 16) {
      setEditPageValue(ksEditLink.tr, true, getLinkIcon(linkSource.value), linkTextEditingController, false, linkTextEditingController, ksEditLink.tr, false,
          true, false, false, '', 'EDIT LINK');
    }
    Get.toNamed(krEdit);
  }

  void clearDataList() {
    otherCityList.clear();
    schoolDataList.clear();
    collegeDataList.clear();
    contactDataList.clear();
    linkDataList.clear();
  }

  //* Profile overview API Implementation
  Rx<ProfileOverviewModel?> profileData = Rx<ProfileOverviewModel?>(null);
  Rx<User?> userData = Rx<User?>(null);
  Rx<CurrentCity?> hometownData = Rx<CurrentCity?>(null);
  Rx<CurrentCity?> currentCityData = Rx<CurrentCity?>(null);
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
        schoolDataList.addAll(profileData.value!.school);
        collegeDataList.addAll(profileData.value!.college);
        contactDataList.addAll(profileData.value!.contacts);
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('setHometown error: $e');
    }
  }

  //* set city API Implementation
  RxList<CurrentCity> otherCityList = RxList<CurrentCity>([]);
  Future<void> setCity() async {
    try {
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('setCity error: $e');
    }
  }

  //* delete city API Implementation
  Future<void> deleteCity(id) async {
    try {
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
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('deleteCity error: $e');
    }
  }

  //* store school API Implementation
  RxList<College> schoolDataList = RxList<College>([]);
  Future<void> storeSchool() async {
    try {
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'school': educationInstituteTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreSchool,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        schoolDataList.add(College.fromJson(response.data));
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('storeSchool error: $e');
    }
  }

  //* update school API Implement
  Future<void> updateSchool(id) async {
    try {
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'school': educationInstituteTextEditingController.text.trim(),
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('updateSchool error: $e');
    }
  }

  //* delete school API Implementation
  Future<void> deleteSchool(id) async {
    try {
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('deleteSchool error: $e');
    }
  }

  //* store college API Implementation
  RxList<College> collegeDataList = RxList<College>([]);
  Future<void> storeCollege() async {
    try {
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'school': educationInstituteTextEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreCollege,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        collegeDataList.add(College.fromJson(response.data));
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('storeCollege error: $e');
    }
  }

  //* update college API Implement
  Future<void> updateCollege(id) async {
    try {
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'school': educationInstituteTextEditingController.text.trim(),
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('updateCollege error: $e');
    }
  }

  //* delete college API Implementation
  Future<void> deleteCollege(id) async {
    try {
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('deleteCollege error: $e');
    }
  }

  //* store workplace API Implementation
  RxList<Workplace> workplaceDataList = RxList<Workplace>([]);
  Future<void> storeWork() async {
    try {
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'company': companyNameTextEditingController.text.trim(),
        'position': designationTextEditingController.text.trim(),
        'is_current': isCommonEditCheckBoxSelected.value ? '1' : '0'
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreWork,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        workplaceDataList.add(Workplace.fromJson(response.data));
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('storeWork error: $e');
    }
  }

  //* update work API Implement
  Future<void> updateWork(id) async {
    try {
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'company': companyNameTextEditingController.text.trim(),
        'position': designationTextEditingController.text.trim(),
        'is_current': isCommonEditCheckBoxSelected.value ? '1' : '0'
      };
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
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('updateWork error: $e');
    }
  }

//* delete college API Implementation
  Future<void> deleteWork(id) async {
    try {
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
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('deleteWork error: $e');
    }
  }

  //* store contact API Implementation
  RxList<Contact> contactDataList = RxList<Contact>([]);
  Future<void> storeContact(type) async {
    try {
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
        contactDataList.add(Contact.fromJson(response.data));
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('storeContact error: $e');
    }
  }

  //* update contact API Implementation
  Future<void> updateContact(id, type) async {
    try {
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('updateContact error: $e');
    }
  }

  //* delete contact API Implementation
  Future<void> deleteContact(id) async {
    try {
      String? token = await _spController.getBearerToken();

      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteContact/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < contactDataList.length; i++) {
          if (contactDataList[i].id == id) {
            contactDataList.removeAt(i);
          }
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('deleteContact error: $e');
    }
  }

  //* store link API Implementation
  RxList<Link> linkDataList = RxList<Link>([]);
  Future<void> storeLink(type) async {
    try {
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('storeLink error: $e');
    }
  }

  //* update link API Implementation
  Future<void> updateLink(id, type) async {
    try {
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('updateLink error: $e');
    }
  }

  //* delete link API Implementation
  Future<void> deleteLink(id) async {
    try {
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
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('deleteContact error: $e');
    }
  }

  //* update bio API Implementation
  Future<void> updateBio() async {
    try {
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
        userData.value = User.fromJson(response.data);
        Get.back();
        Get.back();
        clearBio();
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('updateBio error: $e');
    }
  }

  //* update bio API Implementation
  Future<void> updateDOB() async {
    try {
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'dob':birthday.value,
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateDateOfBirth,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        userData.value = User.fromJson(response.data);
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('updateDOB error: $e');
    }
  }
}
