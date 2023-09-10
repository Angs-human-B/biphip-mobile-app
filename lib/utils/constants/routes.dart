
//* info:: auth screens
import 'package:bip_hip/views/auth/login.dart';
import 'package:bip_hip/views/auth/saved_user_login.dart';
import 'package:bip_hip/views/splash_and_intro/splash_screen.dart';
import 'package:get/get.dart';

const String krLogin = '/login';
const String krSavedUserLogin = '/saved-user-login';
const String krForgotPassword = '/forgot-password';
const String krResetPass = '/reset-pass';
const String krOTP = '/otp-verify';

const String krIntroductionScreen = '/introduction-screen';
const String krSplashScreen = '/splash-screen';
const String krHome = '/home';
const String krNotification = '/notification';
const String krChangePassword = '/change-password';
const String krChangeLanguage = '/change-language';



List<GetPage<dynamic>>? routes = [
  // //* info:: auth screens
  GetPage(name: krLogin, page: () => Login(), transition: Transition.noTransition),
  GetPage(name: krSavedUserLogin, page: () => SavedUserLogin(), transition: Transition.noTransition),
  // GetPage(name: krForgotPassword, page: () => ForgotPasswordScreen(), transition: Transition.noTransition),
  // GetPage(name: krResetPass, page: () => ResetPasswordScreen(), transition: Transition.noTransition),
  // GetPage(name: krOTP, page: () => OTPVerifyScreen(), transition: Transition.noTransition),

  // //* introduction screen
  // GetPage(name: krIntroductionScreen, page: () => IntroductionPage()),

  //* info:: other screens
  GetPage(name: krSplashScreen, page: () => const SplashScreen(), transition: Transition.noTransition),
  
];
