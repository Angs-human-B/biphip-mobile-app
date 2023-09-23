import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

List shortcutButtonContent = [
  {
    'text': 'Friend',
    'icon': BipHip.friends,
    'onPressed': () {
      ll('Friend');
      Get.find<ProfileController>().resetTapButtonData();
      Get.toNamed(krFriends);
    }
  },
  {
    'text': 'Family',
    'icon': BipHip.removeFamily,
    'onPressed': () {
      ll('Family');
      Get.find<ProfileController>().resetTapButtonData();
      Get.toNamed(krFamily);
    }
  },
  {
    'text': 'Images',
    'icon': BipHip.imageFile,
    'onPressed': () {
      ll('Image');
      Get.toNamed(krPhotos);
    }
  },
  {
    'text': 'Videos',
    'icon': BipHip.playNew,
    'onPressed': () {
      ll('Videos');
      Get.toNamed(krVideos);
    }
  },
  {
    'text': 'Stars',
    'icon': BipHip.giftNew,
    'onPressed': () {
      ll('Stars');
    }
  },
  {
    'text': 'Badges',
    'icon': BipHip.friends,
    'onPressed': () {
      ll('Badges');
    }
  },
  {
    'text': 'Earnings',
    'icon': BipHip.earnings,
    'onPressed': () {
      ll('Earnings');
    }
  },
  {
    'text': 'Kids',
    'icon': BipHip.kids,
    'onPressed': () {
      ll('Kids');
    }
  },
  {
    'text': 'Shop',
    'icon': BipHip.shopFill,
    'onPressed': () {
      ll('Shop');
    }
  },
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

List profileInfoContent = [
  {
    'icon': BipHip.address,
    'text': 'Lives in Mirpur, Dhaka, Bangladesh.',
    'isLink': false,
    'onPressed': () {
      ll('Home');
    }
  },
  {
    'icon': BipHip.location,
    'text': 'From Homna, Comilla, Bangladesh.',
    'isLink': false,
    'onPressed': () {
      ll('Location');
    }
  },
  {
    'icon': BipHip.love,
    'text': 'Single',
    'isLink': false,
    'onPressed': () {
      ll('Relationship Status');
    }
  },
  {
    'icon': BipHip.school,
    'text': 'B.N School, Dhaka, Bangladesh.',
    'isLink': false,
    'onPressed': () {
      ll('School');
    }
  },
  {
    'icon': BipHip.work,
    'text': 'Genie InfoTech',
    'isLink': false,
    'onPressed': () {
      ll('Job');
    }
  },
  {
    'icon': BipHip.mail,
    'text': 'manjurulomi@gmail.com',
    'isLink': true,
    'onPressed': () {
      ll('mail');
    }
  },
  {
    'icon': BipHip.phoneFill,
    'text': '01521497698',
    'isLink': true,
    'onPressed': () {
      ll('phone');
    }
  },
  {
    'icon': BipHip.facebook,
    'text': 'www.facebook.com/sharker.omi',
    'isLink': true,
    'onPressed': () {
      ll('facebook');
    }
  },
  {
    'icon': BipHip.linkedin,
    'text': 'www.linkedin.com/sharker.omi',
    'isLink': true,
    'onPressed': () {
      ll('linkedin');
    }
  },
];

List editProfileInfoContent = [
  {
    'icon': BipHip.address,
    'text': 'Lives in Mirpur, Dhaka, Bangladesh.',
    'isLink': false,
  },
  {
    'icon': BipHip.location,
    'text': 'From Homna, Comilla, Bangladesh.',
    'isLink': false,
  },
  {
    'icon': BipHip.love,
    'text': 'Single',
    'isLink': false,
  },
  {
    'icon': BipHip.school,
    'text': 'B.N School, Dhaka, Bangladesh.',
    'isLink': false,
  },
  {
    'icon': BipHip.work,
    'text': 'Genie InfoTech',
    'isLink': false,
  }
];

List friendList = [
  {'name': 'Karnaze Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Joe Biden', 'image': 'assets/images/friend.png'},
  {'name': 'Stewie Griffin', 'image': 'assets/images/friend.png'},
  {'name': 'Rick Sanchez', 'image': 'assets/images/friend.png'},
  {'name': 'Johan Liebert', 'image': 'assets/images/friend.png'},
  {'name': 'Akshia Rekrahs', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'}
];

List familyList = [
  {'name': 'Peter Griffin', 'image': 'assets/images/family.png'},
  {'name': 'Vladmir Putin', 'image': 'assets/images/family.png'},
  {'name': 'Meg Griffin', 'image': 'assets/images/family.png'},
  {'name': 'Rick Sanchez', 'image': 'assets/images/family.png'},
  {'name': 'Morty Sanchez', 'image': 'assets/images/family.png'},
  {'name': 'Beth Sanchez', 'image': 'assets/images/family.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'},
  {'name': 'Alyssa Krnunkenstein', 'image': 'assets/images/friend.png'}
];

List interestProfile = [
  'All',
  'Poetry',
  'Photography',
  'Singing',
  'Writing',
  'Painting',
  'Kid',
  'Story telling',
];

List friendsList = [
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
];
List addFriendList = [
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
  {
    "name": "Maria Jones",
    "image": "assets/images/profilePic4x.png",
  },
];

List photos = [
  'assets/images/pic4.jpeg',
  'assets/images/pic5.jpeg',
  'assets/images/coverPic.png',
  'assets/images/pic12.jpeg',
  'assets/images/pic4.jpeg',
  'assets/images/pic5.jpeg',
  'assets/images/coverPic.png',
  'assets/images/pic12.jpeg',
  'assets/images/pic4.jpeg',
  'assets/images/pic5.jpeg',
  'assets/images/coverPic.png',
  'assets/images/pic12.jpeg',
];

List stories = [
  {'name': 'Rick Sanchez', 'profileImage': 'assets/images/pic4.jpeg', 'storyImage': 'assets/images/pic12.jpeg', 'isSeen': false},
  {'name': 'Stewie Griffin', 'profileImage': 'assets/images/pic4.jpeg', 'storyImage': 'assets/images/pic12.jpeg', 'isSeen': true},
  {'name': 'Johan Liebert', 'profileImage': 'assets/images/pic4.jpeg', 'storyImage': 'assets/images/pic12.jpeg', 'isSeen': false},
  {'name': 'Karnaze Ravencroft', 'profileImage': 'assets/images/pic4.jpeg', 'storyImage': 'assets/images/pic12.jpeg', 'isSeen': true},
  {'name': 'Zekken McLaren', 'profileImage': 'assets/images/pic4.jpeg', 'storyImage': 'assets/images/pic12.jpeg', 'isSeen': false},
  {'name': 'Loreta Stevenson', 'profileImage': 'assets/images/pic4.jpeg', 'storyImage': 'assets/images/pic12.jpeg', 'isSeen': false},
];
