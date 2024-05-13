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
  final TextEditingController selectPeopleTextEditingController = TextEditingController();
  final RxBool isSelectPeopleCrossShow = RxBool(false);
  final RxString selfieText = RxString("");

  final Rx<Color> textSelectedColor = Rx<Color>(cWhiteColor);
  // final RxList<bool> isPeopleSelect = RxList<bool>[(false)];
  void customoOnInit() {
    x.value = width * 0.4;
    y.value = height * 0.5;
    ll(x.value);
    ll(y.value);
    ll(width * 0.4);
    ll(height * 0.5);
    super.onInit();
  }

  final Rx<double> x = Rx<double>(1.0);
  final Rx<double> y = Rx<double>(1.0);
  final RxList<bool> isPeopleSelected = RxList<bool>([]);
  void resetSelfieData() {
    selfieTextEditingController.clear();
    selfieImageLink.value = "";
    selfieImageFile.value = File("");
    isSelfieImageChanged.value = false;
    isTextFieldShow.value = false;
    isColorsShow.value = false;
    textSelectedColor.value = cWhiteColor;
    selfieText.value = "";
    selectedPrivacy.value = "";
    selectedPrivacyId.value = -1;
    isSelectPeopleCrossShow.value = false;
    selectPeopleTextEditingController.clear();
  }

  final RxList<Map<String, dynamic>> privacyList = RxList([
    {'icon': BipHip.world, 'action': 'Public', 'id': 1},
    {'icon': BipHip.friends, 'action': 'Friends', 'id': 2},
    {'icon': BipHip.addFamily, 'action': 'Families', 'id': 3},
    {'icon': BipHip.addFamily, 'action': 'Friends & Families', 'id': 4},
    {'icon': BipHip.unfriend, 'action': 'Custom', 'id': 5},
  ]);

  final RxString selectedPrivacy = RxString("");
  final RxInt selectedPrivacyId = RxInt(-1);
  final RxInt temporarySelectedPrivacyId = RxInt(-1);

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
