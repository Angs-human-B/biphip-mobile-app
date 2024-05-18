import 'dart:math';

import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/shimmers/menu/badges/badge_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/views/menu/badges/badges_star_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:story_view/story_view.dart';

class SelfieViewPage extends StatelessWidget {
  SelfieViewPage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                body: Obx(
                  () => Stack(
                    children: [
                      StoryView(
                        storyItems: selfieController.addStoryItems(selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["selfies"]),
                        controller: selfieController.storyController,
                        inline: false,
                        repeat: false,
                        onStoryShow: (storyItem, index) {
                          selfieController.currentSelfieIndex.value = index;
                          selfieController.selfieId.value = selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["selfies"][index].id;
                        },
                        onComplete: () {
                          ll("complete");
                          int currentIndex = selfieController.allSelfieListIndex.value;
                          if (currentIndex < selfieController.allSelfieList.length - 1) {
                            selfieController.allSelfieListIndex.value++;
                            selfieController.addStoryItems(
                              selfieController.allSelfieList[currentIndex]["selfies"],
                            );
                            selfieController.storyController.play();
                          } else {
                            Get.back();
                          }
                        },
                        //           onEachStoryLoadComplated: ({String? storyID}) {
                        //   print(storyID);
                        // },
                        // onComplete: () {
                        //   int currentIndex = selfieController.allSelfieListIndex.value;

                        //   if (currentIndex < selfieController.allSelfieList.length - 1) {
                        //     // Move to the next index
                        //     selfieController.allSelfieListIndex.value++;

                        //     // Show the selfies at the next index
                        //     selfieController.showSelfiesAtIndex(currentIndex + 1);
                        //   } else {
                        //     // Navigate back when there are no more selfies to show
                        //     Get.back();

                        //     // Reset the index to 0
                        //     selfieController.allSelfieListIndex.value = 0;

                        //     // Show the selfies at the initial index (0)
                        //     // selfieController.showSelfiesAtIndex(0);
                        //   }
                        // },
                        // onComplete: () {
                        //   int currentIndex = selfieController.allSelfieListIndex.value;
                        //   if (currentIndex < selfieController.allSelfieList.length - 1) {
                        //     selfieController.allSelfieListIndex.value++;
                        //     selfieController.addStoryItems(
                        //       selfieController.allSelfieList[currentIndex + 1]["selfies"],
                        //     );
                        //   } else {
                        //     Get.back();
                        //     selfieController.allSelfieListIndex.value = 0;
                        //   }
                        // },
                        // onComplete: () {
                        //   // await Future.delayed(Duration(microseconds: 200));
                        //   int currentIndex = selfieController.allSelfieListIndex.value;
                        //   if (currentIndex < selfieController.allSelfieList.length - 1) {
                        //     selfieController.allSelfieListIndex.value++;
                        //     selfieController.addStoryItems(
                        //       selfieController.allSelfieList[currentIndex + 1]["selfies"],
                        //     );
                        //     selfieController.playNextSelfieSet();
                        //   } else {
                        //     Get.back();
                        //     selfieController.allSelfieListIndex.value = 0;
                        //   }
                        //   // selfieController.storyController.next();
                        // },

                        progressPosition: ProgressPosition.top,
                        indicatorHeight: IndicatorHeight.medium,
                      ),
                      Positioned(
                          top: 80,
                          left: 20,
                          child: CustomstoryView(
                            userImage: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userImage"].toString(),
                            userName: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userName"].toString(),
                            storyUploadTime: "1 hr",
                            // privacyIcon:
                            //     (Get.find<GlobalController>().userId.value == selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userId"])
                            //         ? selfieController.privacyIcon(selfieController.allSelfieList[selfieController.allSelfieListIndex.value])
                            //         : null,
                          )),
                      if (Get.find<GlobalController>().userId.value == selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userId"])
                        Positioned(
                          bottom: 20,
                          left: k20Padding,
                          child: IconWithTextRow(
                            actionIcon: BipHip.giftNew,
                            actionText: "Received 42 Gift",
                            iconColor: cAmberColor,
                            iconSize: kIconSize24,
                            actionTextStyle: semiBold18TextStyle(cWhiteColor),
                            actionOnPressed: () {},
                          ),
                        ),
                      if (Get.find<GlobalController>().userId.value != selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userId"])
                        Positioned(
                            bottom: 140,
                            right: h20,
                            child: InkWell(
                              onTap: () async {
                                Get.find<PendentBadgesController>().resetBadgesData();
                                Get.find<GlobalController>().commonBottomSheet(
                                  context: context,
                                  content: Obx(() => Get.find<PendentBadgesController>().isUserBadgeLoading.value ||
                                          Get.find<PendentBadgesController>().isgetStarPriceLoading.value
                                      ? const BadgeBottomSheetShimmer()
                                      : GiftContent()),
                                  isScrollControlled: true,
                                  bottomSheetHeight: height * .9,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                  title: ksSendGift.tr,
                                  isRightButtonShow: false,
                                );
                                await Get.find<PendentBadgesController>().getUserBadges();
                                await Get.find<PendentBadgesController>().getStarPrice();
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    BipHip.giftNew,
                                    color: cAmberColor,
                                    size: kIconSize30,
                                  ),
                                  kH4sizedBox,
                                  Text(
                                    ksSendGift.tr,
                                    style: semiBold18TextStyle(cWhiteColor),
                                  ),
                                ],
                              ),
                            )),
                    ],
                  ),
                ),
              ),
            ),
            if (selfieController.isSelfieSendGiftLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (selfieController.isSelfieSendGiftLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomstoryView extends StatelessWidget {
  const CustomstoryView({super.key, required this.userName, required this.userImage, required this.storyUploadTime, this.privacyIcon});
  final String userName;
  final String userImage;
  final String storyUploadTime;
  final IconData? privacyIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(child: Image.network(userImage, width: h36, height: h36, fit: BoxFit.cover)),
                Row(
                  children: [
                    kW8sizedBox,
                    Text(
                      userName,
                      style: semiBold14TextStyle(cWhiteColor),
                      overflow: TextOverflow.clip,
                    ),
                    kW8sizedBox,
                    Text(storyUploadTime, style: regular12TextStyle(cWhiteColor)),
                    kW8sizedBox,
                    if (privacyIcon != null)
                      Icon(
                        privacyIcon,
                        color: cWhiteColor,
                        size: kIconSize12,
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: h36,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.find<GlobalController>().blankBottomSheet(
                      context: context,
                      bottomSheetHeight: isDeviceScreenLarge() ? height * 0.2 : height * 0.25,
                      content: Get.find<GlobalController>().userId.value ==
                              Get.find<SelfieController>().allSelfieList[Get.find<SelfieController>().allSelfieListIndex.value]["userId"]
                          ? const SelfSelfieActionBottomSheetContent()
                          : OthersSelfieActionBottomSheetContent(),
                    );
                  },
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: const Icon(
                      BipHip.system,
                      color: cWhiteColor,
                      size: kIconSize20,
                    ),
                  ),
                ),
                kW12sizedBox,
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    BipHip.cross,
                    color: cWhiteColor,
                    size: kIconSize24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelfSelfieActionBottomSheetContent extends StatelessWidget {
  const SelfSelfieActionBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconWithTextRow(
          actionIcon: BipHip.deleteNew,
          actionText: "Delete Selfie",
          actionOnPressed: () async {
            Get.back();
            await Get.find<SelfieController>().deleteSelfie(selfieId: Get.find<SelfieController>().selfieId.value);
            // Get.back();
            // globalController.postSelectedAction.value = "Copy Link";
            // if (globalController.postSelectedAction.value == "Copy Link") {
            //   String baseUrl = "bip-hip-dev.vercel.app/posts";
            //   Clipboard.setData(ClipboardData(text: "$baseUrl/${postData.id}"));
            //   Get.find<GlobalController>().showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
            // }
          },
        ),
        IconWithTextRow(
          actionIcon: BipHip.copy,
          actionText: "Copy link to share this selfie",
          actionOnPressed: () {
            Get.back();
            String baseUrl = "bip-hip-dev.vercel.app/selfies/view";
            Clipboard.setData(
                ClipboardData(text: "$baseUrl/${Get.find<GlobalController>().userId.value}/details/${Get.find<SelfieController>().currentSelfieIndex.value}"));
            Get.find<GlobalController>().showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
          },
        ),
      ],
    );
  }
}

class OthersSelfieActionBottomSheetContent extends StatelessWidget {
  OthersSelfieActionBottomSheetContent({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => IconWithTextRow(
              // actionIcon: BipHip.unFollow,
              // actionText: "Unfollow ${Get.find<SelfieController>().allSelfieList[Get.find<SelfieController>().allSelfieListIndex.value]["userName"]}",
              actionIcon: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["followStatus"] == 0 ? BipHip.follow : BipHip.unFollow,
              actionText: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["followStatus"] == 0
                  ? "Follow ${selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userName"]}"
                  : "UnFollow ${selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userName"]}",
              actionOnPressed: () async {
                Get.back();
                ll(selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["followStatus"]);
                // if (selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["followStatus"] == 0) {
                //     globalController.postSelectedAction.value = "Follow ${postData.user!.fullName}";
                //   } else {
                //     globalController.postSelectedAction.value = "UnFollow ${postData.user!.fullName}";
                //   }
                if (selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["followStatus"] == 0) {
                  await selfieController.followUnfollowUser(
                      userId: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userId"], followOrUnfollow: "Follow");
                } else {
                  await selfieController.followUnfollowUser(
                      userId: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userId"], followOrUnfollow: "UnFollow");
                }
              },
            )),
        IconWithTextRow(
          actionIcon: BipHip.report,
          actionText: "Report Selfie",
          actionOnPressed: () async {
            Get.back();
            Get.find<GlobalController>().commonBottomSheet(
                context: Get.context,
                content: Get.find<GlobalController>().isReportListLoading.value ? const ReportContentShimmer() : SelfieReportBottomSheetContent(),
                onPressCloseButton: () => Get.back(),
                onPressRightButton: () {
                  Get.back();
                  Get.find<GlobalController>().commonBottomSheet(
                      context: Get.context,
                      bottomSheetHeight: height * 0.2,
                      content: SelfieReportDescriptionBottomSheetContent(selectedIndex: selfieController.selectedReportIndex.value),
                      onPressCloseButton: () => Get.back(),
                      onPressRightButton: () {
                        Get.back();
                      },
                      rightText: ksDone.tr,
                      rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                      title: "Report".tr,
                      isBottomSheetRightButtonActive: selfieController.reportBottomSheetState,
                      isRightButtonShow: false);
                },
                rightText: ksDone.tr,
                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                title: "Report".tr,
                isBottomSheetRightButtonActive: selfieController.reportBottomSheetState,
                isRightButtonShow: false);
            await Get.find<GlobalController>().getReportList();
          },
        ),
        IconWithTextRow(
          actionIcon: BipHip.copy,
          actionText: "Copy link to share this selfie",
          actionOnPressed: () {
            Get.back();
            String baseUrl = "bip-hip-dev.vercel.app/selfies/view";
            Clipboard.setData(
                ClipboardData(text: "$baseUrl/${Get.find<GlobalController>().userId.value}/details/${Get.find<SelfieController>().currentSelfieIndex.value}"));
            Get.find<GlobalController>().showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
          },
        ),
      ],
    );
  }
}

class SelfieReportBottomSheetContent extends StatelessWidget {
  SelfieReportBottomSheetContent({super.key});
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: globalController.reportList.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      title: globalController.reportList[index].title,
                      trailing: const Icon(
                        BipHip.rightArrow,
                        size: kIconSize18,
                        color: cIconColor,
                      ),
                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                      subTitleTextStyle: regular14TextStyle(cBlackColor),
                      itemColor: globalController.reportId.value == globalController.reportList[index].id ? cPrimaryTint2Color : cWhiteColor,
                      onPressed: () {
                        Get.find<SelfieController>().reportId.value = globalController.reportList[index].id!;
                        Get.find<SelfieController>().selectedReportIndex.value = index;
                        Get.back();
                        Get.find<GlobalController>().commonBottomSheet(
                            context: Get.context,
                            bottomSheetHeight: height * 0.2,
                            content: SelfieReportDescriptionBottomSheetContent(
                              selectedIndex: Get.find<SelfieController>().selectedReportIndex.value,
                            ),
                            onPressCloseButton: () => Get.back(),
                            onPressRightButton: () {
                              Get.back();
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                            title: "Report".tr,
                            isBottomSheetRightButtonActive: globalController.reportBottomSheetState,
                            isRightButtonShow: false);

                        // homeController.temporaryselectedAudienceId.value = homeController.privacyList[index]['id'];
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class SelfieReportDescriptionBottomSheetContent extends StatelessWidget {
  SelfieReportDescriptionBottomSheetContent({super.key, required this.selectedIndex});
  final GlobalController globalController = Get.find<GlobalController>();
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kH8sizedBox,
        Text(
          globalController.reportList[selectedIndex].description ?? "",
          style: regular16TextStyle(cBlackColor),
        ),
        kH20sizedBox,
        CustomElevatedButton(
          label: ksSubmit.tr,
          onPressed: () async {
            Get.back();
            await Get.find<SelfieController>().reportSelfie(globalController.reportList[selectedIndex].description);
          },
          buttonWidth: width / 2,
          buttonHeight: h32,
        ),
      ],
    );
  }
}

class GiftContent extends StatelessWidget {
  GiftContent({super.key});

  // final PostReactionController postReactionController = Get.find<PostReactionController>();
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kH16sizedBox,
          Text(
            ksAllBadges.tr,
            style: semiBold16TextStyle(cBlackColor),
          ),
          kH16sizedBox,
          SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pendentBadgesController.allBadgesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                crossAxisCount: 3,
                crossAxisSpacing: k16Padding,
                mainAxisSpacing: k16Padding,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    pendentBadgesController.isPackageSelected.value = true;
                    pendentBadgesController.selectedBadgeIndex.value = index;
                    pendentBadgesController.badgesCheckBox.value = false;
                    pendentBadgesController.badgesPaymentCheckBox.value = false;
                    pendentBadgesController.temporarytotalStarBuyAmount.value = 0;
                    pendentBadgesController.totalStarBuyAmount.value = 0;
                    pendentBadgesController.temporaryTotalStars.value = '';
                    pendentBadgesController.totalStars.value = '';
                    pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                    pendentBadgesController.starAmountTextEditingController.clear();
                    pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.allBadgesList[index].icon!;
                    pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.allBadgesList[index].star.toString();
                    pendentBadgesController.selectedBadgePrice.value = pendentBadgesController.allBadgesList[index].price.toString();
                    pendentBadgesController.selectedBadgeDescription.value = pendentBadgesController.allBadgesList[index].description!;
                    pendentBadgesController.badgeId.value = pendentBadgesController.allBadgesList[index].id!;
                    pendentBadgesController.badgesCheckBox.value = false;
                    pendentBadgesController.badgesPaymentCheckBox.value = false;
                    pendentBadgesController.badgesCardNumberTextEditingController.clear();
                    pendentBadgesController.badgesMMYYTextEditingController.clear();
                    pendentBadgesController.badgesCvvTextEditingController.clear();

                    // Get.toNamed(krPurchaseStar);
                  },
                  child: BadgesGridViewContainer(
                    index: index,
                    recommendedOrAllBadgesList: pendentBadgesController.allBadgesList,
                    badgeIcon: pendentBadgesController.allBadgesList[index].icon,
                    badgeName: pendentBadgesController.allBadgesList[index].name,
                    badgeStar: pendentBadgesController.allBadgesList[index].star.toString(),
                  ),
                );
              },
            ),
          ),
          kH20sizedBox,
          kH20sizedBox,
          CustomElevatedButton(
              label: ksGetStars.tr,
              buttonWidth: width - 40,
              onPressed: pendentBadgesController.isPackageSelected.value
                  ? () {
                      Get.find<SelfieController>().selectedBadgeId.value =
                          pendentBadgesController.allBadgesList[pendentBadgesController.selectedBadgeIndex.value].id!;
                      pendentBadgesController.selectedBadgeIndex.value = -1;
                      pendentBadgesController.isPackageSelected.value = false;
                      globalController.commonBottomSheet(
                          context: context,
                          content: PurchaseStarContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {},
                          rightText: '',
                          rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                          title: ksGiveStars.tr,
                          isRightButtonShow: false,
                          isScrollControlled: true,
                          bottomSheetHeight: height * .9);
                    }
                  : null),
        ],
      ),
    );
  }
}

class PurchaseStarContent extends StatelessWidget {
  PurchaseStarContent({super.key});

  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  final SelfieController selfieController = Get.find<SelfieController>();
  final FocusNode giftCommentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Row(
              children: [
                Text(
                  ksYourCurrentStar.tr,
                  style: regular12TextStyle(cIconColor),
                ),
                Text(
                  " (${pendentBadgesController.userBadgesData.value?.starBalance} of 200)",
                  style: regular12TextStyle(cIconColor),
                )
              ],
            ),
            kH4sizedBox,
            Container(
              height: 44,
              width: width,
              decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    BipHip.giftNew,
                    color: cSecondaryColor,
                    size: kIconSize16,
                  ),
                  kW4sizedBox,
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [cBlueLinearColor1, cBlueLinearColor2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      '${pendentBadgesController.userBadgesData.value?.starBalance}',
                      style: semiBold20TextStyle(cWhiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: k8Padding, left: 1),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        ksStars,
                        style: regular12TextStyle(cSmallBodyTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kH24sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              ksYourSelectedPackage.tr,
              style: regular12TextStyle(cSmallBodyTextColor),
            ),
            kH8sizedBox,
            Obx(() => CustomListTile(
                  leading: Image.network(
                    pendentBadgesController.selectedBadgeIcon.value,
                    width: h20,
                    height: h20,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        kiProfileDefaultImageUrl,
                        height: h40,
                        width: h40,
                      );
                    },
                    loadingBuilder: imageLoadingBuilder,
                  ),
                  title: '${pendentBadgesController.selectedBadgeStar.value} stars',
                  borderColor: cPrimaryColor,
                  itemColor: cPrimaryTint2Color,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (pendentBadgesController.totalStars.value != '' &&
                                (int.parse(pendentBadgesController.totalStars.value) > pendentBadgesController.userBadgesData.value!.starBalance!))
                            ? '\$${pendentBadgesController.totalStarBuyAmount.value.toStringAsFixed(2)}'
                            : pendentBadgesController.totalStars.value == '' &&
                                    (int.parse(pendentBadgesController.selectedBadgeStar.value) > pendentBadgesController.userBadgesData.value!.starBalance!)
                                ? '\$${pendentBadgesController.selectedBadgePrice.value}'
                                : "",
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                )),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              ksAllStars.tr,
              style: regular12TextStyle(cIconColor),
            ),
            kH8sizedBox,
            Text(
              pendentBadgesController.selectedBadgeDescription.value,
              style: regular14TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${ksYouCanSendStars.tr}.",
                    style: regular12TextStyle(cBlackColor),
                  ),
                  TextSpan(
                    text: " ${ksLearnMoreAboutStars.tr}",
                    style: regular12TextStyle(cPrimaryColor),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                pendentBadgesController.temporarytotalStarBuyAmount.value = pendentBadgesController.totalStarBuyAmount.value;
                pendentBadgesController.temporaryTotalStars.value = pendentBadgesController.totalStars.value;
                pendentBadgesController.starAmountTextEditingController.text = pendentBadgesController.totalStars.value;
                if (pendentBadgesController.starAmountTextEditingController.text.toString().trim() == '') {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
                    content: PurchaseCustomStarContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: null,
                    rightText: '',
                    rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                    title: ksBuyCustomStar.tr,
                    isRightButtonShow: false);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: k16Padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      BipHip.plus,
                      color: cPrimaryColor,
                    ),
                    kW4sizedBox,
                    Text(
                      ksPurchaseCustomStar.tr,
                      style: semiBold14TextStyle(cPrimaryColor),
                    )
                  ],
                ),
              ),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              ksPopularPackage.tr,
              style: regular10TextStyle(cIconColor),
            ),
            kH16sizedBox,
            SizedBox(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pendentBadgesController.popularBadgesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: k8Padding),
                      child: Obx(() => CustomListTile(
                            onPressed: () {
                              Get.find<SelfieController>().selectedBadgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                              // pendentBadgesController.selectedPackage.value = packages[index];
                              pendentBadgesController.selectedBadgeIndex.value = index;
                              pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.popularBadgesList[index].icon!;
                              pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.popularBadgesList[index].star.toString();
                              pendentBadgesController.selectedBadgePrice.value = pendentBadgesController.popularBadgesList[index].price.toString();
                              pendentBadgesController.selectedBadgeDescription.value = pendentBadgesController.popularBadgesList[index].description!;
                              pendentBadgesController.badgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                              pendentBadgesController.badgesCheckBox.value = false;
                              pendentBadgesController.badgesPaymentCheckBox.value = false;
                              pendentBadgesController.badgesCardNumberTextEditingController.clear();
                              pendentBadgesController.badgesMMYYTextEditingController.clear();
                              pendentBadgesController.badgesCvvTextEditingController.clear();
                              pendentBadgesController.resetPurchaseCustomStar();
                            },
                            leading: Image.network(
                              pendentBadgesController.popularBadgesList[index].icon!,
                              width: h20,
                              height: h20,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  kiProfileDefaultImageUrl,
                                  height: h20,
                                  width: h20,
                                );
                              },
                              loadingBuilder: imageLoadingBuilder,
                            ),
                            title: '${pendentBadgesController.popularBadgesList[index].star} stars',
                            borderColor: pendentBadgesController.selectedBadgeIndex.value == index ? cPrimaryColor : cLineColor,
                            itemColor: pendentBadgesController.selectedBadgeIndex.value == index ? cPrimaryTint3Color : cWhiteColor,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  (pendentBadgesController.popularBadgesList[index].star! > pendentBadgesController.userBadgesData.value!.starBalance!)
                                      ? '\$${pendentBadgesController.popularBadgesList[index].price}'
                                      : "",
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                kW8sizedBox,
                                Radio(
                                  value: index,
                                  groupValue: pendentBadgesController.selectedBadgeIndex.value,
                                  onChanged: (v) {
                                    Get.find<SelfieController>().selectedBadgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                                    ll(Get.find<SelfieController>().selectedBadgeId.value);
                                    pendentBadgesController.selectedBadgeIndex.value = int.parse(v.toString());
                                    pendentBadgesController.selectedBadgeIndex.value = index;
                                    pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.popularBadgesList[index].icon!;
                                    pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.popularBadgesList[index].star.toString();
                                    pendentBadgesController.selectedBadgePrice.value = pendentBadgesController.popularBadgesList[index].price.toString();
                                    pendentBadgesController.selectedBadgeDescription.value = pendentBadgesController.popularBadgesList[index].description!;
                                    pendentBadgesController.badgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                                    pendentBadgesController.badgesCheckBox.value = false;
                                    pendentBadgesController.badgesPaymentCheckBox.value = false;
                                    pendentBadgesController.badgesCardNumberTextEditingController.clear();
                                    pendentBadgesController.badgesMMYYTextEditingController.clear();
                                    pendentBadgesController.badgesCvvTextEditingController.clear();
                                    pendentBadgesController.resetPurchaseCustomStar();
                                  },
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Transform.translate(
                      offset: const Offset(-10.0, 0.0),
                      child: Checkbox(
                        value: pendentBadgesController.badgesCheckBox.value,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (v) {
                          pendentBadgesController.badgesCheckBox.value = !pendentBadgesController.badgesCheckBox.value;
                        },
                      ),
                    )),
                kW12sizedBox,
                Transform.translate(
                  offset: const Offset(-20, 0.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: InkWell(
                                onTap: () {
                                  pendentBadgesController.badgesCheckBox.value = !pendentBadgesController.badgesCheckBox.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.8),
                                  child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)),
                                ))),
                        TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            kH20sizedBox,
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    Get.find<GlobalController>().userImage.toString(),
                    width: h32,
                    height: h32,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(kiDummyImage1ImageUrl);
                    },
                    loadingBuilder: imageLoadingBuilder,
                  ),
                ),
                kW8sizedBox,
                Expanded(
                  child: CustomModifiedTextField(
                      borderRadius: h8,
                      focusNode: giftCommentFocusNode,
                      controller: selfieController.giftAddCommentTextEditingController,
                      suffixIcon: selfieController.isGiftAddCommentSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                      hint: ksAddAommentWithYourGift.tr,
                      contentPadding: const EdgeInsets.symmetric(vertical: k12Padding, horizontal: k12Padding),
                      textInputStyle: regular16TextStyle(cBlackColor),
                      onSuffixPress: () {
                        selfieController.isGiftAddCommentSuffixIconVisible.value = false;
                        selfieController.giftAddCommentTextEditingController.clear();
                      },
                      onSubmit: (v) {
                        unfocus(context);
                        Get.find<SelfieController>().isGiftAddCommentSuffixIconVisible.value = true;
                      },
                      onChanged: (v) {
                        if (selfieController.giftAddCommentTextEditingController.text.toString().trim() != '') {
                          selfieController.isGiftAddCommentSuffixIconVisible.value = true;
                        } else {
                          selfieController.isGiftAddCommentSuffixIconVisible.value = false;
                        }
                      }),
                ),
              ],
            ),
            kH24sizedBox,
            CustomElevatedButton(
                label: pendentBadgesController.totalStars.value == "" &&
                        (int.parse(pendentBadgesController.selectedBadgeStar.value) < pendentBadgesController.userBadgesData.value!.starBalance!)
                    ? "$ksSend ${pendentBadgesController.selectedBadgeStar.value} stars"
                    : ksNext.tr,
                buttonWidth: width - 40,
                onPressed: pendentBadgesController.badgesCheckBox.value
                    ? () async {
                        pendentBadgesController.badgesCheckBox.value = false;
                        pendentBadgesController.badgesPaymentCheckBox.value = false;
                        pendentBadgesController.badgesCardNumberTextEditingController.clear();
                        pendentBadgesController.badgesMMYYTextEditingController.clear();
                        pendentBadgesController.badgesCvvTextEditingController.clear();
                        if (pendentBadgesController.totalStars.value == "" &&
                            (int.parse(pendentBadgesController.selectedBadgeStar.value) < pendentBadgesController.userBadgesData.value!.starBalance!)) {
                          Get.back();
                          Get.back();
                          selfieController.sendGiftSelfie();
                          // Get.find<PostReactionController>().giftStar(pendentBadgesController.totalStars.value == ""
                          //     ? pendentBadgesController.selectedBadgeStar.value
                          //     : pendentBadgesController.totalStars.value);
                        } else {
                          Get.find<GlobalController>().commonBottomSheet(
                              context: context,
                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                              isScrollControlled: true,
                              content: GiftPurchasePaymentContent(),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {},
                              rightText: '',
                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                              title: ksPayNow.tr,
                              isRightButtonShow: false);
                        }
                      }
                    : null),
            kH20sizedBox,
          ],
        ),
      ),
    );
  }
}

class PurchaseCustomStarContent extends StatelessWidget {
  PurchaseCustomStarContent({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  BipHip.giftNew,
                  color: cSecondaryColor,
                  size: kIconSize50,
                ),
                kW12sizedBox,
                kH8sizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${pendentBadgesController.temporarytotalStarBuyAmount.value.toStringAsFixed(2)}',
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      pendentBadgesController.starAmountTextEditingController.text.toString().trim() == ''
                          ? '0 ${ksStarNew.tr}'
                          : '${pendentBadgesController.starAmountTextEditingController.text} ${ksStars.tr}',
                      style: semiBold14TextStyle(cPlaceHolderColor),
                    ),
                  ],
                ),
              ],
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            CustomModifiedTextField(
              controller: pendentBadgesController.starAmountTextEditingController,
              hint: ksAmountOfStar.tr,
              onChanged: (text) {
                if (pendentBadgesController.starAmountTextEditingController.text.toString().trim() != '' &&
                    pendentBadgesController.starAmountTextEditingController.text.toString().trim() != '0') {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = true;
                  pendentBadgesController.temporarytotalStarBuyAmount.value =
                      (double.parse(pendentBadgesController.starAmountTextEditingController.text.toString()) *
                          pendentBadgesController.starPriceData.value!.starPrice!.toDouble());
                  pendentBadgesController.temporaryTotalStars.value = pendentBadgesController.starAmountTextEditingController.text.toString().trim();
                } else {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                  pendentBadgesController.temporarytotalStarBuyAmount.value = 0;
                }
              },
              onSubmit: (text) {},
              inputAction: TextInputAction.done,
              inputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              fillColor: cWhiteColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: cLineColor2,
                  width: 1.0,
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ksYouWillPay.tr,
                    style: regular10TextStyle(cIconColor),
                  ),
                  TextSpan(
                    text: ' ${pendentBadgesController.starPriceData.value!.starPrice.toString()}\$ ',
                    style: regular10TextStyle(cGreenColor),
                  ),
                  TextSpan(
                    text: ksForEveryStar.tr,
                    style: regular10TextStyle(cIconColor),
                  ),
                ],
              ),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Obx(() => CustomElevatedButton(
                  buttonWidth: width - 40,
                  label: ksConfirm.tr,
                  onPressed: pendentBadgesController.isStarAmountConfirmButtonEnabled.value
                      ? () {
                          pendentBadgesController.totalStarBuyAmount.value = pendentBadgesController.temporarytotalStarBuyAmount.value;
                          pendentBadgesController.totalStars.value = pendentBadgesController.temporaryTotalStars.value;
                          pendentBadgesController.selectedBadgeIndex.value = -1;
                          pendentBadgesController.isPackageSelected.value = false;
                          pendentBadgesController.selectedBadgeDescription.value = "";
                          // pendentBadgesController.badgeId.value = -1;
                          pendentBadgesController.badgeStar.value = pendentBadgesController.totalStars.value;
                          pendentBadgesController.badgePrice.value = pendentBadgesController.totalStarBuyAmount.value.toString();
                          pendentBadgesController.badgesCheckBox.value = false;
                          pendentBadgesController.badgesPaymentCheckBox.value = false;
                          pendentBadgesController.badgesCardNumberTextEditingController.clear();
                          pendentBadgesController.badgesMMYYTextEditingController.clear();
                          pendentBadgesController.badgesCvvTextEditingController.clear();
                          Get.back();
                          Get.find<GlobalController>().commonBottomSheet(
                              context: context,
                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                              isScrollControlled: true,
                              content: GiftPurchasePaymentContent(),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {},
                              rightText: '',
                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                              title: ksPayNow.tr,
                              isRightButtonShow: false);
                        }
                      : null,
                  textStyle: semiBold14TextStyle(cWhiteColor),
                )),
          ],
        ));
  }
}

class GiftPurchasePaymentContent extends StatelessWidget {
  GiftPurchasePaymentContent({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                kiPayment,
                width: h40,
                height: h40,
              ),
            ),
            kW12sizedBox,
            kH8sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${pendentBadgesController.totalStars.value != '' ? '\$${pendentBadgesController.totalStarBuyAmount.value.toStringAsFixed(2)}' : pendentBadgesController.selectedBadgePrice.value}',
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  pendentBadgesController.totalStars.value != ''
                      ? '${pendentBadgesController.totalStars.value} stars'
                      : '${pendentBadgesController.selectedBadgeStar.value} stars',
                  style: semiBold14TextStyle(cPlaceHolderColor),
                ),
              ],
            ),
          ],
        ),
        kH20sizedBox,
        const CustomDivider(),
        kH20sizedBox,
        CustomModifiedTextField(
          controller: pendentBadgesController.badgesCardNumberTextEditingController,
          hint: ksCardNumber.tr,
          inputType: TextInputType.number,
          inputAction: TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 16,
          textHintStyle: regular14TextStyle(cPlaceHolderColor),
          prefixIcon: BipHip.calendarFill,
          fillColor: cWhiteColor,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: cLineColor2,
              width: 1.0,
            ),
          ),
        ),
        kH20sizedBox,
        Row(
          children: [
            Expanded(
              child: CustomModifiedTextField(
                controller: pendentBadgesController.badgesMMYYTextEditingController,
                hint: 'MM/YY',
                textHintStyle: regular14TextStyle(cPlaceHolderColor),
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (String value) {},
                maxLength: 6,
                fillColor: cWhiteColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: cLineColor2,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            kW20sizedBox,
            Expanded(
              child: CustomModifiedTextField(
                controller: pendentBadgesController.badgesCvvTextEditingController,
                hint: ksCVV.tr,
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
                textHintStyle: regular14TextStyle(cPlaceHolderColor),
                fillColor: cWhiteColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: cLineColor2,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Transform.translate(
                  offset: const Offset(-10.0, 0.0),
                  child: Checkbox(
                    value: pendentBadgesController.badgesPaymentCheckBox.value,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (v) {
                      pendentBadgesController.badgesPaymentCheckBox.value = !pendentBadgesController.badgesPaymentCheckBox.value;
                    },
                  ),
                )),
            kW12sizedBox,
            Transform.translate(
              offset: const Offset(-20, 0.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: InkWell(
                            onTap: () {
                              pendentBadgesController.badgesPaymentCheckBox.value = !pendentBadgesController.badgesPaymentCheckBox.value;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.8),
                              child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)),
                            ))),
                    TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                  ],
                ),
              ),
            ),
          ],
        ),
        kH16sizedBox,
        const CustomDivider(),
        kH16sizedBox,
        Obx(() => CustomElevatedButton(
            label: ksPayNow.tr,
            buttonHeight: 42,
            buttonWidth: width - 40,
            onPressed: pendentBadgesController.badgesPaymentCheckBox.value
                ? () async {
                    Get.back();
                    await pendentBadgesController.buyBadge();
                    pendentBadgesController.resetBadgesData();
                    // if (pendentBadgesController.totalStars.value == "" && Get.find<SelfieController>().selectedBadgeId.value != -1) {
                    //   Get.back();
                    //   Get.back();
                    //   Get.find<SelfieController>().sendGiftSelfie();
                    // }
                  }
                : null)),
      ],
    );
  }
}
