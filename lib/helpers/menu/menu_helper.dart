import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/auth/social_login_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
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
        Get.find<GlobalController>().searchController.clear();
        Get.find<FriendController>().isFriendSearched.value = false;
        Get.find<FriendController>().isRouteFromBottomNavBar.value = false;
        Get.toNamed(krFriends);
        await Get.find<FriendController>().getFriendList();
        break;
      case 1:
        ll('Family');
        Get.find<GlobalController>().resetTapButtonData();
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
        ll('Stars');
        // Get.to(() => PlatformAndAction());
        break;
      case 5:
        ll('Badges');
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
        ll('Shop');
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
