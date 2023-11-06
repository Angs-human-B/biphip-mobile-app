import 'dart:io';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/profile_widgets/profile_pic_upload_content.dart';

class ProfileHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  void initialDataCoverPhoto() {
    if (_profileController.userData.value!.coverPhoto != null) {
      _profileController.viewOptionEnabled.value = true;
      _profileController.isProfilePhoto.value = false;
      _profileController.previewPhoto.value = _profileController.userData.value!.coverPhoto.toString();
    } else {
      _profileController.viewOptionEnabled.value = false;
    }
    _profileController.isProfilePicEditor.value = false;
  }

  void initialDataProfilePic() {
    if (_profileController.userData.value!.profilePicture != null) {
      _profileController.isProfilePhoto.value = true;
      _profileController.viewOptionEnabled.value = true;
      _profileController.previewPhoto.value = _profileController.userData.value!.profilePicture.toString();
    } else {
      _profileController.viewOptionEnabled.value = false;
    }
    _profileController.isProfilePicEditor.value = true;
  }

  void resetImage() {
    _profileController.profileImageFile.value = File('');
    _profileController.profileImageLink.value = '';
    _profileController.isProfileImageChanged.value = false;
    _profileController.isSharedToNewFeed.value = false;
    _profileController.coverImageFile.value = File('');
    _profileController.coverImageLink.value = '';
    _profileController.isCoverImageChanged.value = false;
  }

  void coverPhotoEditBottomSheet(context) {
    initialDataCoverPhoto();
    resetImage();
    _globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 210,
      content: PictureUploadContent(
        viewPhoto: ksViewCoverPhoto.tr,
        isImageChanged: _profileController.isCoverImageChanged,
        imagePath: _profileController.coverImageLink,
        imageFile: _profileController.coverImageFile,
      ),
    );
  }

  void profilePicEditBottomSheet(context) {
    initialDataProfilePic();
    resetImage();
    _globalController.commonBottomSheet(
        context: context,
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {},
        rightText: '',
        rightTextStyle: regular14TextStyle(cBiddingColor),
        title: ksUploadImage.tr,
        isRightButtonShow: false,
        isScrollControlled: false,
        bottomSheetHeight: 210,
        content: PictureUploadContent(
          viewPhoto: ksViewProfilePicture.tr,
          isImageChanged: _profileController.isProfileImageChanged,
          imagePath: _profileController.profileImageLink,
          imageFile: _profileController.profileImageFile,
        ));
  }

  void profilePicUploadBottomSheet(context) {
    _profileController.isProfilePicEditor.value = true;
    _profileController.viewOptionEnabled.value = false;
    resetImage();
    _globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 170,
      content: PictureUploadContent(
        isImageChanged: _profileController.isProfileImageChanged,
        imagePath: _profileController.profileImageLink,
        imageFile: _profileController.profileImageFile,
      ),
    );
  }

  void coverPhotoUploadBottomSheet(context) {
    _profileController.isProfilePicEditor.value = false;
    _profileController.viewOptionEnabled.value = false;
    resetImage();
    _globalController.commonBottomSheet(
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {},
      rightText: '',
      rightTextStyle: regular14TextStyle(cBiddingColor),
      title: ksUploadImage.tr,
      isRightButtonShow: false,
      isScrollControlled: false,
      bottomSheetHeight: 170,
      content: PictureUploadContent(
        isImageChanged: _profileController.isCoverImageChanged,
        imagePath: _profileController.coverImageLink,
        imageFile: _profileController.coverImageFile,
      ),
    );
  }

  void viewProfilePic() {
    if (_profileController.userData.value!.profilePicture != null) {
      _profileController.isProfilePhoto.value = true;
      _profileController.viewOptionEnabled.value = true;
      _profileController.previewPhoto.value = _profileController.userData.value!.profilePicture.toString();
      Get.toNamed(krViewPhoto);
    }
  }
}
