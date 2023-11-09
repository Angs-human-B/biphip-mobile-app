import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';

class MenuHelper {
  final SpController spController = SpController();

  void menuPressFunction(index) async {
    if (index == 0) {
      ll('Friend');
      Get.find<GlobalController>().resetTapButtonData();
      Get.find<GlobalController>().searchController.clear();
      Get.find<FriendController>().isFriendSearched.value = false;
      Get.find<FriendController>().isRouteFromBottomNavBar.value = false;
      Get.toNamed(krFriends);
      await Get.find<FriendController>().getFriendList();
    } else if (index == 1) {
      ll('Family');
      Get.find<GlobalController>().resetTapButtonData();
      Get.toNamed(krFamily);
      await Get.find<FamilyController>().getFamilyList();
    } else if (index == 2) {
      ll('Image');
      Get.find<GalleryController>().resetTapButtonData();
      Get.toNamed(krGalleryPhotos);
      await Get.find<GalleryController>().getGalleryAlbumList();
    } else if (index == 3) {
      ll('Videos');
      Get.toNamed(krGalleryVideos); //*new changes for gallery Videos
    } else if (index == 4) {
      ll('Stars');
      // Get.to(() => PlatformAndAction());
    } else if (index == 5) {
      ll('Badges');
    } else if (index == 6) {
      ll('Earnings');
    } else if (index == 7) {
      Get.toNamed(krKidsPage);
      await Get.find<KidsController>().getKidsList();
      ll('Kids');
    } else if (index == 8) {
      ll('Shop');
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
    if (status == true) {
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
