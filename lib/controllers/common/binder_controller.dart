import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/home_controller.dart';
import 'package:bip_hip/controllers/post_reaction_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/controllers/profile_controllers/menu_section_controller.dart';
import 'package:bip_hip/controllers/splash_screen_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class BinderController implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
    Get.put<GlobalController>(GlobalController(), permanent: true);
    Get.put<AuthenticationController>(AuthenticationController());
    Get.put<HomeController>(HomeController());
    Get.put<ProfileController>(ProfileController());
    Get.put<CreatePostController>(CreatePostController());
    Get.put<PostReactionController>(PostReactionController());
    Get.put<MenuSectionController>(MenuSectionController());
  }
}
