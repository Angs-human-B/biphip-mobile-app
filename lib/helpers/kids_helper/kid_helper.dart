import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

//*kids
class KidHelper {
  final KidsController _kidsController = Get.find<KidsController>();
  Widget totalKidShow() {
    if (_kidsController.totalKidsCount.value == 0) {
      return const SizedBox();
    } else {
      return Text(
        '${ksTotalKids.tr}: ${_kidsController.totalKidsCount.value}',
        style: semiBold14TextStyle(cBlackColor),
      );
    }
  }

  //*Edit Kids
  void checkCanEditKidInfo() {
    if ((_kidsController.kidNameTextEditingController.text.trim() != '' &&
            _kidsController.kidNameTextEditingController.text.trim() != _kidsController.kidName.value &&
            _kidsController.kidNameTextEditingController.text.trim().length > 2) ||
        (_kidsController.kidAgeTextEditingController.text.trim() != '' &&
            _kidsController.kidAgeTextEditingController.text.trim() != _kidsController.kidAge.value &&
            _kidsController.kidAgeTextEditingController.text.trim() != '0') ||
        _kidsController.isKidImageChanged.value) {
      _kidsController.isSaveKidButtonEnabled.value = true;
    } else {
      _kidsController.isSaveKidButtonEnabled.value = false;
    }
  }

  void setupEditKid() {
    for (int i = 0; i < _kidsController.kidList.length; i++) {
      if (_kidsController.kidId.value == _kidsController.kidList[i].id) {
        _kidsController.kidNameTextEditingController.text = _kidsController.kidList[i].name ?? '';
        _kidsController.kidAgeTextEditingController.text = _kidsController.kidList[i].age.toString();
        _kidsController.kidImageLink.value = _kidsController.kidList[i].kidImage.toString();
        _kidsController.kidName.value = _kidsController.kidNameTextEditingController.text;
        _kidsController.kidAge.value = _kidsController.kidAgeTextEditingController.text;
      }
    }
    checkCanEditKidInfo();
  }

  void editKidCameraOnPressed() async {
    await Get.find<GlobalController>()
        .selectImageSource(_kidsController.isKidImageChanged, _kidsController.kidImageLink, _kidsController.kidImageFile, 'camera', true);
    checkCanEditKidInfo();
  }

  void editKidGallereyOnPressed() async {
    await Get.find<GlobalController>()
        .selectImageSource(_kidsController.isKidImageChanged, _kidsController.kidImageLink, _kidsController.kidImageFile, 'gallery', true);
    checkCanEditKidInfo();
  }

  void kidEditButtonOnPressed() {
    _kidsController.isSaveKidButtonEnabled.value = false;
    setupEditKid();
    Get.back();
  }

  void kidDeleteButtonOnPressed() async {
    Get.back();
    await _kidsController.kidDelete();
  }
}
