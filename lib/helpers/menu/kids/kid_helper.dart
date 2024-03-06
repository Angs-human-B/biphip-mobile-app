import 'dart:io';

import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_picture_upload_content.dart';

//*kids
class KidHelper {
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();
  Widget totalKidShow() {
    if (kidsController.totalKidsCount.value == 0) {
      return const SizedBox();
    } else {
      return Text(
        '${ksTotalKids.tr}: ${kidsController.totalKidsCount.value}',
        style: semiBold14TextStyle(cBlackColor),
      );
    }
  }

  //*Edit Kids
  void checkCanEditKidInfo() {
    if ((kidsController.kidNameTextEditingController.text.trim() != '' &&
            kidsController.kidNameTextEditingController.text.trim() != kidsController.kidName.value &&
            kidsController.kidNameTextEditingController.text.trim().length > 2) ||
        (kidsController.kidAgeTextEditingController.text.trim() != '' &&
            kidsController.kidAgeTextEditingController.text.trim() != kidsController.kidAge.value &&
            kidsController.kidAgeTextEditingController.text.trim() != '0') ||
        kidsController.isKidImageChanged.value) {
      kidsController.isSaveKidButtonEnabled.value = true;
    } else {
      kidsController.isSaveKidButtonEnabled.value = false;
    }
  }

  void setupEditKid() {
    for (int i = 0; i < kidsController.kidList.length; i++) {
      if (kidsController.kidId.value == kidsController.kidList[i].id) {
        kidsController.kidNameTextEditingController.text = kidsController.kidList[i].name ?? '';
        kidsController.kidAgeTextEditingController.text = kidsController.kidList[i].age.toString();
        kidsController.kidImageLink.value = kidsController.kidList[i].profilePicture.toString();
        kidsController.kidName.value = kidsController.kidNameTextEditingController.text;
        kidsController.kidAge.value = kidsController.kidAgeTextEditingController.text;
      }
    }
    checkCanEditKidInfo();
  }

  void editKidImageFromCamera() async {
    await Get.find<GlobalController>()
        .selectImageSource(kidsController.isKidImageChanged, kidsController.kidImageLink, kidsController.kidImageFile, 'camera', true);
    checkCanEditKidInfo();
  }

  void editKidImageFromGallery() async {
    await Get.find<GlobalController>()
        .selectImageSource(kidsController.isKidImageChanged, kidsController.kidImageLink, kidsController.kidImageFile, 'gallery', true);
    checkCanEditKidInfo();
  }

  void kidEditButtonOnPressed() {
    kidsController.isSaveKidButtonEnabled.value = false;
    setupEditKid();
    Get.back();
  }

  void kidDeleteButtonOnPressed() async {
    Get.back();
    await kidsController.kidDelete();
  }
  //!Kid Profile

  void resetKidImage() {
    kidsController.profileImageFile.value = File('');
    kidsController.profileImageLink.value = '';
    kidsController.isProfileImageChanged.value = false;
    kidsController.isSharedToNewFeed.value = false;
    kidsController.coverImageFile.value = File('');
    kidsController.coverImageLink.value = '';
    kidsController.isCoverImageChanged.value = false;
  }

  //*Edit kid cover bottom sheet content
  void kidCoverPhotoUploadBottomSheet(context) {
    kidsController.isKidProfilePicEditor.value = false;
    // kidsController.kidViewOptionEnabled.value = false;
    resetKidImage();
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
      content: KidPictureUploadContent(
        isImageChanged: kidsController.isCoverImageChanged,
        imagePath: kidsController.coverImageLink,
        imageFile: kidsController.coverImageFile,
        // isViewOptionEnabled: false.obs,
      ),
    );
  }

  //*Edit kid profile bottom sheet content
  void kidProfilePicUploadBottomSheet(context) {
    kidsController.isKidProfilePicEditor.value = true;
    kidsController.kidViewOptionEnabled.value = false;
    resetKidImage();
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
      content: KidPictureUploadContent(
        isImageChanged: kidsController.isProfileImageChanged,
        imagePath: kidsController.profileImageLink,
        imageFile: kidsController.profileImageFile,
        // isViewOptionEnabled: false.obs,
      ),
    );
  }

  void kidInitialDataCoverPhoto() {
    // if (kidsController.userData.value!.coverPhoto != null) {
    //   profileController.viewOptionEnabled.value = true;
    //   profileController.isProfilePhoto.value = false;
    //   profileController.previewPhoto.value = profileController.userData.value!.coverPhoto.toString();
    // } else {
    // kidsController.viewOptionEnabled.value = false;//!correct
    kidsController.kidViewOptionEnabled.value = true;
    // }
    kidsController.isKidProfilePicEditor.value = false;
  }

  void kidInitialDataProfilePicture() {
    // if (kidsController.userData.value!.coverPhoto != null) {
    // kidsController.viewOptionEnabled.value = true;
    //   profileController.isProfilePhoto.value = false;
    //   profileController.previewPhoto.value = profileController.userData.value!.coverPhoto.toString();
    // } else {
    // kidsController.viewOptionEnabled.value = false;//!Correct
    kidsController.kidViewOptionEnabled.value = true;
    // }
    kidsController.isKidProfilePicEditor.value = true;
  }

  //* Kid cover photo bottom sheet content
  void kidCoverPhotoEditBottomSheet(context) {
    kidInitialDataCoverPhoto();
    resetKidImage();
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
      content: KidPictureUploadContent(
        viewPhoto: ksViewCoverPhoto.tr,
        isImageChanged: kidsController.isCoverImageChanged,
        imagePath: kidsController.coverImageLink,
        imageFile: kidsController.coverImageFile,
        // isViewOptionEnabled: true.obs,
      ),
    );
  }

  void kidProfilePicEditBottomSheet(context) {
    kidInitialDataProfilePicture();
    resetKidImage();
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
        content: KidPictureUploadContent(
          viewPhoto: ksViewProfilePicture.tr,
          isImageChanged: kidsController.isProfileImageChanged,
          imagePath: kidsController.profileImageLink,
          imageFile: kidsController.profileImageFile,
          // isViewOptionEnabled: true.obs,
        ));
  }

  //* kid Bio edit
  void kidEditBio() {
    if (kidsController.kidBio.value == null) {
      kidsController.bioCount.value = 0;
      kidsController.kidBioEditingController.text = '';
      kidsController.kidBio.value = '';
    } else {
      //!Api Data
      kidsController.kidBio.value = kidsController.kidBio.value;
      kidsController.bioCount.value = kidsController.kidBio.value!.length;
      kidsController.kidBioEditingController.text = kidsController.kidBio.value!;
    }
    Get.toNamed(krEditBio);
  }
}
