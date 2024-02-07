import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/single_image_description.dart';

class GalleryPhotoHelper {
  final GalleryController galleryController = Get.find<GalleryController>();

  void resetTapButtonData() {
    galleryController.tapAbleButtonState.clear();
    galleryController.tapAbleButtonState.addAll([true, false]);
  }

  void yourPhotosTapableButton() {
    galleryController.imageDataList.clear();
    for (var album in galleryController.albumData.value!.imageAlbums.data) {
      if (album.title!.toLowerCase() == 'profile picture' || album.title!.toLowerCase() == 'cover photo') {
        galleryController.imageDataList.add(album);
      }
    }
  }

  void albumsTapableButton() {
    galleryController.imageDataList.clear();
    for (var album in galleryController.albumData.value!.imageAlbums.data) {
      if (album.title!.toLowerCase() != 'profile picture' && album.title!.toLowerCase() != 'cover photo') {
        galleryController.imageDataList.add(album);
      }
    }
  }

  void galleryPhotoActionOnChanged({required int index}) {
    galleryController.galleryPhotoActionSelect.value = galleryController.galleryPhotoActionList[index]['action'];
    if (galleryController.galleryPhotoActionSelect.value == '') {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
    } else {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = true;
    }
  }

  void galleryPhotoOnPressed({required int index}) {
    galleryController.galleryPhotoActionSelect.value = galleryController.galleryPhotoActionList[index]['action'];
    if (galleryController.galleryPhotoActionSelect.value == '') {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
    } else {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = true;
    }
  }

  Color galleryPhotoItemColor({required int index}) {
    if (galleryController.galleryPhotoActionSelect.value == galleryController.galleryPhotoActionList[index]['action']) {
      return cPrimaryTint3Color;
    }
    return cWhiteColor;
  }

  //*Single Photo view bottom sheet

  void photoOnPressed({required int index}) async {
    galleryController.photoActionSelect.value = galleryController.photoActionList[index]['action'];
    Get.back();
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    if (galleryController.photoActionSelect.value == 'Make as profile picture') {
      await galleryController.imageMakeProfilePicture();
    } else if (galleryController.photoActionSelect.value == 'Make as cover photo') {
      await galleryController.imageMakeCoverPhoto();
    } else if (galleryController.photoActionSelect.value == 'Delete photo') {
      await galleryController.deleteImage();
    }
    //  else if (galleryController.photoActionSelect.value == 'Download photo') {
    //   // await galleryController.downloadPhoto();
    // }
    else if (galleryController.photoActionSelect.value == 'Edit caption') {
      galleryController.isImageDescriptionSaveButtonEnable.value = false;
      if (galleryController.imageDetailsData.value!.image!.description == null || galleryController.imageDetailsData.value!.image!.description == '') {
        galleryController.imageDescriptionUpdateController.text = '';
      } else {
        galleryController.imageDescriptionUpdateController.text = galleryController.imageDetailsData.value!.image!.description;
      }
      Get.to(() => SingleImageDescription(
            image: galleryController.imageDetailsData.value!.image!.fullPath.toString(),
          ));
    }
  }

  Color photoItemColor({required int index}) {
    if (galleryController.photoActionSelect.value == galleryController.photoActionList[index]['action']) {
      return cPrimaryTint3Color;
    }
    return cWhiteColor;
  }
}
