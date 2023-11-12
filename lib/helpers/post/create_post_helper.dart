import 'dart:io';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/add_brand.dart';
import 'package:bip_hip/views/post/add_kid.dart';
import 'package:bip_hip/views/post/select_category.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

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

  void selectBrandStatusChange(index) {
    for (int i = 0; i < createPostController.selectedBrandStatusList.length; i++) {
      if (index == i) {
        createPostController.selectedBrandStatusList[i] = true;
      } else {
        createPostController.selectedBrandStatusList[i] = false;
      }
    }
  }

  void postButtonStateCheck() {
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
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${ksWhoCanSeeYourPost.tr}?",
            style: semiBold16TextStyle(cBlackColor),
          ),
          kH8sizedBox,
          Text(
            ksAudienceInformation.tr,
            style: regular14TextStyle(cBlackColor),
          ),
          kH8sizedBox,
          for (int i = 1; i <= 3; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == 3 ? 0.0 : 8.0),
              child: Obx(
                () => CustomListTile(
                  onPressed: () {
                    selectAudienceStatusChange(i - 1);
                  },
                  itemColor: createPostController.audienceStatusList[i - 1] ? cPrimaryTint3Color : cWhiteColor,
                  title: createPostController.audienceTypeList[i - 1]['title'],
                  subtitle: createPostController.audienceTypeList[i - 1]['subtitle'],
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      createPostController.audienceTypeList[i - 1]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      selectAudienceStatusChange(i - 1);
                    },
                    isSelected: createPostController.audienceStatusList[i - 1],
                  ),
                ),
              ),
            ),
        ],
      ),
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

  void selectPlatformTextChange(context) {
    for (int i = 0; i < createPostController.platformList.length; i++) {
      if (createPostController.platformStatusList[i]) {
        // categoryID.value = categoryList[i]['id'];
        // category.value = categoryList[i]['title'];
        // categoryIcon.value = categoryList[i]['icon'];
        // categoryIconColor.value = categoryList[i]['icon_color'];
        break;
      }
    }
    // ll(categoryID);
    Get.back();
  }

  void initializePlatform() {
    for (int i = 0; i < createPostController.platformList.length; i++) {
      if (createPostController.platformList[i]['title'] == createPostController.category.value) {
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

  void initializeAction() {
    for (int i = 0; i < createPostController.actionList.length; i++) {
      if (createPostController.actionList[i]['title'] == createPostController.category.value) {
        createPostController.actionStatusList[i] = true;
      } else {
        createPostController.actionStatusList[i] = false;
      }
    }
  }

  void selectKidStatusChange(index) {
    for (int i = 0; i < createPostController.selectedKidStatusList.length; i++) {
      if (index == i) {
        createPostController.selectedKidStatusList[i] = true;
      } else {
        createPostController.selectedKidStatusList[i] = false;
      }
    }
  }

  void selectBrandTextChange() {
    for (int i = 0; i < createPostController.brandList.length; i++) {
      if (createPostController.selectedBrandStatusList[i]) {
        createPostController.selectedBrandName.value = createPostController.brandList[i]['name'];
        createPostController.selectedBrandImage.value = createPostController.brandList[i]['image_url'];
        break;
      }
    }
  }

  void initializeBrandText() {
    for (int i = 0; i < createPostController.selectedBrandStatusList.length; i++) {
      if (createPostController.brandList[i]['name'] == createPostController.selectedBrandName.value) {
        createPostController.selectedBrandStatusList[i] = true;
      } else {
        createPostController.selectedBrandStatusList[i] = false;
      }
    }
  }

  void resetCategoryData() {
    createPostController.category.value = "";
    createPostController.categoryIcon.value = null;
    createPostController.categoryIconColor.value = null;
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
  }

  void removeMedia(index) {
    createPostController.allMediaList.removeAt(index);
    createPostController.allMediaFileList.removeAt(index);
    if (createPostController.allMediaFileList.isEmpty || createPostController.allMediaList.isEmpty) {
      Get.back();
    }
  }

  void selectCategoryTextChange(context) {
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
        content: Obx(() => Column(
              children: [
                kH8sizedBox,
                if (createPostController.selectedKid.value == null)
                  OutLinedButton(
                    buttonHeight: isDeviceScreenLarge() ? 45 : 40,
                    borderRadius: k8CircularBorderRadius,
                    onPress: !createPostController.isKidAdded.value
                        ? () async {
                            createPostController.isKidListLoading.value = true;
                            createPostController.tempSelectedKid.value = null;
                            createPostController.kidID.value = -1;
                            if (createPostController.tempSelectedKid.value == null) {
                              globalController.isBottomSheetRightButtonActive.value = false;
                            } else {
                              globalController.isBottomSheetRightButtonActive.value = true;
                            }
                            globalController.commonBottomSheet(
                              isScrollControlled: true,
                              bottomSheetHeight: height * .7,
                              context: context,
                              content: Obx(() => createPostController.isKidListLoading.value
                                  ? const KidListShimmer()
                                  : Column(
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) => kH8sizedBox,
                                          itemCount: createPostController.kidList.length,
                                          itemBuilder: (context, i) {
                                            return Obx(
                                              () => CustomListTile(
                                                onPressed: () {
                                                  createPostController.kidID.value = createPostController.kidList[i].id!;
                                                  createPostController.tempSelectedKid.value = createPostController.kidList[i];
                                                  if (createPostController.tempSelectedKid.value == null) {
                                                    globalController.isBottomSheetRightButtonActive.value = false;
                                                  } else {
                                                    globalController.isBottomSheetRightButtonActive.value = true;
                                                  }
                                                },
                                                itemColor:
                                                    createPostController.kidID.value == createPostController.kidList[i].id! ? cPrimaryTint3Color : cWhiteColor,
                                                borderColor:
                                                    createPostController.kidID.value == createPostController.kidList[i].id! ? cPrimaryColor : cLineColor,
                                                title: createPostController.kidList[i].name,
                                                leading: Container(
                                                  height: h24,
                                                  width: h24,
                                                  decoration: const BoxDecoration(
                                                    color: cWhiteColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      Environment.imageBaseUrl + createPostController.kidList[i].kidImage,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                                        BipHip.imageFile,
                                                        size: kIconSize120,
                                                        color: cIconColor,
                                                      ),
                                                      // loadingBuilder: imageLoadingBuilder,
                                                    ),
                                                  ),
                                                ),
                                                trailing: CustomRadioButton(
                                                  onChanged: () {
                                                    // selectKidStatusChange(i);
                                                    createPostController.kidID.value = createPostController.kidList[i].id!;
                                                    createPostController.tempSelectedKid.value = createPostController.kidList[i];
                                                    if (createPostController.tempSelectedKid.value == null) {
                                                      globalController.isBottomSheetRightButtonActive.value = false;
                                                    } else {
                                                      globalController.isBottomSheetRightButtonActive.value = true;
                                                    }
                                                  },
                                                  isSelected: createPostController.kidID.value == createPostController.kidList[i].id!,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                createPostController.selectedKid.value = createPostController.tempSelectedKid.value;
                                Get.back();
                                createPostController.tempSelectedKid.value = null;
                                if (createPostController.selectedKid.value == null || createPostController.isKidAdded.value) {
                                  globalController.isBottomSheetRightButtonActive.value = false;
                                } else {
                                  globalController.isBottomSheetRightButtonActive.value = true;
                                }
                              },
                              rightText: ksDone.tr,
                              rightTextStyle: medium14TextStyle(cPrimaryColor),
                              title: ksSelectKids.tr,
                              isRightButtonShow: true,
                            );
                            await createPostController.getKidList();
                          }
                        : null,
                    buttonText: ksSelectKids.tr,
                    buttonTextStyle: !createPostController.isKidAdded.value ? medium16TextStyle(cBlackColor) : medium16TextStyle(cLineColor2),
                    borderColor: cLineColor,
                    widget: Icon(
                      BipHip.downArrowOutline,
                      color: !createPostController.isKidAdded.value ? cBlackColor : cLineColor2,
                      size: isDeviceScreenLarge() ? h20 : h16,
                    ),
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                if (createPostController.selectedKid.value != null)
                  CustomListTile(
                    borderColor: cPrimaryColor,
                    itemColor: cPrimaryTint3Color,
                    leading: Container(
                      height: h24,
                      width: h24,
                      decoration: const BoxDecoration(
                        color: cWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          Environment.imageBaseUrl + createPostController.selectedKid.value!.kidImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.imageFile,
                            size: kIconSize120,
                            color: cIconColor,
                          ),
                          // loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                    ),
                    title: Text(
                      createPostController.selectedKid.value!.name!,
                      style: medium14TextStyle(cBlackColor),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        createPostController.selectedKid.value = null;
                        if (createPostController.selectedKid.value == null || createPostController.isKidAdded.value) {
                          globalController.isBottomSheetRightButtonActive.value = false;
                        } else {
                          globalController.isBottomSheetRightButtonActive.value = true;
                        }
                      },
                      child: const Icon(
                        BipHip.cross,
                        color: cRedColor,
                      ),
                    ),
                  ),
                // kH12sizedBox,
                // OutLinedButton(
                //   onPress: () {},
                //   buttonText: "Maria Jones",
                //   buttonTextStyle: medium16TextStyle(cBlackColor),
                //   borderColor: cPrimaryColor,
                //   buttonColor: cPrimaryTint3Color,
                //   widget: Icon(
                //     BipHip.circleCrossNew,
                //     color: cRedColor,
                //     size: isDeviceScreenLarge() ? h20 : h18,
                //   ),
                //   backgroundImage: const NetworkImage("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg"),
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ),
                kH12sizedBox,
                Text(
                  ksOr.tr,
                  style: regular16TextStyle(cPlaceHolderColor),
                ),
                kH12sizedBox,
                if (!createPostController.isKidAdded.value)
                  OutLinedButton(
                    buttonHeight: isDeviceScreenLarge() ? 45 : 40,
                    borderRadius: k8CircularBorderRadius,
                    onPress: createPostController.selectedKid.value == null
                        ? () {
                            resetAddKidPage();
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => AddKidPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          }
                        : null,
                    buttonText: ksAddKid.tr,
                    buttonTextStyle: createPostController.selectedKid.value == null ? medium16TextStyle(cPrimaryColor) : medium16TextStyle(cLineColor2),
                    borderColor: createPostController.selectedKid.value == null ? cPrimaryColor : cLineColor2,
                    widget: Icon(
                      BipHip.plus,
                      color: createPostController.selectedKid.value == null ? cPrimaryColor : cLineColor2,
                      size: isDeviceScreenLarge() ? h20 : h16,
                    ),
                  ),
                if (createPostController.isKidAdded.value)
                  CustomListTile(
                    borderColor: cPrimaryColor,
                    itemColor: cPrimaryTint3Color,
                    leading: Container(
                      height: h24,
                      width: h24,
                      decoration: const BoxDecoration(
                        color: cWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.file(
                          createPostController.kidImageFile.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      createPostController.kidNameTextEditingController.text,
                      style: medium14TextStyle(cBlackColor),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        resetAddKidPage();
                        if (createPostController.selectedKid.value == null || createPostController.isKidAdded.value) {
                          globalController.isBottomSheetRightButtonActive.value = false;
                        } else {
                          globalController.isBottomSheetRightButtonActive.value = true;
                        }
                      },
                      child: const Icon(
                        BipHip.cross,
                        color: cRedColor,
                      ),
                    ),
                  ),
                kH8sizedBox,
                Text(
                  "*${ksCustomAddInstruction.tr}",
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
              ],
            )),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          if (createPostController.selectedKid.value != null) {
            createPostController.postSecondaryCircleAvatar.value = createPostController.selectedKid.value!.kidImage;
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
    } else if (createPostController.category.value == "Selling") {
      globalController.commonBottomSheet(
        context: context,
        content: Column(
          children: [
            kH8sizedBox,
            OutLinedButton(
              onPress: () {
                globalController.commonBottomSheet(
                  isScrollControlled: true,
                  bottomSheetHeight: height * .7,
                  context: context,
                  content: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => kH8sizedBox,
                        itemCount: createPostController.brandList.length,
                        itemBuilder: (context, i) {
                          return Obx(
                            () => CustomListTile(
                              onPressed: () {
                                selectBrandStatusChange(i);
                              },
                              itemColor: createPostController.selectedBrandStatusList[i] ? cPrimaryTint3Color : cWhiteColor,
                              borderColor: createPostController.selectedBrandStatusList[i] ? cPrimaryColor : cLineColor,
                              title: createPostController.brandList[i]['name'],
                              leading: CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(createPostController.brandList[i]['image_url']),
                              ),
                              trailing: CustomRadioButton(
                                onChanged: () {
                                  selectBrandStatusChange(i);
                                },
                                isSelected: createPostController.selectedBrandStatusList[i],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: () {
                    Get.back();
                  },
                  rightText: ksDone.tr,
                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                  title: ksSelectBrands.tr,
                  isRightButtonShow: true,
                );
              },
              buttonText: ksSelectSavedBrands.tr,
              buttonTextStyle: medium16TextStyle(cBlackColor),
              borderColor: cLineColor,
              widget: Icon(
                BipHip.downArrowOutline,
                color: cBlackColor,
                size: isDeviceScreenLarge() ? h20 : h16,
              ),
            ),
            // kH12sizedBox,
            // OutLinedButton(
            //   onPress: () {},
            //   buttonText: "Maria Jones",
            //   buttonTextStyle: medium16TextStyle(cBlackColor),
            //   borderColor: cPrimaryColor,
            //   buttonColor: cPrimaryTint3Color,
            //   widget: Icon(
            //     BipHip.circleCrossNew,
            //     color: cRedColor,
            //     size: isDeviceScreenLarge() ? h20 : h18,
            //   ),
            //   backgroundImage: const NetworkImage("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg"),
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ),
            kH12sizedBox,
            Text(
              ksOr.tr,
              style: regular16TextStyle(cPlaceHolderColor),
            ),
            kH12sizedBox,
            OutLinedButton(
              onPress: () {
                Get.to(() => AddBrandPage());
              },
              buttonText: ksAddBrand.tr,
              buttonTextStyle: medium16TextStyle(cPrimaryColor),
              borderColor: cPrimaryColor,
              widget: Icon(
                BipHip.plus,
                color: cPrimaryColor,
                size: isDeviceScreenLarge() ? h20 : h16,
              ),
            ),
            kH8sizedBox,
            Text(
              "*${ksAddBrandInstruction.tr}",
              style: regular14TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksBrands.tr,
        isRightButtonShow: true,
      );
    } else if (createPostController.category.value == "News") {
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

  void resetData() {
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
    createPostController.resetCreatePost();
  }

  //----------------------------
  //! Create post bottom section
  //----------------------------

  IconData getBottomRowIcon(index) {
    if (index == 1) {
      return BipHip.photo;
    }
    if (index == 2) {
      return BipHip.camera;
    }
    if (index == 3) {
      return BipHip.video;
    } else {
      return BipHip.tagFriends;
    }
  }

  Color getBottomIconColor(index) {
    if (index == 1) {
      return cGreenColor;
    }
    if (index == 2) {
      return cPrimaryColor;
    }
    if (index == 3) {
      return cRedColor;
    } else {
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
        content: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: k2Padding),
                child: Text(
                  ksSelected.tr,
                  style: semiBold14TextStyle(cBlackColor),
                ),
              ),
              kH8sizedBox,
              Container(
                color: cWhiteColor,
                height: 40,
                width: width,
                child: ListView.separated(
                  separatorBuilder: (context, index) => kW8sizedBox,
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(createPostController.tagFiendList[index]["image_url"]),
                        ),
                        Positioned(
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: cWhiteColor,
                            ),
                            child: const Icon(
                              BipHip.circleCrossNew,
                              size: 12,
                              color: cRedColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              kH12sizedBox,
              Padding(
                padding: const EdgeInsets.only(left: k2Padding),
                child: Text(
                  ksSuggestionAllCap.tr,
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
              ),
              kH8sizedBox,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: createPostController.tagFiendList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k10Padding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      child: TextButton(
                        style: kTextButtonStyle,
                        onPressed: () async {
                          // ll(index);
                        },
                        child: CustomListTile(
                          padding: const EdgeInsets.symmetric(horizontal: k0Padding, vertical: k4Padding),
                          // borderColor: cRedColor,
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(createPostController.tagFiendList[index]["image_url"]),
                          ),
                          title: createPostController.tagFiendList[index]["name"],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
  //------------------------------
  //! important:: create post bottom option functions end
  //------------------------------

  void addKid() async {
    if (createPostController.saveKidInfo.value) {
      await createPostController.addKid();
    } else {
      Get.back();
    }
    createPostController.isKidAdded.value = true;
    if (!createPostController.isKidAdded.value) {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      globalController.isBottomSheetRightButtonActive.value = true;
    }
  }
}
