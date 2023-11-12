import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryPhotoHelper {
  final GalleryController galleryController = Get.find<GalleryController>();

  void resetTapButtonData() {
    galleryController.tapAbleButtonState.clear();
    galleryController.tapAbleButtonState.addAll([true, false]);
  }

  void galleryPhotoFirstTapableButton() {
    galleryController.imageDataList.clear();
    for (var album in galleryController.albumData.value!.imageAlbums!.data) {
      if (album.title!.toLowerCase() == 'profile picture' || album.title!.toLowerCase() == 'cover photo') {
        galleryController.imageDataList.add(album);
      }
    }
  }

  void galleryPhotoSecondTapableButton() {
    galleryController.imageDataList.clear();
    for (var album in galleryController.albumData.value!.imageAlbums!.data) {
      if (album.title!.toLowerCase() != 'profile picture' && album.title!.toLowerCase() != 'cover photo') {
        galleryController.imageDataList.add(album);
      }
    }
  }
}
