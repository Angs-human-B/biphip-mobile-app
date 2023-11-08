
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryPhotoHelper{
  final GalleryController _galleryController = Get.find<GalleryController>();
    //*For tapAble button
  void toggleType(int index) {
    for (int i = 0; i < 2; i++) {
      if (index == i) {
        _galleryController.tapAbleButtonState[i] = true;
      } else {
        _galleryController.tapAbleButtonState[i] = false;
      }
    }
  }

  void resetTapButtonData() {
    _galleryController.tapAbleButtonState.clear();
    _galleryController.tapAbleButtonState.addAll([true, false]);
  }
}