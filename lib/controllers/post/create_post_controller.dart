import 'dart:convert';
import 'dart:io';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/menu/kids/all_kids_model.dart';
import 'package:bip_hip/models/post/get_create_post_model.dart';
import 'package:bip_hip/models/post/kid_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  void onInit() async {
    getCreatePost();
    super.onInit();
  }

  final RxBool isPostButtonActive = RxBool(false);
  final RxBool isTextLimitCrossed = RxBool(false);
  final TextEditingController createPostController = TextEditingController();
  final RxString tempSelectedCategory = RxString('');
  final RxString category = RxString('');
  final RxInt categoryID = RxInt(-1);
  final Rx<IconData?> categoryIcon = Rx<IconData?>(null);
  final Rx<Color?> categoryIconColor = Rx<Color?>(null);
  final RxBool isTagAdded = RxBool(false);
  final RxString selectedBrandName = RxString('');
  final RxString selectedBrandImage = RxString('');
  final RxBool isSharingPost = RxBool(false);
  final RxBool isEditPost = RxBool(false);

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
  final TextEditingController biddingTitleTextEditingController = TextEditingController();
  final TextEditingController biddingPriceTextEditingController = TextEditingController();
  final TextEditingController biddingDiscountAmountTextEditingController = TextEditingController();
  final TextEditingController biddingDescriptionTextEditingController = TextEditingController();
  final TextEditingController biddingProductTagTextEditingController = TextEditingController();
  final TextEditingController biddingSKUTextEditingController = TextEditingController();
  final TextEditingController biddingDesiredAmountTextEditingController = TextEditingController();
  final TextEditingController sellingLocationTextEditingController = TextEditingController();
  final TextEditingController biddingMinimumBidTextEditingController = TextEditingController();
  final RxBool isPublicPost = RxBool(false);
  final RxBool isPrivatePost = RxBool(false);
  final RxString biddingStartDate = RxString('');
  final RxString tempBiddingStartDate = RxString('');
  final RxString biddingEndDate = RxString('');
  final RxString tempBiddingEndDate = RxString('');
  final RxString biddingStartTime = RxString('');
  final RxString tempBiddingStartTime = RxString('');
  final RxString biddingEndTime = RxString('');
  final RxString tempBiddingEndTime = RxString('');
  final RxBool biddingStartDateBottomSheetRightButtonState = RxBool(false);
  final RxBool biddingStartTimeBottomSheetRightButtonState = RxBool(false);
  final RxBool biddingEndDateBottomSheetRightButtonState = RxBool(false);
  final RxBool biddingEndTimeBottomSheetRightButtonState = RxBool(false);
  final RxList<String> sellingLocationList = RxList<String>(['Shewrapara', 'Agargaon', 'Mirpur 12', 'Mirpur 11', 'Motijheel']);
  final RxBool isSellingLocationSuffixIconVisible = RxBool(false);
  final RxList<String> businessType = RxList<String>(['Electronics', 'Shop', 'Gadgets', 'Hardware']);
  final RxBool isAddBrandSuffixIconVisible = RxBool(false);

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

  final RxList<FriendFamilyUserData> tagFriendList = RxList<FriendFamilyUserData>([]);
  final RxList<FriendFamilyUserData> tempTaggedFriends = RxList<FriendFamilyUserData>([]);
  final RxList<FriendFamilyUserData> taggedFriends = RxList<FriendFamilyUserData>([]);
  final RxBool tagFriendButtonSheetRightButtonState = RxBool(false);
  final RxList tempTagIndex = RxList([]);

  // final List tagFiendList = [
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  //   {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  // ];

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
  final Rx<String?> kidNameErrorText = Rx<String?>(null);
  void checkCanAddKidInfo() {
    if (kidNameTextEditingController.text.trim().length >= 3 && kidAgeTextEditingController.text.trim() != '' && isKidImageChanged.value) {
      isSaveKidButtonEnabled.value = true;
      kidCategoryBottomSheetRightButtonState.value = true;
    } else {
      kidCategoryBottomSheetRightButtonState.value = false;
      isSaveKidButtonEnabled.value = false;
    }
  }

  void kidNameOnChanged() {
    checkCanAddKidInfo();
    if (kidNameTextEditingController.text.trim() == '') {
      kidNameErrorText.value = ksEmptyNameErrorText.tr;
    } else if (kidNameTextEditingController.text.trim().length < 3) {
      kidNameErrorText.value = ksKidNameLengthErrorText.tr;
    } else {
      kidNameErrorText.value = null;
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
        await Get.find<KidsController>().getKidsList();
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
  RxInt tempKidID = RxInt(-1);
  RxInt kidID = RxInt(-1);
  RxInt brandID = RxInt(-1);
  RxBool isKidListLoading = RxBool(false);
  final RxBool kidCategoryBottomSheetRightButtonState = RxBool(false);
  final RxBool kidListBottomSheetRightButtonState = RxBool(false);
  final RxBool kidRelationListBottomSheetRightButtonState = RxBool(false);
  final RxBool kidGenderContentBottomSheetRightButtonState = RxBool(false);
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
    ll(brandImageFile.value.path);
    try {
      isAddBrandPageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'name': brandNameTextEditingController.text.trim(),
        'social_links': json.encode(brandSocialLinkList),
        'profile_picture': brandImageFile.value.path,
        'business_category': businessTypeTextEditingController.text.trim()
      };
      var response = await apiController.mediaUpload(
        url: kuAddStore,
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

  Rx<StoreModel?> storeListData = Rx<StoreModel?>(null);
  RxBool isStoreListLoading = RxBool(false);
  RxList<Store> storeList = RxList<Store>([]);
  Future<void> getStoreList() async {
    try {
      isStoreListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetStores,
      ) as CommonDM;
      if (response.success == true) {
        storeList.clear();
        storeListData.value = StoreModel.fromJson(response.data);
        storeList.addAll(storeListData.value!.stores);
        isStoreListLoading.value = false;
      } else {
        isStoreListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreListLoading.value = true;
      ll('getStoreList error: $e');
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
            brandYoutubeLinkTextEditingController.text.trim() != '') &&
        businessTypeTextEditingController.text.trim() != '') {
      isSaveBrandButtonEnabled.value = true;
    } else {
      isSaveBrandButtonEnabled.value = false;
    }
  }

  // Create post API Implementation
  final RxBool isCreatePostLoading = RxBool(false);
  final RxBool isPostedFromProfile = RxBool(false);

  void resetCreatePost() {
    createPostController.clear();
    categoryID.value = -1;
    kidID.value = -1;
    brandID.value = -1;
    category.value = '';
    subCategory.value = '';
    subCategoryIndex.value = -1;
    newsTitleTextEditingController.clear();
    newsDescriptionTextEditingController.clear();
    isPostButtonActive.value = false;
  }

  List imageDescriptionTextEditingController = [];
  List imageLocationsList = [];
  List imageTimesList = [];
  List imageTagIdList = [];

  Future<void> createPost() async {
    List tags = [];
    for (int i = 0; i < taggedFriends.length; i++) {
      tags.add(taggedFriends[i].id);
    }
    try {
      isCreatePostLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        if (category.value != '') 'post_category_id': categoryID.value.toString(),
        'content': category.value == 'Selling' ? biddingTitleTextEditingController.text.trim() : createPostController.text.trim(),
        "is_public": privacyId.value.toString(),
        'post_tag_friend_id': tags.join(','),
        for (int i = 0; i < imageDescriptionTextEditingController.length; i++)
          'image_description[$i]': imageDescriptionTextEditingController[i].text.toString(),
        for (int i = 0; i < imageLocationsList.length; i++) 'image_locations[$i]': imageLocationsList[i].toString(),
        for (int i = 0; i < imageTimesList.length; i++) 'image_times[$i]': imageTimesList[i].toString(),
        for (int i = 0; i < imageTagIdList.length; i++) 'image_tag_friend_ids[$i]': imageTagIdList[i].toString(),
        if (category.value == 'Kids') 'kid_id': kidID.value.toString(),
        if (category.value == 'Selling') 'store_id': selectedBrandId.value.toString(),
        if (category.value == 'Selling') 'sell_post_type': (isRegularPost.value && !isBiddingPost.value) ? '0' : '1',
        if (category.value == 'Selling') 'title': biddingTitleTextEditingController.text.trim(),
        if (category.value == 'Selling') 'price': biddingPriceTextEditingController.text.trim(),
        if (category.value == 'Selling') 'discount': biddingDiscountAmountTextEditingController.text.trim(),
        if (category.value == 'Selling') 'description': biddingDescriptionTextEditingController.text.trim(),
        if (category.value == 'Selling') 'product_tags': biddingProductTagTextEditingController.text.trim(),
        if (category.value == 'Selling') 'sku': biddingSKUTextEditingController.text.trim(),
        if (category.value == 'Selling') 'bidding_post_type': (isPublicPost.value && !isPrivatePost.value) ? '0' : '1',
        if (category.value == 'Selling') 'desire_amount': biddingDesiredAmountTextEditingController.text.trim(),
        if (category.value == 'Selling') 'min_bidding_amount': biddingDesiredAmountTextEditingController.text.trim(),
        if (category.value == 'Selling') 'sell_post_category_id': selectedProductCategoryID.value,
        if (category.value == 'Selling') 'sell_post_condition_id': selectedProductConditionID.value,
        if (category.value == 'Selling') 'sell_post_availabilty': productAvailabilityId.value,
        if (category.value == 'Selling') 'is_hide_fnf': isHideFriendFamilySwitch.value ? '1' : '0',
        if (category.value == 'Selling') 'location': sellingLocationTextEditingController.text.toString().trim(),
        if (category.value == 'News') 'title': newsTitleTextEditingController.text.trim(),
        if (category.value == 'News') 'description': newsDescriptionTextEditingController.text.trim()
      };
      ll(body);
      var response = await apiController.multiMediaUpload(
        url: kuCreatePost,
        body: body,
        token: token,
        key: 'images[]',
        values: category.value == 'Selling' ? sellingAllMediaFileList : allMediaList,
      ) as CommonDM;

      if (response.success == true) {
        if (isPostedFromProfile.value) {
          await Get.find<HomeController>().getTimelinePostList();
        } else {
          await Get.find<HomeController>().getPostList();
        }
        isCreatePostLoading.value = false;
        Get.find<HomeController>().homeTabIndex.value = 0;
        Get.offAllNamed(krHome);
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

  Future<void> sharePost(postId) async {
    List tags = [];
    for (int i = 0; i < taggedFriends.length; i++) {
      tags.add(taggedFriends[i].id);
    }
    try {
      Get.find<PostReactionController>().isGiftStarLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'share_post_id': postId.toString(),
        'content': createPostController.text.trim(),
        'is_public': '1',
        // 'post_tag_friend_id': tags.join(','),
      };
      ll(body);
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSharePost,
        body: body,
        token: token,
      ) as CommonDM;
      ll("HELLO: $response");
      if (response.success == true) {
        await Get.find<HomeController>().getPostList();

        resetCreatePost();
        Get.find<PostReactionController>().isGiftStarLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        Get.find<PostReactionController>().isGiftStarLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      Get.find<PostReactionController>().isGiftStarLoading.value = false;
      ll('sharePost error: $e');
    }
  }

  final RxString tempSubCategory = RxString('');
  final RxString subCategory = RxString('');
  final RxList subCategoryList = RxList([]);

  final RxInt tempSubCategoryIndex = RxInt(-1);
  final RxInt subCategoryIndex = RxInt(-1);
  final RxBool isSubCategorySelected = RxBool(false);
  final RxBool subCategoryBottomSheetRightButtonState = RxBool(false);
  double subCategoryCustomBottomSheetHeight() {
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

  double savedBrandCustomBottomSheetHeight() {
    if (isStoreListLoading.value == true) {
      return height * 0.4;
    } else {
      if (storeList.isEmpty) {
        ll(storeList.length);
        return height * 0.4;
      } else if (storeList.isNotEmpty && storeList.length <= 1) {
        ll(storeList.length);
        return isDeviceScreenLarge() ? height * 0.2 : height * 0.3;
      } else if (storeList.length >= 2 && storeList.length <= 3) {
        ll(storeList.length);
        return isDeviceScreenLarge() ? height * 0.3 : height * 0.4;
      } else if (storeList.length >= 4 && storeList.length <= 5) {
        ll(storeList.length);
        return isDeviceScreenLarge() ? height * 0.4 : height * 0.5;
      } else if (storeList.length >= 6 && storeList.length <= 7) {
        ll(storeList.length);
        return isDeviceScreenLarge() ? height * 0.5 : height * 0.6;
      } else if (storeList.length >= 8 && storeList.length <= 9) {
        ll(storeList.length);
        return isDeviceScreenLarge() ? height * 0.6 : height * 0.7;
      } else if (storeList.length >= 10 && storeList.length <= 11) {
        ll(storeList.length);
        return isDeviceScreenLarge() ? height * 0.7 : height * 0.8;
      } else if (storeList.length >= 12 && storeList.length <= 13) {
        ll(storeList.length);
        return isDeviceScreenLarge() ? height * 0.8 : height * 0.9;
      } else {
        return height * 0.9;
      }
    }
  }

  final RxBool isRegularPost = RxBool(false);
  final RxBool isBiddingPost = RxBool(false);
  final RxString temporarySellingPostType = RxString('');
  final RxString sellingPostType = RxString('');
  final RxBool sellingPostTypeBottomSheetRightButtonState = RxBool(false);
  final TextEditingController businessTypeTextEditingController = TextEditingController();
  final List<String> businessTypeLists = ['electronic', 'food', 'clothing'];
  // final RxList businessTypeList = RxList([]);
  final RxList filteredBusinessTypeList = RxList([]);
  final RxInt businessTypeIndex = RxInt(-1);

  final RxBool isBrandAdded = RxBool(false);
  final Rx<File> selectedBrandImageFile = File('').obs;
  final RxBool isHideFriendFamilySwitch = RxBool(false);
  final RxList<RxString> sellingImageLinkList = RxList<RxString>([]);
  final RxList<Rx<File>> sellingImageFileList = RxList<Rx<File>>([]);
  final RxBool isSellingImageChanged = RxBool(false);
  final RxList sellingAllMediaList = RxList([]);
  final RxList<Rx<File>> sellingAllMediaFileList = RxList<Rx<File>>([]);
  final RxString tempSelectedProductCondition = RxString('');
  final RxString tempSelectedProductConditionID = RxString('');
  final RxString selectedProductCondition = RxString('');
  final RxString selectedProductConditionID = RxString('');
  final RxBool productConditionBottomSheetRightButtonState = RxBool(false);
  final RxString tempSelectedPlatform = RxString('');
  final RxString selectedPlatform = RxString('');
  final RxBool platformBottomSheetRightButtonState = RxBool(false);
  final RxString tempSelectedAction = RxString('');
  final RxString selectedAction = RxString('');
  final RxString tempCategory = RxString('');
  final RxString tempSelectedBrandName = RxString('');
  final RxInt tempSelectedBrandId = RxInt(-1);
  final RxInt sellingAllMediaListLength = RxInt(-1);
  final RxInt storeListLength = RxInt(-1);
  final RxInt selectedBrandId = RxInt(-1);
  final RxBool storeListBottomSheetRightButtonState = RxBool(false);
  final RxBool selectStoreBottomSheetRightButtonState = RxBool(false);
  final TextEditingController newsTitleTextEditingController = TextEditingController();
  final TextEditingController newsDescriptionTextEditingController = TextEditingController();
  final RxString tempCreatePostSelectedPrivacy = RxString('Friends');
  final RxString createPostSelectedPrivacy = RxString('Friends');
  final Rx<IconData> tempCreatePostSelectedPrivacyIcon = Rx<IconData>(BipHip.friends);
  final Rx<IconData> createPostSelectedPrivacyIcon = Rx<IconData>(BipHip.friends);
  final RxString tempSelectedProductCategory = RxString('');
  final RxString tempSelectedProductCategoryID = RxString('');
  final RxString selectedProductCategory = RxString('');
  final RxString selectedProductCategoryID = RxString('');
  final RxBool productCategoryBottomSheetRightButton = RxBool(false);

  //   //*Get Create Post List Api Call
  final Rx<GetCreatePostModel?> createPostAllData = Rx<GetCreatePostModel?>(null);
  final RxList<PostCategory> createPostCategoryList = RxList<PostCategory>([]);
  final RxList<PostCategory> createPostSubCategoryList = RxList<PostCategory>([]);
  final RxList<Privacy> createPostPrivacyList = RxList<Privacy>([]);
  final RxList<Privacy> createPostSellCategoryList = RxList<Privacy>([]);
  final RxList<Privacy> createPostSellConditionList = RxList<Privacy>([]);
  final RxBool isGetCreatePostLoading = RxBool(false);
  Future<void> getCreatePost() async {
    try {
      isGetCreatePostLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetCreatePost,
      ) as CommonDM;
      if (response.success == true) {
        createPostCategoryList.clear();
        createPostSubCategoryList.clear();
        createPostPrivacyList.clear();
        createPostSellCategoryList.clear();
        createPostSellConditionList.clear();
        createPostAllData.value = GetCreatePostModel.fromJson(response.data);
        createPostSubCategoryList.addAll(createPostAllData.value!.postSubCategories);
        createPostPrivacyList.addAll(createPostAllData.value!.privacy);
        createPostSellCategoryList.addAll(createPostAllData.value!.sellPostCategories);
        createPostSellConditionList.addAll(createPostAllData.value!.sellPostCondition);
        PostCategory allCategory = PostCategory(
          id: 0,
          name: "All",
          isActive: 1,
        );

        createPostCategoryList.insert(0, allCategory);
        createPostCategoryList.addAll(createPostAllData.value!.postCategories);

        for (int i = 0; i < postCategoryList.length; i++) {
          for (int j = 0; j < categoryList.length; j++) {
            if (categoryList[j]['title'].toLowerCase() == postCategoryList[i].name!.toLowerCase()) {
              categoryList[j]['name'] = postCategoryList[i].name!;
              categoryList[j]['id'] = postCategoryList[i].id!;
            }
          }
        }
        isGetCreatePostLoading.value = false;
      } else {
        isGetCreatePostLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isGetCreatePostLoading.value = true;
      ll('getCreatePost error: $e');
    }
  }

  //*Product Availability List
  final List productAvailabilityList = [
    {'id': '0', 'name': 'List as single item'},
    {'id': '1', 'name': 'list as  in stock'}
  ];
  final RxString productAvailabilityId = RxString('');
  final RxString temporaryProductAvailabilityId = RxString('');
  final RxString temporaryProductAvailability = RxString('');
  final RxString productAvailability = RxString('');
  final RxBool productAvailabilityBottomSheetRightButtonState = RxBool(false);
  final sharePostOthersList = [
    {"icon": BipHip.activity, "text": "Message"}, //! Icon must change
    {"icon": BipHip.whatsappFill, "text": "WhatsApp"},
    {"icon": BipHip.addFamily, "text": "Group"},
    {"icon": BipHip.activity, "text": "Your Story"}, //! Icon must change
    {"icon": BipHip.addLink, "text": "Copy Link"},
  ];

  final RxInt postId = RxInt(-1);
  final RxInt privacyId = RxInt(-1);
  List deleteImageIdList = [];
  RxList imageIdList = RxList([]);

  Future<void> updatePost({required int postId}) async {
    try {
      isCreatePostLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        "id": postId.toString(),
        "content": createPostController.text.toString().trim(),
        if (categoryID.value != -1) "post_category_id": categoryID.value.toString(),
        // if (subCategoryIndex.value != -1) "post_sub_category_id": subCategoryIndex.value.toString(),
        "is_public": privacyId.value.toString(),
        "delete_image_ids": deleteImageIdList.join(','),
        for (int i = 0; i < imageIdList.length; i++) 'image_ids[$i]': imageIdList[i].toString(),
        if (kidID.value != -1) 'kid_id': kidID.value.toString(),
        if (selectedBrandId.value != -1) 'store_id': selectedBrandId.value.toString(),
        if (category.value == 'Selling') 'sell_post_type': (isRegularPost.value && !isBiddingPost.value) ? '0' : '1',
        if (category.value == 'Selling') 'title': biddingTitleTextEditingController.text.trim(),
        if (category.value == 'Selling') 'price': biddingPriceTextEditingController.text.trim(),
        if (category.value == 'Selling') 'discount': biddingDiscountAmountTextEditingController.text.trim(),
        if (category.value == 'Selling') 'description': biddingDescriptionTextEditingController.text.trim(),
        if (category.value == 'Selling') 'product_tags': biddingProductTagTextEditingController.text.trim(),
        if (category.value == 'Selling') 'sku': biddingSKUTextEditingController.text.trim(),
        if (category.value == 'Selling') 'bidding_post_type': (isPublicPost.value && !isPrivatePost.value) ? '0' : '1',
        if (category.value == 'Selling') 'desire_amount': biddingDesiredAmountTextEditingController.text.trim(),
        if (category.value == 'Selling') 'min_bidding_amount': biddingDesiredAmountTextEditingController.text.trim(),
        if (category.value == 'Selling') 'sell_post_category_id': selectedProductCategoryID.value,
        if (category.value == 'Selling') 'sell_post_condition_id': selectedProductConditionID.value,
        if (category.value == 'Selling') 'sell_post_availabilty': productAvailabilityId.value,
        if (category.value == 'Selling') 'is_hide_fnf': isHideFriendFamilySwitch.value ? '1' : '0',
        if (category.value == 'Selling') 'location': sellingLocationTextEditingController.text.toString().trim(),
        if (category.value == 'News') 'title': newsTitleTextEditingController.text.trim(),
        if (category.value == 'News') 'description': newsDescriptionTextEditingController.text.trim(),
      };
      // var response = await apiController.commonApiCall(
      //   requestMethod: kPost,
      //   url: kuUpdatePost,
      //   body: body,
      //   token: token,
      // ) as CommonDM;
      var response = await apiController.multiMediaUpload(
        url: kuUpdatePost,
        body: body,
        token: token,
        key: 'images[]',
        values: category.value == 'Selling' ? sellingAllMediaFileList : allMediaList,
      ) as CommonDM;
      // var response = await apiController.multiMediaUpload(
      //   url: kuUpdatePost,
      //   body: body,
      //   token: token,
      //   key: 'images[]',
      //   values: category.value == 'Selling' ? sellingAllMediaFileList : allMediaList,
      // ) as CommonDM;

      if (response.success == true) {
        await Get.find<HomeController>().getPostList();
        Get.back();
        isCreatePostLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isCreatePostLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCreatePostLoading.value = false;
      ll('updatePost error: $e');
    }
  }
}
