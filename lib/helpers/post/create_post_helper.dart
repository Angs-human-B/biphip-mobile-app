import 'dart:io';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';
import 'package:bip_hip/views/post/add_brand.dart';
import 'package:bip_hip/views/post/add_kid.dart';
import 'package:bip_hip/views/post/select_category.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
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

  void selectBrandStatusChange(index) {
    for (int i = 0; i < createPostController.selectedBrandStatusList.length; i++) {
      if (index == i) {
        createPostController.selectedBrandStatusList[i] = true;
      } else {
        createPostController.selectedBrandStatusList[i] = false;
      }
    }
  }

  void checkCanCreatePost() {
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

  void selectProductConditionTextChange() {
    for (int i = 0; i < createPostController.productConditionList.length; i++) {
      if (createPostController.productConditionState[i]) {
        createPostController.selectedProductCondition.value = createPostController.productConditionList[i];
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
        content: Obx(() => Column(
              children: [
                kH8sizedBox,
                if (createPostController.selectedKid.value == null && !createPostController.isKidAdded.value)
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
                // if (!createPostController.isKidAdded.value)
                OutLinedButton(
                  buttonHeight: isDeviceScreenLarge() ? 45 : 40,
                  borderRadius: k8CircularBorderRadius,
                  onPress: (createPostController.selectedKid.value == null && !createPostController.isKidAdded.value)
                      ? () {
                          resetAddKidPage();
                          globalController.commonBottomSheet(
                              bottomSheetHeight: height * 0.9,
                              isScrollControlled: true,
                              context: context,
                              content: AddKidContent(),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                addKid();
                              },
                              rightText: ksDone.tr,
                              rightTextStyle: medium14TextStyle(cPrimaryColor),
                              title: ksAddKid.tr,
                              isRightButtonShow: true);
                        }
                      : null,
                  buttonText: ksAddKid.tr,
                  buttonTextStyle: (createPostController.selectedKid.value == null && !createPostController.isKidAdded.value)
                      ? medium16TextStyle(cPrimaryColor)
                      : medium16TextStyle(cLineColor2),
                  borderColor: (createPostController.selectedKid.value == null && !createPostController.isKidAdded.value) ? cPrimaryColor : cLineColor2,
                  widget: Icon(
                    BipHip.plus,
                    color: (createPostController.selectedKid.value == null && !createPostController.isKidAdded.value) ? cPrimaryColor : cLineColor2,
                    size: isDeviceScreenLarge() ? h20 : h16,
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
        content: Column(
          children: [
            Obx(() => OutLinedButton(
                  onPress: () {
                    createPostController.isRegularPost.value = true;
                    createPostController.isBiddingPost.value = false;
                    createPostController.sellingPostType.value = ksRegularPost.tr;
                    globalController.isBottomSheetRightButtonActive.value = true;
                  },
                  suffixWidget: Padding(
                    padding: const EdgeInsets.only(right: k8Padding),
                    child: Stack(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: k100CircularBorderRadius,
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: [
                                cBlueLinearColor1,
                                cBlueLinearColor2,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 7,
                          bottom: 7,
                          child: SvgPicture.asset(
                            kiRegularPostSvgUrl,
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonText: ksRegularPost.tr,
                  buttonTextStyle: medium16TextStyle(cBlackColor),
                  borderColor: createPostController.isRegularPost.value ? cPrimaryColor : cLineColor,
                  buttonColor: createPostController.isRegularPost.value ? cPrimaryTint2Color : cWhiteColor,
                )),
            kH16sizedBox,
            Obx(() => OutLinedButton(
                  onPress: () {
                    createPostController.isRegularPost.value = false;
                    createPostController.isBiddingPost.value = true;
                    createPostController.sellingPostType.value = ksBiddingPost.tr;
                    globalController.isBottomSheetRightButtonActive.value = true;
                  },
                  suffixWidget: Padding(
                    padding: const EdgeInsets.only(right: k8Padding),
                    child: Stack(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: k100CircularBorderRadius,
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: [
                                cYellowLinearColor1,
                                cYellowLinearColor2,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 7,
                          bottom: 7,
                          child: SvgPicture.asset(
                            kiBiddingPostSvgUrl,
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonText: ksBiddingPost.tr,
                  buttonTextStyle: medium16TextStyle(cBlackColor),
                  borderColor: createPostController.isBiddingPost.value ? cPrimaryColor : cLineColor,
                  buttonColor: createPostController.isBiddingPost.value ? cPrimaryTint2Color : cWhiteColor,
                )),
          ],
        ),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          createPostController.sellingPostType.value;
          globalController.commonBottomSheet(
            context: context,
            bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
            content: Obx(() => Column(
                  children: [
                    kH8sizedBox,
                    if (createPostController.selectedBrandName.value != '')
                      Container(
                        width: width - 40,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: k4CircularBorderRadius,
                          color: cPrimaryTint2Color,
                          border: Border.all(
                            color: cPrimaryColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(k8Padding),
                              child: createPostController.isBrandAdded.value
                                  ? ClipOval(
                                      child: Container(
                                          width: h24,
                                          height: h24,
                                          decoration: const BoxDecoration(shape: BoxShape.circle),
                                          child: Image.file(createPostController.selectedBrandImageFile.value)))
                                  : CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(createPostController.selectedBrandImage.value.toString()),
                                    ),
                            ),
                            Text(
                              createPostController.selectedBrandName.value.toString(),
                              style: semiBold14TextStyle(cBlackColor),
                            ),
                            const Spacer(),
                            CustomIconButton(
                              onPress: () {
                                createPostController.selectedBrandName.value = '';
                                createPostController.selectedBrandImage.value = '';
                                createPostController.isBrandAdded.value = false;
                                createPostController.selectedBrandStatusList.value = [false, false, false, false, false, false, false, false, false];
                              },
                              icon: BipHip.cross,
                              iconColor: cRedColor,
                              size: kIconSize20,
                            ),
                          ],
                        ),
                      ),
                    // OutLinedButton(
                    //   buttonText: createPostController.selectedBrandName.value.toString(),
                    //   buttonTextStyle: semiBold14TextStyle(cBlackColor),
                    //   suffixWidget: CircleAvatar(
                    //     radius: 12,
                    //     backgroundImage: AssetImage(createPostController.selectedBrandImage.toString()),
                    //   ),
                    //   widget: const Icon(
                    //     BipHip.cross,
                    //     color: cRedColor,
                    //   ),
                    //   onPress: () {},
                    //   borderColor: cLineColor2,
                    // ),
                    if (createPostController.selectedBrandName.value == '')
                      OutLinedButton(
                        onPress: () async {
                          globalController.commonBottomSheet(
                            isScrollControlled: true,
                            bottomSheetHeight: height * 0.6,
                            context: context,
                            content: Obx(
                              () => createPostController.isStoreListLoading.value
                                  ? const KidListShimmer()
                                  : Column(
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) => kH8sizedBox,
                                          itemCount: createPostController.storeList.length,
                                          itemBuilder: (context, i) {
                                            return CustomListTile(
                                              onPressed: () {
                                                selectBrandStatusChange(i);
                                              },
                                              itemColor: createPostController.selectedBrandStatusList[i] ? cPrimaryTint3Color : cWhiteColor,
                                              borderColor: createPostController.selectedBrandStatusList[i] ? cPrimaryColor : cLineColor,
                                              title: createPostController.storeList[i].name,
                                              leading: Container(
                                                height: h24,
                                                width: h24,
                                                decoration: const BoxDecoration(
                                                  color: cWhiteColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: Image.network(
                                                    Environment.imageBaseUrl + createPostController.storeList[i].image!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                                      BipHip.imageFile,
                                                      // size: kIconSize20,
                                                      color: cIconColor,
                                                    ),
                                                    // loadingBuilder: imageLoadingBuilder,
                                                  ),
                                                ),
                                              ),
                                              trailing: CustomRadioButton(
                                                onChanged: () {
                                                  selectBrandStatusChange(i);
                                                },
                                                isSelected: createPostController.selectedBrandStatusList[i],
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
                              selectBrandTextChange();
                              ll(createPostController.selectedBrandName.value);
                              // ll(createPostController.selectedBrandImage.value);
                              Get.back();
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: ksSelectBrands.tr,
                            isRightButtonShow: true,
                          );
                          await createPostController.getStoreList();
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
                    kH12sizedBox,
                    Text(
                      ksOr.tr,
                      style: regular16TextStyle(cPlaceHolderColor),
                    ),
                    kH12sizedBox,
                    Obx(() => OutLinedButton(
                          onPress: createPostController.selectedBrandName.value == ''
                              ? () {
                                  // Get.to(() => AddBrandPage());
                                  createPostController.isBrandAdded.value = false;
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) => AddBrandPage(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                }
                              : null,
                          buttonText: ksAddBrand.tr,
                          buttonTextStyle:
                              createPostController.selectedBrandName.value == '' ? medium16TextStyle(cPrimaryColor) : medium16TextStyle(cPlaceHolderColor),
                          borderColor: createPostController.selectedBrandName.value == '' ? cPrimaryColor : cPlaceHolderColor,
                          widget: Icon(
                            BipHip.plus,
                            color: createPostController.selectedBrandName.value == '' ? cPrimaryColor : cPlaceHolderColor,
                            size: isDeviceScreenLarge() ? h20 : h16,
                          ),
                        )),
                    kH8sizedBox,
                    Text(
                      "*${ksAddBrandInstruction.tr}",
                      style: regular14TextStyle(cSmallBodyTextColor),
                    ),
                  ],
                )),
            onPressCloseButton: () {
              Get.back();
            },
            onPressRightButton: () {
              boostPostAlertDialog(context: context, title: ksBoostPost.tr, content: const BoostPostContent()); //* Set it temporary for test case
              // Get.back();
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

class BoostPostContent extends StatelessWidget {
  const BoostPostContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(kiBoostPostSvgUrl),
        kH20sizedBox,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: ksChoosing.tr, style: regular14TextStyle(cBlackColor)),
              TextSpan(text: ksYES.tr, style: semiBold14TextStyle(cBlackColor)),
              TextSpan(text: ksActiveBoostSetting.tr, style: regular14TextStyle(cBlackColor)),
            ],
          ),
        ),
        kH20sizedBox,
        Text(
          ksContinueWithoutBoostingSettings.tr,
          textAlign: TextAlign.center,
          style: regular14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        const CustomDivider(
          thickness: 1,
        )
      ],
    );
  }
}
