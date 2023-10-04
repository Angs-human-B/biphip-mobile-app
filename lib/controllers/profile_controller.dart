import 'dart:io';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/family.dart';
import 'package:bip_hip/views/profile/menu/friends.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
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
  RxString commonEditCheckBoxText = RxString('');
  RxString commonEditPageTitle = RxString('');
  Rx<IconData> commonEditIconData = Rx<IconData>(BipHip.add);
  RxString functionFlag = RxString('');
  final TextEditingController homeTownTextEditingController = TextEditingController();
  final RxString homeTown = RxString('');
  final TextEditingController presentAddressTextEditingController = TextEditingController();
  final TextEditingController educationInstituteTextEditingController = TextEditingController();
  final TextEditingController officeNameTextEditingController = TextEditingController();
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
  final RxString relationshipStatus = RxString('');
  final RxString tempRelationshipStatus = RxString('');
  final RxList schoolList = RxList([]);
  final RxInt schoolIndex = RxInt(-1);
  final RxList collegeList = RxList([]);
  final RxInt collegeIndex = RxInt(-1);
  final RxList<Map> officeList = RxList<Map>([]);
  final RxInt officeIndex = RxInt(-1);
  final RxList phoneList = RxList([]);
  final RxInt phoneIndex = RxInt(-1);
  final RxList emailList = RxList([]);
  final RxInt emailIndex = RxInt(-1);
  final RxString educationBackground = RxString('');

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

  void selectFunction(functionFlag) {
    if (functionFlag == 'HOMETOWN') {
      homeTown.value = homeTownTextEditingController.text.trim();
      homeTownTextEditingController.clear();
    } else if (functionFlag == 'EDIT HOMETOWN') {
      homeTown.value = homeTownTextEditingController.text.trim();
      homeTownTextEditingController.clear();
    } else if (functionFlag == 'ADD PRESENT') {
      cityList.add(commonEditTextEditingController.text);
      commonEditTextEditingController.clear();
      presentAddressTextEditingController.clear();
    } else if (functionFlag == 'EDIT PRESENT') {
      cityList[cityListIndex.value] = commonEditTextEditingController.text;
      presentAddressTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD SCHOOL') {
      if (educationBackground.value == 'School') {
        schoolList.add(commonEditTextEditingController.text);
      } else {
        collegeList.add(commonEditTextEditingController.text);
      }
      commonEditTextEditingController.clear();
      educationInstituteTextEditingController.clear();
    } else if (functionFlag == 'EDIT SCHOOL') {
      schoolList[schoolIndex.value] = commonEditTextEditingController.text;
      educationInstituteTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT COLLEGE') {
      collegeList[collegeIndex.value] = commonEditTextEditingController.text;
      educationInstituteTextEditingController.clear();
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD WORKPLACE') {
      officeList.add({'office': commonEditTextEditingController.text, 'designation': commonEditSecondaryTextEditingController.text});
      officeNameTextEditingController.clear();
      commonEditTextEditingController.clear();
      commonEditSecondaryTextEditingController.clear();
    } else if (functionFlag == 'EDIT WORKPLACE') {
      officeList[officeIndex.value] = {'office': commonEditTextEditingController.text, 'designation': commonEditSecondaryTextEditingController.text};
      officeNameTextEditingController.clear();
      commonEditTextEditingController.clear();
      commonEditSecondaryTextEditingController.clear();
    } else if (functionFlag == 'ADD PHONE') {
      phoneList.add(commonEditTextEditingController.text);
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT PHONE') {
      phoneList[phoneIndex.value] = commonEditTextEditingController.text;
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'ADD EMAIL') {
      emailList.add(commonEditTextEditingController.text);
      commonEditTextEditingController.clear();
    } else if (functionFlag == 'EDIT EMAIL') {
      emailList[emailIndex.value] = commonEditTextEditingController.text;
      commonEditTextEditingController.clear();
    }
  }
}
