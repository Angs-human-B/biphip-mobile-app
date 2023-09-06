import 'dart:async';

import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SplashScreenController extends GetxController {
  final SpController _spController = SpController();

  @override
  void onInit() async {
    await getRemember();
    startSplashScreen();
    super.onInit();
  }

  bool rememberStatus = true;
  Future<void> getRemember() async {
    bool? state = await _spController.getRememberMe();
    if (state == null || state == false) {
      rememberStatus = false;
    } else {
      rememberStatus = true;
    }
  }

  Timer startSplashScreen() {
    final GlobalController globalController = Get.find<GlobalController>();
    globalController.parentRoute.value = "splash-screen";
    var duration = const Duration(seconds: 2);
    return Timer(
      duration,
      () async {
        if (rememberStatus) {
          Get.find<AuthenticationController>().resetLoginScreen();
          Get.offAllNamed(krLogin);
        } else {
          Get.find<AuthenticationController>().resetLoginScreen();
          Get.offAllNamed(krLogin);
        }
      },
    );
  }
}
