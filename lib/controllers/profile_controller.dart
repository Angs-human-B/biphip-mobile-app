import 'package:bip_hip/utils/constants/imports.dart';

class ProfileController extends GetxController{
  RxBool isSupportButtonPressed = RxBool(false);
  RxBool isSettingButtonPressed = RxBool(false);

  List shortcutButtonContent = [
    {
      'text':'Friend',
      'icon': BipHip.friends,
      'onPressed':(){ll('Friend');}
    },
    {
      'text':'Family',
      'icon': BipHip.removeFamily,
      'onPressed':(){ll('Family');}
    },
    {
      'text':'Images',
      'icon': BipHip.imageFile,
      'onPressed':(){ll('Image');}
    },
    {
      'text':'Videos',
      'icon': BipHip.playNew,
      'onPressed':(){ll('Videos');}
    },
    {
      'text':'Stars',
      'icon': BipHip.giftNew,
      'onPressed':(){ll('Stars');}
    },
    {
      'text':'Badges',
      'icon': BipHip.friends,
      'onPressed':(){ll('Badges');}
    },
    {
      'text':'Earnings',
      'icon': BipHip.selling,
      'onPressed':(){ll('Earnings');}
    },
    {
      'text':'Kids',
      'icon': BipHip.kids,
      'onPressed':(){ll('Kids');}
    },
    {
      'text':'Shop',
      'icon': BipHip.world,
      'onPressed':(){ll('Shop');}
    },
  ];

  List supportButtonContent = [
    {
      'text':'Help Center',
      'onPressed':(){ll('help center');}
    },
    {
      'text':'Support Inbox',
      'onPressed':(){ll('Support inbox');}
    },
    {
      'text':'Report a Problem',
      'onPressed':(){ll('Report a problem');}
    },
    {
      'text':'Terms & Conditions',
      'onPressed':(){ll('Terms and condition');}
    },
  ];

  List settingsButtonContent = [
    {
      'text':'Setting',
      'onPressed':(){ll('Setting');}
    },
    {
      'text':'Recent Activity',
      'onPressed':(){ll('Recent Activity');}
    },
    {
      'text':'Dark Mode',
      'onPressed':(){ll('Dark Mode');}
    },
    {
      'text':'Language',
      'onPressed':(){ll('Language');}
    },
  ];
}