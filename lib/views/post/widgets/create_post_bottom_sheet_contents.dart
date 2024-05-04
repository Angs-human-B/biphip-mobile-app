import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/shimmers/post/create_post_shimmers.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/add_kid.dart';
import 'package:bip_hip/views/post/select_category.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter_svg/svg.dart';

class AudienceContent extends StatelessWidget {
  AudienceContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
        for (int i = 0; i < createPostController.createPostPrivacyList.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: k4Padding),
            child: Obx(
              () => CustomListTile(
                onPressed: () {
                  createPostController.tempCreatePostSelectedPrivacy.value = createPostController.createPostPrivacyList[i].name.toString();
                  createPostController.tempCreatePostSelectedPrivacyIcon.value = globalController.privacyList[i]['icon'];
                },
                itemColor: createPostController.tempCreatePostSelectedPrivacy.value == createPostController.createPostPrivacyList[i].name.toString()
                    ? cPrimaryTint3Color
                    : cWhiteColor,
                title: createPostController.createPostPrivacyList[i].name.toString(),
                leading: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: cNeutralColor,
                  ),
                  height: h28,
                  width: h28,
                  child: Icon(
                    Get.find<GlobalController>().privacyList[i]['icon'],
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  ),
                ),
                trailing: CustomRadioButton(
                  onChanged: () {
                    createPostController.tempCreatePostSelectedPrivacyIcon.value = globalController.privacyList[i]['icon'];
                    createPostController.tempCreatePostSelectedPrivacy.value = createPostController.createPostPrivacyList[i].name.toString();
                  },
                  isSelected: createPostController.tempCreatePostSelectedPrivacy.value == createPostController.createPostPrivacyList[i].name.toString(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class KidCategoryContent extends StatelessWidget {
  KidCategoryContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
                      createPostController.tempKidID.value = -1;
                      if (createPostController.tempSelectedKid.value == null) {
                        createPostController.kidListBottomSheetRightButtonState.value = false;
                      } else {
                        createPostController.kidListBottomSheetRightButtonState.value = true;
                      }
                      globalController.commonBottomSheet(
                        isBottomSheetRightButtonActive: createPostController.kidListBottomSheetRightButtonState,
                        isScrollControlled: true,
                        bottomSheetHeight: height * .7,
                        context: context,
                        content: KidListBottomSheetContent(),
                        onPressCloseButton: () {
                          Get.back();
                          if (createPostController.selectedKid.value != null) {
                            createPostController.kidCategoryBottomSheetRightButtonState.value = true;
                          } else {
                            createPostController.kidCategoryBottomSheetRightButtonState.value = false;
                          }
                        },
                        onPressRightButton: () {
                          createPostController.selectedKid.value = createPostController.tempSelectedKid.value;
                          Get.back();
                          createPostController.tempSelectedKid.value = null;
                          if (createPostController.selectedKid.value == null || createPostController.isKidAdded.value) {
                            createPostController.kidCategoryBottomSheetRightButtonState.value = false;
                          } else {
                            createPostController.kidCategoryBottomSheetRightButtonState.value = true;
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
                    createPostController.selectedKid.value!.profilePicture.toString(),
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
                    createPostController.kidCategoryBottomSheetRightButtonState.value = false;
                  } else {
                    createPostController.kidCategoryBottomSheetRightButtonState.value = true;
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
                  CreatePostHelper().resetAddKidPage();
                  if (createPostController.selectedKid.value == null || createPostController.isKidAdded.value) {
                    createPostController.kidCategoryBottomSheetRightButtonState.value = false;
                  } else {
                    createPostController.kidCategoryBottomSheetRightButtonState.value = true;
                  }
                },
                child: const Icon(
                  BipHip.cross,
                  color: cRedColor,
                ),
              ),
            ),
          kH12sizedBox,
          Text(
            ksOr.tr,
            style: regular16TextStyle(cPlaceHolderColor),
          ),
          kH12sizedBox,
          OutLinedButton(
            buttonHeight: isDeviceScreenLarge() ? 45 : 40,
            borderRadius: k8CircularBorderRadius,
            onPress: (createPostController.selectedKid.value == null && !createPostController.isKidAdded.value)
                ? () {
                    CreatePostHelper().resetAddKidPage();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddKidPage()),
                    );
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
      ),
    );
  }
}

class KidListBottomSheetContent extends StatelessWidget {
  KidListBottomSheetContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => createPostController.isKidListLoading.value
          ? const KidListShimmer()
          : createPostController.kidList.isNotEmpty
              ? Column(
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
                              createPostController.tempKidID.value = createPostController.kidList[i].id!;
                              createPostController.tempSelectedKid.value = createPostController.kidList[i];
                              if (createPostController.tempSelectedKid.value == null) {
                                createPostController.kidListBottomSheetRightButtonState.value = false;
                              } else {
                                createPostController.kidListBottomSheetRightButtonState.value = true;
                              }
                            },
                            itemColor: createPostController.tempKidID.value == createPostController.kidList[i].id! ? cPrimaryTint3Color : cWhiteColor,
                            borderColor: createPostController.tempKidID.value == createPostController.kidList[i].id! ? cPrimaryColor : cLineColor,
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
                                  createPostController.kidList[i].profilePicture.toString(),
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
                                createPostController.tempKidID.value = createPostController.kidList[i].id!;
                                createPostController.tempSelectedKid.value = createPostController.kidList[i];
                                if (createPostController.tempSelectedKid.value == null) {
                                  createPostController.kidListBottomSheetRightButtonState.value = false;
                                } else {
                                  createPostController.kidListBottomSheetRightButtonState.value = true;
                                }
                              },
                              isSelected: createPostController.tempKidID.value == createPostController.kidList[i].id!,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              : Container(height: height * 0.6, alignment: Alignment.center, child: EmptyView(title: ksNoKidsAddedYet.tr)),
    );
  }
}

class SellingCategoryBottomSheetContent extends StatelessWidget {
  SellingCategoryBottomSheetContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => OutLinedButton(
            onPress: () {
              createPostController.isRegularPost.value = true;
              createPostController.isBiddingPost.value = false;
              createPostController.temporarySellingPostType.value = ksRegularPost.tr;
              if (createPostController.temporarySellingPostType.value == '') {
                createPostController.sellingPostTypeBottomSheetRightButtonState.value = false;
              } else {
                createPostController.sellingPostTypeBottomSheetRightButtonState.value = true;
              }
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
            borderColor:
                createPostController.temporarySellingPostType.value == 'Regular Post' && createPostController.isRegularPost.value ? cPrimaryColor : cLineColor,
            buttonColor: createPostController.temporarySellingPostType.value == 'Regular Post' && createPostController.isRegularPost.value
                ? cPrimaryTint2Color
                : cWhiteColor,
          ),
        ),
        kH16sizedBox,
        Obx(
          () => OutLinedButton(
            onPress: () {
              createPostController.isRegularPost.value = false;
              createPostController.isBiddingPost.value = true;
              createPostController.temporarySellingPostType.value = ksBiddingPost.tr;
              if (createPostController.temporarySellingPostType.value == '') {
                createPostController.sellingPostTypeBottomSheetRightButtonState.value = false;
              } else {
                createPostController.sellingPostTypeBottomSheetRightButtonState.value = true;
              }
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
            borderColor:
                createPostController.temporarySellingPostType.value == 'Bidding Post' && createPostController.isBiddingPost.value ? cPrimaryColor : cLineColor,
            buttonColor: createPostController.temporarySellingPostType.value == 'Bidding Post' && createPostController.isBiddingPost.value
                ? cPrimaryTint2Color
                : cWhiteColor,
          ),
        ),
      ],
    );
  }
}

class BrandBottomSheetContent extends StatelessWidget {
  BrandBottomSheetContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createPostHelper = CreatePostHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          kH8sizedBox,
          Obx(() => OutLinedButton(
                onPress: createPostController.selectedBrandId.value == -1
                    ? () {
                        Get.find<HomeController>().homeTabIndex.value = 0;
                        Get.offNamedUntil(krCreatePost, ModalRoute.withName(krHome));
                      }
                    : null,
                buttonText: ksCreateSellingPost.tr,
                buttonTextStyle: semiBold16TextStyle(cWhiteColor),
                borderColor: createPostController.selectedBrandId.value == -1 ? cPrimaryColor : cPlaceHolderColor,
                buttonColor: createPostController.selectedBrandId.value == -1 ? cPrimaryColor : cPlaceHolderColor2,
                borderRadius: BorderRadius.circular(k8BorderRadius),
              )),
          kH8sizedBox,
          Text(
            '*${ksDoesNotRequireAnyStore.tr}',
            style: regular12TextStyle(cSmallBodyTextColor),
          ),
          kH16sizedBox,
          Text(
            ksOr.tr,
            style: regular16TextStyle(cPlaceHolderColor),
          ),
          kH16sizedBox,
          if (createPostController.selectedBrandId.value != -1)
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
                    child: Container(
                      width: h24,
                      height: h24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          createPostController.selectedBrandImage.value,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.imageFile,
                            size: kIconSize120,
                            color: cIconColor,
                          ),
                        ),
                      ),
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
                      createPostController.selectedBrandId.value = -1;
                      createPostController.brandID.value = -1;
                      createPostController.isBrandAdded.value = false;
                      createPostController.selectStoreBottomSheetRightButtonState.value = false;
                    },
                    icon: BipHip.cross,
                    iconColor: cRedColor,
                    size: kIconSize20,
                  ),
                ],
              ),
            ),
          if (createPostController.selectedBrandId.value == -1)
            OutLinedButton(
              onPress: () async {
                createPostController.tempSelectedBrandId.value = createPostController.selectedBrandId.value;
                if (createPostController.tempSelectedBrandId.value == -1) {
                  createPostController.storeListBottomSheetRightButtonState.value = false;
                } else {
                  createPostController.storeListBottomSheetRightButtonState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                  isBottomSheetRightButtonActive: createPostController.storeListBottomSheetRightButtonState,
                  isScrollControlled: true,
                  bottomSheetHeight: createPostController.savedBrandCustomBottomSheetHeight(),
                  context: context,
                  content: SelectBrandBottomSheetContent(),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: () {
                    createPostHelper.selectBrandTextChange();
                    createPostController.selectedBrandId.value = createPostController.tempSelectedBrandId.value;
                    createPostController.selectStoreBottomSheetRightButtonState.value = true;
                    Get.back();
                  },
                  rightText: ksDone.tr,
                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                  title: ksSelectBrands.tr,
                  isRightButtonShow: true,
                );
                await createPostController.getStoreList();
              },
              buttonText: ksSelectStore.tr,
              buttonTextStyle: medium16TextStyle(cBlackColor),
              borderColor: cLineColor,
              widget: Icon(
                BipHip.downArrowOutline,
                color: cBlackColor,
                size: isDeviceScreenLarge() ? h20 : h16,
              ),
            ),
          kH8sizedBox,
          RichText(
              textAlign: TextAlign.left,
              text: TextSpan(children: [
                TextSpan(text: '*$ksIfDontHaveAnyStore '.tr, style: regular12TextStyle(cSmallBodyTextColor)),
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      ll('Route here to add store basic info page');
                    },
                    child: Text(
                      ksCreateStore.tr,
                      style: semiBold14TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
                TextSpan(text: ' from here.', style: regular12TextStyle(cSmallBodyTextColor)),
              ]))
        ],
      ),
    );
  }
}

class SelectBrandBottomSheetContent extends StatelessWidget {
  SelectBrandBottomSheetContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => createPostController.isStoreListLoading.value
          ? const KidListShimmer()
          : Column(
              children: [
                createPostController.storeList.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => kH8sizedBox,
                        itemCount: createPostController.storeList.length,
                        itemBuilder: (context, i) {
                          return Obx(() => CustomListTile(
                                onPressed: () {
                                  createPostController.tempSelectedBrandId.value = createPostController.storeList[i].id!;
                                  if (createPostController.tempSelectedBrandId.value == -1) {
                                    createPostController.storeListBottomSheetRightButtonState.value = false;
                                  } else {
                                    createPostController.storeListBottomSheetRightButtonState.value = true;
                                  }
                                },
                                itemColor:
                                    createPostController.tempSelectedBrandId.value == createPostController.storeList[i].id ? cPrimaryTint3Color : cWhiteColor,
                                borderColor:
                                    createPostController.tempSelectedBrandId.value == createPostController.storeList[i].id ? cPrimaryColor : cLineColor,
                                title: createPostController.storeList[i].name,
                                leading: Container(
                                  height: h24,
                                  width: h24,
                                  decoration: const BoxDecoration(
                                    color: cBlackColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      createPostController.storeList[i].profilePicture ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                        BipHip.imageFile,
                                        size: kIconSize16,
                                        color: cIconColor,
                                      ),
                                      // loadingBuilder: imageLoadingBuilder,
                                    ),
                                  ),
                                ),
                                trailing: CustomRadioButton(
                                  onChanged: () {
                                    createPostController.tempSelectedBrandId.value = createPostController.storeList[i].id!;
                                    if (createPostController.tempSelectedBrandId.value == -1) {
                                      createPostController.storeListBottomSheetRightButtonState.value = false;
                                    } else {
                                      createPostController.storeListBottomSheetRightButtonState.value = true;
                                    }
                                  },
                                  isSelected: createPostController.tempSelectedBrandId.value == createPostController.storeList[i].id,
                                ),
                              ));
                        },
                      )
                    : Expanded(child: Container(alignment: Alignment.center, child: EmptyView(title: ksNoSavedStoreAvailable.tr))),
              ],
            ),
    );
  }
}

class TagPeopleBottomSheetContent extends StatelessWidget {
  TagPeopleBottomSheetContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Obx(() => Get.find<FriendController>().isFriendListLoading.value
          ? const TagFriendShimmer()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (createPostController.tempTaggedFriends.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: k2Padding, bottom: k8Padding),
                    child: Text(
                      ksSelected.tr,
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                  ),
                if (createPostController.tempTaggedFriends.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: k12Padding),
                    child: Container(
                      color: cWhiteColor,
                      height: 40,
                      width: width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => kW8sizedBox,
                        scrollDirection: Axis.horizontal,
                        itemCount: createPostController.tempTaggedFriends.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: h40,
                                width: h40,
                                decoration: const BoxDecoration(
                                  color: cWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    createPostController.tempTaggedFriends[index].profilePicture.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(kiProfileDefaultImageUrl);
                                    },
                                    loadingBuilder: imageLoadingBuilder,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: InkWell(
                                  onTap: () {
                                    createPostController.tagFriendList
                                        .insert(createPostController.tempTagIndex[index], createPostController.tempTaggedFriends[index]);
                                    createPostController.tempTagIndex.removeAt(index);
                                    createPostController.tempTaggedFriends.removeAt(index);
                                    if (createPostController.tempTaggedFriends.isNotEmpty) {
                                      createPostController.tagFriendButtonSheetRightButtonState.value = true;
                                    } else {
                                      createPostController.tagFriendButtonSheetRightButtonState.value = false;
                                    }
                                  },
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
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
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
                  itemCount: createPostController.tagFriendList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: k10Padding),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            createPostController.tempTaggedFriends.add(createPostController.tagFriendList[index]);
                            createPostController.tempTagIndex.add(index);
                            createPostController.tagFriendList.removeAt(index);
                            if (createPostController.tempTaggedFriends.isNotEmpty) {
                              createPostController.tagFriendButtonSheetRightButtonState.value = true;
                            } else {
                              createPostController.tagFriendButtonSheetRightButtonState.value = false;
                            }
                          },
                          child: CustomListTile(
                            padding: const EdgeInsets.symmetric(horizontal: k0Padding, vertical: k4Padding),
                            leading: Container(
                              height: h40,
                              width: h40,
                              decoration: const BoxDecoration(
                                color: cWhiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  createPostController.tagFriendList[index].profilePicture.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(kiProfileDefaultImageUrl);
                                  },
                                  loadingBuilder: imageLoadingBuilder,
                                ),
                              ),
                            ),
                            title: createPostController.tagFriendList[index].fullName,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
    );
  }
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

class ProductConditionContent extends StatelessWidget {
  ProductConditionContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: createPostController.createPostSellConditionList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        createPostController.tempSelectedProductCondition.value = createPostController.createPostSellConditionList[index].name.toString();
                        createPostController.tempSelectedProductConditionID.value = createPostController.createPostSellConditionList[index].id.toString();
                        if (createPostController.tempSelectedProductCondition.value == '') {
                          createPostController.productConditionBottomSheetRightButtonState.value = false;
                        } else {
                          createPostController.productConditionBottomSheetRightButtonState.value = true;
                        }
                      },
                      buttonText: createPostController.createPostSellConditionList[index].name.toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor:
                          createPostController.tempSelectedProductCondition.value == createPostController.createPostSellConditionList[index].name.toString()
                              ? cPrimaryColor
                              : cLineColor2,
                      buttonColor:
                          createPostController.tempSelectedProductCondition.value == createPostController.createPostSellConditionList[index].name.toString()
                              ? cPrimaryTint3Color
                              : cWhiteColor,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )),
              );
            }),
      ],
    ));
  }
}

class ProductCategoryContent extends StatelessWidget {
  ProductCategoryContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: createPostController.createPostSellCategoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        createPostController.tempSelectedProductCategory.value = createPostController.createPostSellCategoryList[index].name.toString();
                        createPostController.tempSelectedProductCategoryID.value = createPostController.createPostSellCategoryList[index].id.toString();
                        if (createPostController.tempSelectedProductCategory.value == '') {
                          createPostController.productCategoryBottomSheetRightButton.value = false;
                        } else {
                          createPostController.productCategoryBottomSheetRightButton.value = true;
                        }
                      },
                      buttonText: createPostController.createPostSellCategoryList[index].name.toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor:
                          createPostController.tempSelectedProductCategory.value == createPostController.createPostSellCategoryList[index].name.toString()
                              ? cPrimaryColor
                              : cLineColor2,
                      buttonColor:
                          createPostController.tempSelectedProductCategory.value == createPostController.createPostSellCategoryList[index].name.toString()
                              ? cPrimaryTint3Color
                              : cWhiteColor,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )),
              );
            }),
      ],
    ));
  }
}

class ProductAvailabilityContent extends StatelessWidget {
  ProductAvailabilityContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: createPostController.productAvailabilityList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        createPostController.temporaryProductAvailability.value = createPostController.productAvailabilityList[index]['name'].toString();
                        createPostController.temporaryProductAvailabilityId.value = createPostController.productAvailabilityList[index]['id'];
                        if (createPostController.temporaryProductAvailability.value == '') {
                          createPostController.productAvailabilityBottomSheetRightButtonState.value = false;
                        } else {
                          createPostController.productAvailabilityBottomSheetRightButtonState.value = true;
                        }
                      },
                      buttonText: createPostController.productAvailabilityList[index]['name'].toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor:
                          createPostController.temporaryProductAvailability.value == createPostController.productAvailabilityList[index]['name'].toString()
                              ? cPrimaryColor
                              : cLineColor2,
                      buttonColor:
                          createPostController.temporaryProductAvailability.value == createPostController.productAvailabilityList[index]['name'].toString()
                              ? cPrimaryTint3Color
                              : cWhiteColor,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )),
              );
            }),
      ],
    ));
  }
}
