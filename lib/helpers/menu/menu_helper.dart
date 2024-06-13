import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/auth/social_login_controller.dart';
import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/controllers/menu/quiz_controller.dart';
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/helpers/menu/friend/friend_helper.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class MenuHelper {
  final SpController spController = SpController();

  void menuPressFunction(index) async {
    switch (index) {
      case 0:
        Get.find<GlobalController>().resetTapButtonData();
        FriendHelper().friendSearchFieldReset();
        Get.toNamed(krFriends);
        await Get.find<FriendController>().getFriendList();
        break;
      case 1:
        Get.find<GlobalController>().resetTapButtonData();
        Get.find<GlobalController>().searchController.clear();
        Get.find<FamilyController>().isFamilySuffixIconVisible.value = false;
        Get.toNamed(krFamily);
        await Get.find<FamilyController>().getFamilyList();
        break;
      case 2:
        GalleryPhotoHelper().resetTapButtonData();
        Get.toNamed(krGalleryPhotos);
        await Get.find<GalleryController>().getGalleryAlbumList();
        break;
      case 3:
        Get.toNamed(krGalleryVideos); //*new changes for gallery Videos
        break;
      case 4:
        Get.find<PendentBadgesController>().resetBadgesData();
        Get.toNamed(krBadgesStarPage);
        await Get.find<PendentBadgesController>().getUserBadges();
        await Get.find<PendentBadgesController>().getStarPrice();
        break;
      case 5:
        Get.find<PendentBadgesController>().resetPendentData();
        Get.toNamed(krPendentPage);
        await Get.find<PendentBadgesController>().getUserPendent();
        break;
      case 6:
        break;
      case 7:
        Get.toNamed(krKidsPage);
        await Get.find<KidsController>().getKidsList();
        break;
      case 8:
        Get.toNamed(krStore);
        await Get.find<StoreController>().getStoreList();
        break;
      case 9:
        Get.find<QuizController>().resetQuizTapButtonData();
        Get.find<QuizController>().resetQuizData();
        Get.toNamed(krMyQuiz);
        await Get.find<QuizController>().getQuestionList();
        break;
      case 10:
        Get.find<PendentBadgesController>().todayBirthdayTimelineTextEditingController.clear();
        Get.find<PendentBadgesController>().inTwoDaysBirthdayTimelineTextEditingController.clear();
        Get.find<PendentBadgesController>().upcomingBirthdayTimelineTextEditingController.clear();
        Get.find<PendentBadgesController>().todayBirthdaySendButtonEnabled.clear();
        Get.find<PendentBadgesController>().inTwoDaysBirthdaySendButtonEnabled.clear();
        Get.find<PendentBadgesController>().inTwoDaysBirthdaySendButtonEnabled.clear();
        Get.toNamed(krBirthdayPage);
        await Get.find<PendentBadgesController>().getBirthday();
        break;
      case 11:
        Get.find<AwardController>().resetAwardData();
        Get.toNamed(krAwardsPage);
        await Get.find<AwardController>().getAwardList();
        break;
      case 12:
        // Get.find<QuizController>().resetQuizTapButtonData();
        // Get.find<QuizController>().resetQuizData();
        // await Get.find<QuizController>().getQuestionList();
        Get.toNamed(krDashboardOverview);
        await Get.find<DashboardController>().getDashboardProfileOverview();
        break;
    }
  }

  void menuSearch() async {
    Get.find<AllSearchController>().resetSearchData();
    Get.toNamed(krSearchPage);
  }

  void logout() async {
    var status = await spController.getRememberMe();
    bool? isGmailLoggedInUser = await spController.getIsGmailLogin();
    bool? isFacebookLoggedInUser = await spController.getIsFacebookLogin();
    if (status == true) {
      if (isGmailLoggedInUser != null && isGmailLoggedInUser == true) {
        await Get.find<SocialLogInController>().gmailLogout();
      } else if (isFacebookLoggedInUser != null && isFacebookLoggedInUser == true) {
        await Get.find<SocialLogInController>().facebookLogout();
      }
      await Get.find<AuthenticationController>().getSavedUsers();
      Get.offAllNamed(krSavedUserLogin);
      await spController.onLogout();
      Get.find<AuthenticationController>().resetLoginScreen();
      Get.find<MenuSectionController>().isSupportButtonPressed.value = false;
      Get.find<MenuSectionController>().isSettingButtonPressed.value = false;
    } else {
      await Get.find<AuthenticationController>().logout();
    }
  }
}
