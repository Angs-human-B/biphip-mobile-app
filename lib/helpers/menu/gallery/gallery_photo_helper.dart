import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/create_album.dart';
import 'package:bip_hip/views/menu/photos/create_album_date_time.dart';
import 'package:bip_hip/views/menu/photos/single_image_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
    }
    else if (galleryController.photoActionSelect.value == 'Edit caption') {
      galleryController.isImageDescriptionSaveButtonEnable.value = false;
      if (galleryController.imageDetailsData.value!.image?.description != null && galleryController.imageData.value?.description == null) {
        galleryController.imageDescriptionUpdateController.text = galleryController.imageDetailsData.value!.image!.description;
        galleryController.previousImageDescription.value = galleryController.imageDetailsData.value!.image!.description;
      } else if (galleryController.imageData.value?.description != null) {
        galleryController.imageDescriptionUpdateController.text = galleryController.imageData.value!.description ?? "";
        galleryController.previousImageDescription.value = galleryController.imageData.value!.description ?? "";
      } else {
        galleryController.imageDescriptionUpdateController.text = '';
        galleryController.previousImageDescription.value = '';
      }
      Get.to(() => SingleImageDescription(
            image: galleryController.imageDetailsData.value!.image!.fullPath.toString(),
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
    galleryController.temporaryprivacyId.value = galleryController.privacyId.value;
    galleryController.temporaryCreateAlbumSelectedPrivacyIcon.value = galleryController.createAlbumSelectedPrivacyIcon.value;
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
        galleryController.privacyId.value = galleryController.temporaryprivacyId.value;
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksEditAudience.tr,
      isRightButtonShow: true,
    );
  }

  void insertMedia(mediaFile) {
    galleryController.allMediaList.addAll(mediaFile);
  }

  void configImageDescription() {
    for (int i = 0; i < galleryController.createAlbumAllMediaFileList.length; i++) {
      galleryController.imageDescriptionTextEditingController.add(TextEditingController());
      galleryController.imageLocationsList.add("LOC$i");
      galleryController.imageTimesList.add(DateTime.now().toString());
      galleryController.imageTagIdList.add('1,58');
    }
  }

  void getBottomRowOnPressed(index, [context]) async {
    if (index == 1) {
      var status = await globalController.selectMultiMediaSource(
          galleryController.isCreateAlbumMediaChanged, galleryController.createAlbumAllMediaLinkList, galleryController.createAlbumAllMediaFileList);
      if (status) {
        insertMedia(galleryController.createAlbumAllMediaFileList);
        configImageDescription();
        galleryController.checkCreateAlbum();
        galleryController.isCreateAlbumMediaChanged.value = false;
        galleryController.createAlbumAllMediaLinkList.clear();
        galleryController.createAlbumAllMediaFileList.clear();
      }
    } else if (index == 2) {
      if (galleryController.locationTextEditingController.text.toString().trim() != '') {
        galleryController.addLocationValue.value = galleryController.locationTextEditingController.text.toString().trim();
      } else {
        galleryController.locationTextEditingController.clear();
      }
      Get.toNamed(krCreateAlbumLocation);
    } else if (index == 3) {
      Get.to(() => CreateAlbumDateTime());
    } else {
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

  void removeMedia(index) {
    if (galleryController.isEditAlbum.value && galleryController.allMediaList[index] is String) {
      galleryController.deleteImageIdList.add(galleryController.imageIdList.removeAt(index));
    }
    galleryController.allMediaList.removeAt(index);
    galleryController.checkCreateAlbum();
  }

  //* Get tagged friend bottom sheet
  Future<void> taggedFriendBottomSheet(context) async {
    Get.find<FriendController>().isFriendListLoading.value = true;
    galleryController.temporaryTaggedFriends.addAll(galleryController.taggedFriends);
    if (galleryController.temporaryTaggedFriends.isNotEmpty) {
      galleryController.tagFriendButtonSheetRightButtonState.value = true;
    } else {
      galleryController.tagFriendButtonSheetRightButtonState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: galleryController.tagFriendButtonSheetRightButtonState,
      isScrollControlled: true,
      bottomSheetHeight: height * .9,
      context: context,
      isSearchShow: true,
      content: CreateAlbumTagPeopleBottomSheetContent(),
      isDismissible: false,
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

  String getBottomRowPicture(index) {
    switch (index) {
      case 1:
        return kiGallery;
      case 2:
        return kiLocation;
      case 3:
        return kiTime;
      default:
        return kiTagFriend;
    }
  }

  void createAlbumDateButtonOnPressed(context) {
    galleryController.temporaryCreateAlbumDate.value = '';
    if (galleryController.createAlbumDate.value != '') {
      galleryController.temporaryCreateAlbumDate.value = galleryController.createAlbumDate.value;
    }
    galleryController.createAlbumDateBottomSheetState.value = false;
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: galleryController.createAlbumDateBottomSheetState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        galleryController.isDateTimeSaveButtonEnable.value = true;
        galleryController.createAlbumDate.value = galleryController.temporaryCreateAlbumDate.value;
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksDate,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          maximumDate: DateTime.now().add(const Duration(minutes: 30)),
          initialDateTime:
              galleryController.temporaryCreateAlbumDate.value != '' ? DateTime.parse(galleryController.temporaryCreateAlbumDate.value) : DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            galleryController.createAlbumDateBottomSheetState.value = true;
            galleryController.temporaryCreateAlbumDate.value = DateFormat('yyyy-MM-dd').format(value);
          },
        ),
      ),
    );
  }

  void createAlbumTimeButtonOnPressed(context) {
    galleryController.temporaryCreateAlbumTime.value = '';
    if (galleryController.createAlbumTime.value != '') {
      galleryController.temporaryCreateAlbumTime.value = galleryController.createAlbumTime.value;
    }
    galleryController.createAlbumTimeBottomSheetState.value = false;
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: galleryController.createAlbumTimeBottomSheetState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        galleryController.createAlbumTime.value = galleryController.temporaryCreateAlbumTime.value;
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksTime.tr,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          initialDateTime: galleryController.createAlbumTime.value != ''
              ? DateTime.parse("${galleryController.createAlbumDate} ${galleryController.createAlbumTime.value}")
              : DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (value) {
            galleryController.createAlbumTimeBottomSheetState.value = true;
            galleryController.temporaryCreateAlbumTime.value = DateFormat("HH:mm").format(value);
          },
        ),
      ),
    );
  }

  //* Reset create album all data
  void resetCreateAlbumData() {
    galleryController.createAlbumNameController.clear();
    galleryController.albumNameErrorText.value = null;
    galleryController.isCreateAlbumPostButtonEnable.value = false;
    galleryController.temporaryCreateAlbumSelectedPrivacy.value = 'Public';
    galleryController.createAlbumSelectedPrivacy.value = 'Public';
    galleryController.temporaryCreateAlbumSelectedPrivacyIcon.value = BipHip.world;
    galleryController.createAlbumSelectedPrivacyIcon.value = BipHip.world;
    galleryController.temporaryprivacyId.value = 1;
    galleryController.privacyId.value = 1;
    galleryController.taggedFriends.clear();
    galleryController.temporaryTaggedFriends.clear();
    galleryController.temporaryTagIndex.clear();
    galleryController.tagFriendList.clear();
    Get.find<FriendController>().friendList.clear();
    galleryController.isCreateAlbumMediaChanged.value = false;
    galleryController.createAlbumAllMediaLinkList.clear();
    galleryController.createAlbumAllMediaFileList.clear();
    galleryController.allMediaList.clear();
    galleryController.locationTextEditingController.clear();
    galleryController.addLocationValue.value = '';
    galleryController.isAddLocationSuffixIconVisible.value = false;
    galleryController.isLocationSaveEnable.value = false;
    galleryController.imageDescriptionTextEditingController.clear();
    galleryController.imageLocationsList = [];
    galleryController.imageTimesList = [];
    galleryController.imageTagIdList = [];
    galleryController.isDateTimeSaveButtonEnable.value = false;
    galleryController.createAlbumDateBottomSheetState.value = false;
    galleryController.temporaryCreateAlbumDate.value = '';
    galleryController.createAlbumDate.value = '';
    galleryController.createAlbumTimeBottomSheetState.value = false;
    galleryController.temporaryCreateAlbumTime.value = '';
    galleryController.createAlbumTime.value = '';
    galleryController.isEditAlbum.value = false;
    galleryController.deleteImageIdList.clear();
    galleryController.imageIdList.clear();
    galleryController.previousAlbumImageLength.value = -1;
    galleryController.previousAlbumName.value = "";
    galleryController.selectedPrivacyId.value = 1;
  }
}
