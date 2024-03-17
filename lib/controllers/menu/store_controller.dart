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
  final RxString qrCode = RxString('www.storeqr.com');
  final legalPapersList = [//!Remove it
    "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
    "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
    "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
    "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
    "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
  ];
}
