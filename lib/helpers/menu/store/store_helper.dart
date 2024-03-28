import 'dart:io';

import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/store/widgets/store_picture_upload_content.dart';

class StoreHelper{
  final StoreController storeController = Get.find<StoreController>();
    final GlobalController globalController = Get.find<GlobalController>();
    Widget totalStoreShow() {
    if (storeController.totalStoreCount.value == 0) {
      return const SizedBox();
    } else {
      return Text(
        '${ksTotalStore.tr}: ${storeController.totalStoreCount.value}',
        style: semiBold14TextStyle(cBlackColor),
      );
    }
  }


  //*Edit Store cover bottom sheet content
  void storeCoverPhotoUploadBottomSheet(context) {
    storeController.isStoreProfilePicEditor.value = false;
    resetStoreImage();
    globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 170,
      content: StorePictureUploadContent(
        isImageChanged: storeController.isCoverImageChanged,
        imagePath: storeController.coverImageLink,
        imageFile: storeController.coverImageFile,
      ),
    );
  }

  //*Edit kid profile bottom sheet content
  void storeProfilePicUploadBottomSheet(context) {
    storeController.isStoreProfilePicEditor.value = true;
    storeController.storeViewOptionEnabled.value = false;
    resetStoreImage();
    globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 170,
      content: StorePictureUploadContent(
        isImageChanged: storeController.isProfileImageChanged,
        imagePath: storeController.profileImageLink,
        imageFile: storeController.profileImageFile,
      ),
    );
  }

    void viewProfilePic() {
    if (storeController.storeProfilePicture.value != "") {
      storeController.isStoreProfilePhoto.value = true;
      storeController.storeViewOptionEnabled.value = true;
      storeController.storePreviewPhoto.value = storeController.storeProfilePicture.value;
      Get.toNamed(krStorePhotoView);
    }
  }

  void viewCoverPhoto() {
    if (storeController.storeCoverPhoto.value != "") {
      storeController.storeViewOptionEnabled.value = true;
      storeController.isStoreProfilePhoto.value = false;
      storeController.storePreviewPhoto.value = storeController.storeCoverPhoto.value;
      Get.toNamed(krStorePhotoView);
    }
  }

    void resetStoreImage() {
    storeController.profileImageFile.value = File('');
    storeController.profileImageLink.value = '';
    storeController.isProfileImageChanged.value = false;
    storeController.isSharedToNewFeed.value = false;
    storeController.coverImageFile.value = File('');
    storeController.coverImageLink.value = '';
    storeController.isCoverImageChanged.value = false;
  }
    void storeInitialDataCoverPhoto() {
    if (storeController.storeCoverPhoto.value != "") {
      storeController.storeViewOptionEnabled.value = true;
      storeController.isStoreProfilePhoto.value = false;
      storeController.storePreviewPhoto.value = storeController.storeCoverPhoto.value;
    } else {
      storeController.storeViewOptionEnabled.value = false;
    }
    storeController.isStoreProfilePicEditor.value = false;
  }

  void storeInitialDataProfilePicture() {
    if (storeController.storeProfilePicture.value != "") {
      storeController.storeViewOptionEnabled.value = true;
      storeController.isStoreProfilePhoto.value = false;
      storeController.storePreviewPhoto.value = storeController.storeProfilePicture.value;
    } else {
      storeController.storeViewOptionEnabled.value = false;
    }
    storeController.isStoreProfilePicEditor.value = true;
  }

  //* Kid cover photo bottom sheet content
  void storeCoverPhotoEditBottomSheet(context) {
    storeInitialDataCoverPhoto();
    resetStoreImage();
    globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 210,
      content: StorePictureUploadContent(
        viewPhoto: ksViewCoverPhoto.tr,
        isImageChanged: storeController.isCoverImageChanged,
        imagePath: storeController.coverImageLink,
        imageFile: storeController.coverImageFile,
      ),
    );
  }

  void storeProfilePicEditBottomSheet(context) {
    storeInitialDataProfilePicture();
    resetStoreImage();
    globalController.commonBottomSheet(
        context: context,
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {},
        rightText: '',
        rightTextStyle: regular14TextStyle(cBiddingColor),
        title: ksUploadImage.tr,
        isRightButtonShow: false,
        isScrollControlled: false,
        bottomSheetHeight: 210,
        content: StorePictureUploadContent(
          viewPhoto: ksViewProfilePicture.tr,
          isImageChanged: storeController.isProfileImageChanged,
          imagePath: storeController.profileImageLink,
          imageFile: storeController.profileImageFile,
        ));
  }
}