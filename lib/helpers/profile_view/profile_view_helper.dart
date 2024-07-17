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
      await profileViewController.getVideos();
    } else if (index == 3) {
      profileViewController.profileSelectedTabIndex.value = 3;
      await profileViewController.getProfileViewAwardList();
    }
  }

  String getUserKidOrStoreName({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.name != null) {
      return profileViewController.kidProfileData.value!.name!;
    }
    // if(profileViewController.profileViewType.value == "store" && profileViewController.kidProfileData.value?.name!=null){
    //   return profileViewController.kidProfileData.value!.name!;
    // }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.fullName != null) {
      return profileViewController.userProfileData.value!.fullName!;
    }
    return ksNA.tr;
  }

  String getKidOrStoreFollowers({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.countFollowers != null) {
      return "${profileViewController.kidProfileData.value?.countFollowers} Followers";
    }
    // if(profileViewController.profileViewType.value == "store" && profileViewController.s.value?.name!=null){
    //   return profileViewController.kidProfileData.value!.name!;
    // }
    return "0 Followers";
  }

  String getUserKidOrStoreLastName({required String type}){
     if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.name != null) {
      return profileViewController.kidProfileData.value!.name!;
    }
        // if(profileViewController.profileViewType.value == "store" && profileViewController.kidProfileData.value?.name!=null){
    //   return profileViewController.kidProfileData.value!.name!;
    // }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.lastName != null) {
      return profileViewController.userProfileData.value!.lastName!;
    }
  return "";
  }

  String getUserKidStoreCoverPhoto({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.coverPhoto != null) {
      return profileViewController.kidProfileData.value!.coverPhoto!;
    }
    //       if(profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.coverPhoto!=null){
    //   return profileViewController.kidProfileData.value!.coverPhoto!;
    // }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.coverPhoto != null) {
      return profileViewController.userProfileData.value!.coverPhoto!;
    }
    return "";
  }

  String getUserKidStoreProfilePicture({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.profilePicture != null) {
      return profileViewController.kidProfileData.value!.profilePicture!;
    }
    //       if(profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.coverPhoto!=null){
    //   return profileViewController.kidProfileData.value!.coverPhoto!;
    // }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.profilePicture != null) {
      return profileViewController.userProfileData.value!.profilePicture!;
    }
    return "";
  }
}
