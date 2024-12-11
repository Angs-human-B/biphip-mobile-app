import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/auth/social_login_controller.dart';
import 'package:bip_hip/controllers/common/socket_controller.dart';
import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/controllers/menu/quiz_controller.dart';
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:bip_hip/controllers/notification/notification_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/controllers/intro/splash_screen_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/controllers/settings/privacy_settings_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class BinderController implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
    Get.put<GlobalController>(GlobalController(), permanent: true);
    Get.put<AuthenticationController>(AuthenticationController());
    Get.put<SocialLogInController>(SocialLogInController());
    Get.put<HomeController>(HomeController());
    Get.put<MarketPlaceController>(MarketPlaceController());
    Get.put<NotificationController>(NotificationController());
    Get.put<SelfieController>(SelfieController());
    Get.put<AllSearchController>(AllSearchController());
    Get.put<ProfileController>(ProfileController());
    Get.put<FriendController>(FriendController());
    Get.put<FamilyController>(FamilyController());
    Get.put<CreatePostController>(CreatePostController());
    Get.put<PostReactionController>(PostReactionController());
    Get.put<GalleryController>(GalleryController());
    Get.put<KidsController>(KidsController());
    Get.put<StoreController>(StoreController());
    Get.put<PendentBadgesController>(PendentBadgesController());
    Get.put<AwardController>(AwardController());
    Get.put<QuizController>(QuizController());
    Get.put<MenuSectionController>(MenuSectionController());
    Get.put<SocketController>(SocketController());
    Get.put<MessengerController>(MessengerController());
    Get.put<DashboardController>(DashboardController());
    Get.put<ProfileViewController>(ProfileViewController());
    Get.put<PrivacySettingsController>(PrivacySettingsController());
  }
}
