import 'dart:io';

import 'package:bip_hip/models/auth/common_unverify_model.dart';
import 'package:bip_hip/models/auth/login_model.dart';
import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class AuthenticationController extends GetxController {
  final RxBool isProfessionSelected = RxBool(false);
  final RxBool isInterestSelected = RxBool(false);
  final RxInt professionIndex = RxInt(-1);
  final RxList<int> interestIndex = RxList<int>([]);
  final RxString profileLink = RxString('');
  final Rx<File?> profileFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxList users = RxList([]);

  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();

  final RxString parentRoute = RxString("register");
  final RxString verificationToken = RxString('');

  Future<void> getSavedUsers() async {
    List userList = await _spController.getUserList();
    users.addAll(userList);
  }

  void onIntroDone() async {
    Get.offAllNamed(krLogin);
  }

  void resetProfileImage() {
    profileLink.value = '';
    profileFile.value = File('');
    isProfileImageChanged.value = false;
  }

  void resetChipSelection() {
    professionIndex.value = -1;
    interestIndex.clear();
    isProfessionSelected.value = false;
    isInterestSelected.value = false;
  }

  /*
  |--------------------------------------------------------------------------
  | //! info:: set device id
  |--------------------------------------------------------------------------
  */

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

  Future<void> userLogin() async {
    try {
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
        // log('Login_user_data : ${loginData.token}');

        // if (loginData.user.isVerified == 1) {
        //   await _spController.saveBearerToken(loginData.token);
        //   await _spController.saveRememberMe(isLoginRememberCheck.value);
        //   await setDeviceID(loginData.user.id);
        //   Get.offAllNamed(krHome);
        //   final HomeController homeController = Get.find<HomeController>();
        //   _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cSuccessColor, duration: 1000);
        //   await homeController.getUserHome();
        // } else {
        //   _globalController.loginTokenWithoutVerification.value = loginData.token!;
        //   resetOTPScreen();
        //   Get.toNamed(krOTP);
        // }

        await _spController.saveBearerToken(loginData.token);
        await _spController.saveRememberMe(isLoginRememberCheck.value);
        await _spController.saveUserList({
          "email": loginData.user.email.toString(),
          "token": loginData.token.toString(),
        });
        // await setDeviceID(loginData.user.id);
        Get.offAllNamed(krMenu);
        // final HomeController homeController = Get.find<HomeController>();
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        // await homeController.getUserHome();
      } else {
        if (response.code == 410) {
          CommonUnVerifyModel commonUnVerifyModel = CommonUnVerifyModel.fromJson(response.data);
          verificationToken.value = commonUnVerifyModel.token;
          parentRoute.value = "login";
          resetOTPScreen();
          Get.toNamed(krOTP);
        }
        _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
      }
    } catch (e) {
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

  Future<void> userRegister() async {
    try {
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
        verificationToken.value = commonUnVerifyModel.token;
        resetOTPScreen();
        Get.toNamed(krOTP);
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
      }
    } catch (e) {
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

  // Future<void> forgetPassword() async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'email': forgotPasswordEmailTextEditingController.text.toString(),
  //       "forget": "1",
  //     };
  //     var response = await _apiController.commonPostWithBodyAndToken(
  //       token: null,
  //       url: kuForgetPassword,
  //       body: body,
  //       showLoading: true,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       resetOTPScreen();
  //       Get.toNamed(krOTP);
  //       _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cSuccessColor, duration: 1000);
  //     } else {
  //       _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedAccentColor);
  //     }
  //   } catch (e) {
  //     ll('forgetPassword error: $e');
  //   }
  // }

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

  // Future<void> resetPassword() async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "token": temporaryToken.value,
  //       "email": forgotPasswordEmailTextEditingController.text,
  //       "password": resetNewPasswordTextEditingController.text,
  //       "password_confirmation": resetConfirmPasswordTextEditingController.text,
  //     };
  //     var response = await _apiController.commonPostWithBodyAndToken(
  //       token: null,
  //       url: kuResetPassword,
  //       body: body,
  //       showLoading: true,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       resetLoginScreen();
  //       isLoginButtonClicked.value = true;
  //       Get.offAllNamed(krLogin);

  //       _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cSuccessColor, duration: 1000);
  //     } else {
  //       _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedAccentColor);
  //     }
  //   } catch (e) {
  //     ll('resetPassword error: $e');
  //   }
  // }

  /*
  |--------------------------------------------------------------------------
  | //! info:: otp
  |--------------------------------------------------------------------------
  */
  final TextEditingController otpTextEditingController = TextEditingController();
  final RxBool isOTPResendClick = RxBool(false);
  final RxBool canOTPVerifyNow = RxBool(false);

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

  // Future<void> signUpVerify() async {
  //   try {
  //     String? token = _globalController.loginTokenWithoutVerification.value;
  //     // log("token : $token");

  //     Map<String, dynamic> body = {
  //       'otp': otpTextEditingController.text.toString(),
  //     };
  //     var response = await _apiController.commonPostWithBodyAndToken(
  //       url: kuSignUpVerify,
  //       body: body,
  //       showLoading: true,
  //       token: token,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       CommonAuthDataModel otpData = CommonAuthDataModel.fromJson(response.data);
  //       // log('verified_user_data : ${otpData.user.isVerified}');

  //       await _spController.saveBearerToken(otpData.token);
  //       await _spController.saveRememberMe(true);
  //       await setDeviceID(otpData.user.id);
  //       Get.offAllNamed(krHome);
  //       final HomeController homeController = Get.find<HomeController>();
  //       _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cSuccessColor, duration: 1000);
  //       await homeController.getUserHome();
  //       // _globalController.updateAppLang(langCode: map['user']['lang_code']);
  //       // _globalController.userLanguageCode.value = map['user']['lang_code'];
  //       // _spController.saveLanguageCode(map['user']['lang_code'] ?? 'ja');
  //       // if (map['user']['login_type'] != null) await _spController.saveSocialSite(map['user']['login_type']);
  //     } else {
  //       _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedAccentColor);
  //     }
  //   } catch (e) {
  //     ll('signUpVerify error: $e');
  //   }
  // }

  // Future<void> forgetPasswordVerify() async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "email": forgotPasswordEmailTextEditingController.text,
  //       'otp': otpTextEditingController.text.toString(),
  //       "forget": "1",
  //     };
  //     var response = await _apiController.commonPostWithBodyAndToken(
  //       token: null,
  //       url: kuForgetPasswordOTPVerify,
  //       body: body,
  //       showLoading: true,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       ForgotPasswordOTPVerifyDataModel forgotPasswordOTPVerifyDataModel = ForgotPasswordOTPVerifyDataModel.fromJson(response.data);
  //       // log('verified_user_data : ${forgotPasswordOTPVerifyDataModel.user.isVerified}');
  //       temporaryToken.value = forgotPasswordOTPVerifyDataModel.token.toString();
  //       resetResetPasswordScreen();
  //       Get.toNamed(krResetPass);
  //       _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cSuccessColor, duration: 1000);
  //     } else {
  //       _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedAccentColor);
  //     }
  //   } catch (e) {
  //     ll('forgetPasswordVerify error: $e');
  //   }
  // }

  // Future<void> resendOTP() async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "email": forgotPasswordEmailTextEditingController.text,
  //     };
  //     // log(body.toString());
  //     var response = await _apiController.commonPostWithBodyAndToken(
  //       token: null,
  //       url: kuResendOTP,
  //       body: body,
  //       showLoading: true,
  //     ) as CommonDM;

  //     if (response.success == true) {
  //       resetOTPScreen();
  //       isOTPResendClick.value = false;
  //       // log('data : ${response.data}');
  //       _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cSuccessColor, duration: 1000);
  //     } else {
  //       _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedAccentColor);
  //     }
  //   } catch (e) {
  //     ll('resendOTP error: $e');
  //   }
  // }
}
