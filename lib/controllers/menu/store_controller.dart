import 'dart:async';
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
  final RxList<String> businessType = RxList<String>(['Electronics', 'Shop', 'Gadgets', 'Hardware']);
  final RxBool isBusinessTypeSuffixIconVisible = RxBool(false);
  final RxBool isNextButtonEnable = RxBool(false);
  //*Store contact info
  final TextEditingController storeEmailController = TextEditingController();
  final TextEditingController storePhoneController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();
  final TextEditingController storeBioController = TextEditingController();
  final RxInt storeBioCount = RxInt(0);

  //*Social Links
  final TextEditingController storeWebsiteController = TextEditingController();
  final TextEditingController storeFacebookController = TextEditingController();
  final TextEditingController storeInstagramController = TextEditingController();
  final TextEditingController storeTwitterController = TextEditingController();
  final TextEditingController storeYoutubeController = TextEditingController();
  //*Documents
  final TextEditingController businessIdentificationNumberController = TextEditingController();

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

  void resetStoreData() {
    storeNameController.clear();
    businessTypeTextEditingController.clear();
    isBusinessTypeSuffixIconVisible.value = false;
    storeEmailController.clear();
    storePhoneController.clear();
    storeAddressController.clear();
    storeBioController.clear();
    storeBioCount.value = 0;
    storeWebsiteController.clear();
    storeFacebookController.clear();
    storeInstagramController.clear();
    storeTwitterController.clear();
    storeYoutubeController.clear();
    isNextButtonEnable.value = false;
    resetStoreProfilePictureData();
    resetStoreCoverPhotoData();
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
    }
  }

  Future<void> pickImageFromGallery() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      startUpload();
      Get.back();
      selectedImages.addAll(images);
    }
  }
}
