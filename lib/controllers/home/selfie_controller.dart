import 'dart:io';

import 'package:bip_hip/utils/constants/imports.dart';

class SelfieController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxString selfieImageLink = RxString('');
  final Rx<File> selfieImageFile = File('').obs;
  final RxBool isSelfieImageChanged = RxBool(false);
  final RxBool isTextFieldShow = RxBool(false);
  final RxBool isColorsShow = RxBool(false);
  final TextEditingController selfieTextEditingController = TextEditingController();
  final RxString selfieText = RxString("");
  // Offset dragOffset = Offset.zero;
  // Rx<Offset> dragOffset = Offset.zero.obs;

  // void updateDragOffset(Offset offset) {
  //   dragOffset.value = offset;
  // }
  // void updateDragOffset(Offset offset) {
  //   // Perform your calculations here
  //   Offset calculatedOffset = calculateNewOffset(offset);

  //   // Update the dragOffset with the calculated value
  //   dragOffset.value = calculatedOffset;
  // }

  // Offset calculateNewOffset(Offset offset) {
  //   // Example calculation: Add 10 pixels to the x and y coordinates
  //   return Offset(offset.dx + 10, offset.dy + 10);
  // }
// Offset initialOffset = Offset.zero;
  //  void updateDragOffset(Offset initialOffset, Offset finalOffset) {
  //   // Calculate the difference between the final and initial positions
  //   Offset difference = finalOffset - initialOffset;

  //   // Update the dragOffset with the calculated difference
  //   dragOffset.value += difference;
  // }

// void updateDragOffset(Offset newPosition) {
//     dragOffset.value = newPosition;
//   }
  // final RxDouble x = RxDouble(width * 0.5);
  // final RxDouble y = RxDouble(height * 0.5);

  final Rx<Color> textSelectedColor = Rx<Color>(cWhiteColor);
  void resetSelfieData() {
    selfieTextEditingController.clear();
    selfieImageLink.value = "";
    selfieImageFile.value = File("");
    isSelfieImageChanged.value = false;
    isTextFieldShow.value = false;
    isColorsShow.value = false;
    textSelectedColor.value = cWhiteColor;
    selfieText.value = "";
    // dragOffset.value = Offset.zero;
  }

  final List colorList = [
    {"color": "White", "colorCode": cWhiteColor},
    {"color": "Black", "colorCode": cBlackColor},
    {"color": "Blue", "colorCode": cPrimaryColor},
    {"color": "Green", "colorCode": cGreenColor},
    {"color": "Red", "colorCode": cRedColor},
    {"color": "Bidding", "colorCode": cBiddingColor},
    {"color": "Category", "colorCode": cCategoryColor},
    {"color": "DarkRed", "colorCode": cDarkRedColor},
    {"color": "Pink", "colorCode": cPinkColor},
    {"color": "AmberAccent", "colorCode": cAmberAccentColor},
  ];
}
