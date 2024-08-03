import 'dart:convert';
import 'dart:io';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/models/menu/family/family_relation_model.dart';
import 'package:bip_hip/models/menu/kids/all_hobbies_model.dart';
import 'package:bip_hip/models/menu/kids/all_kids_model.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/get_kid_post_model.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/kid_bio_update_model.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/kid_overview_model.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/kid_school_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/models/post/kid_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidsController extends GetxController {
  final RxInt kidId = RxInt(-1);
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  //*Kids List Api Call
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

  //*Edit kid
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
  final Rx<String?> kidGender = Rx<String?>(null);
  final RxBool isKidGenderSelected = RxBool(false);
  final Rx<DateTime?> kidDob = Rx<DateTime?>(DateTime.now());
  final Rx<String?> kidRelation = Rx<String?>(null);
  final RxInt kidRelationId = RxInt(-1);
  final RxBool isKidRelationSaveButtonActive = RxBool(false);
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
  final RxBool isSingleDatePicker = RxBool(false);
  final RxBool showCommonSecondaryEditSuffixIcon = RxBool(false);
  final RxList<String> temporaryListCommon = RxList<String>([]);
  final Rx<IconData?> commonEditPageIcon = Rx<IconData?>(null);
  final RxBool showCommonEditSuffixIcon = RxBool(false);
  RxList<String> temporaryList = RxList<String>();
  TextEditingController kidSearchLanguageTextEditingController = TextEditingController();
  final RxString commonStartDate = RxString('');
  final RxString temporaryCommonStartDate = RxString('');
  final RxString commonEndDate = RxString('');
  final RxString temporaryCommonEndDate = RxString('');
  final RxBool commonEditStartDateBottomSheetRightButtonState = RxBool(false);
  final RxBool commonEditEndDateBottomSheetRightButtonState = RxBool(false);
  final RxInt kidProfileTabIndex = RxInt(0);
  final RxBool seeMore = RxBool(false);
  final RxBool isPostButtonActive = RxBool(false);
  final RxBool isRouteFromKid = RxBool(false);

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
        kidRelation.value = kidsData.value?.relation;
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

  //* upload profile photo
  final RxBool isImageUploadPageLoading = RxBool(false);
  final Rx<KidBioUpdateModel?> kidProfileCoverData = Rx<KidBioUpdateModel?>(null);
  Future<void> uploadKidProfileAndCover(File imageFile, String type, [isFromProfile = true]) async {
    try {
      isImageUploadPageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'kid_id': selectedKidId.value.toString(),
      };
      var response = await apiController.mediaUpload(
        url: type == 'profile' ? kuKidUpdateProfilePicture : kuKidUpdateCoverPhoto,
        token: token,
        body: body,
        key: type == 'profile' ? "profile_image" : "cover_photo",
        value: imageFile.path,
      ) as CommonDM;

      if (response.success == true) {
        await getKidOverview();
        isImageUploadPageLoading.value = false;
        Get.back();
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
        await getKidOverview();
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
    userLanguages.clear();
    selectedHobbies.clear();
    hobbiesIndex.clear();
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
  final RxList allHobbiesList = RxList([]);
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
        allHobbiesList.clear();
        allHobbiesListData.value = AllHobbiesModel.fromJson(response.data);
        temporaryHobbiesList.addAll(allHobbiesListData.value!.hobbies);
        for (int i = 0; i < temporaryHobbiesList.length; i++) {
          if (!allHobbiesList.contains(temporaryHobbiesList[i])) {
            allHobbiesList.add(temporaryHobbiesList[i]);
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
    try {
      isSetHobbiesLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
        'hobbies': hobbies.join(','),
      };
      ll(body);
      var response = await apiController.commonPostDio(
        url: kuKidUpdateHobbies,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        selectedHobbies.clear();
        kidBioUpdateData.value = KidBioUpdateModel.fromJson(response.data);
        kidsData.value = kidBioUpdateData.value!.kids;
        selectedHobbies.addAll(kidsData.value!.hobbies);
        isSetHobbiesLoading.value = false;
        Get.back();
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

  //* Get school list api implementation
  final List<String> schoolList = [];
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

  //* Kid All school list api implementation
  Rx<KidSchoolModel?> kidAllSchoolData = Rx<KidSchoolModel?>(null);
  RxList<School> kidSchoolList = RxList<School>([]);
  Future<void> getKidAllSchoolList() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuKidAllSchools/${selectedKidId.value.toString()}',
      ) as CommonDM;
      if (response.success == true) {
        kidSchoolList.clear();
        kidAllSchoolData.value = KidSchoolModel.fromJson(response.data);
        kidSchoolList.addAll(kidAllSchoolData.value!.schools);
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
      ll('getKidAllSchoolList error: $e');
    }
  }

  //* store school API Implementation
  RxList<KidSchool> schoolDataList = RxList<KidSchool>([]);
  final RxBool isKidSchoolLoading = RxBool(false);
  Future<void> storeSchool() async {
    try {
      isKidSchoolLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
        'school': kidEducationInstituteTextEditingController.text.trim(),
        'started': commonStartDate.value,
        'ended': commonEndDate.value,
        'is_current': isCommonEditCheckBoxSelected.value ? '0' : '1',
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuKidStoreSchool,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        schoolDataList.add(KidSchool.fromJson(response.data));
        Get.back();
        isKidSchoolLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidSchoolLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidSchoolLoading.value = false;
      ll('storeSchool error: $e');
    }
  }

  //* update school API Implement
  Future<void> updateSchool(id) async {
    try {
      isKidSchoolLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'school': kidEducationInstituteTextEditingController.text.trim(),
        'started': commonStartDate.value,
        'ended': commonEndDate.value,
        'is_current': isCommonEditCheckBoxSelected.value ? '0' : '1',
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuKidUpdateSchool,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < schoolDataList.length; i++) {
          if (schoolDataList[i].id == id) {
            schoolDataList[i] = KidSchool.fromJson(response.data);
          }
        }
        isKidSchoolLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidSchoolLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidSchoolLoading.value = false;
      ll('updateSchool error: $e');
    }
  }

  //* delete school API Implementation
  Future<void> deleteSchool(id) async {
    try {
      isKidSchoolLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuKidDeleteSchool/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < schoolDataList.length; i++) {
          if (schoolDataList[i].id == id) {
            schoolDataList.removeAt(i);
          }
        }
        isKidSchoolLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidSchoolLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidSchoolLoading.value = false;
      ll('deleteSchool error: $e');
    }
  }

  final RxInt phoneID = RxInt(-1);
  final RxInt emailID = RxInt(-1);
  final RxInt schoolID = RxInt(-1);
  final RxBool isCurrentlyStudyingHere = RxBool(false);
  final Rx<KidContactModel?> allContactData = Rx<KidContactModel?>(null);
  final RxList<Contact> contactList = RxList<Contact>([]);
  final RxBool isKidContactLoading = RxBool(false);
  Future<void> getKidContacts() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetAllKidContacts/${selectedKidId.value.toString()}",
      ) as CommonDM;
      if (response.success == true) {
        contactList.clear();
        allContactData.value = KidContactModel.fromJson(response.data);
        contactList.addAll(allContactData.value!.contacts);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getKidContacts error: $e');
    }
  }

  final Rx<KidContactModel?> contactUpdateData = Rx<KidContactModel?>(null);
  Future<void> storeContact(type) async {
    try {
      isKidContactLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'kid_id': selectedKidId.value.toString(),
        'type': type,
        'value': type == 'phone' ? kidPhoneNumberTextEditingController.text.trim() : kidEmailTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuKidStoreContact,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getKidContacts();
        isKidContactLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidContactLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidContactLoading.value = false;
      ll('storeContact error: $e');
    }
  }

  //* update contact API Implementation
  Future<void> updateContact(id, type) async {
    try {
      isKidContactLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'type': type,
        'value': type == 'phone' ? kidPhoneNumberTextEditingController.text.trim() : kidEmailTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuKidUpdateContact,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getKidContacts();
        isKidContactLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidContactLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidContactLoading.value = false;
      ll('updateContact error: $e');
    }
  }

  //* delete contact API Implementation
  Future<void> deleteContact(id, type) async {
    try {
      isKidContactLoading.value = true;
      Get.back();
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuKidDeleteContact/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getKidContacts();
        isKidContactLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidContactLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidContactLoading.value = false;
      ll('deleteContact error: $e');
    }
  }

  //*Get Relation Status
  final RxBool relationBottomSheetRightButtonState = RxBool(false);
  final RxString temporaryRelation = RxString("");
  final Rx<FamilyRelationModel?> relationListData = Rx<FamilyRelationModel?>(null);
  final RxList<Relation> relationList = RxList<Relation>([]);
  RxBool isRelationListLoading = RxBool(false);
  Future<void> getKidRelationList() async {
    try {
      isRelationListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllFamilyRelations,
      ) as CommonDM;
      if (response.success == true) {
        relationList.clear();
        relationListData.value = FamilyRelationModel.fromJson(response.data);
        relationList.addAll(relationListData.value!.relations);
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
      ll('getFamilyRelationList error: $e');
    }
  }

  //*Kid all post data get Api implement
  final ScrollController postListScrollController = ScrollController();
  final Rx<GetKidPostModel?> postListData = Rx<GetKidPostModel?>(null);
  final RxList<PostDataRx> allPostList = RxList<PostDataRx>([]);
  final RxBool isKidPageLoading = RxBool(false);
  final RxBool isKidPagePaginationLoading = RxBool(false);
  final Rx<String?> postListSubLink = Rx<String?>(null);
  final RxBool postListScrolled = RxBool(false);
  Future<void> getPostList() async {
    try {
      isKidPageLoading.value = true;
      String suffixUrl = '?take=15&kid_id=${selectedKidId.value}';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetKidPosts + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        allPostList.clear();
        globalController.commonPostList.clear();
        postListScrolled.value = false;
        postListData.value = GetKidPostModel.fromJson(response.data);
        allPostList.addAll(postListData.value!.posts.data);
        globalController.populatePostList(allPostList);
        postListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (postListSubLink.value != null) {
          postListScrolled.value = false;
        } else {
          postListScrolled.value = true;
        }

        isKidPageLoading.value = false;
      } else {
        isKidPageLoading.value = true;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidPageLoading.value = true;

      ll('getPostList error: $e');
    }
  }

  //*Get More Post List for pagination
  Future<void> getMorePostList() async {
    try {
      isKidPagePaginationLoading.value = true;
      String? token = await spController.getBearerToken();
      dynamic postListSub;

      if (postListSubLink.value == null) {
        return;
      } else {
        postListSub = postListSubLink.value!.split('?');
      }

      String postListSuffixUrl = '';

      postListSuffixUrl = '?${postListSub[1]}&take=15&kid_id=${selectedKidId.value}';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetKidPosts + postListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        allPostList.clear();
        postListData.value = GetKidPostModel.fromJson(response.data);
        allPostList.addAll(postListData.value!.posts.data);
        globalController.populatePostList(allPostList);
        postListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (postListSubLink.value != null) {
          postListScrolled.value = false;
        } else {
          postListScrolled.value = true;
        }

        isKidPagePaginationLoading.value = false;
      } else {
        isKidPagePaginationLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidPagePaginationLoading.value = true;
      ll('getMorePostList error: $e');
    }
  }

  List imageDescriptionTextEditingController = [];
  List imageLocationsList = [];
  List imageTimesList = [];
  List imageTagIdList = [];

  Future<void> kidCreatePost() async {
    List tags = [];
    for (int i = 0; i < Get.find<CreatePostController>().taggedFriends.length; i++) {
      tags.add(Get.find<CreatePostController>().taggedFriends[i].id);
    }
    try {
      Get.find<CreatePostController>().isCreatePostLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'content': Get.find<CreatePostController>().createPostTextEditingController.text.trim(),
        'post_category_id': "7",
        'is_public': '1',
        'post_tag_friend_id': tags.join(','),
        for (int i = 0; i < imageDescriptionTextEditingController.length; i++)
          'image_description[$i]': imageDescriptionTextEditingController[i].text.toString(),
        for (int i = 0; i < imageLocationsList.length; i++) 'image_locations[$i]': imageLocationsList[i].toString(),
        for (int i = 0; i < imageTimesList.length; i++) 'image_times[$i]': imageTimesList[i].toString(),
        for (int i = 0; i < imageTagIdList.length; i++) 'image_tag_friend_ids[$i]': imageTagIdList[i].toString(),
        'kid_id': Get.find<CreatePostController>().kidID.value.toString(),
      };
      ll(body);
      var response = await apiController.multiMediaUpload(
        url: kuKidCreatePost,
        body: body,
        token: token,
        key: 'images[]',
        values: Get.find<CreatePostController>().allMediaList,
      ) as CommonDM;

      if (response.success == true) {
        await getPostList();
        Get.find<CreatePostController>().isCreatePostLoading.value = false;
        Get.offNamedUntil(krKidProfile, ModalRoute.withName(krKidsPage));
        Get.find<CreatePostController>().resetCreatePost();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        Get.find<CreatePostController>().isCreatePostLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      Get.find<CreatePostController>().isCreatePostLoading.value = false;
      ll('createPost error: $e');
    }
  }

  IconData getCategoryIcon(categoryID) {
    if (categoryID == 3) {
      return BipHip.poetry;
    } else if (categoryID == 4) {
      return BipHip.photography;
    } else if (categoryID == 5) {
      return BipHip.painting;
    } else if (categoryID == 6) {
      return BipHip.storytelling;
    } else if (categoryID == 7) {
      return BipHip.kids;
    } else if (categoryID == 8) {
      return BipHip.newsFill;
    } else {
      return BipHip.selling;
    }
  }

  Color getCategoryColor(categoryID) {
    if (categoryID == 3) {
      return cPoetryColor;
    } else if (categoryID == 4) {
      return cPhotographyColor;
    } else if (categoryID == 5) {
      return cPaintingColor;
    } else if (categoryID == 6) {
      return cStoryTellingColor;
    } else if (categoryID == 7) {
      return cKidsColor;
    } else if (categoryID == 8) {
      return cBlackColor;
    } else {
      return cSellingColor;
    }
  }
}
