import 'dart:async';

import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SplashScreenController extends GetxController {
  final SpController spController = SpController();

  @override
  void onInit() async {
    await getRemember();
    startSplashScreen();
    super.onInit();
  }

  bool rememberStatus = false;
  Future<void> getRemember() async {
    bool? state = await spController.getRememberMe();
    if (state == null || state == false) {
      rememberStatus = false;
    } else {
      rememberStatus = true;
    }
  }

  Timer startSplashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () async {
        if (rememberStatus) {
          await Get.find<GlobalController>().getUserInfo();
          Get.find<HomeController>().homeTabIndex.value = 0;
          Get.offAllNamed(krHome);
          await Get.find<HomeController>().getPostList();
          Get.find<CreatePostController>().getCreatePost();
        } else {
          await Get.find<GlobalController>().getUserInfo();
          final AuthenticationController authenticationController = Get.find<AuthenticationController>();
          await authenticationController.getSavedUsers();
          if (authenticationController.users.isNotEmpty) {
            Get.offAllNamed(krSavedUserLogin);
          } else {
            Get.find<AuthenticationController>().resetLoginScreen();
            Get.offAllNamed(krLogin);
          }
        }
      },
    );
  }
}
