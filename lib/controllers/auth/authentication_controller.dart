import 'dart:io';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/auth/common_unverify_model.dart';
import 'package:bip_hip/models/auth/forget_pass_model.dart';
import 'package:bip_hip/models/auth/login_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:confetti/confetti.dart';

class AuthenticationController extends GetxController {
  final RxString profileLink = RxString('');
  final Rx<File> profileFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxBool isImageUploadLoading = RxBool(false);
  final RxList users = RxList([]);

  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxString parentRoute = RxString("register");
  final RxString verificationToken = RxString('');

  Future<void> getSavedUsers() async {
    List userList = await spController.getUserList();
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

  Widget setGap(errorText) {
    if (errorText != null) {
      return isDeviceScreenLarge() ? kH10sizedBox : kH8sizedBox;
    } else {
      return isDeviceScreenLarge() ? kH24sizedBox : kH20sizedBox;
    }
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
  final Rx<String?> loginEmailErrorText = Rx<String?>(null);
  final Rx<String?> loginPasswordErrorText = Rx<String?>(null);

  void resetLoginScreen() {
    loginEmailTextEditingController.clear();
    loginPasswordTextEditingController.clear();
    isLoginPasswordToggleObscure.value = true;
    isLoginRememberCheck.value = false;
    loginEmailErrorText.value = null;
    loginPasswordErrorText.value = null;
    canLogin.value = false;
  }

  final RxBool canLogin = RxBool(false);

  final RxBool isLoginLoading = RxBool(false);
  Future<void> userLogin() async {
    try {
      isLoginLoading.value = true;
      Map<String, dynamic> body = {
        'email': loginEmailTextEditingController.text.toString(),
        "password": loginPasswordTextEditingController.text.toString(),
      };
      ll("body : $body");
      var response = await apiController.commonApiCall(
        url: kuLogin,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.success == true) {
        LoginModel loginData = LoginModel.fromJson(response.data);
        Get.find<ProfileController>().userData.value = loginData.user;
        await spController.saveBearerToken(loginData.token);
        await spController.saveRememberMe(isLoginRememberCheck.value);
        await spController.saveUserName(loginData.user.fullName.toString());
        await spController.saveUserFirstName(loginData.user.firstName.toString());
        await spController.saveUserLastName(loginData.user.lastName.toString());
        await spController.saveUserImage(loginData.user.image.toString());
        await spController.saveUserEmail(loginData.user.email.toString());
        if (isLoginRememberCheck.value) {
          await spController.saveUserList({
            "email": loginData.user.email.toString(),
            "name": loginData.user.fullName.toString(),
            "first_name": loginData.user.firstName.toString(),
            "last_name": loginData.user.lastName.toString(),
            "image_url": loginData.user.image,
            "token": loginData.token.toString(),
          });
        }
        await globalController.getUserInfo();
        // await setDeviceID(loginData.user.id);
        isLoginLoading.value = false;
        Get.offAllNamed(krHome);
        await Get.find<HomeController>().getPostList();
        // final HomeController homeController = Get.find<HomeController>();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        // await homeController.getUserHome();
      } else {
        if (response.code == 410) {
          CommonUnVerifyModel commonUnVerifyModel = CommonUnVerifyModel.fromJson(response.data);
          verificationToken.value = commonUnVerifyModel.token.toString();
          parentRoute.value = "login";
          resetOTPScreen();
          isLoginLoading.value = false;
          Get.toNamed(krOTP);
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          ErrorModel errorModel = ErrorModel.fromJson(response.data);
          isLoginLoading.value = false;
          if (errorModel.errors.isEmpty) {
            globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
          } else {
            globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
  final Rx<String?> firstNameError = Rx<String?>(null);
  final Rx<String?> lastNameError = Rx<String?>(null);
  final Rx<String?> registerEmailError = Rx<String?>(null);
  final Rx<String?> registerPasswordError = Rx<String?>(null);
  final Rx<String?> registerConfirmPasswordError = Rx<String?>(null);
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
    firstNameError.value = null;
    lastNameError.value = null;
    registerEmailError.value = null;
    registerPasswordError.value = null;
    registerConfirmPasswordError.value = null;
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
      var response = await apiController.commonApiCall(
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

        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isRegisterLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
  final Rx<String?> forgotPasswordEmailError = Rx<String?>(null);
  final RxBool canSendOTP = RxBool(false);

  void resetForgotPasswordScreen() {
    forgotPasswordEmailTextEditingController.clear();
    forgotPasswordEmailError.value = null;
    canSendOTP.value = false;
  }

  final RxBool isForgetPasswordLoading = RxBool(false);
  Future<void> forgetPassword() async {
    try {
      isForgetPasswordLoading.value = true;
      Map<String, dynamic> body = {
        'email': forgotPasswordEmailTextEditingController.text.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuForgetPassword,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        parentRoute.value = "forget-password";
        resetOTPScreen();
        isForgetPasswordLoading.value = false;
        Get.toNamed(krOTP);
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isForgetPasswordLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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

  final Rx<String?> resetPasswordError = Rx<String?>(null);
  final Rx<String?> resetConfirmPasswordError = Rx<String?>(null);

  void resetResetPasswordScreen() {
    resetNewPasswordTextEditingController.clear();
    resetConfirmPasswordTextEditingController.clear();
    isResetNewPasswordToggleObscure.value = true;
    isResetConfirmPasswordToggleObscure.value = true;
    resetPasswordError.value = null;
    resetConfirmPasswordError.value = null;
    canResetPassword.value = false;
  }

  final RxBool isResetPasswordLoading = RxBool(false);
  Future<void> resetPassword() async {
    try {
      isResetPasswordLoading.value = true;
      Map<String, dynamic> body = {
        "password": resetNewPasswordTextEditingController.text,
        "password_confirmation": resetConfirmPasswordTextEditingController.text,
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        token: verificationToken.value,
        url: kuResetPassword,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        resetLoginScreen();
        isResetPasswordLoading.value = false;
        Get.offAllNamed(krLogin);
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isResetPasswordLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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

  Future<void> signUpVerify() async {
    try {
      isOTPLoading.value = true;
      String? token = verificationToken.value;
      // log("token : $token");

      Map<String, dynamic> body = {
        'otp': otpTextEditingController.text.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuRegistrationVerifyOTP,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        LoginModel otpData = LoginModel.fromJson(response.data);
        // log('verified_user_data : ${otpData.user.isVerified}');

        await spController.saveBearerToken(otpData.token);
        await spController.saveRememberMe(true);
        await spController.saveUserName(otpData.user.fullName.toString());
        await spController.saveUserFirstName(otpData.user.firstName.toString());
        await spController.saveUserLastName(otpData.user.lastName.toString());
        await spController.saveUserImage(otpData.user.image.toString());
        await spController.saveUserEmail(otpData.user.email.toString());
        await spController.saveUserList({
          "email": otpData.user.email.toString(),
          "name": otpData.user.fullName.toString(),
          "first_name": otpData.user.firstName.toString(),
          "last_name": otpData.user.lastName.toString(),
          "image_url": otpData.user.image,
          "token": otpData.token.toString(),
        });
        await globalController.getUserInfo();
        // await setDeviceID(otpData.user.id);
        // final HomeController homeController = Get.find<HomeController>();
        // await homeController.getUserHome();
        if (parentRoute.value == "login") {
          isOTPLoading.value = false;
          Get.offAllNamed(krHome);
          await Get.find<HomeController>().getPostList();
        } else if (parentRoute.value == "register") {
          isOTPLoading.value = false;
          Get.offAllNamed(krSelectProfession);
          resetRegisterScreen();
          resetOTPScreen();
        }
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isOTPLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isOTPLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isOTPLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        "all_devices": 0.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        token: token,
        url: kuLogOut,
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        await SpController().onLogout();
        resetLoginScreen();
        isLogoutLoading.value = false;
        Get.find<MenuSectionController>().isSupportButtonPressed.value = false;
        Get.find<MenuSectionController>().isSettingButtonPressed.value = false;
        Get.offAllNamed(krLogin);
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isLogoutLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isLogoutLoading.value = false;
      ll('logout error: $e');
    }
  }

  //*newly added confetti controller
  final ConfettiController confettiController1 = ConfettiController();
  final ConfettiController confettiController2 = ConfettiController();
  final ConfettiController confettiController3 = ConfettiController();
  final RxBool isConfettiPlaying = RxBool(true);
  final RxDouble currentStar = RxDouble(1);
  animateStars() async {
    for (int i = 1; i <= currentStar.value; i++) {
      await Future.delayed(const Duration(seconds: 1));
      currentStar.value++;
    }
  }
}
