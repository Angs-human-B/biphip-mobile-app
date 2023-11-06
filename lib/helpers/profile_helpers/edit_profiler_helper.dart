import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class EditProfileHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  //* Place Edit Methods
  void setHometown() {
    _profileController.resetTextEditor();
    _profileController.getCityList();
    _profileController.getMethod(9);
  }

  void editHometown() {
    _profileController.enableSaveButton.value = true;
    _profileController.getMethod(0);
    _profileController.getCityList();
  }

  void setCurrentCity() {
    _profileController.resetTextEditor();
    _profileController.getMethod(1);
    Get.toNamed(krEdit);
    _profileController.getCityList();
  }

  void editCurrentCity() {
    _profileController.enableSaveButton.value = true;
    _profileController.isCurrentlyLiveHere.value = true;
    _profileController.cityID.value = _profileController.currentCityData.value!.id!;
    _profileController.getMethod(2);
    _profileController.getCityList();
  }

  void setOtherCity() {
    _profileController.resetTextEditor();
    _profileController.isSingleDatePicker.value = true;
    _profileController.getMethod(3);
    Get.toNamed(krEdit);
    _profileController.getCityList();
  }

  void editOtherCity(index){
    _profileController.cityID.value = _profileController.otherCityList[index].id!;
                      _profileController.presentAddressTextEditingController.text = _profileController.otherCityList[index].city!;
                      _profileController.enableSaveButton.value = true;
                      _profileController.isSingleDatePicker.value = true;
                      _profileController.getMethod(4);
                      _profileController.getCityList();
  }
}
