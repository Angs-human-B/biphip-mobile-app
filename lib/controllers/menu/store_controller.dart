import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bip_hip/models/menu/store/all_business_category_model.dart';
import 'package:bip_hip/models/menu/store/all_location_model.dart';
import 'package:bip_hip/models/menu/store/profile_cover_picture_update_model.dart';
import 'package:bip_hip/models/menu/store/store_common_update_model.dart';
import 'package:bip_hip/models/menu/store/store_contact_model.dart';
import 'package:bip_hip/models/menu/store/store_overview_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:image_picker/image_picker.dart';

class StoreController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  Rx<StoreModel?> storeListData = Rx<StoreModel?>(null);
  RxBool isStoreListLoading = RxBool(false);
  RxList<Store> storeList = RxList<Store>([]);
  final RxInt totalStoreCount = RxInt(-1);
  final RxInt storeId = RxInt(-1);
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
        totalStoreCount.value = storeListData.value!.stores.length;
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

  //*Store Basic info
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController businessTypeTextEditingController = TextEditingController();
  final List<String> businessType = ['Electronics', 'Shop', 'Gadgets', 'Hardware'];
  final RxBool isBusinessTypeSuffixIconVisible = RxBool(false);
  final RxBool isNextButtonEnable = RxBool(false);
  final Rx<String?> storeNameErrorText = Rx<String?>(null);
  final RxBool foucsOnBusinessTypeFieldFirstTime = RxBool(true);
  final Rx<String?> storeBusinessTypeErrorText = Rx<String?>(null);
  //*Store contact info
  final TextEditingController storeEmailController = TextEditingController();
  final TextEditingController storePhoneController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();
  final TextEditingController storeBioController = TextEditingController();
  final RxInt storeBioCount = RxInt(0);
  final Rx<String?> storeEmailErrorText = Rx<String?>(null);
  final RxBool isStoreContactInfoNextButtonEnabled = RxBool(false);

  //*Social Links
  final TextEditingController storeWebsiteController = TextEditingController();
  final TextEditingController storeFacebookController = TextEditingController();
  final TextEditingController storeInstagramController = TextEditingController();
  final TextEditingController storeTwitterController = TextEditingController();
  final TextEditingController storeYoutubeController = TextEditingController();
  final RxBool isStoreSocialLinkNextButtonEnabled = RxBool(false);
  //*Documents
  final TextEditingController businessIdentificationNumberController = TextEditingController();
  final TextEditingController storeQRCodeController = TextEditingController();
  final RxBool isStoreDocumentNextButtonEnabled = RxBool(false);

  //*Store Profile and cover photo
  final RxString storeProfileImageLink = RxString('');
  final Rx<File> storeProfileImageFile = File('').obs;
  final RxBool isStoreProfileImageChanged = RxBool(false);
  final RxString storeCoverImageLink = RxString('');
  final Rx<File> storeCoverImageFile = File('').obs;
  final RxBool isStoreCoverImageChanged = RxBool(false);

  void resetStoreProfilePictureData() {
    isStoreProfileImageChanged.value = false;
    storeProfileImageLink.value = '';
    storeProfileImageFile.value = File('');
  }

  void resetStoreCoverPhotoData() {
    isStoreCoverImageChanged.value = false;
    storeCoverImageLink.value = '';
    storeCoverImageFile.value = File('');
  }

  void storeNameOnChanged() {
    checkNextButtonEnable();
    if (storeNameController.text.toString().trim() == '') {
      storeNameErrorText.value = ksEmptyStoreErrorText.tr;
    } else if (storeNameController.text.trim().length < 3) {
      storeNameErrorText.value = ksStoreNameLengthErrorText.tr;
    } else {
      storeNameErrorText.value = null;
    }
  }

  void businessTypeErrorText() {
    String businessTypeValue = businessTypeTextEditingController.text.toString().trim();
    if (businessType.contains(businessTypeValue)) {
      storeBusinessTypeErrorText.value = null;
    } else {
      storeBusinessTypeErrorText.value = ksSelectBusinessTypeFromSuggestion.tr;
    }
  }

  void checkNextButtonEnable() {
    String businessTypeValue = businessTypeTextEditingController.text.toString().trim();
    if (storeNameController.text.toString().trim().length >= 3 && businessType.contains(businessTypeValue)) {
      isNextButtonEnable.value = true;
    } else {
      isNextButtonEnable.value = false;
    }
  }

  RxDouble progress = 0.0.obs;

  void startUpload() {
    Timer.periodic(const Duration(milliseconds: 250), (timer) {
      double currentProgress = progress.value + 0.25;
      progress.value = currentProgress;
      if (currentProgress > 1) {
        currentProgress = 1;
        progress.value = 1;
        timer.cancel();
      }
      progress.value = currentProgress;
    });
  }

  final ImagePicker picker = ImagePicker();
  RxList<XFile> selectedImages = RxList<XFile>();

  Future<void> captureImageFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      startUpload();
      Get.back();
      selectedImages.add(image);
      checkStoreDocumentsNextButtonEnabled();
    }
  }

  Future<void> pickImageFromGallery() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      startUpload();
      Get.back();
      selectedImages.addAll(images);
      checkStoreDocumentsNextButtonEnabled();
    }
  }

  void checkContactInfoNextButtonEnabled() {
    if ((storePhoneController.text.toString().trim() != '' ||
            storeAddressController.text.toString().trim() != '' ||
            storeBioController.text.toString().trim() != '' ||
            storeEmailController.text.toString().trim().isValidEmail) &&
        storeEmailErrorText.value == null) {
      isStoreContactInfoNextButtonEnabled.value = true;
    } else {
      isStoreContactInfoNextButtonEnabled.value = false;
    }
  }

  void checkStoreSocialLinkNextButtonEnabled() {
    if (storeWebsiteController.text.toString().trim() != '' ||
        storeFacebookController.text.toString().trim() != '' ||
        storeInstagramController.text.toString().trim() != '' ||
        storeTwitterController.text.toString().trim() != '' ||
        storeYoutubeController.text.toString().trim() != '') {
      isStoreSocialLinkNextButtonEnabled.value = true;
    } else {
      isStoreSocialLinkNextButtonEnabled.value = false;
    }
  }

  void checkStoreDocumentsNextButtonEnabled() {
    if (businessIdentificationNumberController.text.toString().trim() != '' ||
        storeQRCodeController.text.toString().trim() != '' ||
        selectedImages.isNotEmpty) {
      isStoreDocumentNextButtonEnabled.value = true;
    } else {
      isStoreDocumentNextButtonEnabled.value = false;
    }
  }

  void resetStoreDocuments() {
    storeQRCodeController.clear();
    businessIdentificationNumberController.clear();
    selectedImages.clear();
    isStoreDocumentNextButtonEnabled.value = false;
  }

  void storeEmailValidation() {
    if (storeEmailController.text.toString().trim() != '' && !storeEmailController.text.toString().trim().isValidEmail) {
      storeEmailErrorText.value = ksInvalidEmailErrorMessage.tr;
    } else {
      storeEmailErrorText.value = null;
    }
    checkContactInfoNextButtonEnabled();
  }

  void resetStoreContactInfo() {
    storeEmailController.clear();
    storePhoneController.clear();
    storeAddressController.clear();
    storeBioController.clear();
    storeEmailErrorText.value = null;
    isStoreContactInfoNextButtonEnabled.value = false;
    storeBioCount.value = 0;
  }

  void resetStoreSocialLinks() {
    storeWebsiteController.clear();
    storeFacebookController.clear();
    storeInstagramController.clear();
    storeTwitterController.clear();
    storeYoutubeController.clear();
    isStoreSocialLinkNextButtonEnabled.value = false;
  }

  void resetStoreData() {
    storeNameController.clear();
    businessTypeTextEditingController.clear();
    isBusinessTypeSuffixIconVisible.value = false;
    resetStoreContactInfo();
    resetStoreSocialLinks();
    storeNameErrorText.value = null;
    storeBusinessTypeErrorText.value = null;
    isNextButtonEnable.value = false;
    resetStoreDocuments();
    resetStoreProfilePictureData();
    resetStoreCoverPhotoData();
  }

  //*Add Store API Implementation
  final RxBool isCreateStoreLoading = RxBool(false);
  Future<void> createStore() async {
    try {
      isCreateStoreLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'name': storeNameController.text.toString().trim(),
        'business_category': businessTypeTextEditingController.text.toString().trim(),
        'email': storeEmailController.text.toString().trim(),
        'phone': storePhoneController.text.toString().trim(),
        'address': storeAddressController.text.toString().trim(),
        'bio': storeBioController.text.toString().trim(),
        'social_links': json.encode(storeSocialLinkList),
        'bin': storeBioController.text.toString().trim(),
        'qr_code': storeQRCodeController.text.toString().trim(),
      };
      List<String> key = [];
      List<dynamic> value = [];
      for (int i = 0; i < selectedImages.length; i++) {
        key.add('legal_files[$i]');
        value.add(selectedImages[i].path);
      }
      key.add('profile_picture');
      value.add(storeProfileImageFile.value.path);
      key.add('cover_photo');
      value.add(storeCoverImageFile.value.path);
      var response = await apiController.mediaUploadMultipleKeyAndValue(
        url: kuAddStore,
        body: body,
        token: token,
        keys: key,
        values: value,
      ) as CommonDM;

      if (response.success == true) {
        getStoreList();
        isCreateStoreLoading.value = false;
        Get.offNamedUntil(krStore, ModalRoute.withName(krMenu));
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isCreateStoreLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCreateStoreLoading.value = false;
      ll('createStore error: $e');
    }
  }

  final RxList storeSocialLinkList = RxList([]);

  void storeSocialLink() {
    storeSocialLinkList.clear();
    if (storeWebsiteController.text.toString().trim() != '') {
      storeSocialLinkList.add({'Web': storeWebsiteController.text.toString().trim()});
    }
    if (storeFacebookController.text.toString().trim() != '') {
      storeSocialLinkList.add({'Facebook': storeFacebookController.text.toString().trim()});
    }
    if (storeInstagramController.text.toString().trim() != '') {
      storeSocialLinkList.add({'Instagram': storeInstagramController.text.toString().trim()});
    }
    if (storeTwitterController.text.toString().trim() != '') {
      storeSocialLinkList.add({'Twitter': storeTwitterController.text.toString().trim()});
    }
    if (storeYoutubeController.text.toString().trim() != '') {
      storeSocialLinkList.add({'Youtube': storeYoutubeController.text.toString().trim()});
    }
    ll(storeSocialLinkList);
  }

  //!
  //! Store profile
  final RxInt storeProfileTabIndex = RxInt(0);
  final RxInt selectedStoreId = RxInt(-1);
  final Rx<String?> storeBio = Rx<String?>(null);
  final Rx<String?> storeCategory = Rx<String?>('');
  final RxList storeLocationList = RxList([]);
  final RxList legalPaperAllInfoList = RxList([
    {"fileName": "Image.png", "fileSize": "250KB"},
    {"fileName": "Image1.png", "fileSize": "251KB"}
  ]);
  // final RxList websiteAndSocialLinkList = RxList(["Facebook.1", "Facebook.2", "Facebook.3", "Facebook.4", "Facebook.5"]);
  final Rx<String?> storePrivacyLink = Rx<String?>('');
  final RxList paymentMethodList = RxList([
    {"paymentMethod": "Nagad", "payment": "01789368774638"},
    {"paymentMethod": "Paypal", "payment": "Shohagjalal@gmail.com"}
  ]);
  final Rx<String?> qrCode = Rx<String?>(null);
  final Rx<String?> storeBIN = Rx<String?>(null);
  //!* Edit store profile
  final TextEditingController storePhoneNumberTextEditingController = TextEditingController();
  final TextEditingController storeEmailTextEditingController = TextEditingController();
  final TextEditingController storePrivacyLinkTextEditingController = TextEditingController();
  final TextEditingController storeQrCodeTextEditingController = TextEditingController();
  final TextEditingController storeBINTextEditingController = TextEditingController();
  final TextEditingController storeLocationTextEditingController = TextEditingController();
  final RxBool isStoreLocationSuffixIconVisible = RxBool(false);
  final TextEditingController storeCategoryTextEditingController = TextEditingController();
  final TextEditingController storeSocialLinkTextEditingController = TextEditingController();
  final RxBool isStoreCategorySuffixIconVisible = RxBool(false);
  final RxList<String> storeCategoryList = RxList([]);
  final RxString selectedStoreSocialLinkSource = RxString("");
  final RxString temporarySelectedStoreSocialLinkSource = RxString("");
  // final RxList storeSocialLinkSourceList = RxList(["Facebook", "Twitter", "Youtube", "Instagram", "Website"]);
  final RxBool storeSocialLinkBottomSheetRightButtonState = RxBool(false);
  final TextEditingController storePaymentTextEditingController = TextEditingController();
  final TextEditingController storeBioTextEditingController = TextEditingController();
  final RxInt bioCount = RxInt(0);
  final RxString selectedStorePaymentMethod = RxString("");
  final RxString temporarySelectedStorePaymentMethod = RxString("");
  final RxString storeProfilePicture = RxString("");
  final RxString storeCoverPhoto = RxString("");
  final RxString storeName = RxString("");
  final RxBool storeViewOptionEnabled = RxBool(false);
  final RxBool isStoreProfilePhoto = RxBool(false);
  final RxBool isStoreProfilePicEditor = RxBool(false);
  final RxString storePreviewPhoto = RxString("");
  final RxString profileImageLink = RxString('');
  final Rx<File> profileImageFile = File('').obs;
  final Rx<File> newProfileImageFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxString coverImageLink = RxString('');
  final Rx<File> coverImageFile = File('').obs;
  final Rx<File> newCoverImageFile = File('').obs;
  final RxBool isCoverImageChanged = RxBool(false);
  final RxBool isSharedToNewFeed = RxBool(false);
  final RxList storePaymentMethodList = RxList(["Bkash", "Nagad", "Rocket", "Paypal", "Visacard", "Mastercard"]);
  final RxBool storePaymentMethodBottomSheetRightButtonState = RxBool(false);
  final RxList<String> allLocationList = RxList<String>([]);
  final RxBool isEditOrAdd = RxBool(false);
  final RxList storeLegalPapersList = RxList([]);

  final storeReviewList = [
    {
      "userImage":
          "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Emma isabela",
      "storeName": "Store Name",
      "rating": "4.0",
      "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    },
    {
      "userImage":
          "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Emma isabela2",
      "storeName": "Store Name2",
      "rating": "4.0",
      "content":
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userImage":
          "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Emma isabela3",
      "storeName": "Store Name3",
      "rating": "4.0",
      "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    },
    {
      "userImage":
          "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Emma isabela4",
      "storeName": "Store Name4",
      "rating": "4.0",
      "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    },
  ];
  void clearStoreData() {
    storeLegalPapersList.clear();
  }
  //!Store profile api call

  //*store Overview Api call
  final Rx<StoreOverviewModel?> storeOverviewData = Rx<StoreOverviewModel?>(null);
  final RxList<FeaturePost> featuredPostList = RxList<FeaturePost>([]);
  final Rx<Stores?> storesData = Rx<Stores?>(null);
  final RxBool isStoreOverviewLoading = RxBool(false);
  Future<void> getStoreOverview() async {
    try {
      isStoreOverviewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuStoreProfileOverview/${selectedStoreId.value}",
      ) as CommonDM;
      if (response.success == true) {
        clearStoreData();
        featuredPostList.clear();
        ll("0");
        storeOverviewData.value = StoreOverviewModel.fromJson(response.data);
        ll("1");
        storesData.value = storeOverviewData.value?.stores;
        // featuredPostList.addAll(kidOverviewData.value!.featurePost);
        ll("2");
        storeBio.value = storesData.value?.bio;
        ll("3");
        storeName.value = storesData.value?.name ?? "";
        ll("4");
        storeProfilePicture.value = storesData.value?.profilePicture ?? "";
        ll("5");
        storeCoverPhoto.value = storesData.value?.coverPhoto ?? "";
        ll("6");
        storeBIN.value = storesData.value?.bin;
        ll("7");
        storeLegalPapersList.addAll(storesData.value?.legalPapers ?? []);
        ll("8");
        qrCode.value = storesData.value?.qrCode;
        ll("9");
        storePrivacyLink.value = storesData.value?.privacyLink;
        ll("10");
        storeCategory.value = storesData.value?.categories[0];
        ll("11");
        isStoreOverviewLoading.value = false;
      } else {
        isStoreOverviewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreOverviewLoading.value = true;
      ll('getStoreOverview error: $e');
    }
  }

  void clearStoreBio() {
    bioCount.value = 0;
    storeBioTextEditingController.clear();
  }

  //* update store bio API Implementation
  final Rx<StoreCommonUpdateModel?> storeCommonUpdateData = Rx<StoreCommonUpdateModel?>(null);
  // final Rx<Kids?> kidsData = Rx<Kids?>(null);
  RxBool isStoreBioLoading = RxBool(false);
  Future<void> updateStoreBio() async {
    try {
      isStoreBioLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'bio': storeBioTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStoreBio,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        storeCommonUpdateData.value = StoreCommonUpdateModel.fromJson(response.data);
        storesData.value = storeCommonUpdateData.value!.stores;
        storeBio.value = storesData.value!.bio;
        clearStoreBio();
        Get.back();
        isStoreBioLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isStoreBioLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreBioLoading.value = false;
      ll('updateStoreBio error: $e');
    }
  }

  //*update store BIN Api implement
  RxBool isStoreBINLoading = RxBool(false);
  Future<void> updateStoreBIN() async {
    try {
      isStoreBINLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'bin': storeBINTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStoreBin,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        storeCommonUpdateData.value = StoreCommonUpdateModel.fromJson(response.data);
        storesData.value = storeCommonUpdateData.value!.stores;
        storeBIN.value = storesData.value!.bin!;
        Get.back();
        isStoreBINLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isStoreBINLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreBINLoading.value = false;
      ll('updateStoreBIN error: $e');
    }
  }

  //*update store Qr code Api implement
  RxBool isStoreQrCodeLoading = RxBool(false);
  Future<void> updateStoreQrCode() async {
    try {
      isStoreQrCodeLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'qr_code': storeQrCodeTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStoreQr,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        storeCommonUpdateData.value = StoreCommonUpdateModel.fromJson(response.data);
        storesData.value = storeCommonUpdateData.value!.stores;
        qrCode.value = storesData.value!.qrCode!;
        Get.back();
        isStoreQrCodeLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isStoreQrCodeLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreQrCodeLoading.value = false;
      ll('updateStoreQrCode error: $e');
    }
  }

  //*update store Qr code Api implement
  RxBool isStorePrivacyLinkLoading = RxBool(false);
  Future<void> updateStorePrivacyLink() async {
    try {
      isStorePrivacyLinkLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'privacy_link': "[{${storePrivacyLinkTextEditingController.text.trim()}}]",
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStorePrivacyLink,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        storeCommonUpdateData.value = StoreCommonUpdateModel.fromJson(response.data);
        storesData.value = storeCommonUpdateData.value!.stores;
        storePrivacyLink.value = storesData.value!.privacyLink;
        Get.back();
        isStorePrivacyLinkLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isStorePrivacyLinkLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStorePrivacyLinkLoading.value = false;
      ll('updateStorePrivacyLink error: $e');
    }
  }

//* All Business category Api call
  final Rx<AllBusinessCategoryModel?> businessCategoryData = Rx<AllBusinessCategoryModel?>(null);
  // final RxList<FeaturePost> featuredPostList = RxList<FeaturePost>([]);
  final RxList<BusinessCategory?> businessCategoryList = RxList<BusinessCategory?>([]);
  final RxBool isBusinessCategoryLoading = RxBool(false);
  Future<void> getAllBusinessCategory() async {
    try {
      isBusinessCategoryLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetBusinessCategories?take=100",
      ) as CommonDM;
      if (response.success == true) {
        clearStoreData();
        // featuredPostList.clear();
        businessCategoryData.value = AllBusinessCategoryModel.fromJson(response.data);
        businessCategoryList.addAll(businessCategoryData.value!.businessCategories!.data);
        // storeCategoryList.addAll(businessCategoryList.value);
        List<String> categoryValues = businessCategoryList.map((category) => category!.value).toList();
        storeCategoryList.addAll(categoryValues);
        ll(storeCategoryList);
        // storeCategoryList.addAll(businessCategoryData.value!.businessCategory.value);
        isBusinessCategoryLoading.value = false;
      } else {
        isBusinessCategoryLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isBusinessCategoryLoading.value = true;
      ll('getAllBusinessCategory error: $e');
    }
  }

  // storeCategory.value
  //*update store category Api implement
  RxBool isStoreCategoryLoading = RxBool(false);
  Future<void> updateStoreCategory() async {
    try {
      isStoreCategoryLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'categories': storeCategoryTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStoreCategories,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        storeCommonUpdateData.value = StoreCommonUpdateModel.fromJson(response.data);
        storesData.value = storeCommonUpdateData.value!.stores;
        storeCategory.value = storesData.value!.categories[0];
        Get.back();
        isStoreCategoryLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isStoreCategoryLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreCategoryLoading.value = false;
      ll('updateStoreQrCode error: $e');
    }
  }

  //* update store legal files API Implementation
  final RxBool isLegalFileLoading = RxBool(false);
  Future<void> updateLegalFiles() async {
    try {
      isLegalFileLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'store_id': selectedStoreId.value.toString(),
      };
      List<String> key = [];
      List<dynamic> value = [];
      for (int i = 0; i < selectedImages.length; i++) {
        key.add('legal_files[$i]');
        value.add(selectedImages[i].path);
      }
      var response = await apiController.mediaUploadMultipleKeyAndValue(
        url: kuUpdateStoreLegalFiles,
        body: body,
        token: token,
        keys: key,
        values: value,
      ) as CommonDM;

      if (response.success == true) {
        storeLegalPapersList.clear();
        storeCommonUpdateData.value = StoreCommonUpdateModel.fromJson(response.data);
        storesData.value = storeCommonUpdateData.value!.stores;
        storeLegalPapersList.addAll(storesData.value!.legalPapers);
        isLegalFileLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isLegalFileLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isLegalFileLoading.value = false;
      ll('updateLegalFiles error: $e');
    }
  }

  final RxBool isImageUploadPageLoading = RxBool(false);
  final Rx<ProfileCoverPictureUpdateModel?> profileCoverPictureUpdateData = Rx<ProfileCoverPictureUpdateModel?>(null);
  Future<void> uploadStoreProfileAndCover(File imageFile, String type, [isFromProfile = true]) async {
    try {
      // if (isFromProfile == true) {
      isImageUploadPageLoading.value = true;
      // }
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'store_id': selectedStoreId.value.toString(),
      };
      var response = await apiController.mediaUpload(
        url: type == 'profile' ? kuUpdateStoreProfilePicture : kuUpdateStoreCoverPhoto,
        token: token,
        body: body,
        key: "image",
        value: imageFile.path,
      ) as CommonDM;

      if (response.success == true) {
        profileCoverPictureUpdateData.value = ProfileCoverPictureUpdateModel.fromJson(response.data);
        if (type == "profile") {
          storeProfilePicture.value = profileCoverPictureUpdateData.value!.profilePicture!;
        } else {
          storeCoverPhoto.value = profileCoverPictureUpdateData.value!.coverPhoto!;
        }
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
        allLocationList.clear();
        cityListData.value = CityListModel.fromJson(response.data);
        allLocationList.addAll(cityListData.value!.cities);
        // isLinkListLoading.value = false;
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

  final Rx<AllLocationModel?> allLocationData = Rx<AllLocationModel?>(null);
  Future<void> getStoreLocations() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetStoreLocations/$selectedStoreId",
      ) as CommonDM;
      if (response.success == true) {
        storeLocationList.clear();
        allLocationData.value = AllLocationModel.fromJson(response.data);
        storeLocationList.addAll(allLocationData.value!.locations);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getStoreLocations error: $e');
    }
  }

  //*store Store Location Api implement
  RxBool isStoreLocationLoading = RxBool(false);
  Future<void> storeStoreLocation() async {
    try {
      isStoreLocationLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'location': storeLocationTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreStoreLocation,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        // storeLocationList.clear();
        // allLocationData.value = AllLocationModel.fromJson(response.data);
        // storeLocationList.addAll(allLocationData.value!.locations);
        await getStoreLocations();
        isStoreLocationLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isStoreLocationLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreLocationLoading.value = false;
      ll('storeStoreLocation error: $e');
    }
  }

  final RxInt selectedStoreLocationId = RxInt(-1);
  //*store Store Location Api implement
  Future<void> updateStoreLocation() async {
    try {
      isStoreLocationLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': selectedStoreLocationId.value.toString(),
        'location': storeLocationTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStoreLocation,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        // storeLocationList.clear();
        // allLocationData.value = AllLocationModel.fromJson(response.data);
        // storeLocationList.addAll(allLocationData.value!.locations);
        await getStoreLocations();
        isStoreLocationLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isStoreLocationLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreLocationLoading.value = false;
      ll('updateStoreLocation error: $e');
    }
  }

//*Delete Store Location Api Call
  Future<void> deleteStoreLocation() async {
    try {
      isStoreLocationLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteStoreLocation/${selectedStoreLocationId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        await getStoreLocations();
        isStoreLocationLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreLocationLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreLocationLoading.value = false;
      ll('deleteStoreLocation error: $e');
    }
  } //*Store All Contacts

  final RxInt storeContactId = RxInt(-1);
  final Rx<StoreContactModel?> allContactData = Rx<StoreContactModel?>(null);
  final RxList<Contact> contactList = RxList<Contact>([]);
  final RxBool isStoreContactLoading = RxBool(false);
  Future<void> getStoreContacts() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetAllStoreContacts/${selectedStoreId.value.toString()}",
      ) as CommonDM;
      if (response.success == true) {
        contactList.clear();
        allContactData.value = StoreContactModel.fromJson(response.data);
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
      ll('getStoreContacts error: $e');
    }
  }

  // final Rx<StoreContactModel?> contactUpdateData = Rx<StoreContactModel?>(null);
  Future<void> storStoreContact(type) async {
    try {
      isStoreContactLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'type': type,
        'value': type == 'phone' ? storePhoneNumberTextEditingController.text.trim() : storeEmailTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreStoreContacts,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getStoreContacts();
        isStoreContactLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreContactLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreContactLoading.value = false;
      ll('storStoreContact error: $e');
    }
  }

  // //* update contact API Implementation
  Future<void> updateContact(id, type) async {
    try {
      isStoreContactLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': id.toString(),
        'type': type,
        'value': type == 'phone' ? storePhoneNumberTextEditingController.text.trim() : storeEmailTextEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStoreContacts,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        // for (int i = 0; i < contactDataList.length; i++) {
        //   if (contactDataList[i].id == id) {
        //     contactDataList[i] = Contact.fromJson(response.data);
        //   }
        // }
        await getStoreContacts();
        isStoreContactLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreContactLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreContactLoading.value = false;
      ll('updateContact error: $e');
    }
  }

  // //* delete contact API Implementation
  Future<void> deleteContact(id, type) async {
    try {
      isStoreContactLoading.value = true;
      Get.back();
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteStoreContact/${id.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getStoreContacts();
        isStoreContactLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreContactLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreContactLoading.value = false;
      ll('deleteContact error: $e');
    }
  }

  //* Get link api implementation
  Rx<LinkListModel?> linkListData = Rx<LinkListModel?>(null);
  final RxList linkSourceList = RxList([]);
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

  final RxBool isStoreSocialLinkSaveEnabled = RxBool(false);
  //*Store all links
  final RxInt storeLinkId = RxInt(-1);
  final Rx<StoreAllLinksModel?> allLinksData = Rx<StoreAllLinksModel?>(null);
  final RxList<Link> allLinkList = RxList<Link>([]);
  final RxBool isStoreLinkLoading = RxBool(false);
  Future<void> getStoreLinks() async {
    try {
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetAllLinks/${selectedStoreId.value.toString()}",
      ) as CommonDM;
      if (response.success == true) {
        allLinkList.clear();
        allLinksData.value = StoreAllLinksModel.fromJson(response.data);
        allLinkList.addAll(allLinksData.value!.links);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      ll('getStoreLinks error: $e');
    }
  }

  Future<void> storStoreLink() async {
    try {
      isStoreLinkLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'store_id': selectedStoreId.value.toString(),
        'type': selectedStoreSocialLinkSource.value,
        'link': storeSocialLinkTextEditingController.text.toString().trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuStoreStoreLink,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getStoreLinks();
        isStoreLinkLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreLinkLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreLinkLoading.value = false;
      ll('storStoreLink error: $e');
    }
  }

  // //* update Store link API Implementation
  Future<void> updateStoreLink() async {
    try {
      isStoreLinkLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': storeLinkId.value.toString(),
        'type': selectedStoreSocialLinkSource.value.toString(),
        'link': storeSocialLinkTextEditingController.text.toString().trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateStoreLink,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getStoreLinks();
        isStoreLinkLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreLinkLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreLinkLoading.value = false;
      ll('updateContact error: $e');
    }
  }

  // //* delete contact API Implementation
  Future<void> deleteStoreLink() async {
    try {
      isStoreLinkLoading.value = true;
      Get.back();
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteStoreLink/${storeLinkId.value.toString()}',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        await getStoreLinks();
        isStoreLinkLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isStoreLinkLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreLinkLoading.value = false;
      ll('deleteStoreLink error: $e');
    }
  }
}
