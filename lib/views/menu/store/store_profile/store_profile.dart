import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/menu/store/store_helper.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/common_feature_post_widget.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/views/menu/photos/widgets/gallery_photo_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/post/post_button_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class StoreProfile extends StatelessWidget {
  StoreProfile({
    super.key,
  });
  final StoreController storeController = Get.find<StoreController>();
  final StoreHelper storeHelper = StoreHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => storeController.isStoreOverviewLoading.value
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
                      title: storeController.storeName.value,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: Obx(
                    () => SizedBox(
                      height: height,
                      width: width,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (storeController.postListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                              scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                              !storeController.postListScrolled.value) {
                            storeController.postListScrolled.value = true;
                            if (storeController.allPostList.isNotEmpty) {
                              storeController.getMorePostList();
                            }
                            return true;
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: storeController.postListScrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
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
                                      StoreHelper().storeCoverPhotoEditBottomSheet(context);
                                    },
                                    child: Container(
                                      height: 150,
                                      width: width,
                                      decoration: const BoxDecoration(color: cBlackColor, border: Border(bottom: BorderSide(color: cLineColor))),
                                      child: Image.network(
                                        storeController.storeCoverPhoto.value,
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
                                            StoreHelper().storeProfilePicEditBottomSheet(context);
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
                                                storeController.storeProfilePicture.value,
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
                                              StoreHelper().storeProfilePicUploadBottomSheet(context);
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
                                        StoreHelper().storeCoverPhotoUploadBottomSheet(context);
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
                                        storeController.storeName.value,
                                        style: medium24TextStyle(cBlackColor),
                                      ),
                                    ),
                                    kH4sizedBox,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: Text(
                                        '${storeController.storesData.value?.countFollowers.toString() ?? ksNA} Followers',
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
                                              Get.toNamed(krEditStoreProfile);
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
                              Container(
                                color: cWhiteColor,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k8Padding),
                                      child: DefaultTabController(
                                        length: 3,
                                        initialIndex: 0,
                                        child: Column(
                                          children: [
                                            Container(
                                              color: cWhiteColor,
                                              height: 40,
                                              width: width,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(color: cLineColor, width: 1),
                                                  ),
                                                ),
                                                child: TabBar(
                                                  onTap: (value) async {
                                                    storeController.storeProfileTabIndex.value = value;
                                                    if (storeController.storeProfileTabIndex.value == 1 || storeController.storeProfileTabIndex.value == 2) {
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (storeController.storeProfileTabIndex.value == 0) StoreProfilePostTab(),
                                    if (storeController.storeProfileTabIndex.value == 1 || storeController.storeProfileTabIndex.value == 2)
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
                                              : SizedBox(
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

class StoreProfilePostTab extends StatelessWidget {
  StoreProfilePostTab({super.key});

  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cBackgroundColor,
      child: Column(
        children: [
          Container(
            color: cWhiteColor,
            child: Padding(
              padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k16Padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ksDetails.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  kH12sizedBox,
                  KidStoreProfileLinkUpIconTextRow(
                    iconOrSvg: const Icon(
                      BipHip.info,
                      size: kIconSize20,
                      color: cPrimaryColor,
                    ),
                    onPressed: null,
                    prefixText: '${ksPage.tr} ',
                    suffixText: storeController.storesData.value?.pageType ?? ksNA.tr,
                  ),
                  KidStoreProfileLinkUpIconTextRow(
                    iconOrSvg: const Icon(
                      BipHip.info,
                      size: kIconSize20,
                      color: cPrimaryColor,
                    ),
                    onPressed: null,
                    prefixText: ksBIN.tr,
                    suffixText: storeController.storeBIN.value ?? "",
                  ),
                  StoreProfileLinkUpIconTextRow(
                    iconOrSvg: const Icon(
                      BipHip.location,
                      size: kIconSize20,
                      color: cPrimaryColor,
                    ),
                    onPressed: null,
                    prefixText: storeController.storeOverviewData.value?.location ?? ksNA.tr,
                    suffixText: '',
                  ),
                  StoreProfileLinkUpIconTextRow(
                    iconOrSvg: const Icon(
                      BipHip.mail,
                      size: kIconSize20,
                      color: cPrimaryColor,
                    ),
                    onPressed: null,
                    prefixText: storeController.storeOverviewData.value?.email ?? ksNA.tr,
                    suffixText: '',
                  ),
                  StoreProfileLinkUpIconTextRow(
                    iconOrSvg: const Icon(
                      BipHip.phoneFill,
                      size: kIconSize20,
                      color: cPrimaryColor,
                    ),
                    onPressed: null,
                    prefixText: storeController.storeOverviewData.value?.phone ?? ksNA.tr,
                    suffixText: '',
                  ),
                  StoreProfileLinkUpIconTextRow(
                    iconOrSvg: SvgPicture.asset(
                      kiWorldSvgImage,
                    ),
                    onPressed: null,
                    prefixText: storeController.storesData.value?.country ?? ksNA,
                    suffixText: '',
                  ),
                  StoreProfileLinkUpIconTextRow(
                    iconOrSvg: SvgPicture.asset(
                      kiStarSvgImage,
                      color: cAmberColor,
                    ),
                    onPressed: () {
                      Get.toNamed(krStoreReview);
                    },
                    prefixText: ksRating.tr,
                    suffixText:
                        "${storeController.storesData.value?.countPageRating.toString() ?? ksNA.tr} (${storeController.storesData.value?.countPageReviews.toString() ?? ksNA.tr})",
                  ),
                  kH20sizedBox,
                  Text(
                    ksLegalPapers.tr,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH8sizedBox,
                  Obx(() => SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: storeController.storeLegalPapersList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                            crossAxisCount: 4,
                            crossAxisSpacing: k16Padding,
                            mainAxisSpacing: k16Padding,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Image.network(
                                  storeController.storeLegalPapersList[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize70,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                  kH16sizedBox,
                ],
              ),
            ),
          ),
          kH8sizedBox,
          Container(
            color: cWhiteColor,
            child: CustomPostButton(
              name: storeController.storeName.value,
              profilePic: storeController.storeProfilePicture.value,
              onPressed: () async {
                Get.find<CreatePostController>().isPostedFromProfile.value = false;
                CreatePostHelper().resetCreatePostData();
                Get.find<KidsController>().isRouteFromKid.value = false;
                Get.find<CreatePostController>().isEditPost.value = false;
                Get.toNamed(krCreatePost);
                await Get.find<CreatePostController>().getCreatePost();
              },
            ),
          ),
          kH8sizedBox,
          Container(
            width: width,
            color: cWhiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH16sizedBox,
                  Text(
                    ksFeatured.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  kH16sizedBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FittedBox(
                      child: SizedBox(
                        width: width - 40,
                        height: 420,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => kW16sizedBox,
                          itemCount: storeController.featuredPostList.length,
                          itemBuilder: (context, index) {
                            var item = storeController.featuredPostList[index];
                            return Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: cWhiteColor,
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                                border: Border.all(color: cLineColor2, width: 1),
                              ),
                              child: CommonFeaturePostWidget(
                                isCommented: false,
                                isLiked: false,
                                isSharedPost: false,
                                userName: item.user?.fullName ?? ksNA,
                                postTime: Get.find<GlobalController>().postTimeDifference(item.createdAt ?? DateTime.now()),
                                isCategorized: true,
                                subCategory: null,

                                category: item.postCategory == null ? null : item.postCategory?.name ?? "", 
                                categoryIcon:
                                    item.postCategory == null ? null : Get.find<GlobalController>().getCategoryIcon(item.postCategory!.id),
                                categoryIconColor:
                                    item.postCategory == null ? null : Get.find<GlobalController>().getCategoryColor(item.postCategory!.id),
                                privacy: BipHip.world,
                                brandName: item.stores?.name ?? "",
                                title: item.title,
                                postText: item.content ?? '',
                                price: null, 
                                mediaList: item.images,
                                isSelfPost: true,
                                isInStock: true,
                                isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!,
                                giftCount: item.countStar!,
                                postID: item.id!,
                                userImage: storeController.storeProfilePicture.value,
                                taggedFriends: const [],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  kH12sizedBox,
                ],
              ),
            ),
          ),
          kH8sizedBox,
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => kH8sizedBox,
              itemCount: Get.find<GlobalController>().commonPostList.length,
              itemBuilder: (context, index) {
                return Container(
                  color: cWhiteColor,
                  width: width,
                  child: CommonPostWidget(
                    postIndex: index,
                  ),
                );
              }),
          if (storeController.allPostList.isNotEmpty && storeController.postListScrolled.value && storeController.postListSubLink.value != null)
            const HomePagePaginationShimmer(),
        ],
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

class StoreProfileLinkUpIconTextRow extends StatelessWidget {
  const StoreProfileLinkUpIconTextRow({super.key, required this.iconOrSvg, required this.prefixText, this.onPressed, required this.suffixText});

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
