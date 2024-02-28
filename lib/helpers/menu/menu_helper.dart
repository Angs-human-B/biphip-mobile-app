import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/auth/social_login_controller.dart';
import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/helpers/menu/friend/friend_helper.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';

class MenuHelper {
  final SpController spController = SpController();

  void menuPressFunction(index) async {
    switch (index) {
      case 0:
        ll('Friend');
        Get.find<GlobalController>().resetTapButtonData();
        FriendHelper().friendSearchFieldReset();
        Get.toNamed(krFriends);
        await Get.find<FriendController>().getFriendList();
        break;
      case 1:
        ll('Family');
        Get.find<GlobalController>().resetTapButtonData();
        Get.find<GlobalController>().searchController.clear();
        Get.find<FamilyController>().isFamilySuffixIconVisible.value = false;
        Get.toNamed(krFamily);
        await Get.find<FamilyController>().getFamilyList();
        break;
      case 2:
        ll('Image');
        GalleryPhotoHelper().resetTapButtonData();
        Get.toNamed(krGalleryPhotos);
        await Get.find<GalleryController>().getGalleryAlbumList();
        break;
      case 3:
        ll('Videos');
        Get.toNamed(krGalleryVideos); //*new changes for gallery Videos
        break;
      case 4:
        ll('Badges');
        Get.find<PendentBadgesController>().resetBadgesData();
        Get.toNamed(krBadgesStarPage);
        break;
      case 5:
        ll('Pendent');
        Get.find<PendentBadgesController>().resetPendentData();
        Get.toNamed(krPendentPage);
        break;
      case 6:
        ll('Earnings');
        break;
      case 7:
        Get.toNamed(krKidsPage);
        await Get.find<KidsController>().getKidsList();
        ll('Kids');
        break;
      case 8:
        ll('Store');
        Get.toNamed(krStore);
        await Get.find<StoreController>().getStoreList();
        break;
      case 9:
        ll('Quiz');
        Get.find<PostReactionController>().resetQuizTapButtonData();
        Get.toNamed(krMyQuiz);
        break;
      case 10:
        ll('Birthday');
        Get.find<PendentBadgesController>().todayBirthdayTimelineTextEditingController.clear();
        Get.find<PendentBadgesController>().in2DaysBirthdayTimelineTextEditingController.clear();
        Get.find<PendentBadgesController>().upcomingBirthdayTimelineTextEditingController.clear();
        Get.find<PendentBadgesController>().todayBirthdaySendButtonEnabled.clear();
        Get.find<PendentBadgesController>().in2DaysBirthdaySendButtonEnabled.clear();
        Get.toNamed(krBirthdayPage);
        break;
      case 11:
        ll('Awards');
        Get.find<AwardController>().resetAwardData();
        Get.toNamed(krAwardsPage);
        break;
    }
  }

  void menuSearch() async {
    Get.find<GlobalController>().recentSearch.value = await spController.getRecentSearchList();
    Get.find<GlobalController>().searchController.clear();
    Get.to(
      () => Search(
        searchController: Get.find<GlobalController>().searchController,
        recentSearchList: Get.find<GlobalController>().recentSearch,
        onSubmit: () {},
      ),
      transition: Transition.rightToLeft,
    );
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
