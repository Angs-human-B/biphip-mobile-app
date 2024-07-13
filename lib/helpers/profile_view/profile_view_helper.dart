import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';

class ProfileViewHelper {
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  void showProfileViewTabSection(index) async {
    if (index == 0) {
      profileViewController.profileSelectedTabIndex.value = 0;
    } else if (index == 1) {
      profileViewController.profileSelectedTabIndex.value = 1;
      await profileViewController.getAllImage();
    } else if (index == 2) {
      profileViewController.profileSelectedTabIndex.value = 2;
    } else if (index == 3) {
      profileViewController.profileSelectedTabIndex.value = 3;
      await profileViewController.getProfileViewAwardList();
    }
  }
}
