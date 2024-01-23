import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/auth/login_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLogInController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async {
    try {
      await gmailLogout();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      } else {
        _user = googleUser;
      }
      ll(googleUser.email);
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Map<String, dynamic> body = {
        'token': googleAuth.accessToken,
        'provider': 'firebase',
        'email': _user?.email,
        'user_name': _user?.id,
        'name': _user?.displayName,
      };
      await socialLogin(body);
      await spController.saveIsGmailLogin(true);
    } catch (e) {
      ll('Error: $e');
    }
  }

  Future<void> facebookLogIn() async {
    try {
      await FacebookAuth.instance.logOut();
      FacebookAuth.instance.login(permissions: ['public_profile', 'email']).then((value) {
        FacebookAuth.instance.getUserData().then((userData) async {
          Map<String, dynamic> body = {
            'token': value.accessToken!.token,
            'provider': 'facebook',
            'email': userData['email'],
            'user_name': userData['id'],
            'name': userData['name'],
          };
          await socialLogin(body);
          await spController.saveIsFacebookLogin(true);
        });
      });
    } catch (e) {
      ll("error: $e");
    }
  }

  Future<void> socialLogin(body) async {
    try {
      Get.find<AuthenticationController>().isLoginLoading.value = true;
      ll("body : $body");
      var response = await apiController.commonApiCall(
        url: kuSocialLogIn,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.success == true) {
        LoginModel loginData = LoginModel.fromJson(response.data);
        Get.find<ProfileController>().userData.value = loginData.user;
        await spController.saveBearerToken(loginData.token);
        Get.find<AuthenticationController>().isLoginRememberCheck.value = true;
        await spController.saveRememberMe(Get.find<AuthenticationController>().isLoginRememberCheck.value);
        await spController.saveUserName(loginData.user.fullName.toString());
        await spController.saveUserFirstName(loginData.user.firstName.toString());
        await spController.saveUserLastName(loginData.user.lastName.toString());
        await spController.saveUserImage(loginData.user.profilePicture.toString());
        await spController.saveUserEmail(loginData.user.email.toString());
        await spController.saveUserList({
          "email": loginData.user.email.toString(),
          "name": loginData.user.fullName.toString(),
          "first_name": loginData.user.firstName.toString(),
          "last_name": loginData.user.lastName.toString(),
          "image_url": loginData.user.profilePicture,
          "token": loginData.token.toString(),
        });
        await globalController.getUserInfo();
        Get.find<AuthenticationController>().isLoginLoading.value = false;
        Get.offAllNamed(krHome);
        await Get.find<HomeController>().getPostList();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        Get.find<AuthenticationController>().isLoginLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      Get.find<AuthenticationController>().isLoginLoading.value = false;
      ll('socialLogin error: $e');
    }
  }

  Future gmailLogout() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future facebookLogout() async {
    await FacebookAuth.instance.logOut();
  }
}
