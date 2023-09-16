import 'package:bip_hip/utils/constants/imports.dart';

class ProfileController extends GetxController{
  RxBool isSupportButtonPressed = RxBool(false);
  RxBool isSettingButtonPressed = RxBool(false);

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