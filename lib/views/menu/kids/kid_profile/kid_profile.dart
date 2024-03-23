import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile_post_tab.dart';

class KidProfile extends StatelessWidget {
  KidProfile({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => kidsController.isKidOverviewLoading.value || kidsController.isHomePageLoading.value
            ? const ProfilePageShimmer2()
            : SafeArea(
                top: false,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: cBackgroundColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kAppBarSize),
                    //* info:: appBar
                    child: CustomAppBar(
                      appBarColor: cWhiteColor,
                      title: kidsController.kidOverviewData.value?.kids?.name ?? ksNA,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: SizedBox(
                    height: height,
                    width: width,
                    // child: NotificationListener<ScrollNotification>(
                    //   onNotification: (scrollNotification) {
                    //     // if (homeController.timelinePostListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                    //     //     scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                    //     //     !homeController.timelinePostListScrolled.value) {
                    //     //       homeController.timelinePostListScrolled.value = true;
                    //     //   if (homeController.allTimelinePostList.isNotEmpty) {
                    //     //     homeController.getMoreTimelinePostList();
                    //     //   }
                    //       return true;
                    //     }
                    //     // homeController.timelinePostListScrolled.value = false;
                    //     return false;
                    //   },
                    child: SingleChildScrollView(
                      // controller: homeController.timelinePostListScrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 225,
                                  color: cWhiteColor,
                                ),
                                InkWell(
                                  onTap: () {
                                    // profileHelper).coverPhotoEditBottomSheet(context);
                                    kidHelper.kidCoverPhotoEditBottomSheet(context);
                                  },
                                  child: Container(
                                    height: 150,
                                    width: width,
                                    decoration: const BoxDecoration(color: cBlackColor, border: Border(bottom: BorderSide(color: cLineColor))),
                                    child: Image.network(
                                      kidsController.kidOverviewData.value?.kids?.coverPhoto ?? '',
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                      errorBuilder: (context, error, stackTrace) =>
                                          imageErrorBuilderCover(context, error, stackTrace, BipHip.imageFile, kIconSize120),
                                      loadingBuilder: imageLoadingBuilder,
                                      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                        return child;
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 20,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          kidHelper.kidProfilePicEditBottomSheet(context);
                                        },
                                        child: Container(
                                          height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                          width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                          decoration: BoxDecoration(
                                            color: cBlackColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: cWhiteColor.withAlpha(500), width: 2),
                                          ),
                                          child: ClipOval(
                                            child: Image.network(
                                              kidsController.kidOverviewData.value?.kids?.profilePicture ?? "",
                                              fit: BoxFit.cover,
                                              filterQuality: FilterQuality.high,
                                              errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(
                                                context,
                                                error,
                                                stackTrace,
                                                BipHip.user,
                                                kIconSize70,
                                              ),
                                              loadingBuilder: imageLoadingBuilder,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 6,
                                        bottom: 10,
                                        child: TextButton(
                                          style: kTextButtonStyle,
                                          onPressed: () {
                                            kidHelper.kidProfilePicUploadBottomSheet(context);
                                          },
                                          child: Container(
                                            height: h28,
                                            width: h28,
                                            decoration: BoxDecoration(
                                              color: cGreyBoxColor,
                                              borderRadius: BorderRadius.circular(26),
                                              border: Border.all(
                                                color: cLineColor,
                                              ),
                                            ),
                                            child: const Icon(
                                              BipHip.camera,
                                              color: cBlackColor,
                                              size: kIconSize14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 16,
                                  bottom: 60,
                                  child: TextButton(
                                    style: kTextButtonStyle,
                                    onPressed: () {
                                      kidHelper.kidCoverPhotoUploadBottomSheet(context);
                                    },
                                    child: Container(
                                      height: h28,
                                      width: h28,
                                      decoration: BoxDecoration(
                                        color: cGreyBoxColor,
                                        borderRadius: BorderRadius.circular(26),
                                        border: Border.all(
                                          color: cLineColor,
                                        ),
                                      ),
                                      child: const Icon(
                                        BipHip.camera,
                                        color: cBlackColor,
                                        size: kIconSize14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: cWhiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  kH10sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: Text(
                                      kidsController.kidOverviewData.value?.kids?.name ?? ksNA,
                                      // '${profileController.userData.value!.firstName} ${profileController.userData.value!.lastName}',//*needed and change it
                                      style: medium24TextStyle(cBlackColor),
                                    ),
                                  ),
                                  kH10sizedBox,
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                  //     children: [
                                  //       const Icon(
                                  //         Icons.attach_money_sharp,
                                  //         color: cSecondaryColor,
                                  //         size: kIconSize14,
                                  //       ),
                                  //       Text(
                                  //         '2.57',
                                  //         style: medium14TextStyle(cSmallBodyTextColor),
                                  //       ),
                                  //       kW4sizedBox,
                                  //       const Icon(
                                  //         BipHip.giftNew,
                                  //         color: cSecondaryColor,
                                  //         size: kIconSize14,
                                  //       ),
                                  //       kW4sizedBox,
                                  //       Text(
                                  //         '457',
                                  //         style: medium14TextStyle(cSmallBodyTextColor),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  kH4sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: Text(
                                      "${kidsController.kidOverviewData.value?.kids?.countFollowers.toString() ?? ksNA} Followers",
                                      style: semiBold14TextStyle(cSmallBodyTextColor),
                                    ),
                                  ),
                                  kH12sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CustomElevatedButton(
                                          label: ksManage.tr,
                                          buttonHeight: 32,
                                          buttonWidth: 130,
                                          prefixIcon: BipHip.setting,
                                          textStyle: semiBold16TextStyle(cWhiteColor),
                                          prefixIconSize: screenWiseSize(kIconSize18, 4),
                                          onPressed: () {},
                                        ),
                                        kW16sizedBox,
                                        CustomElevatedButton(
                                          label: ksEditProfile.tr,
                                          onPressed: () {
                                            Get.toNamed(krEditKidProfile);
                                          },
                                          prefixIcon: BipHip.edit,
                                          prefixIconColor: cPrimaryColor,
                                          prefixIconSize: screenWiseSize(kIconSize18, 4),
                                          buttonHeight: 32,
                                          buttonWidth: 130,
                                          buttonColor: cWhiteColor,
                                          textStyle: semiBold16TextStyle(cPrimaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  kH16sizedBox,
                                ],
                              ),
                            ),
                            kH8sizedBox,
                            DefaultTabController(
                              length: 3,
                              // initialIndex: profileController.postSectionVisible.value ? 0 : 1,//!con
                              initialIndex: 0,
                              child: Column(
                                children: [
                                  Container(
                                    color: cWhiteColor,
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: cLineColor, width: 1),
                                          ),
                                        ),
                                        child: TabBar(
                                          onTap: (value) {
                                            kidsController.kidProfileTabIndex.value = value;
                                            // profileHelper.showProfileTabSection(value);
                                          },
                                          indicatorColor: cPrimaryColor,
                                          indicatorWeight: 1,
                                          unselectedLabelColor: cSmallBodyTextColor,
                                          unselectedLabelStyle: medium14TextStyle(cSmallBodyTextColor),
                                          labelStyle: medium14TextStyle(cPrimaryColor),
                                          labelColor: cPrimaryColor,
                                          tabs: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                              child: Text(
                                                ksPosts.tr,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                              child: Text(
                                                ksPhotos.tr,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                              child: Text(
                                                ksVideos.tr,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (kidsController.kidProfileTabIndex.value == 0)
                              KidProfilePostSection(
                                seeAllAboutOnPressed: () {
                                  Get.toNamed(krEditKidProfile);
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class KidStoreProfileLinkUpIconTextRow extends StatelessWidget {
  const KidStoreProfileLinkUpIconTextRow({super.key, required this.iconOrSvg, required this.prefixText, this.onPressed, required this.suffixText});

  final Widget iconOrSvg;
  final String prefixText, suffixText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: k12Padding),
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconOrSvg,
            kW12sizedBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: prefixText, style: regular14TextStyle(cBlackColor)),
                ],
              ),
            ),
            kW4sizedBox,
            Container(
              width: 2,
              height: 2,
              decoration: const BoxDecoration(
                color: cBlackColor,
                shape: BoxShape.circle,
              ),
            ),
            kW4sizedBox,
            RichText(
              text: TextSpan(children: [
                TextSpan(text: suffixText, style: semiBold14TextStyle(cBlackColor)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
