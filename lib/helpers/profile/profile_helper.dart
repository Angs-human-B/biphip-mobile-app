import 'dart:io';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_pic_upload_content.dart';

import '../../controllers/menu/menu_section_controller.dart';
import '../../views/menu/settings/personal details/changeNameBottomSheetContent.dart';

class ProfileHelper {
  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final MenuSectionController menuController = Get.find<MenuSectionController>();

  void showProfileTabSection(index) async {
    if (index == 0) {
      profileController.postSectionVisible.value = true;
    } else if (index == 1) {
      profileController.postSectionVisible.value = false;
      await Get.find<FriendController>().getFriendList();
      await Get.find<FamilyController>().getFamilyList();
    }
  }

  void initialDataCoverPhoto() {
    if (profileController.userData.value!.coverPhoto != null) {
      profileController.viewOptionEnabled.value = true;
      profileController.isProfilePhoto.value = false;
      profileController.previewPhoto.value = profileController.userData.value!.coverPhoto.toString();
    } else {
      profileController.viewOptionEnabled.value = false;
    }
    profileController.isProfilePicEditor.value = false;
  }

  void initialDataProfilePic() {
    if (profileController.userData.value!.profilePicture != null) {
      profileController.isProfilePhoto.value = true;
      profileController.viewOptionEnabled.value = true;
      profileController.previewPhoto.value = profileController.userData.value!.profilePicture.toString();
    } else {
      profileController.viewOptionEnabled.value = false;
    }
    profileController.isProfilePicEditor.value = true;
  }

  void resetImage() {
    profileController.profileImageFile.value = File('');
    profileController.profileImageLink.value = '';
    profileController.isProfileImageChanged.value = false;
    profileController.isSharedToNewFeed.value = false;
    profileController.coverImageFile.value = File('');
    profileController.coverImageLink.value = '';
    profileController.isCoverImageChanged.value = false;
  }

  void coverPhotoEditBottomSheet(context) {
    initialDataCoverPhoto();
    resetImage();
    globalController.commonBottomSheet(
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
        isImageChanged: profileController.isCoverImageChanged,
        imagePath: profileController.coverImageLink,
        imageFile: profileController.coverImageFile,
      ),
    );
  }

  void profilePicEditBottomSheet(context) {
    initialDataProfilePic();
    resetImage();
    globalController.commonBottomSheet(
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
          isImageChanged: profileController.isProfileImageChanged,
          imagePath: profileController.profileImageLink,
          imageFile: profileController.profileImageFile,
        ));
  }

  void profilePicUploadBottomSheet(context) {
    profileController.isProfilePicEditor.value = true;
    profileController.viewOptionEnabled.value = false;
    resetImage();
    globalController.commonBottomSheet(
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
        isImageChanged: profileController.isProfileImageChanged,
        imagePath: profileController.profileImageLink,
        imageFile: profileController.profileImageFile,
      ),
    );
  }

  void coverPhotoUploadBottomSheet(context) {
    profileController.isProfilePicEditor.value = false;
    profileController.viewOptionEnabled.value = false;
    resetImage();
    globalController.commonBottomSheet(
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
        isImageChanged: profileController.isCoverImageChanged,
        imagePath: profileController.coverImageLink,
        imageFile: profileController.coverImageFile,
      ),
    );
  }

  void viewProfilePic() {
    if (profileController.userData.value!.profilePicture != null) {
      profileController.isProfilePhoto.value = true;
      profileController.viewOptionEnabled.value = true;
      profileController.previewPhoto.value = profileController.userData.value!.profilePicture.toString();
      Get.toNamed(krViewPhoto);
    }
  }

  void viewCoverPhoto() {
    if (profileController.userData.value!.coverPhoto != null) {
      profileController.viewOptionEnabled.value = true;
      profileController.isProfilePhoto.value = false;
      profileController.previewPhoto.value = profileController.userData.value!.coverPhoto.toString();
      Get.toNamed(krViewPhoto);
    }
  }

  //* Bio edit
  void editBio() {
    if (profileController.userData.value!.bio == null) {
      profileController.bioCount.value = 0;
      profileController.bioEditingController.text = '';
      profileController.bio.value = '';
    } else {
      profileController.bio.value = profileController.userData.value!.bio!;
      profileController.bioCount.value = profileController.userData.value!.bio.toString().length;
      profileController.bioEditingController.text = profileController.userData.value!.bio!;
    }
    Get.toNamed(krEditBio);
  }
  void editName(BuildContext context){
    menuController
        .firstNameEditingController.text =
        globalController.userFirstName.value ??
            '';
    menuController
        .lastNameEditingController.text =
        globalController.userLastName.value ?? '';
    menuController
        .changeNameBottomSheetButtonState
        .value = false;
    globalController.commonBottomSheet(
        context: context,
        isScrollControlled: true,
        isBottomSheetRightButtonActive:
        menuController
            .changeNameBottomSheetButtonState,
        content: ChangeNameBottomSheetContent(
          menuController: menuController,
        ),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () async {
          menuController
              .changeNameBottomSheetButtonState
              .value = false;
          unfocus(context);
          Get.back();
          await menuController.changeName();
        },
        rightText: ksDone.tr,
        rightTextStyle:
        medium14TextStyle(cPrimaryColor),
        title: ksChangeName.tr,
        isRightButtonShow: true);
  }

  void saveBio() async {
    profileController.bio.value = profileController.bioEditingController.text.trim();
    await profileController.updateBio();
  }
}
