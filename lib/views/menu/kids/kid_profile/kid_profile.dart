import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile_post_tab.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/views/menu/photos/widgets/gallery_photo_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';

class KidProfile extends StatelessWidget {
  KidProfile({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => kidsController.isKidOverviewLoading.value
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
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (kidsController.postListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                            scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                            !kidsController.postListScrolled.value) {
                          kidsController.postListScrolled.value = true;
                          if (kidsController.allPostList.isNotEmpty) {
                            kidsController.getMorePostList();
                          }
                          return true;
                        }
                        return false;
                      },
                      child: SingleChildScrollView(
                        controller: kidsController.postListScrollController,
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
                                            onTap: (value) async {
                                              kidsController.kidProfileTabIndex.value = value;
                                              if (kidsController.kidProfileTabIndex.value == 1 || kidsController.kidProfileTabIndex.value == 2) {
                                                await Get.find<GalleryController>().getGalleryAlbumList();
                                              }
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
                              if (kidsController.kidProfileTabIndex.value == 1 || kidsController.kidProfileTabIndex.value == 2)
                                Get.find<GalleryController>().isAlbumListLoading.value
                                    ? const PhotoVideoContainer()
                                    : Get.find<GalleryController>().imageDataList.isEmpty
                                        ? Expanded(
                                            child: Center(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: EmptyView(
                                                  title: ksNoAlbumAvailable.tr,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: cWhiteColor,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: Get.find<GalleryController>().imageDataList.length,
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: k4Padding + k2Padding,
                                                  crossAxisCount: 2,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          GalleryPhotoContainer(
                                                            title: Get.find<GalleryController>().imageDataList[index].title ?? ksNA.tr,
                                                            subTitle: Get.find<GalleryController>().imageDataList[index].totalImage.toString(),
                                                            image: Get.find<GalleryController>().imageDataList[index].preview,
                                                            threeDotOnPressed: () {
                                                              Get.find<GalleryController>().galleryPhotoActionSelect.value = '';
                                                              Get.find<GalleryController>().galleryPhotoBottomSheetRightButtonState.value = false;
                                                              Get.find<GlobalController>().commonBottomSheet(
                                                                context: context,
                                                                isBottomSheetRightButtonActive:
                                                                    Get.find<GalleryController>().galleryPhotoBottomSheetRightButtonState,
                                                                isScrollControlled: true,
                                                                content: GalleryPhotoActionContent(),
                                                                onPressCloseButton: () {
                                                                  Get.back();
                                                                },
                                                                onPressRightButton: () async {
                                                                  Get.back();
                                                                },
                                                                rightText: ksDone.tr,
                                                                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                                                title: ksAction.tr,
                                                                isRightButtonShow: true,
                                                                bottomSheetHeight: 140,
                                                              );
                                                            },
                                                            onPressed: () {
                                                              // Get.to(() => Photos(
                                                              //       imageList: galleryController.imageDataList[index].imageList,
                                                              //       imageListTitle: galleryController.imageDataList[index].title ?? ksNA,
                                                              //     ));
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                            ],
                          ),
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

class PhotoVideoContainer extends StatelessWidget {
  const PhotoVideoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH12sizedBox,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: k10Padding,
                mainAxisSpacing: k4Padding,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: k8CircularBorderRadius,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: k8CircularBorderRadius,
                          child: ShimmerCommon(
                            widget: Container(
                              color: cWhiteColor,
                              height: 100,
                              width: ((width - 52) / 2),
                            ),
                          ),
                        ),
                        kH8sizedBox,
                        ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 12,
                            width: 80,
                          ),
                        ),
                        kH4sizedBox,
                        ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 12,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
