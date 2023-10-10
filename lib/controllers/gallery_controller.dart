
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryController extends GetxController{
    final RxList tapAbleButtonState = RxList([true, false]);
  final RxList tapAbleButtonText = RxList(["Your Photos", "Albums"]);
    //*For tapAble button
  void toggleType(int index) {
    for (int i = 0; i < 2; i++) {
      if (index == i) {
        tapAbleButtonState[i] = true;
      } else {
        tapAbleButtonState[i] = false;
      }
    }
  }

  void resetTapButtonData() {
    tapAbleButtonState.clear();
    tapAbleButtonState.addAll([true, false]);
  }
}