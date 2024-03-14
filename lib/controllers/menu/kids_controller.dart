import 'dart:convert';
import 'dart:io';
import 'package:bip_hip/models/menu/kids/all_hobbies_model.dart';
import 'package:bip_hip/models/menu/kids/all_kids_model.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/kid_bio_update_model.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/kid_overview_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/models/menu/profile/profile_overview_model.dart';
import 'package:bip_hip/models/post/kid_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidsController extends GetxController {
  final RxInt kidId = RxInt(-1);
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  //   //*Kids List Api Call
  final Rx<AllKidsModel?> kidsListData = Rx<AllKidsModel?>(null);
  final RxList<Kid> kidList = RxList<Kid>([]);
  final RxBool isKidsListLoading = RxBool(false);
  final RxInt totalKidsCount = RxInt(0);
  Future<void> getKidsList() async {
    try {
      isKidsListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllKidList,
      ) as CommonDM;
      if (response.success == true) {
        kidList.clear();
        kidsListData.value = AllKidsModel.fromJson(response.data);
        kidList.addAll(kidsListData.value!.kids);
        totalKidsCount.value = kidList.length;
        isKidsListLoading.value = false;
      } else {
        isKidsListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidsListLoading.value = true;
      ll('getKidsList error: $e');
    }
  }

  //*Delete Kid Api Call
  final RxBool isKidDeleteLoading = RxBool(false);
  Future<void> kidDelete() async {
    try {
      isKidDeleteLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteKids/${kidId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index <= kidList.length; index++) {
          if (kidId.value == kidList[index].id) {
            kidList.removeAt(index);
            totalKidsCount.value--;
          }
        }
        isKidDeleteLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidDeleteLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidDeleteLoading.value = false;
      ll('kidDelete error: $e');
    }
  }

  //Edit kid
  final RxBool saveKidInfo = RxBool(false);
  final RxString kidImageLink = RxString('');
  final Rx<File> kidImageFile = File('').obs;
  final RxBool isKidImageChanged = RxBool(false);
  final TextEditingController kidNameTextEditingController = TextEditingController();
  final TextEditingController kidAgeTextEditingController = TextEditingController();
  final TextEditingController kidSchoolNameTextEditingController = TextEditingController();
  final RxBool isSaveKidButtonEnabled = RxBool(false);
  final RxBool isKidAdded = RxBool(false);
  final RxBool isKidSelected = RxBool(false);
  final RxString kidName = RxString('');
  final RxString kidAge = RxString('');
  final Rx<String?> kidNameErrorText = Rx<String?>(null);
  final Rx<String?> kidAgeErrorText = Rx<String?>(null);
  final RxBool isNextButtonEnabled = RxBool(false);
  void checkNextButtonEnable() {
    if (kidNameTextEditingController.text.trim().length >= 3 &&
        (kidAgeTextEditingController.text.isNotEmpty && int.parse(kidAgeTextEditingController.text.toString()) <= 17)) {
      isNextButtonEnabled.value = true;
    } else {
      isNextButtonEnabled.value = false;
    }
  }

  void kidNameOnChanged() {
    checkNextButtonEnable();
    if (kidNameTextEditingController.text.toString().trim() == '') {
      kidNameErrorText.value = ksEmptyNameErrorText.tr;
    } else if (kidNameTextEditingController.text.trim().length < 3) {
      kidNameErrorText.value = ksKidNameLengthErrorText.tr;
    } else {
      kidNameErrorText.value = null;
    }
  }

  void kidAgeOnChanged() {
    checkNextButtonEnable();
    if (kidAgeTextEditingController.text.toString().trim() == '') {
      kidAgeErrorText.value = ksEmptyKidAgeErrorText.tr;
    } else if (kidAgeTextEditingController.text.toString().trim() != '' && int.parse(kidAgeTextEditingController.text.toString()) > 17) {
      kidAgeErrorText.value = ksKidAgeErrorText.tr;
    } else {
      kidAgeErrorText.value = null;
    }
  }

  final TextEditingController kidParentEmailController = TextEditingController();
  final TextEditingController kidParentPhoneController = TextEditingController();
  final TextEditingController kidParentAddressController = TextEditingController();
  final TextEditingController kidBioController = TextEditingController();
  final RxInt kidBioCount = RxInt(0);

  //*Social Links
  final TextEditingController kidWebsiteController = TextEditingController();
  final TextEditingController kidFacebookController = TextEditingController();
  final TextEditingController kidInstagramController = TextEditingController();
  final TextEditingController kidTwitterController = TextEditingController();
  final TextEditingController kidYoutubeController = TextEditingController();

  //*Kid Profile and cover photo
  final RxString kidProfileImageLink = RxString('');
  final Rx<File> kidProfileImageFile = File('').obs;
  final RxBool isKidProfileImageChanged = RxBool(false);
  final RxString kidCoverImageLink = RxString('');
  final Rx<File> kidCoverImageFile = File('').obs;
  final RxBool isKidCoverImageChanged = RxBool(false);

  final List kidRelationList = (['Father', 'Mother', 'Sister', 'Brother']);
  final kidRelationMap = [
    {
      "relation": "Father",
      "relation_id": "0",
    },
    {
      "relation": "Mother",
      "relation_id": "1",
    },
    {
      "relation": "Sister",
      "relation_id": "2",
    },
    {
      "relation": "Brother",
      "relation_id": "3",
    },
  ];
  final RxString selectedKidRelation = RxString('');
  final RxString tempSelectedKidRelation = RxString('');

  final List kidGenderList = (['Male', 'Female', 'Others']);
  final RxString selectedKidGender = RxString('');
  final RxString tempSelectedKidGender = RxString('');

  void resetKidProfilePictureData() {
    isKidProfileImageChanged.value = false;
    kidImageLink.value = '';
    kidProfileImageFile.value = File('');
  }

  void resetKidCoverPhotoData() {
    isKidCoverImageChanged.value = false;
    kidCoverImageLink.value = '';
    kidCoverImageFile.value = File('');
  }

  final RxBool isContactInfoNextButtonEnabled = RxBool(false);

  void resetKidContactInfo() {
    kidParentEmailController.clear();
    kidParentPhoneController.clear();
    kidParentAddressController.clear();
    kidBioController.clear();
    kidParentEmailErrorText.value = null;
    isContactInfoNextButtonEnabled.value = false;
  }

  void checkContactInfoNextButtonEnabled() {
    if ((kidParentPhoneController.text.toString().trim() != '' ||
            kidParentAddressController.text.toString().trim() != '' ||
            kidBioController.text.toString().trim() != '' ||
            kidParentEmailController.text.toString().trim().isValidEmail) &&
        kidParentEmailErrorText.value == null) {
      isContactInfoNextButtonEnabled.value = true;
    } else {
      isContactInfoNextButtonEnabled.value = false;
    }
  }

  void resetkidSocialLink() {
    kidWebsiteController.clear();
    kidFacebookController.clear();
    kidInstagramController.clear();
    kidTwitterController.clear();
    kidYoutubeController.clear();
  }

  final Rx<String?> kidParentEmailErrorText = Rx<String?>(null);

  void kidParentEmailValidation() {
    if (kidParentEmailController.text.toString().trim() != '' && !kidParentEmailController.text.toString().trim().isValidEmail) {
      kidParentEmailErrorText.value = ksInvalidEmailErrorMessage.tr;
    } else {
      kidParentEmailErrorText.value = null;
    }
    checkContactInfoNextButtonEnabled();
  }

  void resetKidsData() {
    kidNameTextEditingController.clear();
    kidAgeTextEditingController.clear();
    kidSchoolNameTextEditingController.clear();
    resetKidContactInfo();
    resetkidSocialLink();
    isNextButtonEnabled.value = false;
    kidNameErrorText.value = null;
    kidAgeErrorText.value = null;
    tempSelectedKidRelation.value = '';
    selectedKidRelation.value = '';
    tempSelectedKidGender.value = '';
    selectedKidGender.value = '';
    kidBioCount.value = 0;
    resetKidProfilePictureData();
    resetKidCoverPhotoData();
  }

  //*Edit Kid Api Call
  final RxBool isEditKidLoading = RxBool(false);
  Future<void> editKid() async {
    try {
      isEditKidLoading.value = true;
      String? token = await spController.getBearerToken();

      Map<String, String> body = {
        'id': kidId.value.toString(),
        'name': kidNameTextEditingController.text.trim(),
        'age': kidAgeTextEditingController.text.trim(),
      };
      var response;
      if (isKidImageChanged.value) {
        response = await apiController.mediaUpload(
          url: kuUpdateKid,
          body: body,
          token: token,
          key: 'image',
          value: kidImageFile.value.path,
        ) as CommonDM;
      } else {
        response = await apiController.commonApiCall(
          requestMethod: kPost,
          url: kuUpdateKid,
          body: body,
          token: token,
        ) as CommonDM;
      }

      if (response.success == true) {
        await getKidsList();
        isEditKidLoading.value = false;
        isKidImageChanged.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditKidLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditKidLoading.value = false;
      ll('editKid error: $e');
    }
  }

  //*Add kid API Implementation
  Rx<KidModel?> kidData = Rx<KidModel?>(null);
  // RxList<PostCategory> postCategoryList = RxList<PostCategory>([]);
  final RxBool isAddKidLoading = RxBool(false);
  Future<void> addKid() async {
    try {
      isAddKidLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'name': kidNameTextEditingController.text.toString().trim(),
        'relation_id': '1',
        'age': kidAgeTextEditingController.text.toString().trim(),
        'gender': selectedKidGender.value,
        'school_name': kidSchoolNameTextEditingController.text.toString().trim(),
        'email': kidParentEmailController.text.toString().trim(),
        'phone': kidParentPhoneController.text.toString().trim(),
        'address': kidParentAddressController.text.toString().trim(),
        'bio': kidBioController.text.toString().trim(),
        'social_links': json.encode(kidSocialLinkList),
      };
      final List<String> key = ['profile_picture', 'cover_photo'];
      final List<dynamic> value = [kidProfileImageFile.value.path, kidCoverImageFile.value.path];
      var response = await apiController.mediaUploadMultipleKeyAndValue(
        url: kuAddKid,
        body: body,
        token: token,
        keys: key,
        values: value,
      ) as CommonDM;

      if (response.success == true) {
        kidData.value = KidModel.fromJson(response.data);
        ll(kidData.value!.name);
        getKidsList();
        isAddKidLoading.value = false;
        Get.offNamedUntil(krKidsPage, ModalRoute.withName(krMenu));
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAddKidLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddKidLoading.value = false;
      ll('addKid error: $e');
    }
  }

  final RxList kidSocialLinkList = RxList([]);

  void kidSocialLink() {
    kidSocialLinkList.clear();
    if (kidWebsiteController.text.toString().trim() != '') {
      kidSocialLinkList.add({'Web': kidWebsiteController.text.toString().trim()});
    }
    if (kidFacebookController.text.toString().trim() != '') {
      kidSocialLinkList.add({'Facebook': kidFacebookController.text.toString().trim()});
    }
    if (kidInstagramController.text.toString().trim() != '') {
      kidSocialLinkList.add({'Instagram': kidInstagramController.text.toString().trim()});
    }
    if (kidTwitterController.text.toString().trim() != '') {
      kidSocialLinkList.add({'Twitter': kidTwitterController.text.toString().trim()});
    }
    if (kidYoutubeController.text.toString().trim() != '') {
      kidSocialLinkList.add({'Youtube': kidYoutubeController.text.toString().trim()});
    }
    ll(kidSocialLinkList);
  }

  //!Kid profile
  final RxString profileImageLink = RxString('');
  final Rx<File> profileImageFile = File('').obs;
  final Rx<File> newProfileImageFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxString coverImageLink = RxString('');
  final Rx<File> coverImageFile = File('').obs;
  final Rx<File> newCoverImageFile = File('').obs;
  final RxBool isCoverImageChanged = RxBool(false);
  final RxBool isSharedToNewFeed = RxBool(false);
  final RxBool isKidProfilePicEditor = RxBool(false);
  final RxBool kidViewOptionEnabled = RxBool(false);
  final Rx<String?> kidBio = Rx<String?>(null);
  final TextEditingController kidBioEditingController = TextEditingController();
  final RxInt bioCount = RxInt(0);
  final RxBool isKidProfilePhoto = RxBool(false);
  final RxString kidPreviewPhoto = RxString('');
  final RxList<int> hobbiesIndex = RxList<int>([]);
  final RxList selectedHobbies = RxList([]);
  final RxList temporarySelectedHobbies = RxList([]);
  final RxList kidPhoneNumberList = RxList(['017236748765478', '019823973893']);
  final RxList kidEmailList = RxList(['abcdef@gmail.com', 'hjfdnd@gmail.com']);
  final TextEditingController kidEducationInstituteTextEditingController = TextEditingController();
  final RxBool isKidCurrentlyStudyingHere = RxBool(false);
  final RxString temporaryKidSchoolStartDate = RxString('');
  final RxString temporaryKidSchoolEndDate = RxString('');
  final TextEditingController kidPhoneNumberTextEditingController = TextEditingController();
  final TextEditingController kidEmailTextEditingController = TextEditingController();
  final RxBool enableKidSaveButton = RxBool(false);
  final RxString kidCommonEditPageTitle = RxString('');
  final RxString kidFunctionFlag = RxString('');
  final RxString kidEducationBackground = RxString('');
  final RxString kidTemporaryEducationBackground = RxString('');
  final RxInt deleteIndex = RxInt(-1);
  final RxBool isDropdownShown = RxBool(false);
  final RxBool editCommonSelectionBottomSheetRightButtonState = RxBool(false);
  final RxString kidGender = RxString('');
  final RxBool isKidGenderSelected = RxBool(false);
  final Rx<DateTime?> kidDob = Rx<DateTime?>(DateTime.now());
  final Rx<String?> kidRelation = Rx<String?>(null);
  final RxString temporaryKidRelationData = RxString('');
  final RxString kidRelationData = RxString('');
  final RxString temporaryKidRelationId = RxString('');
  final RxString kidRelationId = RxString('');
  final RxBool isKidRelationSaveButtonActive = RxBool(false);
  final RxBool kidRelationDataBottomSheetState = RxBool(false);
  final RxString temporaryKidGender = RxString('');
  final RxBool kidGenderBottomSheetState = RxBool(false);
  final RxInt kidInterestCatagoriesIndex = RxInt(-1);
  final RxBool isKidInterestSelected = RxBool(false);
  final Rx<IconData> kidCommonEditIconData = Rx<IconData>(BipHip.add);
  final RxBool isKidSecondaryTextfieldShown = RxBool(false);
  TextEditingController kidCommonEditTextEditingController = TextEditingController();
  TextEditingController kidCommonEditSecondaryTextEditingController = TextEditingController();
  final RxString commonEditTextfieldHintText = RxString('');
  final RxBool isCommonEditDatePickerShown = RxBool(false);
  final RxBool isCommonEditPrivacyShown = RxBool(false);
  final RxBool isCommonEditCheckBoxShown = RxBool(false);
  final RxBool isCommonEditCheckBoxSelected = RxBool(false);
  final RxString commonEditCheckBoxText = RxString('');
  final RxString commonStartDate = RxString('');
  final RxString commonEndDate = RxString('');
  final RxBool isSingleDatePicker = RxBool(false);
  final RxBool showCommonSecondaryEditSuffixIcon = RxBool(false);
  final RxList<String> temporaryListCommon = RxList<String>([]);
  final Rx<IconData?> commonEditPageIcon = Rx<IconData?>(null);
  final RxBool showCommonEditSuffixIcon = RxBool(false);
  RxList<String> temporaryList = RxList<String>();
  final List kidSchoolList = ['abc school', 'def school', 'ghi school'];
  TextEditingController kidSearchLanguageTextEditingController = TextEditingController();
  // final RxBool isSearchLanguageSuffixIconShowing = RxBool(false);
  final RxInt kidProfileTabIndex = RxInt(0);
  final RxBool seeMore = RxBool(false);
  //* kid data reset
  void resetKidProfileData() {
    kidInterestCatagoriesIndex.value = -1;
    isKidInterestSelected.value = false;
    kidProfileTabIndex.value = 0;
  }

  //*Kid Overview Api call
  final Rx<KidOverviewModel?> kidOverviewData = Rx<KidOverviewModel?>(null);
  final RxList<FeaturePost> featuredPostList = RxList<FeaturePost>([]);
  final Rx<Kids?> kidsData = Rx<Kids?>(null);
  final RxBool isKidOverviewLoading = RxBool(false);
  final RxInt selectedKidId = RxInt(-1);
  Future<void> getKidOverview() async {
    try {
      isKidOverviewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuKidOverview/${selectedKidId.value}",
      ) as CommonDM;
      if (response.success == true) {
        clearDataList();
        featuredPostList.clear();
        kidOverviewData.value = KidOverviewModel.fromJson(response.data);
        kidsData.value = kidOverviewData.value!.kids;
        featuredPostList.addAll(kidOverviewData.value!.featurePost);
        kidBio.value = kidsData.value!.bio;
        kidGender.value = kidsData.value?.gender;
        userLanguages.addAll(kidsData.value!.languages);
        selectedHobbies.addAll(kidsData.value!.hobbies);
        kidRelation.value = kidsData.value?.relation.toString();
        isKidOverviewLoading.value = false;
      } else {
        isKidOverviewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidOverviewLoading.value = true;
      ll('getKidOverview error: $e');
    }
  }

  void clearBio() {
    bioCount.value = 0;
    kidBioEditingController.clear();
  }

  //* update Kid bio API Implementation
  final Rx<KidBioUpdateModel?> kidBioUpdateData = Rx<KidBioUpdateModel?>(null);
  // final Rx<Kids?> kidsData = Rx<Kids?>(null);
  RxBool isKidBioLoading = RxBool(false);
  Future<void> updateKidBio([isUpdate = true]) async {
    try {
      isKidBioLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
        'bio': kidBioEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuKidUpdateBio,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        kidBioUpdateData.value = KidBioUpdateModel.fromJson(response.data);
        kidsData.value = kidBioUpdateData.value!.kids;
        kidBio.value = kidsData.value!.bio;
        ll(kidsData.value!.bio);

        if (isUpdate) {
          Get.back();
        }
        clearBio();
        isKidBioLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isKidBioLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidBioLoading.value = false;
      ll('updateKidBio error: $e');
    }
  }

  // //* upload profile photo
  final RxBool isImageUploadPageLoading = RxBool(false);
  Future<void> uploadKidProfileAndCover(File imageFile, String type, [isFromProfile = true]) async {
    try {
      // if (isFromProfile == true) {
      isImageUploadPageLoading.value = true;
      // }
      String? token = await spController.getBearerToken();
      List<String> key = [];
      List<dynamic> value = [];
      key.add('kid_id');
      value.add(selectedKidId.value.toString());
      if (type == 'profile') {
        key.add('profile_image');
        // value.add(newProfileImageFile.value);
      } else {
        key.add('cover_photo');
        // value.add(coverImageFile.value);
      }
      value.add(imageFile);
      ll(key);
      ll(value);
      var response = await apiController.mediaUploadMultipleKeyAndValue(
        url: type == 'profile' ? kuKidUpdateProfilePicture : kuKidUpdateCoverPhoto,
        token: token,
        keys: key,
        values: value,
      ) as CommonDM;

      if (response.success == true) {
        // ll(response.data.toString());
        // KidBioUpdateModel kidsModelData = KidBioUpdateModel.fromJson(response.data);
        // kidsData.value = kidsModelData.kids;
        // var rememberMe = await spController.getRememberMe();
        // if (rememberMe == true) {
        //   // await spController.saveUserList({
        //   //   "email": userData.value!.email.toString(),
        //   //   "name": userData.value!.fullName.toString(),
        //   //   "first_name": userData.value!.firstName.toString(),
        //   //   "last_name": userData.value!.lastName.toString(),
        //   //   "image_url": userData.value!.profilePicture.toString(),
        //   //   "token": token.toString(),
        //   // });
        // }
        // await spController.saveUserImage(kidsData.value!.profilePicture.toString());
        // await globalController.getUserInfo();
        // if (isFromProfile == true) {
        //   Get.back();
        //   isImageUploadPageLoading.value = false;
        // } else {
        //   Get.offAllNamed(krHome);
        // }
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
      ll('uploadProfileAndCover error: $e');
    }
  }

  // final Rx<Kids?> kidsData = Rx<Kids?>(null);
  // final Rx<Kids?> kidRelationModelData = Rx<Kids?>(null);
  RxBool isKidRelationLoading = RxBool(false);
  Future<void> updateKidRelation() async {
    try {
      isKidRelationLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
        'relation_id': kidRelationId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuKidUpdateParentRelation,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        kidRelation.value = kidsData.value?.relation;
        ll(kidRelation.value);
        isKidRelationLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isKidRelationLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidRelationLoading.value = false;
      ll('updateKidRelation error: $e');
    }
  }

  final RxList genderList = RxList([]);
  //* get gender list API
  Rx<GenderListModel?> genderListData = Rx<GenderListModel?>(null);
  RxBool isGenderListLoading = RxBool(false);
  Future<void> getKidGenderList() async {
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

  RxBool isKidGenderLoading = RxBool(false);
  Future<void> updateKidGender() async {
    try {
      isKidGenderLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
        'gender': kidGender.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuKidUpdateGender,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        // kidRelation.value = kidsData.value?.relation;
        // ll(kidRelation.value);
        isKidGenderLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isKidGenderLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidGenderLoading.value = false;
      ll('updateKidGender error: $e');
    }
  }

  void clearDataList() {
    // otherCityList.clear();
    // schoolDataList.clear();
    // collegeDataList.clear();
    // contactDataList.clear();
    // emailDataList.clear();
    // phoneDataList.clear();
    // linkDataList.clear();
    userLanguages.clear();
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

  final RxBool isStoreLanguageLoading = RxBool(false);
  Future<void> storeLanguages(languages) async {
    try {
      isStoreLanguageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
        'languages': languages,
      };
      ll(body);
      var response = await apiController.commonPostDio(
        url: kuKidUpdateLanguages,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        userLanguages.clear();
        kidBioUpdateData.value = KidBioUpdateModel.fromJson(response.data);
        kidsData.value = kidBioUpdateData.value!.kids;
        userLanguages.addAll(kidsData.value!.languages);
        isStoreLanguageLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreLanguageLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreLanguageLoading.value = false;
      ll('storeLanguages error: $e');
    }
  }

  //* get Hobbies list API
  final RxList hobbiesList = RxList([]);
  Rx<AllHobbiesModel?> allHobbiesListData = Rx<AllHobbiesModel?>(null);
  RxBool isAllHobbiesListLoading = RxBool(false);
  RxList temporaryHobbiesList = RxList([]);
  Future<void> getAllHobbiesList() async {
    try {
      isAllHobbiesListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllHobbies,
      ) as CommonDM;
      if (response.success == true) {
        temporaryHobbiesList.clear();
        hobbiesList.clear();
        allHobbiesListData.value = AllHobbiesModel.fromJson(response.data);
        temporaryHobbiesList.addAll(allHobbiesListData.value!.hobbies);
        for (int i = 0; i < temporaryHobbiesList.length; i++) {
          if (hobbiesList.contains(temporaryHobbiesList[i])) {
            hobbiesList.add(temporaryHobbiesList[i]);
            ll(hobbiesList);
          }
        }
        isAllHobbiesListLoading.value = false;
      } else {
        isAllHobbiesListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAllHobbiesListLoading.value = true;
      ll('getAllHobbiesList error: $e');
    }
  }
  //* set Hobbies API implementation
  final RxBool isSetHobbiesLoading = RxBool(false);
  Future<void> setHobbies(hobbies) async {
    ll(interest);
    try {
      isSetHobbiesLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
       'hobbies': hobbies
       };
      ll(body);
      var response = await apiController.commonPostDio(
        url: kuKidUpdateHobbies,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data);
         selectedHobbies.clear();
        kidBioUpdateData.value = KidBioUpdateModel.fromJson(response.data);
        kidsData.value = kidBioUpdateData.value!.kids;
        selectedHobbies.addAll(kidsData.value!.hobbies);
        // commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        // userData.value = commonUserLayeredData.value!.user;
        isSetHobbiesLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isSetHobbiesLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSetHobbiesLoading.value = false;
      ll('setHobbies error: $e');
    }
  }

  // //* store contact API Implementation
  // RxList<Contact> contactDataList = RxList<Contact>([]);
  // RxList<Contact> emailDataList = RxList<Contact>([]);
  // RxList<Contact> phoneDataList = RxList<Contact>([]);
  // Future<void> storeContact(type) async {
  //   try {
  //     isEditProfileLoading.value = true;
  //     String? token = await spController.getBearerToken();
  //     Map<String, dynamic> body = {
  //       'type': type,
  //       'value': type == 'phone' ? phoneTextEditingController.text.trim() : emailTextEditingController.text.trim(),
  //     };
  //     var response = await apiController.commonApiCall(
  //       requestMethod: kPost,
  //       url: kuStoreContact,
  //       body: body,
  //       token: token,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       emailDataList.clear();
  //       phoneDataList.clear();
  //       contactDataList.add(Contact.fromJson(response.data));
  //       for (int i = 0; i < contactDataList.length; i++) {
  //         if (contactDataList[i].type == 'email') {
  //           emailDataList.add(contactDataList[i]);
  //         } else {
  //           phoneDataList.add(contactDataList[i]);
  //         }
  //       }
  //       isEditProfileLoading.value = false;
  //       globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
  //     } else {
  //       isEditProfileLoading.value = false;
  //       ErrorModel errorModel = ErrorModel.fromJson(response.data);
  //       if (errorModel.errors.isEmpty) {
  //         globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
  //       } else {
  //         globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
  //       }
  //     }
  //   } catch (e) {
  //     isEditProfileLoading.value = false;
  //     ll('storeContact error: $e');
  //   }
  // }

  // //* update contact API Implementation
  // Future<void> updateContact(id, type) async {
  //   try {
  //     isEditProfileLoading.value = true;
  //     String? token = await spController.getBearerToken();
  //     Map<String, dynamic> body = {
  //       'id': id.toString(),
  //       'type': type,
  //       'value': type == 'phone' ? phoneTextEditingController.text.trim() : emailTextEditingController.text.trim(),
  //     };
  //     var response = await apiController.commonApiCall(
  //       requestMethod: kPost,
  //       url: kuUpdateContact,
  //       body: body,
  //       token: token,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       for (int i = 0; i < contactDataList.length; i++) {
  //         if (contactDataList[i].id == id) {
  //           contactDataList[i] = Contact.fromJson(response.data);
  //         }
  //       }
  //       isEditProfileLoading.value = false;
  //       globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
  //     } else {
  //       isEditProfileLoading.value = false;
  //       ErrorModel errorModel = ErrorModel.fromJson(response.data);
  //       if (errorModel.errors.isEmpty) {
  //         globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
  //       } else {
  //         globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
  //       }
  //     }
  //   } catch (e) {
  //     isEditProfileLoading.value = false;
  //     ll('updateContact error: $e');
  //   }
  // }

  // //* delete contact API Implementation
  // Future<void> deleteContact(id) async {
  //   try {
  //     isEditProfileLoading.value = true;
  //     String? token = await spController.getBearerToken();
  //     var response = await apiController.commonApiCall(
  //       requestMethod: kDelete,
  //       url: '$kuDeleteContact/${id.toString()}',
  //       token: token,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       emailDataList.clear();
  //       phoneDataList.clear();
  //       for (int i = 0; i < contactDataList.length; i++) {
  //         if (contactDataList[i].id == id) {
  //           contactDataList.removeAt(i);
  //         }
  //       }
  //       for (int i = 0; i < contactDataList.length; i++) {
  //         if (contactDataList[i].type == 'email') {
  //           emailDataList.add(contactDataList[i]);
  //         } else {
  //           phoneDataList.add(contactDataList[i]);
  //         }
  //       }
  //       isEditProfileLoading.value = false;
  //       globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
  //     } else {
  //       isEditProfileLoading.value = false;
  //       ErrorModel errorModel = ErrorModel.fromJson(response.data);
  //       if (errorModel.errors.isEmpty) {
  //         globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
  //       } else {
  //         globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
  //       }
  //     }
  //   } catch (e) {
  //     isEditProfileLoading.value = false;
  //     ll('deleteContact error: $e');
  //   }
  // }

}
