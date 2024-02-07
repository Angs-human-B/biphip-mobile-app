import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

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
   
    if (galleryController.galleryPhotoActionSelect.value == '') {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
    } else {
      galleryController.galleryPhotoBottomSheetRightButtonState.value= true;
    }
  }
    void galleryPhotoOnPressed({required int index}) {
      galleryController.galleryPhotoActionSelect.value = galleryController.galleryPhotoActionList[index]['action'];
    if (galleryController.galleryPhotoActionSelect.value == '') {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
    } else {
      galleryController.galleryPhotoBottomSheetRightButtonState.value= true;
    }
  }
  Color galleryPhotoItemColor({required int index}){
     if (galleryController.galleryPhotoActionSelect.value == galleryController.galleryPhotoActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
      return cWhiteColor;
  }
}
