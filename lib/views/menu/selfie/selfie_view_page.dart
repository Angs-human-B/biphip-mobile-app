import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:story_view/story_view.dart';

class SelfieViewPage extends StatelessWidget {
  SelfieViewPage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  // if (Get.isBottomSheetOpen!) {
                  //   selfieController.storyController.pause();
                  // }
                  selfieController.selfieId.value = selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["selfies"][index].id;
                  selfieController.currentSelfieIndex.value = index;
                },
                // onComplete: () {
                //   int currentIndex = selfieController.allSelfieListIndex.value;
                //   if (currentIndex < selfieController.allSelfieList.length - 1) {
                //     selfieController.allSelfieListIndex.value++;
                //     selfieController.addStoryItems(
                //       selfieController.allSelfieList[currentIndex + 1]["selfies"],
                //     );
                //   } else {
                //     Get.back();
                //   }
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
                onComplete: () {
                  int currentIndex = selfieController.allSelfieListIndex.value;
                  if (currentIndex < selfieController.allSelfieList.length - 1) {
                    selfieController.allSelfieListIndex.value++;
                    selfieController.addStoryItems(
                      selfieController.allSelfieList[currentIndex + 1]["selfies"],
                    );
                    selfieController.playNextSelfieSet();
                  } else {
                    Get.back();
                    selfieController.allSelfieListIndex.value = 0;
                  }
                },

                progressPosition: ProgressPosition.top,
                indicatorHeight: IndicatorHeight.medium,
              ),
              Positioned(
                  top: 80,
                  left: 20,
                  child: CustomstoryView(
                      userImage: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userImage"].toString(),
                      userName: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userName"].toString(),
                      storyUploadTime: "1 hr ago")),
              if (Get.find<GlobalController>().userId.value == selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userId"])
                Positioned(
                  bottom: 20,
                  left: k20Padding,
                  child: IconWithTextRow(
                    actionIcon: BipHip.gift,
                    actionText: "Received 42 Gift",
                    iconColor: cAmberColor,
                    iconSize: kIconSize24,
                    actionTextStyle: semiBold18TextStyle(cWhiteColor),
                    actionOnPressed: () {},
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomstoryView extends StatelessWidget {
  const CustomstoryView({super.key, required this.userName, required this.userImage, required this.storyUploadTime});
  final String userName;
  final String userImage;
  final String storyUploadTime;
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
                      style: semiBold18TextStyle(cWhiteColor),
                      overflow: TextOverflow.clip,
                    ),
                    kW8sizedBox,
                    Text(storyUploadTime, style: regular14TextStyle(cWhiteColor)),
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
                  child: const Icon(
                    BipHip.system,
                    color: cWhiteColor,
                    size: kIconSize20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    BipHip.cross,
                    color: cWhiteColor,
                    size: kIconSize20,
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
                            content: SelfieReportDescriptionBottomSheetContent(selectedIndex:  Get.find<SelfieController>().selectedReportIndex.value ,),
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


