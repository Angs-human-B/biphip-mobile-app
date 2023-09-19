//* info:: auth screens
import 'package:bip_hip/views/auth/forget_password/forgot_password_screen.dart';
import 'package:bip_hip/views/auth/forget_password/otp_forget_password.dart';
import 'package:bip_hip/views/auth/forget_password/reset_password_screen.dart';
import 'package:bip_hip/views/auth/login.dart';
import 'package:bip_hip/views/auth/register/otp_verification.dart';
import 'package:bip_hip/views/auth/register/picture_upload_screen.dart';
import 'package:bip_hip/views/auth/register/register.dart';
import 'package:bip_hip/views/auth/register/select_interest.dart';
import 'package:bip_hip/views/auth/register/select_profession.dart';
import 'package:bip_hip/views/auth/register/set_password.dart';
import 'package:bip_hip/views/auth/saved_user_login.dart';
import 'package:bip_hip/views/auth/register/select_birthday.dart';
import 'package:bip_hip/views/auth/register/select_gender.dart';
import 'package:bip_hip/views/auth/register/set_email.dart';
import 'package:bip_hip/views/create_post/create_post.dart';
import 'package:bip_hip/views/profile/edit_bio.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/menu/family.dart';
import 'package:bip_hip/views/profile/menu/friends.dart';
import 'package:bip_hip/views/profile/menu/menu.dart';
import 'package:bip_hip/views/profile/profile.dart';
import 'package:bip_hip/views/splash_and_intro/splash_screen.dart';
import 'package:get/get.dart';

const String krLogin = '/login';
const String krSavedUserLogin = '/saved-user-login';
const String krForgotPassword = '/forgot-password';
const String krResetPass = '/reset-pass';
const String krSetNewPass = '/set-new-pass';
const String krForgetPasswordOTP = '/forgot-password-otp';
const String krOTP = '/otp-verify';

const String krIntroductionScreen = '/introduction-screen';
const String krSplashScreen = '/splash-screen';
const String krHome = '/home';
const String krNotification = '/notification';
const String krChangePassword = '/change-password';
const String krChangeLanguage = '/change-language';

const String krRegister = '/register';
const String krSelectBirthday = '/birthday';
const String krSelectGender = '/gender';
const String krSetEmail = '/set-email';
const String krSelectProfession = '/select-profession';
const String krSelectInterest = '/select-interest';
const String krUploadPicture = '/upload-picture';

const String krMenu = '/menu';
const String krProfile = '/profile';
const String krFriends = '/friends';
const String krFamily = '/family';
const String krEditProfile = '/edit-profile';
const String krEditBio = '/edit-bio';

const String krCreatePost = '/create-post';

List<GetPage<dynamic>>? routes = [
  // //* info:: auth screens
  GetPage(name: krLogin, page: () => Login(), transition: Transition.noTransition),
  GetPage(name: krSavedUserLogin, page: () => SavedUserLogin(), transition: Transition.noTransition),
  GetPage(name: krRegister, page: () => Register(), transition: Transition.noTransition),
  GetPage(name: krSelectBirthday, page: () => SelectBirthday(), transition: Transition.noTransition),
  GetPage(name: krSelectGender, page: () => SelectGender(), transition: Transition.noTransition),
  GetPage(name: krSetEmail, page: () => SetEmail(), transition: Transition.noTransition),
  GetPage(name: krSetNewPass, page: () => SetPassword(), transition: Transition.noTransition),
  GetPage(name: krSelectProfession, page: () => SelectProfessionScreen(), transition: Transition.noTransition),
  GetPage(name: krSelectInterest, page: () => SelectInterestScreen(), transition: Transition.noTransition),
  GetPage(name: krUploadPicture, page: () => PictureUploadScreen(), transition: Transition.noTransition),
  GetPage(name: krForgotPassword, page: () => ForgotPasswordScreen(), transition: Transition.noTransition),
  GetPage(name: krForgetPasswordOTP, page: () => ForgetPasswordOTP(), transition: Transition.noTransition),
  GetPage(name: krResetPass, page: () => ResetPasswordScreen(), transition: Transition.noTransition),
  GetPage(name: krOTP, page: () => OTPVerifyScreen(), transition: Transition.noTransition),

  // //* introduction screen
  // GetPage(name: krIntroductionScreen, page: () => IntroductionPage()),

  //* menu screen
  GetPage(name: krMenu, page: () => Menu(), transition: Transition.noTransition),
  GetPage(name: krProfile, page: () => Profile(), transition: Transition.noTransition),
  GetPage(name: krFriends, page: () => Friends(), transition: Transition.noTransition),
  GetPage(name: krFamily, page: () => Family(), transition: Transition.noTransition),
  GetPage(name: krEditProfile, page: () => EditProfile(), transition: Transition.noTransition),
  GetPage(name: krEditBio, page: () => EditBio(), transition: Transition.noTransition),

  //* info:: other screens
  GetPage(name: krSplashScreen, page: () => const SplashScreen(), transition: Transition.noTransition),

  //* create post
  GetPage(name: krCreatePost, page: () => CreatePost(), transition: Transition.downToUp),
];
