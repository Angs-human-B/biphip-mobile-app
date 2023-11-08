import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryPhotoHelper {
  final GalleryController _galleryController = Get.find<GalleryController>();

  void resetTapButtonData() {
    _galleryController.tapAbleButtonState.clear();
    _galleryController.tapAbleButtonState.addAll([true, false]);
  }

  void galleryPhotoFirstTapableButton() {
    _galleryController.imageDataList.clear();
    for (var album in _galleryController.albumData.value!.imageAlbums!.data) {
      if (album.title!.toLowerCase() == 'profile picture' || album.title!.toLowerCase() == 'cover photo') {
        _galleryController.imageDataList.add(album);
      }
    }
  }

  void galleryPhotoSecondTapableButton() {
    _galleryController.imageDataList.clear();
    for (var album in _galleryController.albumData.value!.imageAlbums!.data) {
      if (album.title!.toLowerCase() != 'profile picture' && album.title!.toLowerCase() != 'cover photo') {
        _galleryController.imageDataList.add(album);
      }
    }
  }
}
