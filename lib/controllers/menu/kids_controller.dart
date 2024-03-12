import 'dart:convert';
import 'dart:io';
import 'package:bip_hip/models/menu/kids/all_kids_model.dart';
import 'package:bip_hip/models/menu/kids/kid_profile/kid_overview_model.dart';
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
  final Rx<String?> kidBio = Rx<String?>('This is kid bio');
  final TextEditingController kidBioEditingController = TextEditingController();
  final RxInt bioCount = RxInt(0);
  final RxBool isKidProfilePhoto = RxBool(false);
  final RxString kidPreviewPhoto = RxString('');
  final RxList hobbiesList = RxList([]);
  final RxList<int> hobbiesIndex = RxList<int>([]);
  final RxList selectedHobbies = RxList([]);
  final RxList temporarySelectedHobbies = RxList([]);
  final RxList kidPhoneNumberList = RxList(['017236748765478', '019823973893']);
  final RxList kidEmailList = RxList(['abcdef@gmail.com', 'hjfdnd@gmail.com']);
  final allHobbiesList = ['Cricket', 'Football', 'Garden', 'Tour', 'Watching Movie'];
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
  final Rx<String?> kidGender = Rx<String?>("Male");
  final Rx<DateTime?> kidDob = Rx<DateTime?>(DateTime.now());
  final Rx<String?> kidRelation = Rx<String?>("Father");
  final RxString temporaryKidRelationData = RxString('');
  final RxString kidRelationData = RxString('');
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
  final RxList kidLanguageList = RxList(['English', 'Bangla']);
  final List<String> allLanguageList = ['English', 'Bangla', 'Hindi', 'Urdu', 'Spanish', 'Japanese', 'Yue Chinese', 'Marathi', 'Telugu'];
  final RxString addedLanguage = RxString("");
  TextEditingController kidSearchLanguageTextEditingController = TextEditingController();
  final RxBool isAddLanguageButtonEnabled = RxBool(false);
  final RxBool isSearchLanguageSuffixIconShowing = RxBool(false);
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
        featuredPostList.clear();
        kidOverviewData.value = KidOverviewModel.fromJson(response.data);
        featuredPostList.addAll(kidOverviewData.value!.featurePost);
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
}
