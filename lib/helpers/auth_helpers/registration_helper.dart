import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class RegistrationHelper {
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  void checkName() {
    if (_authenticationController.registerFirstNameTextEditingController.text.trim() != '' &&
        _authenticationController.registerLastNameTextEditingController.text.trim() != '') {
      _authenticationController.checkValidName.value = true;
    } else {
      _authenticationController.checkValidName.value = false;
    }
  }

  void registerFirstNameOnChange() {
    checkName();
    if (_authenticationController.registerFirstNameTextEditingController.text.trim() == '') {
      _authenticationController.firstNameError.value = ksEmptyFirstNameErrorMessage.tr;
    } else {
      _authenticationController.firstNameError.value = "";
    }
  }

  void registerLastNameOnChange() {
    checkName();
    if (_authenticationController.registerLastNameTextEditingController.text.trim() == '') {
      _authenticationController.lastNameError.value = ksEmptyLastNameErrorMessage.tr;
    } else {
      _authenticationController.lastNameError.value = "";
    }
  }

  void onPressedNext() {
    Get.find<ProfileController>().isRouteFromAboutInfo.value = false;
    _authenticationController.birthDay.value = '';
    Get.toNamed(krSelectBirthday);
  }
}
