import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/create_post/platform_action.dart';

class MenuSectionController extends GetxController {
  final GalleryController _galleryController = Get.find<GalleryController>();

  List shortcutButtonContent = [
    {'text': 'Friend', 'icon': BipHip.friends},
    {'text': 'Family', 'icon': BipHip.addFamily},
    {'text': 'Images', 'icon': BipHip.imageFile},
    {'text': 'Videos', 'icon': BipHip.playNew},
    {'text': 'Stars', 'icon': BipHip.giftNew},
    {'text': 'Badges', 'icon': BipHip.badgesFill},
    {'text': 'Earnings', 'icon': BipHip.earnings},
    {'text': 'Kids', 'icon': BipHip.kids},
    {'text': 'Shop', 'icon': BipHip.shopFill},
  ];

  void menuPressFunction(index) async {
    if (index == 0) {
      ll('Friend');
      Get.find<ProfileController>().resetTapButtonData();
      Get.find<ProfileController>().searchController.clear();
      Get.find<FriendController>().isFriendSearched.value = false;
      Get.find<FriendController>().isRouteFromBottomNavBar.value = false;
      Get.toNamed(krFriends);
      await Get.find<FriendController>().getFriendList();
    } else if (index == 1) {
      ll('Family');
      Get.find<ProfileController>().resetTapButtonData();
      Get.toNamed(krFamily);
      await Get.find<FamilyController>().getFamilyList();
    } else if (index == 2) {
      ll('Image');
      _galleryController.resetTapButtonData();
      Get.toNamed(krGalleryPhotos);
      await _galleryController.getGalleryAlbumList();
    } else if (index == 3) {
      ll('Videos');
      Get.toNamed(krGalleryVideos); //*new changes for gallery Videos
    } else if (index == 4) {
      ll('Stars');
      Get.to(() => PlatformAndAction());
    } else if (index == 5) {
      ll('Badges');
    } else if (index == 5) {
      ll('Earnings');
    } else if (index == 5) {
      ll('Kids');
    } else if (index == 5) {
      ll('Shop');
    }
  }

  List supportButtonContent = [
    {
      'text': 'Help Center',
      'icon': BipHip.helpFill,
      'onPressed': () {
        ll('help center');
      }
    },
    {
      'text': 'Support Inbox',
      'icon': BipHip.supportInbox,
      'onPressed': () {
        ll('Support inbox');
      }
    },
    {
      'text': 'Report a Problem',
      'icon': BipHip.report,
      'onPressed': () {
        ll('Report a problem');
      }
    },
    {
      'text': 'Terms & Conditions',
      'icon': BipHip.termsCondition,
      'onPressed': () {
        ll('Terms and condition');
      }
    },
  ];

  List settingsButtonContent = [
    {
      'text': 'Setting',
      'icon': BipHip.setting,
      'onPressed': () {
        ll('Setting');
        Get.toNamed(krSettings);
      }
    },
    {
      'text': 'Recent Activity',
      'icon': BipHip.activity,
      'onPressed': () {
        ll('Recent Activity');
      }
    },
    {
      'text': 'Dark Mode',
      'icon': BipHip.darkMode,
      'onPressed': () {
        ll('Dark Mode');
      }
    },
    {
      'text': 'Language',
      'icon': BipHip.language,
      'onPressed': () {
        ll('Language');
      }
    },
  ];

  List friendList = [
    {'name': 'Karnaze Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Joe Biden', 'image': kiFriendImageUrl},
    {'name': 'Stewie Griffin', 'image': kiFriendImageUrl},
    {'name': 'Rick Sanchez', 'image': kiFriendImageUrl},
    {'name': 'Johan Liebert', 'image': kiFriendImageUrl},
    {'name': 'Akshia Rekrahs', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl}
  ];

  List familyList = [
    {'name': 'Peter Griffin', 'image': kiFamilyImageUrl},
    {'name': 'Vladmir Putin', 'image': kiFamilyImageUrl},
    {'name': 'Meg Griffin', 'image': kiFamilyImageUrl},
    {'name': 'Rick Sanchez', 'image': kiFamilyImageUrl},
    {'name': 'Morty Sanchez', 'image': kiFamilyImageUrl},
    {'name': 'Beth Sanchez', 'image': kiFamilyImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl}
  ];
}
