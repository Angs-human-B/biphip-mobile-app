import 'dart:convert';
import 'dart:io';
import 'package:bip_hip/models/post/kid_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostController extends GetxController {
  @override
  void onInit() {
    subCategoryList.addAll(subCategoryLists);
    filteredBusinessTypeList.addAll(businessTypeLists);
    ll('Filtered busness types : $filteredBusinessTypeList');
    super.onInit();
  }

  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxBool isPostButtonActive = RxBool(false);
  final RxBool isTextLimitCrossed = RxBool(false);
  final TextEditingController createPostController = TextEditingController();
  final RxString postType = RxString('Public');
  final Rx<IconData> postTypeIcon = Rx<IconData>(BipHip.world);
  final RxString category = RxString('');
  final RxInt categoryID = RxInt(-1);
  final Rx<IconData?> categoryIcon = Rx<IconData?>(null);
  final Rx<Color?> categoryIconColor = Rx<Color?>(null);
  final RxBool isTagAdded = RxBool(false);
  final RxString selectedBrandName = RxString('');
  final RxString selectedBrandImage = RxString('');

  // image and video picker variables
  final RxString createPostImageLink = RxString('');
  final RxList<Rx<File>> createPostImageFile = RxList<Rx<File>>([]);
  final RxBool isCreatePostImageChanged = RxBool(false);

  final RxString createPostVideoLink = RxString('');
  final RxList<Rx<File>> createPostVideoFile = RxList<Rx<File>>([]);
  final RxBool isCreatePostVideoChanged = RxBool(false);

  final RxList<RxString> mediaLinkList = RxList<RxString>([]);
  final RxList<Rx<File>> mediaFileList = RxList<Rx<File>>([]);
  final RxBool isMediaChanged = RxBool(false);
  final RxString postSecondaryCircleAvatar = RxString('');
  final Rx<File> postSecondaryLocalCirclerAvatar = File('').obs;
  final RxList audienceStatusList = RxList([true, false, false]);
  final TextEditingController biddingTitleTextEditingController = TextEditingController();
  final TextEditingController biddingPriceTextEditingController = TextEditingController();
  final TextEditingController biddingDiscountAmountTextEditingController = TextEditingController();
  final TextEditingController biddingDescriptionTextEditingController = TextEditingController();
  final TextEditingController biddingProductTagTextEditingController = TextEditingController();
  final TextEditingController biddingSKUTextEditingController = TextEditingController();
  final TextEditingController biddingDesiredAmountTextEditingController = TextEditingController();
  final TextEditingController biddingMinimumBidTextEditingController = TextEditingController();
  final RxBool isPublicPost = RxBool(false);
  final RxBool isPrivatePost = RxBool(false);

  final List audienceTypeList = [
    {"title": "Public", "subtitle": "Anyone from BipHip", "icon": BipHip.world},
    {"title": "Friends", "subtitle": "Your friends from BipHip", "icon": BipHip.friends},
    {"title": "Only me", "subtitle": "Only you can see", "icon": BipHip.lock},
  ];

  final List categoryList = [
    {"id": '', "name": '', "title": "Poetry", "icon": BipHip.poetry, "icon_color": cPoetryColor},
    {"id": '', "name": '', "title": "Painting", "icon": BipHip.painting, "icon_color": cPaintingColor},
    {"id": '', "name": '', "title": "Kids", "icon": BipHip.kids, "icon_color": cKidsColor},
    {"id": '', "name": '', "title": "Storytelling", "icon": BipHip.storytelling, "icon_color": cStoryTellingColor},
    {"id": '', "name": '', "title": "Photography", "icon": BipHip.photography, "icon_color": cPhotographyColor},
    {"id": '', "name": '', "title": "News", "icon": BipHip.newsFill, "icon_color": cBlackColor},
    {"id": '', "name": '', "title": "Selling", "icon": BipHip.selling, "icon_color": cSellingColor},
  ];

  final RxList categoryStatusList = RxList([false, false, false, false, false, false, false]);

  final List tagFiendList = [
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  ];

  final RxList selectedKidStatusList = RxList([false, false, false, false, false, false, false, false, false]);
  final RxList selectedBrandStatusList = RxList([false, false, false, false, false, false, false, false, false]);
  final List brandList = [
    {"name": "Takin Ahmed 1", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 2", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 3", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 4", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 5", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 6", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 7", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 8", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 9", "image_url": kiLogoImageUrl},
  ];

  final RxList allMediaList = RxList([]);
  final RxList<Rx<File>> allMediaFileList = RxList<Rx<File>>([]);

  final List platformList = [
    {"id": '', "name": 'Facebook', "title": "Facebook", "image": kiFacebookSvgImageUrl},
    {"id": '', "name": 'Website', "title": "Website", "image": kiWebSvgImageUrl},
    {"id": '', "name": 'LinkedIn', "title": "LinkedIn", "image": kiLinkedInSvgImageUrl},
    {"id": '', "name": 'Twitter', "title": "Twitter", "image": kiTwitterXSvgImageUrl},
    {"id": '', "name": 'Youtube', "title": "Youtube", "image": kiYoutubeSvgImageUrl},
  ];

  final RxList platformStatusList = RxList([false, false, false, false, false]);
  final List actionList = [
    {"id": '', "name": 'Learn More', "title": "Learn More"},
    {"id": '', "name": 'Message', "title": "Message"},
    {"id": '', "name": 'Buy Now', "title": "Buy Now"},
    {"id": '', "name": 'See Post', "title": "See Post"},
  ];

  final RxList actionStatusList = RxList([false, false, false, false]);
//------------------------------
//! important:: create post API
//------------------------------

  //Get all post catagories API implementation
  Rx<PostCategoryListModel?> postCategoryData = Rx<PostCategoryListModel?>(null);
  final RxBool isAddKidPageLoading = RxBool(false);
  final RxBool isPostCategoryListLoading = RxBool(false);
  Future<void> getPostCategoryList() async {
    try {
      isPostCategoryListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllPostCatagories,
      ) as CommonDM;
      if (response.success == true) {
        postCategoryList.clear();
        postCategoryData.value = PostCategoryListModel.fromJson(response.data);
        postCategoryList.addAll(postCategoryData.value!.postCategories);
        for (int i = 0; i < postCategoryList.length; i++) {
          for (int j = 0; j < categoryList.length; j++) {
            if (categoryList[j]['title'].toLowerCase() == postCategoryList[i].name!.toLowerCase()) {
              categoryList[j]['name'] = postCategoryList[i].name!;
              categoryList[j]['id'] = postCategoryList[i].id!;
            }
          }
        }
        isPostCategoryListLoading.value = false;
      } else {
        isPostCategoryListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostCategoryListLoading.value = true;
      ll('getPostCategoryList error: $e');
    }
  }

  //Add kid
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

  void checkCanAddKidInfo() {
    if (kidNameTextEditingController.text.trim() != '' && kidAgeTextEditingController.text.trim() != '' && isKidImageChanged.value) {
      isSaveKidButtonEnabled.value = true;
      globalController.isBottomSheetRightButtonActive.value = true;
    } else {
      globalController.isBottomSheetRightButtonActive.value = false;
      isSaveKidButtonEnabled.value = false;
    }
  }

  //Add kid API Implementation
  Rx<KidModel?> kidData = Rx<KidModel?>(null);
  RxList<PostCategory> postCategoryList = RxList<PostCategory>([]);
  Future<void> addKid() async {
    try {
      isAddKidPageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'name': kidNameTextEditingController.text.trim(),
        'age': kidAgeTextEditingController.text.trim(),
      };
      var response = await apiController.mediaUpload(
        url: kuAddKid,
        body: body,
        token: token,
        key: 'image',
        value: kidImageFile.value.path,
      ) as CommonDM;

      if (response.success == true) {
        kidData.value = KidModel.fromJson(response.data);
        ll(kidData.value!.name);
        isAddKidPageLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAddKidPageLoading.value = false;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddKidPageLoading.value = false;
      ll('addKid error: $e');
    }
  }

  //Get Kid List API Implementation
  Rx<KidListModel?> kidListData = Rx<KidListModel?>(null);
  RxList<Kid> kidList = RxList<Kid>([]);
  Rx<Kid?> selectedKid = Rx<Kid?>(null);
  Rx<Kid?> tempSelectedKid = Rx<Kid?>(null);
  RxInt kidID = RxInt(-1);
  RxBool isKidListLoading = RxBool(false);
  Future<void> getKidList() async {
    try {
      isKidListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllKidList,
      ) as CommonDM;
      if (response.success == true) {
        kidList.clear();
        kidListData.value = KidListModel.fromJson(response.data);
        kidList.addAll(kidListData.value!.kids);
        isKidListLoading.value = false;
      } else {
        isKidListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidListLoading.value = true;
      ll('getKidList error: $e');
    }
  }

  // Add Brand API Implementation
  final RxString brandImageLink = RxString('');
  final Rx<File> brandImageFile = File('').obs;
  final RxBool isBrandImageChanged = RxBool(false);
  final RxBool isSaveBrandButtonEnabled = RxBool(false);
  final RxBool isAddBrandPageLoading = RxBool(false);
  final TextEditingController brandNameTextEditingController = TextEditingController();
  final TextEditingController brandWebLinkTextEditingController = TextEditingController();
  final TextEditingController brandFacebookLinkTextEditingController = TextEditingController();
  final TextEditingController brandLinkedInLinkTextEditingController = TextEditingController();
  final TextEditingController brandYoutubeLinkTextEditingController = TextEditingController();
  final TextEditingController brandTwitterTextEditingController = TextEditingController();
  final TextEditingController brandInstagramTextEditingController = TextEditingController();
  final RxList brandSocialLinkList = RxList([]);
  Future<void> addBrand() async {
    try {
      isAddBrandPageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'name': brandNameTextEditingController.text.trim(),
        'social_links': json.encode(brandSocialLinkList),
      };
      var response = await apiController.mediaUpload(
        url: kuAddBrand,
        body: body,
        token: token,
        key: 'image',
        value: brandImageFile.value.path,
      ) as CommonDM;

      if (response.success == true) {
        isAddBrandPageLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAddBrandPageLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddBrandPageLoading.value = false;
      ll('addBrand error: $e');
    }
  }

  void createLinkList() {
    brandSocialLinkList.clear();
    if (brandWebLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Web': brandWebLinkTextEditingController.text.trim()});
    }
    if (brandFacebookLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Facebook': brandFacebookLinkTextEditingController.text.trim()});
    }
    if (brandLinkedInLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'LinkedIn': brandLinkedInLinkTextEditingController.text.trim()});
    }
    if (brandTwitterTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Twitter': brandTwitterTextEditingController.text.trim()});
    }
    if (brandYoutubeLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Youtube': brandYoutubeLinkTextEditingController.text.trim()});
    }
    ll(brandSocialLinkList);
  }

  void checkCanSaveBrand() {
    if (isBrandImageChanged.value &&
        brandNameTextEditingController.text.trim() != '' &&
        (brandWebLinkTextEditingController.text.trim() != '' ||
            brandFacebookLinkTextEditingController.text.trim() != '' ||
            brandLinkedInLinkTextEditingController.text.trim() != '' ||
            brandTwitterTextEditingController.text.trim() != '' ||
            brandYoutubeLinkTextEditingController.text.trim() != '')) {
      isSaveBrandButtonEnabled.value = true;
    } else {
      isSaveBrandButtonEnabled.value = false;
    }
  }

  // Create post API Implementation
  final RxBool isCreatePostLoading = RxBool(false);

  void resetCreatePost() {
    createPostController.clear();
    categoryID.value = -1;
    category.value = '';
    subCategory.value = '';
    isPostButtonActive.value = false;
  }

  Future<void> createPost() async {
    ll(allMediaList);
    try {
      isCreatePostLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'post_category_id': categoryID.value.toString(),
        'content': createPostController.text.trim(),
        'is_public': '1',
      };
      var response = await apiController.multiMediaUpload(
        url: kuCreatePost,
        body: body,
        token: token,
        key: 'images[]',
        values: allMediaList,
      ) as CommonDM;

      if (response.success == true) {
        isCreatePostLoading.value = false;
        Get.back();
        resetCreatePost();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isCreatePostLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCreatePostLoading.value = false;
      ll('createPost error: $e');
    }
  }

  final RxString tempSubCategory = RxString('');
  final RxString subCategory = RxString('');
  // final RxList subCategoryList = RxList(subCategoryLists);
  final RxList subCategoryList = RxList([]);

  final RxInt tempSubCategoryIndex = RxInt(-1);
  final RxInt subCategoryIndex = RxInt(-1);
  final List subCategoryLists = [
    // {"id": '', "title": "Drawing"},
    {"id": '', "title": "Birthday"},
    {"id": '', "title": "School"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Drawing"},
    // {"id": '', "title": "Birthday"},
    // {"id": '', "title": "School"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Drawing"},
    // {"id": '', "title": "Birthday"},
    // {"id": '', "title": "School"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Drawing"},
    // {"id": '', "title": "Birthday"},
    // {"id": '', "title": "School"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Drawing"},
    // {"id": '', "title": "Birthday"},
    // {"id": '', "title": "School"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Drawing"},
    // {"id": '', "title": "Birthday"},
    // {"id": '', "title": "School"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Birthday"},
    // {"id": '', "title": "School"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
    // {"id": '', "title": "Song"},
    // {"id": '', "title": "Art"},
  ];
  final RxBool isSubCategorySelected = RxBool(false);
  double customBottomSheetHeight() {
    if (subCategoryList.isEmpty) {
      return height * 0.4;
    } else if (subCategoryList.length < 5) {
      return isDeviceScreenLarge() ? height * 0.2 : height * 0.3;
    } else if (subCategoryList.length >= 5 && subCategoryList.length < 10) {
      return isDeviceScreenLarge() ? height * 0.3 : height * 0.35;
    } else if (subCategoryList.length >= 10 && subCategoryList.length < 15) {
      return isDeviceScreenLarge() ? height * 0.4 : height * 0.5;
    } else if (subCategoryList.length >= 15 && subCategoryList.length < 20) {
      return isDeviceScreenLarge() ? height * 0.5 : height * 0.6;
    } else if (subCategoryList.length >= 20 && subCategoryList.length < 25) {
      return isDeviceScreenLarge() ? height * 0.6 : height * 0.7;
    } else if (subCategoryList.length >= 25 && subCategoryList.length < 30) {
      return isDeviceScreenLarge() ? height * 0.7 : height * 0.8;
    } else if (subCategoryList.length >= 30 && subCategoryList.length < 35) {
      return isDeviceScreenLarge() ? height * 0.75 : height * 0.85;
    } else if (subCategoryList.length >= 35 && subCategoryList.length < 40) {
      return isDeviceScreenLarge() ? height * 0.8 : height * 0.9;
    } else {
      return height * 0.9;
    }
  }

  final RxBool isRegularPost = RxBool(false);
  final RxBool isBiddingPost = RxBool(false);
  final RxString tempSellingPostType = RxString('');
  final RxString sellingPostType = RxString('');
  final TextEditingController businessTypeTextEditingController = TextEditingController();
  final List<String> businessTypeLists = ['electronic', 'food', 'clothing'];
  // final RxList businessTypeList = RxList([]);
  final RxList filteredBusinessTypeList = RxList([]);
  final RxInt businessTypeIndex = RxInt(-1);
  void filterList(String query) {
    // filteredBusinessTypeList.clear();
    for (var item in filteredBusinessTypeList) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        filteredBusinessTypeList.clear();
        filteredBusinessTypeList.add(item);
        ll('after filtering the list : $filteredBusinessTypeList');
      }
    }
  }

  final RxBool isBrandAdded = RxBool(false);
  final Rx<File> selectedBrandImageFile = File('').obs;
  final RxBool isHideFriendFamilySwitch = RxBool(false);
  final RxList<RxString> sellingImageLinkList = RxList<RxString>([]);
  final RxList<Rx<File>> sellingImageFileList = RxList<Rx<File>>([]);
  final RxBool isSellingImageChanged = RxBool(false);
  final RxList sellingAllMediaList = RxList([]);
  final RxList<Rx<File>> sellingAllMediaFileList = RxList<Rx<File>>([]);
  final RxList productConditionList = RxList(["New", "Used", "Like New", "Reconditions", "Refurbished"]);
  final RxString selectedProductCondition = RxString('');
  // final RxString selectedProductCondition = RxString('');
  final RxList<bool> productConditionState = RxList<bool>([false, false, false, false, false]);
  final RxString tempSelectedPlatform = RxString('');
  final RxString selectedPlatform = RxString('');
  final RxString tempSelectedAction = RxString('');
  final RxString selectedAction = RxString('');
}
