import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class LoginHelper {
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  void checkCanLogin() {
    if (_authenticationController.loginEmailTextEditingController.text.trim().isNotEmpty &&
        _authenticationController.loginPasswordTextEditingController.text.trim().isNotEmpty &&
        _authenticationController.loginPasswordTextEditingController.text.length >= kMinPasswordLength) {
      _authenticationController.canLogin.value = true;
    } else {
      _authenticationController.canLogin.value = false;
    }
  }

  void loginEmailEditorOnChanged() {
    checkCanLogin();
    if (_authenticationController.loginEmailTextEditingController.text.trim() == '') {
      _authenticationController.loginEmailErrorText.value = ksEmptyEmailErrorMessage.tr;
    } else if (!_authenticationController.loginEmailTextEditingController.text.trim().isValidEmail) {
      _authenticationController.loginEmailErrorText.value = ksInvalidEmailErrorMessage.tr;
    } else {
      _authenticationController.loginEmailErrorText.value = '';
    }
  }

  void loginPasswordEditorOnChanger() {
    checkCanLogin();
    if (_authenticationController.loginPasswordTextEditingController.text.trim() == '') {
      _authenticationController.loginPasswordErrorText.value = ksEmptyPasswordErrorMessage.tr;
    } else if (_authenticationController.loginPasswordTextEditingController.text.length < kMinPasswordLength) {
      _authenticationController.loginPasswordErrorText.value = ksPasswordLengthErrorMessage.tr;
    } else {
      _authenticationController.loginPasswordErrorText.value = '';
    }
  }

  void getSaveUserDetails(item) async {
    final SpController spController = SpController();
        await spController.saveBearerToken(item['token']);
        await spController.saveRememberMe(true);
        await spController.saveUserName(item['name'].toString());
        await spController.saveUserFirstName(item['first_name'].toString());
        await spController.saveUserLastName(item['last_name'].toString());
        await spController.saveUserImage(item['image_url'].toString());
        await spController.saveUserEmail(item['email'].toString());
        await Get.find<GlobalController>().getUserInfo();
        Get.offAllNamed(krHome);
        await Get.find<HomeController>().getPostList();
  }
}
