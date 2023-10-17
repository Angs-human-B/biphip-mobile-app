import 'dart:io';

import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/models/auth/common_unverify_model.dart';
import 'package:bip_hip/models/auth/forget_pass_model.dart';
import 'package:bip_hip/models/auth/login_model.dart';
import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/models/common/common_error_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class AuthenticationController extends GetxController {
  final RxString profileLink = RxString('');
  final Rx<File> profileFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxBool isImageUploadLoading = RxBool(false);
  final RxList users = RxList([]);

  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();

  final RxString parentRoute = RxString("register");
  final RxString verificationToken = RxString('');

  Future<void> getSavedUsers() async {
    List userList = await _spController.getUserList();
    users.clear();
    users.addAll(userList);
    ll("user list length : ${users.length}");
  }

  void onIntroDone() async {
    Get.offAllNamed(krLogin);
  }

  void resetProfileImage() {
    profileLink.value = '';
    profileFile.value = File('');
    isProfileImageChanged.value = false;
  }

  /*
  |--------------------------------------------------------------------------
  | //! info:: login
  |--------------------------------------------------------------------------
  */

  final TextEditingController loginEmailTextEditingController = TextEditingController();
  final TextEditingController loginPasswordTextEditingController = TextEditingController();
  final RxBool isLoginPasswordToggleObscure = RxBool(true);
  final RxBool isLoginRememberCheck = RxBool(false);
  final RxString loginEmailErrorText = RxString('');
  final RxString loginPasswordErrorText = RxString('');

  void resetLoginScreen() {
    loginEmailTextEditingController.clear();
    loginPasswordTextEditingController.clear();
    isLoginPasswordToggleObscure.value = true;
    isLoginRememberCheck.value = false;
    loginEmailErrorText.value = '';
    loginPasswordErrorText.value = '';
    canLogin.value = false;
  }

  final RxBool canLogin = RxBool(false);

  void checkCanLogin() {
    if (loginEmailTextEditingController.text.trim().isNotEmpty &&
        loginPasswordTextEditingController.text.trim().isNotEmpty &&
        loginPasswordTextEditingController.text.length >= kMinPasswordLength) {
      canLogin.value = true;
    } else {
      canLogin.value = false;
    }
  }

  final RxBool isLoginLoading = RxBool(false);
  Future<void> userLogin() async {
    try {
      isLoginLoading.value = true;
      Map<String, dynamic> body = {
        'email': loginEmailTextEditingController.text.toString(),
        "password": loginPasswordTextEditingController.text.toString(),
      };
      ll("body : $body");
      var response = await _apiController.commonApiCall(
        url: kuLogin,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.success == true) {
        LoginModel loginData = LoginModel.fromJson(response.data);
        Get.find<ProfileController>().userData.value = loginData.user;
        await _spController.saveBearerToken(loginData.token);
        await _spController.saveRememberMe(isLoginRememberCheck.value);
        await _spController.saveUserName(loginData.user.fullName.toString());
        await _spController.saveUserFirstName(loginData.user.firstName.toString());
        await _spController.saveUserLastName(loginData.user.lastName.toString());
        await _spController.saveUserImage(loginData.user.image.toString());
        await _spController.saveUserEmail(loginData.user.email.toString());
        if (isLoginRememberCheck.value) {
          await _spController.saveUserList({
            "email": loginData.user.email.toString(),
            "name": loginData.user.fullName.toString(),
            "first_name": loginData.user.firstName.toString(),
            "last_name": loginData.user.lastName.toString(),
            "image_url": loginData.user.image,
            "token": loginData.token.toString(),
          });
        }
        await _globalController.getUserInfo();
        // await setDeviceID(loginData.user.id);
        isLoginLoading.value = false;
        Get.offAllNamed(krHome);
        // final HomeController homeController = Get.find<HomeController>();
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        // await homeController.getUserHome();
      } else {
        if (response.code == 410) {
          CommonUnVerifyModel commonUnVerifyModel = CommonUnVerifyModel.fromJson(response.data);
          verificationToken.value = commonUnVerifyModel.token.toString();
          parentRoute.value = "login";
          resetOTPScreen();
          isLoginLoading.value = false;
          Get.toNamed(krOTP);
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          ErrorModel errorModel = ErrorModel.fromJson(response.data);
          isLoginLoading.value = false;
          if (errorModel.errors.isEmpty) {
            _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
          } else {
            _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
          }
        }
      }
    } catch (e) {
      isLoginLoading.value = false;
      ll('userLogin error: $e');
    }
  }

  /*
  |--------------------------------------------------------------------------
  | //! info:: register
  |--------------------------------------------------------------------------
  */

  final TextEditingController registerFirstNameTextEditingController = TextEditingController();
  final TextEditingController registerLastNameTextEditingController = TextEditingController();
  final TextEditingController registerEmailTextEditingController = TextEditingController();
  final TextEditingController registerPasswordTextEditingController = TextEditingController();
  final TextEditingController registerConfirmPasswordTextEditingController = TextEditingController();
  final RxString firstNameError = RxString('');
  final RxString lastNameError = RxString('');
  final RxString registerEmailError = RxString('');
  final RxString registerPasswordError = RxString('');
  final RxString registerConfirmPasswordError = RxString('');
  final RxString birthDay = RxString('');
  final RxString gender = RxString('');
  final RxBool isRegisterPasswordToggleObscure = RxBool(true);
  final RxBool isRegisterConfirmPasswordToggleObscure = RxBool(true);
  final RxBool isReferredRegistration = RxBool(false);
  final RxBool checkValidName = RxBool(false);
  final RxBool checkValidEmail = RxBool(false);
  final RxBool checkValidPassword = RxBool(false);

  void resetRegisterScreen() {
    registerFirstNameTextEditingController.clear();
    registerLastNameTextEditingController.clear();
    registerEmailTextEditingController.clear();
    registerPasswordTextEditingController.clear();
    registerConfirmPasswordTextEditingController.clear();
    isRegisterPasswordToggleObscure.value = true;
    isRegisterConfirmPasswordToggleObscure.value = true;
    checkValidName.value = false;
    checkValidEmail.value = false;
    checkValidPassword.value = false;
    birthDay.value = '';
    gender.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
    registerEmailError.value = '';
    registerPasswordError.value = '';
    registerConfirmPasswordError.value = '';
  }

  void checkName() {
    if (registerFirstNameTextEditingController.text.trim() != '' && registerLastNameTextEditingController.text.trim() != '') {
      checkValidName.value = true;
    } else {
      checkValidName.value = false;
    }
  }

  void checkEmail() {
    if (registerEmailTextEditingController.text.trim() != '' && registerEmailTextEditingController.text.isValidEmail) {
      checkValidEmail.value = true;
    } else {
      checkValidEmail.value = false;
    }
  }

  void checkPassword() {
    if (registerPasswordTextEditingController.text.length >= kMinPasswordLength &&
        registerPasswordTextEditingController.text == registerConfirmPasswordTextEditingController.text) {
      checkValidPassword.value = true;
    } else {
      checkValidPassword.value = false;
    }
  }

  final RxBool isRegisterLoading = RxBool(false);
  Future<void> userRegister() async {
    try {
      isRegisterLoading.value = true;
      Map<String, dynamic> body = {
        "first_name": registerFirstNameTextEditingController.text,
        "last_name": registerLastNameTextEditingController.text,
        "email": registerEmailTextEditingController.text,
        "dob": birthDay.value,
        "gender": gender.value,
        "password": registerPasswordTextEditingController.text,
        "password_confirmation": registerConfirmPasswordTextEditingController.text,
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuRegistration,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        CommonUnVerifyModel commonUnVerifyModel = CommonUnVerifyModel.fromJson(response.data);
        // log('Login_user_data : ${loginData.token}');
        verificationToken.value = commonUnVerifyModel.token.toString();
        parentRoute.value = "register";
        resetOTPScreen();
        isRegisterLoading.value = false;
        Get.toNamed(krOTP);

        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isRegisterLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isRegisterLoading.value = false;
      ll('userRegister error: $e');
    }
  }

  /*
  |--------------------------------------------------------------------------
  | //! info:: forgot password
  |--------------------------------------------------------------------------
  */

  final TextEditingController forgotPasswordEmailTextEditingController = TextEditingController();
  final RxString forgotPasswordEmailError = RxString('');
  final RxBool canSendOTP = RxBool(false);

  void resetForgotPasswordScreen() {
    forgotPasswordEmailTextEditingController.clear();
    forgotPasswordEmailError.value = '';
    canSendOTP.value = false;
  }

  void checkCanSendOTP() {
    if (forgotPasswordEmailTextEditingController.text.trim().isValidEmail) {
      canSendOTP.value = true;
    } else {
      canSendOTP.value = false;
    }
  }

  final RxBool isForgetPasswordLoading = RxBool(false);
  Future<void> forgetPassword() async {
    try {
      isForgetPasswordLoading.value = true;
      Map<String, dynamic> body = {
        'email': forgotPasswordEmailTextEditingController.text.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuForgetPassword,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        parentRoute.value = "forget-password";
        resetOTPScreen();
        isForgetPasswordLoading.value = false;
        Get.toNamed(krOTP);
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isForgetPasswordLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isForgetPasswordLoading.value = false;
      ll('forgetPassword error: $e');
    }
  }

  /*
  |--------------------------------------------------------------------------
  | //! info:: reset password
  |--------------------------------------------------------------------------
  */
  final TextEditingController resetNewPasswordTextEditingController = TextEditingController();
  final RxBool isResetNewPasswordToggleObscure = RxBool(true);
  final TextEditingController resetConfirmPasswordTextEditingController = TextEditingController();
  final RxBool isResetConfirmPasswordToggleObscure = RxBool(true);
  final RxBool canResetPassword = RxBool(false);

  final RxString resetPasswordError = RxString('');
  final RxString resetConfirmPasswordError = RxString('');

  void resetResetPasswordScreen() {
    resetNewPasswordTextEditingController.clear();
    resetConfirmPasswordTextEditingController.clear();
    isResetNewPasswordToggleObscure.value = true;
    isResetConfirmPasswordToggleObscure.value = true;
    resetPasswordError.value = '';
    resetConfirmPasswordError.value = '';
    canResetPassword.value = false;
  }

  void checkCanResetPassword() {
    if (resetNewPasswordTextEditingController.text.trim().length >= kMinPasswordLength &&
        resetNewPasswordTextEditingController.text.trim() == resetConfirmPasswordTextEditingController.text.trim()) {
      canResetPassword.value = true;
    } else {
      canResetPassword.value = false;
    }
  }

  final RxBool isResetPasswordLoading = RxBool(false);
  Future<void> resetPassword() async {
    try {
      isResetPasswordLoading.value = true;
      Map<String, dynamic> body = {
        "password": resetNewPasswordTextEditingController.text,
        "password_confirmation": resetConfirmPasswordTextEditingController.text,
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        token: verificationToken.value,
        url: kuResetPassword,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        resetLoginScreen();
        isResetPasswordLoading.value = false;
        Get.offAllNamed(krLogin);
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isResetPasswordLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isResetPasswordLoading.value = false;
      ll('resetPassword error: $e');
    }
  }

  /*
  |--------------------------------------------------------------------------
  | //! info:: otp
  |--------------------------------------------------------------------------
  */
  final TextEditingController otpTextEditingController = TextEditingController();
  final RxBool isOTPResendClick = RxBool(false);
  final RxBool canOTPVerifyNow = RxBool(false);
  final RxBool isOTPLoading = RxBool(false);

  void resetOTPScreen() {
    otpTextEditingController.clear();
    isOTPResendClick.value = false;
    canOTPVerifyNow.value = false;
  }

  void checkCanOTPVerifyNow() {
    if (otpTextEditingController.text.length == kOTPLength) {
      canOTPVerifyNow.value = true;
    } else {
      canOTPVerifyNow.value = false;
    }
  }

  Future<void> signUpVerify() async {
    try {
      isOTPLoading.value = true;
      String? token = verificationToken.value;
      // log("token : $token");

      Map<String, dynamic> body = {
        'otp': otpTextEditingController.text.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuRegistrationVerifyOTP,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        LoginModel otpData = LoginModel.fromJson(response.data);
        // log('verified_user_data : ${otpData.user.isVerified}');

        await _spController.saveBearerToken(otpData.token);
        await _spController.saveRememberMe(true);
        await _spController.saveUserName(otpData.user.fullName.toString());
        await _spController.saveUserFirstName(otpData.user.firstName.toString());
        await _spController.saveUserLastName(otpData.user.lastName.toString());
        await _spController.saveUserImage(otpData.user.image.toString());
        await _spController.saveUserEmail(otpData.user.email.toString());
        await _spController.saveUserList({
          "email": otpData.user.email.toString(),
          "name": otpData.user.fullName.toString(),
          "first_name": otpData.user.firstName.toString(),
          "last_name": otpData.user.lastName.toString(),
          "image_url": otpData.user.image,
          "token": otpData.token.toString(),
        });
        await _globalController.getUserInfo();
        // await setDeviceID(otpData.user.id);
        // Get.offAllNamed(krHome);
        // final HomeController homeController = Get.find<HomeController>();
        // await homeController.getUserHome();
        if (parentRoute.value == "login") {
          isOTPLoading.value = false;
          Get.offAllNamed(krHome);
        } else if (parentRoute.value == "register") {
          isOTPLoading.value = false;
          Get.offAllNamed(krSelectProfession);
          resetRegisterScreen();
          resetOTPScreen();
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isOTPLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isOTPLoading.value = false;
      ll('signUpVerify error: $e');
    }
  }

  Future<void> forgetPasswordVerify() async {
    try {
      isOTPLoading.value = true;
      Map<String, dynamic> body = {
        "email": forgotPasswordEmailTextEditingController.text,
        'otp': otpTextEditingController.text.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuForgetPasswordVerifyOTP,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        ForgetPassOtpVerify forgetPassOtpVerify = ForgetPassOtpVerify.fromJson(response.data);
        verificationToken.value = forgetPassOtpVerify.token.toString();
        ll(verificationToken.value);
        resetResetPasswordScreen();
        isOTPLoading.value = false;
        Get.toNamed(krResetPass);
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isOTPLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isOTPLoading.value = false;
      ll('forgetPasswordVerify error: $e');
    }
  }

  Future<void> resendOTP() async {
    try {
      isOTPLoading.value = true;
      Map<String, dynamic> body = {
        if (parentRoute.value == "forget-password") "email": forgotPasswordEmailTextEditingController.text.trim(),
      };
      ll(body.toString());
      ll(parentRoute.value.toString());
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        token: (parentRoute.value == "login" || parentRoute.value == "register") ? verificationToken.value : null,
        url: (parentRoute.value == "login" || parentRoute.value == "register") ? kuRegistrationResendOTP : kuForgetPasswordResendOTP,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        CommonUnVerifyModel commonUnVerifyModel = CommonUnVerifyModel.fromJson(response.data);
        verificationToken.value = commonUnVerifyModel.token.toString();
        resetOTPScreen();
        isOTPResendClick.value = false;
        // log('data : ${response.data}');
        isOTPLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isOTPLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isOTPLoading.value = false;
      ll('resendOTP error: $e');
    }
  }

  /*
  |--------------------------------------------------------------------------
  | //! info:: logout
  |--------------------------------------------------------------------------
  */
  final RxBool isLogoutLoading = RxBool(false);
  Future<void> logout() async {
    try {
      isLogoutLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        "all_devices": 0.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        token: token,
        url: kuLogOut,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        await SpController().onLogout();
        resetLoginScreen();
        isLogoutLoading.value = false;
        Get.find<ProfileController>().isSupportButtonPressed.value = false;
        Get.find<ProfileController>().isSettingButtonPressed.value = false;
        Get.offAllNamed(krLogin);
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isLogoutLoading.value = false;
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isLogoutLoading.value = false;
      ll('logout error: $e');
    }
  }
}
