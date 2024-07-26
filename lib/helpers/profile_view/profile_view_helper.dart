import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:intl/intl.dart';

class ProfileViewHelper {
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  void showProfileViewTabSection(index) async {
    if (index == 0) {
      profileViewController.profileSelectedTabIndex.value = 0;
    } else if (index == 1) {
      profileViewController.profileSelectedTabIndex.value = 1;
      // await profileViewController.getAllImage();
      getUserKidOrStoreAllImages(type: profileViewController.profileViewType.value);
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

  String getUserKidOrStoreLastName({required String type}) {
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

  String getUserKidOrStoreGender({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.gender != null) {
      return profileViewController.kidProfileData.value!.gender!;
    }
    // if(profileViewController.profileViewType.value == "store" && profileViewController.kidProfileData.value?.name!=null){
    //   return profileViewController.kidProfileData.value!.name!;
    // }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.gender != null) {
      return profileViewController.userProfileData.value!.gender!;
    }
    return "";
  }

  List<String> getUserKidOrStoreLanguages({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.languages != null) {
      return profileViewController.kidProfileData.value!.languages!;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.languages != null) {
      return profileViewController.userProfileBasicData.value!.languages!;
    }
    return [];
  }

  List getUserKidOrStorePosts({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.profileViewKidPostList.isNotEmpty) {
      return profileViewController.profileViewKidPostList;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.profileViewPostList.isNotEmpty) {
      return profileViewController.profileViewPostList;
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return [];
  }
  List getUserKidOrStoreAlbumList({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.profileViewKidImageAlbumList.isNotEmpty) {
      return profileViewController.profileViewKidImageAlbumList;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.imageAlbumList.isNotEmpty) {
      return profileViewController.imageAlbumList;
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return [];
  }

  getUserKidOrStoreAllImages({required String type}) async {
    if (profileViewController.profileViewType.value == "kid") {
      return await profileViewController.getProfileViewKidAllImage(kidPageId: "4113727326");
    }
    if (profileViewController.profileViewType.value == "profile") {
      return await profileViewController.getAllImage();
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return null;
  }

  getUserKidOrStoreAlbumImage({required String type}) async {
    if (profileViewController.profileViewType.value == "kid") {
      return await profileViewController.getProfileViewKidImageAlbum(kidPageId: "4113727326");
    }
    if (profileViewController.profileViewType.value == "profile") {
      return await profileViewController.getImageAlbum();
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return null;
  }

  int getUserKidOrStoreAlbumListLength({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.profileViewKidImageAlbumList.isNotEmpty) {
      return profileViewController.profileViewKidImageAlbumList.length;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.imageAlbumList.isNotEmpty) {
      return profileViewController.imageAlbumList.length;
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return 0;
  }
  int getUserKidOrStorePostsListLength({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.profileViewKidPostList.isNotEmpty) {
      return profileViewController.profileViewKidPostList.length;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.profileViewPostList.isNotEmpty) {
      return profileViewController.profileViewPostList.length;
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return 0;
  }

  int getUserKidOrStoreAllImageListLength({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidAllImageList.isNotEmpty) {
      return profileViewController.kidAllImageList.length;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.allImageList.isNotEmpty) {
      return profileViewController.allImageList.length;
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return 0;
  }

  String getUserKidOrStoreAllImageListSingleImage({required String type, required int index}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidAllImageList.isNotEmpty) {
      return profileViewController.kidAllImageList[index].fullPath ?? "";
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.allImageList.isNotEmpty) {
      return profileViewController.allImageList[index].fullPath ?? "";
    }
    // if (profileViewController.profileViewType.value == "store" && profileViewController.userProfileData.value?.languages != null) {
    //   return  profileViewController.profileViewPostList;
    // }
    return "";
  }

  String getUserKidOrStoreDateOfBirth({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.dob != null) {
      return DateFormat('MMMM d, yyyy').format(profileViewController.kidProfileData.value!.dob!);
    }
    // if(profileViewController.profileViewType.value == "store" && profileViewController.kidProfileData.value?.name!=null){
    //   return profileViewController.kidProfileData.value!.name!;
    // }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.dob != null) {
      return DateFormat('MMMM d, yyyy').format(profileViewController.userProfileBasicData.value!.dateOfBirth!);
    }
    return ksNA.tr;
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

  getUserKidOrStoreContactInfo({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileContactList.isNotEmpty) {
      return profileViewController.kidProfileContactList;
    }
    //       if(profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.coverPhoto!=null){
    //   return profileViewController.kidProfileData.value!.coverPhoto!;
    // }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userBasicData.isNotEmpty) {
      return profileViewController.userBasicData;
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
