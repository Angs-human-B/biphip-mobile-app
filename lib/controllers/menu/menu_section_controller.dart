import 'package:bip_hip/utils/constants/imports.dart';

class MenuSectionController extends GetxController {


  final RxBool isSupportButtonPressed = RxBool(false);
  final RxBool isSettingButtonPressed = RxBool(false);
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
