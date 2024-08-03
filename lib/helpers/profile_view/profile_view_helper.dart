import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';
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
      getUserKidOrStoreAllImages(type: profileViewController.profileViewType.value);
    } else if (index == 2) {
      profileViewController.profileSelectedTabIndex.value = 2;
      getUserKidOrStoreVideos(type: profileViewController.profileViewType.value);
    } else if (index == 3) {
      profileViewController.profileSelectedTabIndex.value = 3;
      if (profileViewController.profileViewType.value != "store") {
        getUserKidAwardList(type: profileViewController.profileViewType.value);
      }
      if (profileViewController.profileViewType.value == "store") {
        profileViewController.getProfileViewStoreReview(storePageId: profileViewController.kidOrStorePageId.value);
      }
    }
  }

  String getUserKidOrStoreName({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value?.name != null) {
      return profileViewController.kidProfileData.value!.name!;
    }
    if (type == "profile" && profileViewController.userProfileData.value?.fullName != null) {
      return profileViewController.userProfileData.value!.fullName!;
    }
    if (type == "store" && profileViewController.storeProfileData.value?.name != null) {
      return profileViewController.storeProfileData.value!.name!;
    }
    return ksNA.tr;
  }

  String getKidOrStoreFollowers({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value?.countFollowers != null) {
      return "${profileViewController.kidProfileData.value?.countFollowers} Followers";
    }
    if (type == "store" && profileViewController.storeProfileData.value?.countFollowers != null) {
      return "${profileViewController.storeProfileData.value?.countFollowers!} Followers";
    }
    return "0 Followers";
  }

  String getUserKidOrStoreLastName({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value?.name != null) {
      return profileViewController.kidProfileData.value!.name!;
    }
    if (type == "store" && profileViewController.storeProfileData.value?.name != null) {
      return profileViewController.storeProfileData.value!.name!;
    }
    if (type == "profile" && profileViewController.userProfileData.value?.lastName != null) {
      return profileViewController.userProfileData.value!.lastName!;
    }
    return "";
  }

  String getUserKidGender({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value?.gender != null) {
      return profileViewController.kidProfileData.value!.gender!;
    }
    if (type == "profile" && profileViewController.userProfileData.value?.gender != null) {
      return profileViewController.userProfileData.value!.gender!;
    }
    return "";
  }

  List<String> getUserKidOrStoreLanguages({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value?.languages != null) {
      return profileViewController.kidProfileData.value!.languages!;
    }
    if (type == "profile" && profileViewController.userProfileData.value?.languages != null) {
      return profileViewController.userProfileBasicData.value!.languages!;
    }
    return [];
  }

  List getUserKidOrStorePosts({required String type}) {
    if (type == "kid") {
      return profileViewController.profileViewKidPostList;
    }
    if (type == "profile") {
      return profileViewController.profileViewPostList;
    }
    if (type == "store") {
      return profileViewController.profileViewStorePostList;
    }
    return [];
  }

  RxList getUserKidOrStoreVideosList({required String type}) {
    if (type == "kid") {
      return profileViewController.profileViewKidVideoList;
    }
    if (type == "profile") {
      return profileViewController.videoList;
    }
    if (type == "store") {
      return profileViewController.profileViewStoreVideoList;
    }
    return RxList([]);
  }

  List getUserKidOrStoreAlbumList({required String type}) {
    if (type == "kid") {
      return profileViewController.profileViewKidImageAlbumList;
    }
    if (type == "profile") {
      return profileViewController.imageAlbumList;
    }
    if (type == "store") {
      return profileViewController.profileViewStoreImageAlbumList;
    }
    return [];
  }

  getUserKidOrStoreAllImages({required String type}) async {
    if (type == "kid") {
      return await profileViewController.getProfileViewKidAllImage(kidPageId: "4113727326");
    }
    if (type == "profile") {
      return await profileViewController.getAllImage();
    }
    if (type == "store") {
      return await profileViewController.getProfileViewStoreAllImage(storePageId: profileViewController.kidOrStorePageId.value.toString());
    }
    return null;
  }

  getUserKidOrStoreVideos({required String type}) async {
    if (type == "kid") {
      return await profileViewController.getProfileViewKidVideos(kidPageId: profileViewController.kidOrStorePageId.value);
    }
    if (type == "profile") {
      return await profileViewController.getVideos();
    }
    if (type == "store") {
      return await profileViewController.getProfileViewStoreVideos(storePageId: profileViewController.kidOrStorePageId.value.toString());
    }
    return null;
  }

  getUserKidOrStoreAlbumImage({required String type}) async {
    if (type == "kid") {
      return await profileViewController.getProfileViewKidImageAlbum(kidPageId: profileViewController.kidOrStorePageId.value.toString());
    }
    if (type == "profile") {
      return await profileViewController.getImageAlbum();
    }
    if (type == "store") {
      return await profileViewController.getProfileViewStoreImageAlbum(storePageId: profileViewController.kidOrStorePageId.value.toString());
    }
    return null;
  }

  getUserKidAwardList({required String type}) async {
    if (type == "kid") {
      return await profileViewController.getProfileViewKidAwardList(kidPageId: "4113727326");
    }
    if (type == "profile") {
      return await profileViewController.getProfileViewAwardList();
    }
    return null;
  }

  int getUserKidAwardListLength({required String type}) {
    if (type == "kid") {
      return profileViewController.profileViewKidAllAwardList.length;
    }
    if (type == "profile") {
      return profileViewController.allAwardList.length;
    }
    return 0;
  }

  int getUserKidOrStoreAlbumListLength({required String type}) {
    if (type == "kid") {
      return profileViewController.profileViewKidImageAlbumList.length;
    }
    if (type == "profile") {
      return profileViewController.imageAlbumList.length;
    }
    if (type == "store") {
      return profileViewController.profileViewStoreImageAlbumList.length;
    }
    return 0;
  }

  int getUserKidOrStorePostsListLength({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.profileViewKidPostList.isNotEmpty) {
      return profileViewController.profileViewKidPostList.length;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.profileViewPostList.isNotEmpty) {
      return profileViewController.profileViewPostList.length;
    }
    if (type == "store") {
      return profileViewController.profileViewStorePostList.length;
    }
    return 0;
  }

  int getUserKidOrStoreVideosListLength({required String type}) {
    if (type == "kid" && profileViewController.profileViewKidPostList.isNotEmpty) {
      return profileViewController.profileViewKidVideoList.length;
    }
    if (type == "profile" && profileViewController.profileViewPostList.isNotEmpty) {
      return profileViewController.profileViewPostList.length;
    }
    if (type == "store") {
      return profileViewController.profileViewStoreVideoList.length;
    }
    return 0;
  }

  int getUserKidOrStoreAllImageListLength({required String type}) {
    if (type == "kid") {
      return profileViewController.kidAllImageList.length;
    }
    if (type == "profile") {
      return profileViewController.allImageList.length;
    }
    if (type == "store") {
      return profileViewController.storeAllImageList.length;
    }
    return 0;
  }

  String getUserKidOrStoreAllImageListSingleImage({required String type, required int index}) {
    if (type == "kid" && profileViewController.kidAllImageList.isNotEmpty) {
      return profileViewController.kidAllImageList[index].fullPath ?? "";
    }
    if (type == "profile" && profileViewController.allImageList.isNotEmpty) {
      return profileViewController.allImageList[index].fullPath ?? "";
    }
    if (type == "store" && profileViewController.storeAllImageList.isNotEmpty) {
      return profileViewController.storeAllImageList[index].fullPath ?? "";
    }
    return "";
  }

  getUserKidOrStoreAllImageList({required String type}) {
    if (type == "kid") {
      return profileViewController.kidAllImageList;
    }
    if (type == "profile" && profileViewController.allImageList.isNotEmpty) {
      return profileViewController.allImageList;
    }
    if (type == "store" && profileViewController.storeAllImageList.isNotEmpty) {
      return profileViewController.storeAllImageList;
    }
    return [];
  }

  String getUserKidDateOfBirth({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.dob != null) {
      return DateFormat('MMMM d, yyyy').format(profileViewController.kidProfileData.value!.dob!);
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.dob != null) {
      return DateFormat('MMMM d, yyyy').format(profileViewController.userProfileBasicData.value!.dateOfBirth!);
    }
    return ksNA.tr;
  }

  String getUserKidStoreCoverPhoto({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value?.coverPhoto != null) {
      return profileViewController.kidProfileData.value!.coverPhoto!;
    }
    if (type == "profile" && profileViewController.userProfileData.value?.coverPhoto != null) {
      return profileViewController.userProfileData.value!.coverPhoto!;
    }
    if (type == "store" && profileViewController.storeProfileData.value?.coverPhoto != null) {
      return profileViewController.storeProfileData.value!.coverPhoto!;
    }
    return "";
  }

  List<Contact?> getUserKidOrStoreContactInfo({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileContactList.isNotEmpty) {
      return profileViewController.kidProfileContactList;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userBasicData.isNotEmpty) {
      return profileViewController.userBasicData;
    }
    if (profileViewController.profileViewType.value == "store" && profileViewController.storeProfileContactList.isNotEmpty) {
      return profileViewController.storeProfileContactList;
    }
    return [];
  }

  String getKidOrStorePageId({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value!.pageId != null) {
      return profileViewController.kidProfileData.value!.pageId.toString();
    }
    if (type == "store" && profileViewController.storeProfileData.value!.pageId != null) {
      return profileViewController.storeProfileData.value!.pageId!.toString();
    }
    return "";
  }

  getKidOrStoreCreatingDate({required String type}) {
    if (type == "kid" && profileViewController.kidProfileData.value?.createdAt != null) {
      return profileViewController.kidProfileData.value!.createdAt!;
    }
    if (type == "store" && profileViewController.storeProfileData.value!.pageId != null) {
      return profileViewController.storeProfileData.value!.createdAt!;
    }
    return "";
  }

  String getUserKidStoreProfilePicture({required String type}) {
    if (profileViewController.profileViewType.value == "kid" && profileViewController.kidProfileData.value?.profilePicture != null) {
      return profileViewController.kidProfileData.value!.profilePicture!;
    }
    if (profileViewController.profileViewType.value == "store" && profileViewController.storeProfileData.value?.profilePicture != null) {
      return profileViewController.storeProfileData.value!.profilePicture!;
    }
    if (profileViewController.profileViewType.value == "profile" && profileViewController.userProfileData.value?.profilePicture != null) {
      return profileViewController.userProfileData.value!.profilePicture!;
    }
    return "";
  }
}
