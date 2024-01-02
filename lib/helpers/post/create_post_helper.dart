import 'dart:io';
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
    } else if (createPostController.category.value == 'Kid') {
      if (createPostController.createPostController.text.trim() != '' && createPostController.selectedKid.value != null) {
        createPostController.isPostButtonActive.value = true;
      } else {
        createPostController.isPostButtonActive.value = false;
      }
    } else {
      if (createPostController.createPostController.text.trim().isNotEmpty) {
        createPostController.isPostButtonActive.value = true;
        if (createPostController.createPostController.text.length > 150) {
          createPostController.isTextLimitCrossed.value = true;
        } else {
          createPostController.isTextLimitCrossed.value = false;
        }
      } else {
        createPostController.isPostButtonActive.value = false;
      }
    }
  }

  void selectAudienceStatusChange(index) {
    for (int i = 0; i < createPostController.audienceStatusList.length; i++) {
      if (index == i) {
        createPostController.audienceStatusList[i] = true;
      } else {
        createPostController.audienceStatusList[i] = false;
      }
    }
  }

  void selectAudienceTextChange() {
    for (int i = 0; i < createPostController.audienceTypeList.length; i++) {
      if (createPostController.audienceStatusList[i]) {
        createPostController.postType.value = createPostController.audienceTypeList[i]['title'];
        createPostController.postTypeIcon.value = createPostController.audienceTypeList[i]['icon'];
        break;
      }
    }
  }

  void initializeAudienceText() {
    for (int i = 0; i < createPostController.audienceStatusList.length; i++) {
      if (createPostController.audienceTypeList[i]['title'] == createPostController.postType.value) {
        createPostController.audienceStatusList[i] = true;
      } else {
        createPostController.audienceStatusList[i] = false;
      }
    }
  }

  void showAudienceSheet(context) {
    Get.find<GlobalController>().commonBottomSheet(
      bottomSheetHeight: height * .51,
      context: context,
      content: AudienceContent(),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        ll("message");
        selectAudienceTextChange();
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
      if (createPostController.tempSelectedBrandName.value == createPostController.storeList[i].name) {
        createPostController.selectedBrandName.value = createPostController.storeList[i].name.toString();
        createPostController.selectedBrandImage.value = Environment.imageBaseUrl + createPostController.storeList[i].image!.toString();
        break;
      }
    }
  }

  void selectProductConditionTextChange() {
    for (int i = 0; i < createPostController.productConditionList.length; i++) {
      if (createPostController.productConditionState[i]) {
        createPostController.selectedProductCondition.value = createPostController.productConditionList[i];
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
    createPostController.allMediaFileList.removeAt(index);
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
        globalController.isBottomSheetRightButtonActive.value = false;
      } else {
        globalController.isBottomSheetRightButtonActive.value = true;
      }
      globalController.commonBottomSheet(
        context: context,
        content: KidCategoryContent(),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          if (createPostController.selectedKid.value != null) {
            createPostController.postSecondaryCircleAvatar.value = createPostController.selectedKid.value!.kidImage;
            createPostController.kidID.value = createPostController.selectedKid.value!.id!;
            ll(createPostController.kidID.value);
          } else {
            createPostController.postSecondaryLocalCirclerAvatar.value = createPostController.kidImageFile.value;
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
      createPostController.sellingPostType.value = '';
      createPostController.isRegularPost.value = false;
      createPostController.isBiddingPost.value = false;
      globalController.isBottomSheetRightButtonActive.value = false;
      globalController.commonBottomSheet(
        context: context,
        bottomSheetHeight: isDeviceScreenLarge() ? height * .25 : height * 0.35,
        content: SellingCategoryBottomSheetContent(),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          createPostController.sellingPostType.value = createPostController.tempSellingPostType.value;
          createPostController.selectedBrandName.value = '';
          checkCanCreatePost();
          globalController.commonBottomSheet(
            context: context,
            bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
            content: BrandBottomSheetContent(),
            onPressCloseButton: () {
              Get.back();
            },
            onPressRightButton: () {
              // boostPostAlertDialog(context: context, title: ksBoostPost.tr, content: const BoostPostContent()); //* Set it temporary for test case
              for (int i = 0; i < createPostController.storeList.length; i++) {
                if (createPostController.selectedBrandName.value == createPostController.storeList[i].name) {
                  createPostController.brandID.value = createPostController.storeList[i].id!;
                  createPostController.selectedBrandImage.value = createPostController.storeList[i].brandImage!;
                }
              }
              createPostController.postSecondaryCircleAvatar.value = createPostController.selectedBrandImage.value;
              Get.back();
              Get.back();
              Get.back();
            },
            rightText: ksDone.tr,
            rightTextStyle: medium14TextStyle(cPrimaryColor),
            title: ksBrands.tr,
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
  }

  void resetCreatePostData() {
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
    createPostController.allMediaFileList.clear();
    createPostController.sellingAllMediaList.clear();
    createPostController.sellingAllMediaFileList.clear();
    createPostController.resetCreatePost();
    createPostController.selectedPlatform.value = "";
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
    createPostController.isHideFriendFamilySwitch.value = false;
    createPostController.selectedPlatform.value = '';
    createPostController.selectedAction.value = '';
    createPostController.kidID.value = -1;
    createPostController.categoryID.value = -1;
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

  void getBottomRowOnPressed(index, [context]) async {
    ll(index);
    if (index == 1) {
      var status = await globalController.selectMultiMediaSource(
          createPostController.isMediaChanged, createPostController.mediaLinkList, createPostController.mediaFileList);
      if (status) {
        ll("media list length : ${createPostController.mediaLinkList.length}");
        insertMedia(createPostController.mediaLinkList, createPostController.mediaFileList);
        createPostController.isMediaChanged.value = false;
        createPostController.mediaLinkList.clear();
        createPostController.mediaFileList.clear();
      }
    } else if (index == 2) {
      var status = await globalController.selectImageSource(createPostController.isCreatePostImageChanged, createPostController.createPostImageLink,
          createPostController.createPostImageFile, 'camera', false, true);
      if (status) {
        insertMedia([createPostController.createPostImageLink], createPostController.createPostImageFile);
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
      globalController.commonBottomSheet(
        isScrollControlled: true,
        bottomSheetHeight: height * .9,
        context: context,
        isSearchShow: true,
        content: TagPeopleBottomSheetContent(),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksTagPeople.tr,
        isRightButtonShow: true,
      );
    }
  }

  void insertMedia(mediaLink, mediaFile) {
    createPostController.allMediaList.addAll(mediaFile);
    createPostController.allMediaFileList.addAll(mediaFile);
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

  void addKid() async {
    ll(createPostController.saveKidInfo.value);
    if (createPostController.saveKidInfo.value) {
      await createPostController.addKid();
    } else {
      Get.back();
    }
    createPostController.isKidAdded.value = true;
    if (!createPostController.isKidAdded.value) {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      createPostController.postSecondaryLocalCirclerAvatar.value = createPostController.kidImageFile.value;
      globalController.isBottomSheetRightButtonActive.value = true;
    }
  }

  void regularSellingPostSelect() {
    createPostController.isRegularPost.value = true;
    createPostController.isBiddingPost.value = false;
    createPostController.tempSellingPostType.value = ksRegularPost.tr;
    if (createPostController.tempSellingPostType.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  void biddingSellingPostSelect() {
    createPostController.isRegularPost.value = false;
    createPostController.isBiddingPost.value = true;
    createPostController.tempSellingPostType.value = ksBiddingPost.tr;
    if (createPostController.tempSellingPostType.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  void sellingPostTypeSelect() {
    if (createPostController.tempSellingPostType.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
      createPostController.isRegularPost.value = false;
      createPostController.isBiddingPost.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
      if (createPostController.tempSellingPostType.value == 'Regular Post') {
        createPostController.isRegularPost.value = true;
      } else {
        createPostController.isBiddingPost.value = true;
      }
    }
  }

  //*Selected Condition for selling post change
  void selectConditionStatusChange(index) {
    for (int i = 0; i < createPostController.productConditionState.length; i++) {
      if (index == i) {
        createPostController.productConditionState[i] = true;
      } else {
        createPostController.productConditionState[i] = false;
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
    String dateStr = "${now.year}-${now.month}-${now.day}";
    String fullDateTimeStr = "$dateStr $timeStr";
    ll(fullDateTimeStr);
    return DateTime.parse(fullDateTimeStr);
  }

  void selectStartDate(context) {
    createPostController.tempBiddingStartDate.value = '';
    if (createPostController.tempBiddingStartDate.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    }
    globalController.commonBottomSheet(
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
            globalController.isBottomSheetRightButtonActive.value = true;
            createPostController.tempBiddingStartDate.value = DateFormat("yyyy-MM-dd").format(value);
          },
        ),
      ),
    );
  }

  void selectEndDate(context) {
    createPostController.tempBiddingEndDate.value = '';
    if (createPostController.tempBiddingEndDate.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    }
    globalController.commonBottomSheet(
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
            globalController.isBottomSheetRightButtonActive.value = true;
            createPostController.tempBiddingEndDate.value = DateFormat("yyyy-MM-dd").format(value);
          },
        ),
      ),
    );
  }

  void selectStartTime(context) {
    createPostController.tempBiddingStartTime.value = '';
    if (createPostController.tempBiddingStartTime.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    }
    globalController.commonBottomSheet(
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
            globalController.isBottomSheetRightButtonActive.value = true;
            createPostController.tempBiddingStartTime.value = DateFormat("HH:mm").format(value);
          },
        ),
      ),
    );
  }

  void selectEndTime(context) {
    createPostController.tempBiddingEndTime.value = '';
    if (createPostController.tempBiddingStartTime.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    }
    globalController.commonBottomSheet(
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
            globalController.isBottomSheetRightButtonActive.value = true;
            createPostController.tempBiddingEndTime.value = DateFormat("HH:mm").format(value);
          },
        ),
      ),
    );
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
