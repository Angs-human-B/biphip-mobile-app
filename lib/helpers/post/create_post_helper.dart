import 'dart:io';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_sheet_contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CreatePostHelper {
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final GlobalController globalController = Get.find<GlobalController>();

  void initializeCategory() {
    for (int i = 0; i < createPostController.categoryList.length; i++) {
      if (createPostController.categoryList[i]['title'] == createPostController.category.value) {
        createPostController.categoryStatusList[i] = true;
      } else {
        createPostController.categoryStatusList[i] = false;
      }
    }
  }

  void selectCategoryStatusChange(index) {
    for (int i = 0; i < createPostController.categoryStatusList.length; i++) {
      if (index == i) {
        createPostController.categoryStatusList[i] = true;
      } else {
        createPostController.categoryStatusList[i] = false;
      }
    }
  }

  void checkCanCreatePost() {
    if (createPostController.category.value == 'Selling') {
      if (createPostController.sellingPostType.value != '' &&
          createPostController.biddingTitleTextEditingController.text.trim() != '' &&
          createPostController.selectedProductCondition.value != '' &&
          (createPostController.biddingPriceTextEditingController.text.trim() != '' ||
              createPostController.biddingDesiredAmountTextEditingController.text.trim() != '')) {
        createPostController.isPostButtonActive.value = true;
      } else {
        createPostController.isPostButtonActive.value = false;
      }
    } else if (createPostController.category.value == 'Kids') {
      if (createPostController.isEditPost.value) {
        if ((createPostController.previousPostContent.value == createPostController.createPostTextEditingController.text.toString().trim())) {
          createPostController.isPostButtonActive.value = false;
        } else {
          createPostController.isPostButtonActive.value = true;
        }
      } else {
        if ((createPostController.createPostTextEditingController.text.trim() != '' || createPostController.allMediaList.isNotEmpty) &&
            (createPostController.kidID.value != -1)) {
          createPostController.isPostButtonActive.value = true;
        } else {
          createPostController.isPostButtonActive.value = false;
        }
      }
    } else if (createPostController.category.value == 'News') {
       if (createPostController.isEditPost.value) {
        if ((createPostController.previousNewsTitle.value == createPostController.newsTitleTextEditingController.text.toString().trim())) {
          createPostController.isPostButtonActive.value = false;
        } else {
          createPostController.isPostButtonActive.value = true;
        }
      } else {
      if (createPostController.newsTitleTextEditingController.text.trim() == '') {
        createPostController.isPostButtonActive.value = false;
      } else {
        createPostController.isPostButtonActive.value = true;
      }
      }
    } else {
      if (createPostController.isEditPost.value) {
        if ((createPostController.previousPostContent.value == createPostController.createPostTextEditingController.text.toString().trim())) {
          createPostController.isPostButtonActive.value = false;
        } else {
          createPostController.isPostButtonActive.value = true;
        }
      } else {
        if (createPostController.createPostTextEditingController.text.trim().isNotEmpty || createPostController.allMediaList.isNotEmpty) {
          createPostController.isPostButtonActive.value = true;
          if (createPostController.createPostTextEditingController.text.length > 150) {
            createPostController.isTextLimitCrossed.value = true;
          } else {
            createPostController.isTextLimitCrossed.value = false;
          }
        } else {
          createPostController.isPostButtonActive.value = false;
        }
      }
    }
  }

  void onSelectPostSubCategory(index) {
    if (createPostController.tempSubCategoryIndex.value == index) {
      createPostController.tempSubCategoryIndex.value = -1;
      createPostController.subCategoryIndex.value = -1;
      createPostController.subCategoryBottomSheetRightButtonState.value = false;
      createPostController.tempSubCategory.value = '';
      createPostController.subCategory.value = '';
    } else {
      createPostController.tempSubCategoryIndex.value = index;
      Get.find<CreatePostController>().tempSubCategory.value = Get.find<CreatePostController>().createPostSubCategoryList[index].name.toString();
      createPostController.subCategoryBottomSheetRightButtonState.value = true;
    }
  }

  void showAudienceSheet(context) {
    createPostController.tempCreatePostSelectedPrivacy.value = createPostController.createPostSelectedPrivacy.value;
    Get.find<GlobalController>().commonBottomSheet(
      isBottomSheetRightButtonActive: true.obs,
      bottomSheetHeight: height * .6,
      context: context,
      content: AudienceContent(),
      onPressCloseButton: () {
        Get.back();
      },
      // onPressRightButton: () {
      //   createPostController.createPostSelectedPrivacy.value = createPostController.tempCreatePostSelectedPrivacy.value;
      //   createPostController.createPostSelectedPrivacyIcon.value = createPostController.tempCreatePostSelectedPrivacyIcon.value;
      //   ll("message");
      //   // selectAudienceTextChange();
      //   Get.back();
      // },
      onPressRightButton: () {
        createPostController.createPostSelectedPrivacy.value = createPostController.tempCreatePostSelectedPrivacy.value;
        createPostController.createPostSelectedPrivacyIcon.value = createPostController.tempCreatePostSelectedPrivacyIcon.value;
        if (createPostController.createPostSelectedPrivacy.value.toLowerCase() == "Only Me".toLowerCase()) {
          createPostController.privacyId.value = 0;
        } else if (createPostController.createPostSelectedPrivacy.value.toLowerCase() == "Public".toLowerCase()) {
          createPostController.privacyId.value = 1;
        } else if (createPostController.createPostSelectedPrivacy.value.toLowerCase() == "Friends".toLowerCase()) {
          createPostController.privacyId.value = 2;
        } else if (createPostController.createPostSelectedPrivacy.value.toLowerCase() == "Families".toLowerCase()) {
          createPostController.privacyId.value = 3;
        } else if (createPostController.createPostSelectedPrivacy.value.toLowerCase() == "Friend & Family".toLowerCase()) {
          createPostController.privacyId.value = 4;
        }
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksEditAudience.tr,
      isRightButtonShow: true,
    );
  }

  void selectPlatformStatusChange(index) {
    for (int i = 0; i < createPostController.platformStatusList.length; i++) {
      if (index == i) {
        createPostController.platformStatusList[i] = true;
      } else {
        createPostController.platformStatusList[i] = false;
      }
    }
  }

  void selectActionStatusChange(index) {
    for (int i = 0; i < createPostController.actionStatusList.length; i++) {
      if (index == i) {
        createPostController.actionStatusList[i] = true;
      } else {
        createPostController.actionStatusList[i] = false;
      }
    }
  }

  void selectBrandTextChange() {
    for (int i = 0; i < createPostController.storeList.length; i++) {
      if (createPostController.tempSelectedBrandId.value == createPostController.storeList[i].id) {
        createPostController.selectedBrandName.value = createPostController.storeList[i].name.toString();
        createPostController.selectedBrandImage.value = createPostController.storeList[i].profilePicture.toString();
        break;
      }
    }
  }

  void resetAddBrandPage() {
    createPostController.brandImageLink.value = '';
    createPostController.brandImageFile.value = File('');
    createPostController.isBrandImageChanged.value = false;
    createPostController.isSaveBrandButtonEnabled.value = false;
    createPostController.brandNameTextEditingController.clear();
    createPostController.brandWebLinkTextEditingController.clear();
    createPostController.brandFacebookLinkTextEditingController.clear();
    createPostController.brandTwitterTextEditingController.clear();
    createPostController.brandLinkedInLinkTextEditingController.clear();
    createPostController.brandYoutubeLinkTextEditingController.clear();
    createPostController.businessTypeTextEditingController.clear();
  }

  void removeMedia(index) {
    createPostController.allMediaList.removeAt(index);
    // createPostController.allMediaFileList.removeAt(index);
    // if (createPostController.allMediaFileList.isEmpty || createPostController.allMediaList.isEmpty) {
    //   Get.back();
    // }
  }

  void selectCategory(context) {
    for (int i = 0; i < createPostController.categoryList.length; i++) {
      if (createPostController.categoryStatusList[i]) {
        createPostController.categoryID.value = createPostController.categoryList[i]['id'];
        createPostController.category.value = createPostController.categoryList[i]['title'];
        createPostController.categoryIcon.value = createPostController.categoryList[i]['icon'];
        createPostController.categoryIconColor.value = createPostController.categoryList[i]['icon_color'];
        break;
      }
    }
    if (createPostController.category.value == "Kids") {
      createPostController.selectedKid.value = null;
      resetAddKidPage();
      if (createPostController.selectedKid.value == null || createPostController.isKidAdded.value) {
        createPostController.kidCategoryBottomSheetRightButtonState.value = false;
      } else {
        createPostController.kidCategoryBottomSheetRightButtonState.value = true;
      }
      globalController.commonBottomSheet(
        isBottomSheetRightButtonActive: createPostController.kidCategoryBottomSheetRightButtonState,
        context: context,
        content: KidCategoryContent(),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () async {
          createPostController.category.value = createPostController.tempCategory.value;
          if (createPostController.selectedKid.value != null) {
            createPostController.postSecondaryCircleAvatar.value = createPostController.selectedKid.value!.profilePicture.toString();
            createPostController.kidID.value = createPostController.selectedKid.value!.id!;
          } else if (createPostController.isKidAdded.value) {
            createPostController.postSecondaryLocalCirclerAvatar.value = createPostController.kidImageFile.value;
            createPostController.kidID.value = Get.find<KidsController>().kidList.last.id!;
          }
          Get.back();
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksKids.tr,
        isRightButtonShow: true,
      );
    }
    //*For Selling type post
    else if (createPostController.category.value == "Selling") {
      createPostController.temporarySellingPostType.value = createPostController.sellingPostType.value;
      sellingPostTypeSelect();
      globalController.commonBottomSheet(
        isBottomSheetRightButtonActive: createPostController.sellingPostTypeBottomSheetRightButtonState,
        context: context,
        bottomSheetHeight: isDeviceScreenLarge() ? height * .25 : height * 0.35,
        content: SellingCategoryBottomSheetContent(),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          createPostController.sellingPostType.value = createPostController.temporarySellingPostType.value;
          createPostController.selectedBrandName.value = '';
          createPostController.selectedBrandId.value = -1;
          createPostController.selectStoreBottomSheetRightButtonState.value = false;
          globalController.commonBottomSheet(
            isBottomSheetRightButtonActive: createPostController.selectStoreBottomSheetRightButtonState,
            context: context,
            bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
            content: BrandBottomSheetContent(),
            onPressCloseButton: () {
              Get.back();
            },
            onPressRightButton: () {
              for (int i = 0; i < createPostController.storeList.length; i++) {
                if (createPostController.selectedBrandId.value == createPostController.storeList[i].id) {
                  createPostController.brandID.value = createPostController.storeList[i].id!;
                  createPostController.selectedBrandImage.value = createPostController.storeList[i].profilePicture.toString();
                }
              }
              createPostController.postSecondaryCircleAvatar.value = createPostController.selectedBrandImage.value;
              Get.find<HomeController>().homeTabIndex.value = 0;
              Get.offNamedUntil(krCreatePost, ModalRoute.withName(krHome));
            },
            rightText: ksDone.tr,
            rightTextStyle: medium14TextStyle(cPrimaryColor),
            title: ksStore.tr,
            isRightButtonShow: true,
          );
        },
        rightText: ksNext.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksSelectPostType.tr,
        isRightButtonShow: true,
      );
    } else {
      Get.back();
    }
  }

  void resetAddKidPage() {
    createPostController.isKidAdded.value = false;
    createPostController.saveKidInfo.value = false;
    createPostController.isSaveKidButtonEnabled.value = false;
    createPostController.kidImageLink.value = '';
    createPostController.kidImageFile.value = File('');
    createPostController.isKidImageChanged.value = false;
    createPostController.kidNameTextEditingController.clear();
    createPostController.kidAgeTextEditingController.clear();
    createPostController.kidSchoolNameTextEditingController.clear();
    createPostController.kidNameErrorText.value = null;
  }

  void resetCreatePostData() {
    createPostController.isEditPost.value = false;
    createPostController.deleteImageIdList.clear();
    createPostController.imageIdList.clear();
    createPostController.isSharingPost.value = false;
    createPostController.taggedFriends.clear();
    createPostController.tempTaggedFriends.clear();
    createPostController.tempTagIndex.clear();
    createPostController.tagFriendList.clear();
    Get.find<FriendController>().friendList.clear();
    createPostController.isKidAdded.value = false;
    createPostController.selectedKid.value = null;
    createPostController.postSecondaryCircleAvatar.value = '';
    createPostController.postSecondaryLocalCirclerAvatar.value = File('');
    createPostController.isMediaChanged.value = false;
    createPostController.mediaLinkList.clear();
    createPostController.mediaFileList.clear();
    createPostController.isCreatePostImageChanged.value = false;
    createPostController.createPostImageLink.value = "";
    createPostController.createPostImageFile.clear();
    createPostController.isCreatePostVideoChanged.value = false;
    createPostController.createPostVideoLink.value = "";
    createPostController.createPostVideoFile.clear();
    createPostController.allMediaList.clear();
    // createPostController.allMediaFileList.clear();
    createPostController.sellingAllMediaList.clear();
    createPostController.sellingAllMediaFileList.clear();
    createPostController.resetCreatePost();
    createPostController.selectedPlatform.value = "";
    createPostController.selectedProductCategory.value = '';
    createPostController.selectedProductCategoryID.value = '';
    createPostController.selectedProductCondition.value = '';
    createPostController.selectedProductConditionID.value = '';
    createPostController.tempCreatePostSelectedPrivacy.value = 'Public';
    createPostController.tempCreatePostSelectedPrivacyIcon.value = BipHip.world;
    createPostController.createPostSelectedPrivacyIcon.value = BipHip.world;
    createPostController.createPostSelectedPrivacy.value = 'Public';
    createPostController.privacyId.value = 1;
    createPostController.imageDescriptionTextEditingController.clear();
    createPostController.imageLocationsList.clear();
    createPostController.imageTimesList.clear();
    createPostController.imageTagIdList.clear();
    clearCreateSellingPostView();
  }

  void clearCreateSellingPostView() {
    createPostController.sellingAllMediaList.value = [];
    createPostController.biddingTitleTextEditingController.clear();
    createPostController.selectedProductCondition.value = '';
    createPostController.biddingPriceTextEditingController.clear();
    createPostController.biddingDesiredAmountTextEditingController.clear();
    createPostController.biddingDescriptionTextEditingController.clear();
    createPostController.biddingDiscountAmountTextEditingController.clear();
    createPostController.biddingMinimumBidTextEditingController.clear();
    createPostController.biddingProductTagTextEditingController.clear();
    createPostController.biddingSKUTextEditingController.clear();
    createPostController.sellingLocationTextEditingController.clear();
    createPostController.isHideFriendFamilySwitch.value = false;
    createPostController.selectedPlatform.value = '';
    createPostController.selectedAction.value = '';
    createPostController.kidID.value = -1;
    createPostController.categoryID.value = -1;
    createPostController.selectedBrandImage.value = '';
    createPostController.selectedBrandName.value = '';
    createPostController.temporarySellingPostType.value = '';
    createPostController.sellingPostType.value = '';
  }

  //----------------------------
  //! Create post bottom section
  //----------------------------

  IconData getBottomRowIcon(index) {
    switch (index) {
      case 1:
        return BipHip.photo;
      case 2:
        return BipHip.camera;
      case 3:
        return BipHip.video;
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

  void configImageDescription() {
    for (int i = 0; i < createPostController.mediaFileList.length; i++) {
      createPostController.imageDescriptionTextEditingController.add(TextEditingController());
      createPostController.imageLocationsList.add("LOC$i");
      createPostController.imageTimesList.add(DateTime.now().toString());
      createPostController.imageTagIdList.add('1,58');
    }
  }

  void getBottomRowOnPressed(index, [context]) async {
    ll(index);
    if (index == 1) {
      var status = await globalController.selectMultiMediaSource(
          createPostController.isMediaChanged, createPostController.mediaLinkList, createPostController.mediaFileList);
      if (status) {
        ll("media list length : ${createPostController.mediaLinkList.length}");
        insertMedia(createPostController.mediaLinkList, createPostController.mediaFileList);
        configImageDescription();
        checkCanCreatePost();
        createPostController.isMediaChanged.value = false;
        createPostController.mediaLinkList.clear();
        createPostController.mediaFileList.clear();
      }
    } else if (index == 2) {
      var status = await globalController.selectImageSource(createPostController.isCreatePostImageChanged, createPostController.createPostImageLink,
          createPostController.createPostImageFile, 'camera', false, true);
      if (status) {
        insertMedia([createPostController.createPostImageLink], createPostController.createPostImageFile);
        configImageDescription();
        checkCanCreatePost();
        createPostController.isCreatePostImageChanged.value = false;
        createPostController.createPostImageLink.value = "";
        createPostController.createPostImageFile.clear();
      }
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
      createPostController.tempTaggedFriends.addAll(createPostController.taggedFriends);
      if (createPostController.tempTaggedFriends.isNotEmpty) {
        createPostController.tagFriendButtonSheetRightButtonState.value = true;
      } else {
        createPostController.tagFriendButtonSheetRightButtonState.value = false;
      }
      globalController.commonBottomSheet(
        isBottomSheetRightButtonActive: createPostController.tagFriendButtonSheetRightButtonState,
        isDismissible: false,
        isScrollControlled: true,
        bottomSheetHeight: height * .9,
        context: context,
        isSearchShow: true,
        content: TagPeopleBottomSheetContent(),
        onPressCloseButton: () {
          createPostController.taggedFriends.clear();
          createPostController.taggedFriends.addAll(createPostController.tempTaggedFriends);
          createPostController.tempTaggedFriends.clear();
          createPostController.tagFriendButtonSheetRightButtonState.value = false;
          Get.back();
        },
        onPressRightButton: () {
          createPostController.taggedFriends.clear();
          createPostController.taggedFriends.addAll(createPostController.tempTaggedFriends);
          createPostController.tempTaggedFriends.clear();
          createPostController.tagFriendButtonSheetRightButtonState.value = false;
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksTagPeople.tr,
        isRightButtonShow: true,
      );
      if (Get.find<FriendController>().friendList.isEmpty) {
        await Get.find<FriendController>().getFriendList();
        createPostController.tagFriendList.addAll(Get.find<FriendController>().friendList);
      } else {
        for (int i = 0; i < createPostController.tempTaggedFriends.length; i++) {
          createPostController.tagFriendList.remove(createPostController.tempTaggedFriends);
        }
        Get.find<FriendController>().isFriendListLoading.value = false;
      }
    }
  }

  void insertMedia(mediaLink, mediaFile) {
    createPostController.allMediaList.addAll(mediaFile);
    // createPostController.allMediaFileList.addAll(mediaFile);
  }

  void insertSellingMedia(mediaLink, mediaFile) {
    createPostController.sellingAllMediaList.addAll(mediaFile);
    createPostController.sellingAllMediaFileList.addAll(mediaFile);
  }

  void removeSellingMedia(index) {
    createPostController.sellingAllMediaList.removeAt(index);
    createPostController.sellingAllMediaFileList.removeAt(index);
    // if (createPostController.allMediaFileList.isEmpty || createPostController.allMediaList.isEmpty) {
    //   Get.back();
    // }
  }
  //------------------------------
  //! important:: create post bottom option functions end
  //------------------------------

  void sellingPostTypeSelect() {
    if (createPostController.temporarySellingPostType.value == '') {
      createPostController.sellingPostTypeBottomSheetRightButtonState.value = false;
      createPostController.isRegularPost.value = false;
      createPostController.isBiddingPost.value = false;
    } else {
      createPostController.sellingPostTypeBottomSheetRightButtonState.value = true;
      if (createPostController.temporarySellingPostType.value == 'Regular Post') {
        createPostController.isRegularPost.value = true;
      } else {
        createPostController.isBiddingPost.value = true;
      }
    }
  }

  bool checkTodayDate(date) {
    if (date != '') {
      DateTime parsedDate = DateTime.parse(date);
      DateTime now = DateTime.now();
      bool isToday = parsedDate.year == now.year && parsedDate.month == now.month && parsedDate.day == now.day;
      return isToday;
    } else {
      return true;
    }
  }

  DateTime parseTimeToday(timeStr) {
    DateTime now = DateTime.now();
    String month = "";
    String day = "";
    if (now.day < 10) {
      day = "0${now.day}";
    } else {
      day = "${now.day}";
    }
    if (now.month < 10) {
      month = "0${now.month}";
    } else {
      month = "${now.month}";
    }
    String dateStr = "${now.year}-$month-$day";
    String fullDateTimeStr = "$dateStr $timeStr:00";
    ll(fullDateTimeStr);
    return DateTime.parse(fullDateTimeStr);
  }

  void selectStartDate(context) {
    createPostController.tempBiddingStartDate.value = '';
    if (createPostController.tempBiddingStartDate.value == '') {
      createPostController.biddingStartDateBottomSheetRightButtonState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: createPostController.biddingStartDateBottomSheetRightButtonState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        createPostController.biddingStartDate.value = createPostController.tempBiddingStartDate.value;
        if (createPostController.biddingEndDate.value != '') {
          if (DateTime.parse(createPostController.biddingStartDate.value).isAfter(DateTime.parse(createPostController.biddingEndDate.value))) {
            createPostController.biddingEndDate.value = '';
            createPostController.biddingEndTime.value = '';
          }
        }
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksStartDate,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          minimumDate: DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now())),
          maximumDate: DateTime.now().add(const Duration(days: 15 * 365)),
          initialDateTime: createPostController.biddingStartDate.value != ''
              ? DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.parse(createPostController.biddingStartDate.value)))
              : DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            createPostController.biddingStartDateBottomSheetRightButtonState.value = true;
            createPostController.tempBiddingStartDate.value = DateFormat("yyyy-MM-dd").format(value);
          },
        ),
      ),
    );
  }

  void selectEndDate(context) {
    createPostController.tempBiddingEndDate.value = '';
    if (createPostController.tempBiddingEndDate.value == '') {
      createPostController.biddingEndDateBottomSheetRightButtonState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: createPostController.biddingEndDateBottomSheetRightButtonState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        createPostController.biddingEndDate.value = createPostController.tempBiddingEndDate.value;
        createPostController.biddingEndTime.value = '';
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksEndDate,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          minimumDate: DateTime.parse(createPostController.biddingStartDate.value),
          maximumDate: DateTime.parse(createPostController.biddingStartDate.value).add(const Duration(days: 15 * 365)),
          initialDateTime: createPostController.biddingEndDate.value != ''
              ? DateTime.parse(createPostController.biddingEndDate.value)
              : DateTime.parse(createPostController.biddingStartDate.value),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            createPostController.biddingEndDateBottomSheetRightButtonState.value = true;
            createPostController.tempBiddingEndDate.value = DateFormat("yyyy-MM-dd").format(value);
          },
        ),
      ),
    );
  }

  void selectStartTime(context) {
    createPostController.tempBiddingStartTime.value = '';
    if (createPostController.tempBiddingStartTime.value == '') {
      createPostController.biddingStartTimeBottomSheetRightButtonState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: createPostController.biddingStartTimeBottomSheetRightButtonState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (checkTodayDate(createPostController.biddingStartDate.value)) {
          if (parseTimeToday(createPostController.tempBiddingStartTime.value).isBefore(DateTime.now())) {
            globalController.showSnackBar(title: ksWarning.tr, message: ksPastTimeIsNotAllowed.tr, color: cRedColor);
          } else {
            Get.back();
            createPostController.biddingStartTime.value = createPostController.tempBiddingStartTime.value;
          }
        } else {
          Get.back();
          createPostController.biddingStartTime.value = createPostController.tempBiddingStartTime.value;
        }
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksStartDate,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          initialDateTime: createPostController.biddingStartTime.value != ''
              ? DateTime.parse("${createPostController.biddingStartDate} ${createPostController.biddingStartTime.value}")
              : DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (value) {
            createPostController.biddingStartTimeBottomSheetRightButtonState.value = true;
            createPostController.tempBiddingStartTime.value = DateFormat("HH:mm").format(value);
          },
        ),
      ),
    );
  }

  void selectEndTime(context) {
    createPostController.tempBiddingEndTime.value = '';
    if (createPostController.tempBiddingStartTime.value == '') {
      createPostController.biddingEndTimeBottomSheetRightButtonState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: createPostController.biddingEndTimeBottomSheetRightButtonState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        if (checkTodayDate(createPostController.biddingEndDate.value)) {
          if (parseTimeToday(createPostController.tempBiddingStartTime.value).isAfter(parseTimeToday(createPostController.tempBiddingEndTime.value))) {
            globalController.showSnackBar(title: ksWarning.tr, message: ksPastTimeIsNotAllowed.tr, color: cRedColor);
          } else {
            Get.back();
            createPostController.biddingEndTime.value = createPostController.tempBiddingEndTime.value;
          }
        } else if (createPostController.biddingStartDate.value == createPostController.biddingEndDate.value) {
          if (parseTimeToday(createPostController.tempBiddingStartTime.value).isAfter(parseTimeToday(createPostController.tempBiddingEndTime.value))) {
            globalController.showSnackBar(title: ksWarning.tr, message: ksPastTimeIsNotAllowed.tr, color: cRedColor);
          } else {
            Get.back();
            createPostController.biddingEndTime.value = createPostController.tempBiddingEndTime.value;
          }
        } else {
          Get.back();
          createPostController.biddingEndTime.value = createPostController.tempBiddingEndTime.value;
        }
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: ksStartDate,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          initialDateTime: createPostController.biddingEndTime.value != ''
              ? DateTime.parse("${createPostController.biddingEndDate} ${createPostController.biddingEndTime.value}")
              : DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (value) {
            createPostController.biddingEndTimeBottomSheetRightButtonState.value = true;
            createPostController.tempBiddingEndTime.value = DateFormat("HH:mm").format(value);
          },
        ),
      ),
    );
  }

  //Get tagged friend bottom sheet
  Future<void> taggedFriendBottomSheet(context) async {
    Get.find<FriendController>().isFriendListLoading.value = true;
    createPostController.tempTaggedFriends.addAll(createPostController.taggedFriends);
    if (createPostController.tempTaggedFriends.isNotEmpty) {
      createPostController.tagFriendButtonSheetRightButtonState.value = true;
    } else {
      createPostController.tagFriendButtonSheetRightButtonState.value = false;
    }
    globalController.commonBottomSheet(
      isBottomSheetRightButtonActive: createPostController.tagFriendButtonSheetRightButtonState,
      isScrollControlled: true,
      bottomSheetHeight: height * .9,
      context: context,
      isSearchShow: true,
      content: TagPeopleBottomSheetContent(),
      isDismissible: false,
      onPressCloseButton: () {
        createPostController.taggedFriends.clear();
        createPostController.taggedFriends.addAll(createPostController.tempTaggedFriends);
        createPostController.tempTaggedFriends.clear();
        createPostController.tagFriendButtonSheetRightButtonState.value = false;
        Get.back();
      },
      onPressRightButton: () {
        createPostController.taggedFriends.clear();
        createPostController.taggedFriends.addAll(createPostController.tempTaggedFriends);
        createPostController.tempTaggedFriends.clear();
        createPostController.tagFriendButtonSheetRightButtonState.value = false;
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksTagPeople.tr,
      isRightButtonShow: true,
    );
    if (Get.find<FriendController>().friendList.isEmpty) {
      await Get.find<FriendController>().getFriendList();
      createPostController.tagFriendList.addAll(Get.find<FriendController>().friendList);
    } else {
      for (int i = 0; i < createPostController.tempTaggedFriends.length; i++) {
        createPostController.tagFriendList.remove(createPostController.tempTaggedFriends);
      }
      Get.find<FriendController>().isFriendListLoading.value = false;
    }
  }

  void removeImage(index) {
    if (createPostController.allMediaList[index] is String) {
      createPostController.allMediaList.removeAt(index);
      createPostController.deleteImageIdList.add(createPostController.imageIdList.removeAt(index));
    } else {
      createPostController.allMediaList.removeAt(index);
      // createPostController.allMediaFileList.removeAt(index);
    }
  }
}

//*Newly added for boost post popup show
void boostPostAlertDialog({required BuildContext context, required Widget content, required String title}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
      title: title,
      actions: [
        CustomElevatedButton(
          label: ksYes.tr,
          onPressed: () {
            Get.back();
          },
          buttonWidth: width - 70,
          buttonHeight: 40,
          textStyle: semiBold14TextStyle(cWhiteColor),
          buttonColor: cPrimaryColor,
        ),
        kH12sizedBox,
        CustomElevatedButton(
          label: ksNo.tr,
          onPressed: () {
            Get.back();
          },
          buttonWidth: width - 70,
          buttonHeight: 40,
          textStyle: semiBold14TextStyle(cPrimaryColor),
          buttonColor: cWhiteColor,
          borderColor: cLineColor2,
        ),
        kH8sizedBox,
      ],
    ),
  );
}
