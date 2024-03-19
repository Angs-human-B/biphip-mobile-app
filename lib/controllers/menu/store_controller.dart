import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
  final Rx<String?> storeBio = Rx<String?>(null);
  final Rx<String?> storeCategory = Rx<String?>('Electronics');
  final RxList storeLocationList = RxList(["Shewrapara, Mirpur, Dhaka, Bangladesh"]);
  final RxList storeNumberList = RxList([
    {"id": 1, "phone": '0175634536785'},
    {"id": 2, "phone": '0175634536786'}
  ]);
  final RxList storeEmailList = RxList([
    {"id": 1, "email": 'Genieelec@gmail.com'},
    {"id": 2, "email": 'Genieelec1@gmail.com'}
  ]);
  final RxList legalPaperAllInfoList = RxList([
    {"fileName": "Image.png", "fileSize": "250KB"},
    {"fileName": "Image1.png", "fileSize": "251KB"}
  ]);
  final RxList websiteAndSocialLinkList = RxList(["Facebook.1", "Facebook.2", "Facebook.3", "Facebook.4", "Facebook.5"]);
  final Rx<String?> storePrivacyLink = Rx<String?>('abc');
  final RxList paymentMethodList = RxList([
    {"paymentMethod": "Nagad", "payment": "01789368774638"},
    {"paymentMethod": "Paypal", "payment": "Shohagjalal@gmail.com"}
  ]);
  final RxString qrCode = RxString('store.qr.code');
  final RxString storeBIN = RxString('129874675766');
  //!* Edit store
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
  final List<String> storeCategoryList = ['Electronics', 'Shop', 'Gadgets', 'Hardware'];
  final RxString selectedStoreSocialLinkSource = RxString("");
  final RxString temporarySelectedStoreSocialLinkSource = RxString("");
  final RxList storeSocialLinkSourceList = RxList(["Facebook","Twitter","Youtube","Instagram","Website"]);
  final RxBool storeSocialLinkBottomSheetRightButtonState = RxBool(false);
  final TextEditingController storePaymentTextEditingController = TextEditingController();
  final TextEditingController storeBioTextEditingController = TextEditingController();
    final RxInt bioCount = RxInt(0);
  final RxString selectedStorePaymentMethod = RxString("");
  final RxString temporarySelectedStorePaymentMethod = RxString("");
  final RxList storePaymentMethodList = RxList(["Bkash","Nagad","Rocket","Paypal","Visacard","Mastercard"]);
  final RxBool storePaymentMethodBottomSheetRightButtonState = RxBool(false);
  final RxList<String> allLocationList = RxList<String>([
    "Shewrapar, Dhaka",
    "Kazipara, Dhaka",
    "Mirpur10, Dhaka",
    "Mirpur11, Dhaka",
    "Mirpur12, Dhaka",
    "Agargaon, Dhaka",
  ]);
  final RxBool isEditOrAdd = RxBool(false);
  final legalPapersList = [
    //!Remove it
    "https://images.examples.com/wp-content/uploads/2018/06/Affidavit-Of-Identity-Example.jpg",
    "https://images.examples.com/wp-content/uploads/2018/06/Affidavit-Of-Identity-Example.jpg",
    "https://images.examples.com/wp-content/uploads/2018/06/Affidavit-Of-Identity-Example.jpg",
    "https://images.examples.com/wp-content/uploads/2018/06/Affidavit-Of-Identity-Example.jpg",
    "https://images.examples.com/wp-content/uploads/2018/06/Affidavit-Of-Identity-Example.jpg",
  ];
  final storeReviewList = [
    {"userImage": "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","userName": "Emma isabela","storeName":"Store Name","rating":"4.0","content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."},
    {"userImage": "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","userName": "Emma isabela2","storeName":"Store Name2","rating":"4.0","content": "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"},
    {"userImage": "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","userName": "Emma isabela3","storeName":"Store Name3","rating":"4.0","content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."},
    {"userImage": "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","userName": "Emma isabela4","storeName":"Store Name4","rating":"4.0","content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."},
  ];
}
