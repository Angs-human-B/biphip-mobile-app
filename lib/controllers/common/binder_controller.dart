import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/auth/social_login_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/controllers/intro/splash_screen_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class BinderController implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
    Get.put<GlobalController>(GlobalController(), permanent: true);
    Get.put<AuthenticationController>(AuthenticationController());
    Get.put<SocialLogInController>(SocialLogInController());
    Get.put<HomeController>(HomeController());
    Get.put<ProfileController>(ProfileController());
    Get.put<FriendController>(FriendController());
    Get.put<FamilyController>(FamilyController());
    Get.put<CreatePostController>(CreatePostController());
    Get.put<PostReactionController>(PostReactionController());
    Get.put<GalleryController>(GalleryController());
    Get.put<KidsController>(KidsController());
    Get.put<StoreController>(StoreController());
    Get.put<MenuSectionController>(MenuSectionController());
  }
}
