import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/add_brand.dart';
import 'package:bip_hip/views/post/add_kid.dart';
import 'package:bip_hip/views/post/select_category.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter_svg/svg.dart';

class AudienceContent extends StatelessWidget {
  AudienceContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

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
        for (int i = 1; i <= 3; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == 3 ? 0.0 : 8.0),
            child: Obx(
              () => CustomListTile(
                onPressed: () {
                  CreatePostHelper().selectAudienceStatusChange(i - 1);
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
                    CreatePostHelper().selectAudienceStatusChange(i - 1);
                  },
                  isSelected: createPostController.audienceStatusList[i - 1],
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
                        content: KidListBottomSheetContent(),
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
                  CreatePostHelper().resetAddKidPage();
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
                    globalController.commonBottomSheet(
                        bottomSheetHeight: height * 0.9,
                        isScrollControlled: true,
                        context: context,
                        content: AddKidContent(),
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () {
                          CreatePostHelper().addKid();
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
                            Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                          } else {
                            Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                          }
                        },
                        itemColor: createPostController.kidID.value == createPostController.kidList[i].id! ? cPrimaryTint3Color : cWhiteColor,
                        borderColor: createPostController.kidID.value == createPostController.kidList[i].id! ? cPrimaryColor : cLineColor,
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
                              Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                            } else {
                              Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                            }
                          },
                          isSelected: createPostController.kidID.value == createPostController.kidList[i].id!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
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
        Obx(() => OutLinedButton(
              onPress: () {
                createPostController.isRegularPost.value = true;
                createPostController.isBiddingPost.value = false;
                createPostController.tempSellingPostType.value = ksRegularPost.tr;
                if (createPostController.tempSellingPostType.value == '') {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                } else {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
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
                  createPostController.tempSellingPostType.value == 'Regular Post' && createPostController.isRegularPost.value ? cPrimaryColor : cLineColor,
              buttonColor: createPostController.tempSellingPostType.value == 'Regular Post' && createPostController.isRegularPost.value
                  ? cPrimaryTint2Color
                  : cWhiteColor,
            )),
        kH16sizedBox,
        Obx(() => OutLinedButton(
              onPress: () {
                createPostController.isRegularPost.value = false;
                createPostController.isBiddingPost.value = true;
                createPostController.tempSellingPostType.value = ksBiddingPost.tr;
                if (createPostController.tempSellingPostType.value == '') {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                } else {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
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
                  createPostController.tempSellingPostType.value == 'Bidding Post' && createPostController.isBiddingPost.value ? cPrimaryColor : cLineColor,
              buttonColor: createPostController.tempSellingPostType.value == 'Bidding Post' && createPostController.isBiddingPost.value
                  ? cPrimaryTint2Color
                  : cWhiteColor,
            )),
      ],
    );
  }
}

class BrandBottomSheetContent extends StatelessWidget {
  BrandBottomSheetContent({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
                        : Container(
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
                      createPostController.isBrandAdded.value = false;
                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                      Get.back();
                      Get.back();
                    },
                    icon: BipHip.cross,
                    iconColor: cRedColor,
                    size: kIconSize20,
                  ),
                ],
              ),
            ),
          if (createPostController.selectedBrandName.value == '')
            OutLinedButton(
              onPress: () async {
                createPostController.tempSelectedBrandName.value = createPostController.selectedBrandName.value;
                if (createPostController.tempSelectedBrandName.value == '') {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                } else {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                  isScrollControlled: true,
                  bottomSheetHeight: createPostController.savedBrandCustomBottomSheetHeight(),
                  context: context,
                  content: SelectBrandBottomSheetContent(),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: () {
                    CreatePostHelper().selectBrandTextChange();
                    createPostController.selectedBrandName.value = createPostController.tempSelectedBrandName.value;
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
                buttonTextStyle: createPostController.selectedBrandName.value == '' ? medium16TextStyle(cPrimaryColor) : medium16TextStyle(cPlaceHolderColor),
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
          kH16sizedBox,
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: createPostController.selectedBrandName.value == ''
                  ? () {
                      Get.toNamed(krCreatePost);
                    }
                  : null,
              child: Text(
                ksSkip.tr,
                style: createPostController.selectedBrandName.value == '' ? semiBold16TextStyle(cPrimaryColor) : semiBold16TextStyle(cPlaceHolderColor),
              ),
            ),
          ),
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
                                  createPostController.tempSelectedBrandName.value = createPostController.storeList[i].name!.toString();
                                  if (createPostController.tempSelectedBrandName.value == '') {
                                    Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                                  } else {
                                    Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                                  }
                                },
                                itemColor: createPostController.tempSelectedBrandName.value == createPostController.storeList[i].name.toString()
                                    ? cPrimaryTint3Color
                                    : cWhiteColor,
                                borderColor: createPostController.tempSelectedBrandName.value == createPostController.storeList[i].name.toString()
                                    ? cPrimaryColor
                                    : cLineColor,
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
                                    createPostController.tempSelectedBrandName.value = createPostController.storeList[i].name.toString();
                                    if (createPostController.tempSelectedBrandName.value == '') {
                                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                                    } else {
                                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                                    }
                                  },
                                  isSelected: createPostController.tempSelectedBrandName.value == createPostController.storeList[i].name.toString(),
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
                    onPressed: () async {},
                    child: CustomListTile(
                      padding: const EdgeInsets.symmetric(horizontal: k0Padding, vertical: k4Padding),
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
