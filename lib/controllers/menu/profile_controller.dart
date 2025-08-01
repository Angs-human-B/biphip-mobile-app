import 'dart:io';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/menu/profile/profile_overview_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxBool showAllEditOption = RxBool(true);
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
  final Rx<IconData?> commonEditPageIcon = Rx<IconData?>(null);
  final RxBool isEditProfileLoading = RxBool(false);
  final RxBool postSectionVisible = RxBool(true);

  void playVideo(
    String videoUrl, {
    bool init = false,
  }) {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..addListener(() {})
      ..setLooping(true)
      ..initialize().then((value) => videoPlayerController.play());
  }

  void clearBio() {
    bioCount.value = 0;
    bioEditingController.clear();
  }

  //-----------------
  // !Edit About info
  //-----------------
  TextEditingController commonEditTextEditingController = TextEditingController();
  TextEditingController commonEditSecondaryTextEditingController = TextEditingController();
  final TextEditingController temporaryCommonEditSecondaryTextEditingController = TextEditingController();
  final RxString commonEditTextfieldHintText = RxString('');
  final RxBool isCommonEditDatePickerShown = RxBool(false);
  final RxBool isCommonEditPrivacyShown = RxBool(false);
  final RxBool isCommonEditCheckBoxShown = RxBool(false);
  final RxBool isCommonEditCheckBoxSelected = RxBool(false);
  final RxBool isDropdownShown = RxBool(false);
  final RxBool isSecondaryTextfieldShown = RxBool(false);
  final RxBool isRouteFromAboutInfo = RxBool(false);
  final RxString commonEditCheckBoxText = RxString('');
  final RxString commonEditPageTitle = RxString('');
  final RxBool editCommonSelectionBottomSheetRightButtonState = RxBool(false);
  final Rx<IconData> commonEditIconData = Rx<IconData>(BipHip.add);
  final RxString functionFlag = RxString('');
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
  final RxString commonStartDate = RxString('');
  final RxString temporaryCommonStartDate = RxString('');
  final RxBool commonEditStartDateBottomSheetRightButtonState = RxBool(false);
  final RxString commonEndDate = RxString('');
  final RxString temporaryCommonEndDate = RxString('');
  final RxBool commonEditEndDateBottomSheetRightButtonState = RxBool(false);
  final RxBool isCurrentlyLiveHere = RxBool(false);
  final RxBool isCurrentlyStudyingHere = RxBool(false);
  final RxBool isCurrentlyWorkingHere = RxBool(false);
  final List<String> cityList = [];
  final List<String> companyList = [];
  final List<String> schoolList = [];
  final RxString birthday = RxString('');
  final RxBool showEditRelationshipStatus = RxBool(false);
  final Rx<String?> commonEditTextFieldErrorText = Rx<String?>(null);
  final RxBool showCommonEditSuffixIcon = RxBool(false);
  final RxBool showCommonSecondaryEditSuffixIcon = RxBool(false);
  final RxList relationshipStatusList = RxList([]);
  final RxList genderList = RxList([]);
  final List<String> positionList = [];
  final RxList educationBackgroundList = RxList(['School', 'College']);
  final RxList linkSourceList = RxList([]);
  final RxString relationshipStatus = RxString('');
  final RxString relationshipDate = RxString('');
  final RxString temporaryRelationshipDate = RxString('');
  final RxBool relationshipDateBottomSheetState = RxBool(false);
  final TextEditingController relationshipPartnerTextEditingController = TextEditingController();
  final RxBool showRelationshipPartnerSuffixIcon = RxBool(false);
  final RxInt relationshipPartnerID = RxInt(-1);
  final RxList<FriendFamilyUserData> temporaryFriendList = RxList<FriendFamilyUserData>([]);
  final RxBool isRelationshipSaveButtonActive = RxBool(false);
  final RxString selectedGender = RxString('');
  final RxString temporarySelectedGender = RxString('');
  final RxBool isGenderSelected = RxBool(false);
  final RxString temporaryRelationshipStatus = RxString('');
  final RxBool relationshipBottomSheetRightButtonState = RxBool(false);
  final RxInt schoolID = RxInt(-1);
  final RxInt collegeID = RxInt(-1);
  final RxInt officeID = RxInt(-1);
  final RxInt phoneID = RxInt(-1);
  final RxInt emailID = RxInt(-1);
  final RxString educationBackground = RxString('');
  final RxString temporaryEducationBackground = RxString('');
  final RxString linkSource = RxString('');
  final RxString temporaryLinkSource = RxString('');
  final RxInt linkID = RxInt(-1);
  final RxInt deleteIndex = RxInt(-1);
  final RxBool viewOptionEnabled = RxBool(false);
  final RxString previewPhoto = RxString('');
  final RxBool isProfilePhoto = RxBool(true);
  final RxList<String> temporaryListCommon = RxList<String>([]);
  final RxBool enableSaveButton = RxBool(false);
  final RxString temporarySchoolStartDate = RxString('');
  final RxString temporarySchoolEndDate = RxString('');
  final RxString temporaryWorkplaceStartDate = RxString('');
  final RxString temporaryWorkplaceEndDate = RxString('');
  final RxBool isSingleDatePicker = RxBool(false);
  final RxBool genderBottomSheetButtonState = RxBool(false);

  void clearDataList() {
    otherCityList.clear();
    schoolDataList.clear();
    collegeDataList.clear();
    contactDataList.clear();
    emailDataList.clear();
    phoneDataList.clear();
    linkDataList.clear();
    userLanguages.clear();
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        schoolDataList.addAll(profileData.value!.schools);
        collegeDataList.addAll(profileData.value!.colleges);
        contactDataList.addAll(profileData.value!.contacts);
        userLanguages.addAll(profileData.value!.user!.languages);
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
        isProfileLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileLoading.value = true;
      ll('getProfileOverview error: $e');
    }
  }

  //* Set Hometown API Implementation
  Future<void> setHometown() async {
    try {
      isEditProfileLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'city': homeTownTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSetHomeTown,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        hometownData.value = CurrentCity.fromJson(response.data);
        otherCityList.add(CurrentCity.fromJson(response.data));
        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {'city': presentAddressTextEditingController.text.trim(), 'moved': commonStartDate.value};
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'city': presentAddressTextEditingController.text.trim(),
        if (isSingleDatePicker.value) 'moved': commonStartDate.value
      };
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreSchool,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        schoolDataList.add(College.fromJson(response.data));
        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreCollege,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        collegeDataList.add(College.fromJson(response.data));
        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'school': educationInstituteTextEditingController.text.trim(),
        'graduated': isCommonEditCheckBoxSelected.value ? '0' : '1',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'company': companyNameTextEditingController.text.trim(),
        'position': designationTextEditingController.text.trim(),
        'is_current': isCommonEditCheckBoxSelected.value ? '1' : '0',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'company': companyNameTextEditingController.text.trim(),
        'position': designationTextEditingController.text.trim(),
        'is_current': isCommonEditCheckBoxSelected.value ? '1' : '0',
        'started': commonStartDate.value,
        'ended': commonEndDate.value
      };
      ll(body);
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'type': type,
        'value': type == 'phone' ? phoneTextEditingController.text.trim() : emailTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'type': type,
        'value': type == 'phone' ? phoneTextEditingController.text.trim() : emailTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'type': type,
        'link': linkTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreLink,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        linkDataList.add(Link.fromJson(response.data));

        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'type': type.toString(),
        'link': linkTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'bio': bioEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateBio,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        if (isUpdate) {
          Get.back();
        }
        clearBio();
        isBioLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBioLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'dob': birthday.value,
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateDateOfBirth,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isEditProfileLoading.value = false;
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.mediaUpload(
        url: type == 'profile' ? kuSetProfilePicture : kuSetCoverPhoto,
        token: token,
        key: 'image',
        value: imageFile.path,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data.toString());
        CommonUserDataModel commonUserDataModel = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserDataModel.user;
        var rememberMe = await spController.getRememberMe();
        if (rememberMe == true) {
          await spController.saveUserList({
            "id": userData.value!.id,
            "email": userData.value!.email.toString(),
            "name": userData.value!.fullName.toString(),
            "first_name": userData.value!.firstName.toString(),
            "last_name": userData.value!.lastName.toString(),
            "image_url": userData.value!.profilePicture.toString(),
            "token": token.toString(),
          });
        }
        await spController.saveUserImage(userData.value!.profilePicture.toString());
        await globalController.getUserInfo();
        if (isFromProfile == true) {
          Get.back();
          isImageUploadPageLoading.value = false;
        } else {
          Get.find<HomeController>().homeTabIndex.value = 0;
          Get.offAllNamed(krHome);
          await Get.find<HomeController>().getPostList();
        }
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        if (isFromProfile == true) {
          isImageUploadPageLoading.value = false;
        }
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'key': key.toString(),
        'value': value.toString(),
        if (key.toString() == "relationship" && relationshipPartnerID.value != -1) 'partner_id': relationshipPartnerID.value.toString(),
        if (key.toString() == "relationship" && relationshipDate.value != "") 'date_since': relationshipDate.value.toString()
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSetGeneralSetting,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;

        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeUserSetting error: $e');
    }
  }

  //* get profession list API
  Rx<ProfessionListModel?> professionListData = Rx<ProfessionListModel?>(null);
  RxBool isProfessionListLoading = RxBool(false);
  Future<void> getProfessionList() async {
    try {
      isProfessionListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllProfessions,
      ) as CommonDM;
      if (response.success == true) {
        globalController.professionList.clear();
        professionListData.value = ProfessionListModel.fromJson(response.data);
        globalController.professionList.addAll(professionListData.value!.professions);
        isProfessionListLoading.value = false;
      } else {
        isProfessionListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfessionListLoading.value = true;
      ll('getProfessionList error: $e');
    }
  }

  //* get interest list API
  Rx<InterestListModel?> interestListData = Rx<InterestListModel?>(null);
  RxBool isInterestListLoading = RxBool(false);
  RxList temporaryInterestList = RxList([]);
  Future<void> getInterestList() async {
    try {
      isInterestListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllInterests,
      ) as CommonDM;
      if (response.success == true) {
        temporaryInterestList.clear();
        globalController.interestList.clear();
        interestListData.value = InterestListModel.fromJson(response.data);
        temporaryInterestList.addAll(interestListData.value!.interests);
        for (int i = 0; i < temporaryInterestList.length; i++) {
          if (!globalController.interestList.contains(temporaryInterestList[i])) {
            globalController.interestList.add(temporaryInterestList[i]);
          }
        }
        isInterestListLoading.value = false;
      } else {
        isInterestListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isInterestListLoading.value = true;
      ll('getInterestList error: $e');
    }
  }

  //* set profession API implementation
  Future<void> setProfession(profession) async {
    List professionList = [];
    professionList.add(profession);
    try {
      isEditProfileLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {'key': 'profession', 'value': professionList};
      ll(body);
      var response = await apiController.commonPostDio(
        url: kuSetGeneralSetting,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('setProfession error: $e');
    }
  }

  //* set profession API implementation
  Future<void> setInterest(interest) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {'key': 'interest', 'value': interest};
      var response = await apiController.commonPostDio(
        url: kuSetGeneralSetting,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data);
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        isGenderListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isGenderListLoading.value = true;
      ll('getGenderList error: $e');
    }
  }

  //* get relationship list API
  Rx<RelationshipListModel?> relationshipListData = Rx<RelationshipListModel?>(null);
  RxBool isRelationListLoading = RxBool(false);
  Future<void> getRelationshipList() async {
    try {
      isRelationListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        isRelationListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isRelationListLoading.value = true;
      ll('getRelationshipList error: $e');
    }
  }

  //* get position list API
  Rx<PositionListModel?> positionListData = Rx<PositionListModel?>(null);
  RxList<String> temp = RxList<String>();
  Future<void> getPositionList() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        isLinkListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isLinkListLoading.value = true;
      ll('getLinkList error: $e');
    }
  }

  //* Get city list api implementation
  Rx<CityListModel?> cityListData = Rx<CityListModel?>(null);
  Future<void> getCityList() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllCities,
      ) as CommonDM;
      if (response.success == true) {
        cityList.clear();
        cityListData.value = CityListModel.fromJson(response.data);
        cityList.addAll(cityListData.value!.cities);
        temporaryListCommon.addAll(cityList);
        isLinkListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getCityList error: $e');
    }
  }

  //* Get city list api implementation
  Rx<CompanyListModel?> companyListData = Rx<CompanyListModel?>(null);
  Future<void> getCompanyList() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllCompanies,
      ) as CommonDM;
      if (response.success == true) {
        companyList.clear();
        companyListData.value = CompanyListModel.fromJson(response.data);
        companyList.addAll(companyListData.value!.companies);
        temporaryListCommon.addAll(companyList);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getCompanyList error: $e');
    }
  }

  //* Get school list api implementation
  Rx<SchoolListModel?> schoolListData = Rx<SchoolListModel?>(null);
  Future<void> getSchoolList() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllSchools,
      ) as CommonDM;
      if (response.success == true) {
        schoolList.clear();
        schoolListData.value = SchoolListModel.fromJson(response.data);
        schoolList.addAll(schoolListData.value!.schools);
        temporaryListCommon.addAll(schoolList);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getSchoolList error: $e');
    }
  }

  //* Get Language list api implementation
  Rx<LanguageListModel?> languageListData = Rx<LanguageListModel?>(null);
  final TextEditingController searchLanguageTextEditingController = TextEditingController();
  final RxBool isAddLanguageButtonEnabled = RxBool(false);
  final RxString addedLanguage = RxString("");
  List<String> allLanguageList = [];
  RxList<String> userLanguages = RxList<String>([]);
  RxBool isSearchLanguageSuffixIconShowing = RxBool(false);
  Future<void> getLanguageList() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetALlLanguageList,
      ) as CommonDM;
      if (response.success == true) {
        allLanguageList.clear();
        languageListData.value = LanguageListModel.fromJson(response.data);
        allLanguageList.addAll(languageListData.value!.languages);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getLanguageList error: $e');
    }
  }

  Future<void> storeLanguages(languages) async {
    try {
      isEditProfileLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'languages': languages,
      };
      var response = await apiController.commonPostDio(
        url: kuUpdateLanguages,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        userLanguages.clear();
        commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        userData.value = commonUserLayeredData.value!.user;
        userLanguages.addAll(userData.value!.languages);
        isEditProfileLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditProfileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditProfileLoading.value = false;
      ll('storeLanguages error: $e');
    }
  }
}
