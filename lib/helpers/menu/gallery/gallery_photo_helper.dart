import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/create_album.dart';
import 'package:bip_hip/views/menu/photos/single_image_description.dart';

class GalleryPhotoHelper {
  final GalleryController galleryController = Get.find<GalleryController>();
  final GlobalController globalController = Get.find<GlobalController>();

  void resetTapButtonData() {
    galleryController.tapAbleButtonState.clear();
    galleryController.tapAbleButtonState.addAll([true, false]);
  }

  void yourPhotosTapableButton() {
    galleryController.imageDataList.clear();
    for (var album in galleryController.albumData.value!.imageAlbums.data) {
      if (album.title!.toLowerCase() == 'profile picture' || album.title!.toLowerCase() == 'cover photo') {
        galleryController.imageDataList.add(album);
      }
    }
  }

  void albumsTapableButton() {
    galleryController.imageDataList.clear();
    for (var album in galleryController.albumData.value!.imageAlbums.data) {
      if (album.title!.toLowerCase() != 'profile picture' && album.title!.toLowerCase() != 'cover photo') {
        galleryController.imageDataList.add(album);
      }
    }
  }

  void galleryPhotoActionOnChanged({required int index}) {
    galleryController.galleryPhotoActionSelect.value = galleryController.galleryPhotoActionList[index]['action'];
    if (galleryController.galleryPhotoActionSelect.value == '') {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
    } else {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = true;
    }
  }

  void galleryPhotoOnPressed({required int index}) {
    galleryController.galleryPhotoActionSelect.value = galleryController.galleryPhotoActionList[index]['action'];
    if (galleryController.galleryPhotoActionSelect.value == '') {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
    } else {
      galleryController.galleryPhotoBottomSheetRightButtonState.value = true;
    }
  }

  Color galleryPhotoItemColor({required int index}) {
    if (galleryController.galleryPhotoActionSelect.value == galleryController.galleryPhotoActionList[index]['action']) {
      return cPrimaryTint3Color;
    }
    return cWhiteColor;
  }

  //*Single Photo view bottom sheet

  void photoOnPressed({required int index}) async {
    galleryController.photoActionSelect.value = galleryController.photoActionList[index]['action'];
    Get.back();
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    if (galleryController.photoActionSelect.value == 'Make as profile picture') {
      await galleryController.imageMakeProfilePicture();
    } else if (galleryController.photoActionSelect.value == 'Make as cover photo') {
      await galleryController.imageMakeCoverPhoto();
    } else if (galleryController.photoActionSelect.value == 'Delete photo') {
      await galleryController.deleteImage();
    } else if (galleryController.photoActionSelect.value == 'Download photo') {
      await galleryController.downloadPhoto();
    } else if (galleryController.photoActionSelect.value == 'Edit caption') {
      Get.to(() => SingleImageDescription(
            image: galleryController.imageDetailsData.value!.image!.fullPath.toString(),
            description: galleryController.imageDetailsData.value!.image!.description,
          ));
    }
  }

  Color photoItemColor({required int index}) {
    if (galleryController.photoActionSelect.value == galleryController.photoActionList[index]['action']) {
      return cPrimaryTint3Color;
    }
    return cWhiteColor;
  }

  void showAudienceSheet(context) {
    galleryController.temporaryCreateAlbumSelectedPrivacy.value = galleryController.createAlbumSelectedPrivacy.value;
    Get.find<GlobalController>().commonBottomSheet(
      isBottomSheetRightButtonActive: true.obs,
      bottomSheetHeight: height * .6,
      context: context,
      content: CreateAlbumAudienceContent(),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        galleryController.createAlbumSelectedPrivacy.value = galleryController.temporaryCreateAlbumSelectedPrivacy.value;
        galleryController.createAlbumSelectedPrivacyIcon.value = galleryController.temporaryCreateAlbumSelectedPrivacyIcon.value;
        galleryController.privacyId.value = galleryController.temoparyprivacyId.value;
        // selectAudienceTextChange();
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksEditAudience.tr,
      isRightButtonShow: true,
    );
  }

  void getBottomRowOnPressed(index, [context]) async {
    ll(index);
    if (index == 1) {
      // var status = await globalController.selectMultiMediaSource(
      //     galleryController.isCreateAlbumMediaChanged,galleryController.createAlbumAllMediaLinkList, galleryController.createAlbumAllMediaFileList);
      // if (status) {
      //   insertMedia(galleryController.createAlbumAllMediaLinkList, galleryController.createAlbumAllMediaFileList);
      // configImageDescription();
      // checkCanCreatePost();
      // createPostController.isMediaChanged.value = false;
      // createPostController.mediaLinkList.clear();
      // createPostController.mediaFileList.clear();
      // }
    } else if (index == 2) {
    } else if (index == 3) {
      // var status = await _globalController.selectVideoSource(isCreatePostVideoChanged, createPostVideoLink, createPostVideoFile, 'camera', true);
      // if (status) {
      //   insertMedia([createPostVideoLink], createPostVideoFile);
      //   isCreatePostVideoChanged.value = false;
      //   createPostVideoLink.value = "";
      //   createPostVideoFile.clear();
      // }
    } else {
      // createPostController.tagFriendList.clear();
      // createPostController.tempTaggedFriends.clear();
      Get.find<FriendController>().isFriendListLoading.value = true;
      galleryController.temporaryTaggedFriends.addAll(galleryController.taggedFriends);
      if (galleryController.temporaryTaggedFriends.isNotEmpty) {
        galleryController.tagFriendButtonSheetRightButtonState.value = true;
      } else {
        galleryController.tagFriendButtonSheetRightButtonState.value = false;
      }
      globalController.commonBottomSheet(
        isBottomSheetRightButtonActive: galleryController.tagFriendButtonSheetRightButtonState,
        isDismissible: false,
        isScrollControlled: true,
        bottomSheetHeight: height * .9,
        context: context,
        isSearchShow: true,
        content: CreateAlbumTagPeopleBottomSheetContent(),
        onPressCloseButton: () {
          galleryController.taggedFriends.clear();
          galleryController.taggedFriends.addAll(galleryController.temporaryTaggedFriends);
          galleryController.temporaryTaggedFriends.clear();
          galleryController.tagFriendButtonSheetRightButtonState.value = false;
          Get.back();
        },
        onPressRightButton: () {
          galleryController.taggedFriends.clear();
          galleryController.taggedFriends.addAll(galleryController.temporaryTaggedFriends);
          galleryController.temporaryTaggedFriends.clear();
          galleryController.tagFriendButtonSheetRightButtonState.value = false;
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksTagPeople.tr,
        isRightButtonShow: true,
      );
      if (Get.find<FriendController>().friendList.isEmpty) {
        await Get.find<FriendController>().getFriendList();
        galleryController.tagFriendList.addAll(Get.find<FriendController>().friendList);
      } else {
        for (int i = 0; i < galleryController.temporaryTaggedFriends.length; i++) {
          galleryController.tagFriendList.remove(galleryController.temporaryTaggedFriends);
        }
        Get.find<FriendController>().isFriendListLoading.value = false;
      }
    }
  }

  // //Get tagged friend bottom sheet
  // Future<void> createAlbumTaggedFriendBottomSheet(context) async {
  //   Get.find<FriendController>().isFriendListLoading.value = true;
  //   createPostController.tempTaggedFriends.addAll(createPostController.taggedFriends);
  //   if (createPostController.tempTaggedFriends.isNotEmpty) {
  //     createPostController.tagFriendButtonSheetRightButtonState.value = true;
  //   } else {
  //     createPostController.tagFriendButtonSheetRightButtonState.value = false;
  //   }
  //   globalController.commonBottomSheet(
  //     isBottomSheetRightButtonActive: createPostController.tagFriendButtonSheetRightButtonState,
  //     isScrollControlled: true,
  //     bottomSheetHeight: height * .9,
  //     context: context,
  //     isSearchShow: true,
  //     content: TagPeopleBottomSheetContent(),
  //     isDismissible: false,
  //     onPressCloseButton: () {
  //       createPostController.taggedFriends.clear();
  //       createPostController.taggedFriends.addAll(createPostController.tempTaggedFriends);
  //       createPostController.tempTaggedFriends.clear();
  //       createPostController.tagFriendButtonSheetRightButtonState.value = false;
  //       Get.back();
  //     },
  //     onPressRightButton: () {
  //       createPostController.taggedFriends.clear();
  //       createPostController.taggedFriends.addAll(createPostController.tempTaggedFriends);
  //       createPostController.tempTaggedFriends.clear();
  //       createPostController.tagFriendButtonSheetRightButtonState.value = false;
  //       Get.back();
  //     },
  //     rightText: ksDone.tr,
  //     rightTextStyle: medium14TextStyle(cPrimaryColor),
  //     title: ksTagPeople.tr,
  //     isRightButtonShow: true,
  //   );
  //   if (Get.find<FriendController>().friendList.isEmpty) {
  //     await Get.find<FriendController>().getFriendList();
  //     createPostController.tagFriendList.addAll(Get.find<FriendController>().friendList);
  //   } else {
  //     for (int i = 0; i < createPostController.tempTaggedFriends.length; i++) {
  //       createPostController.tagFriendList.remove(createPostController.tempTaggedFriends);
  //     }
  //     Get.find<FriendController>().isFriendListLoading.value = false;
  //   }
  // }

  IconData getBottomRowIcon(index) {
    switch (index) {
      case 1:
        return BipHip.photo;
      case 2:
        return BipHip.location;
      case 3:
        return BipHip.twitchFill;
      default:
        return BipHip.tagFriends;
    }
  }

  Color getBottomIconColor(index) {
    switch (index) {
      case 1:
        return cGreenColor;
      case 2:
        return cPrimaryColor;
      case 3:
        return cRedColor;
      default:
        return cSecondaryColor;
    }
  }
}
