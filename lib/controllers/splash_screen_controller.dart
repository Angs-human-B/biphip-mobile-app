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

  bool rememberStatus = false;
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
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () async {
        if (rememberStatus) {
          Get.offAllNamed(krSavedUserLogin);
        } else {
          Get.find<AuthenticationController>().resetLoginScreen();
          Get.offAllNamed(krLogin);
        }
      },
    );
  }
}
