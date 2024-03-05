import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/post/post_button_widget.dart';
import 'package:flutter_svg/svg.dart';

class KidProfile extends StatelessWidget {
  KidProfile({super.key, this.userName, this.profilePicture, this.coverPhoto});
  final String? userName;
  final String? profilePicture;
  final String? coverPhoto;

  // final ProfileController profileController = Get.find<ProfileController>();
  // final HomeController homeController = Get.find<HomeController>();
  // final ProfileHelper profileHelper = ProfileHelper();
  final KidsController kidsController = Get.find<KidsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: cBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: userName,
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
                          // profileHelper.coverPhotoEditBottomSheet(context);
                        },
                        child: Container(
                          height: 150,
                          width: width,
                          decoration: const BoxDecoration(color: cBlackColor, border: Border(bottom: BorderSide(color: cLineColor))),
                          child: Image.network(
                            coverPhoto ?? '',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(context, error, stackTrace, BipHip.imageFile, kIconSize120),
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
                                // profileHelper.profilePicEditBottomSheet(context);//!needed
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
                                    profilePicture ?? "",
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
                                  // profileHelper.profilePicUploadBottomSheet(context);//!needed
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
                            // Positioned(
                            //   right: 6,
                            //   top: 10,
                            //   child: Container(
                            //       height: h28,
                            //       width: h28,
                            //       decoration: BoxDecoration(
                            //         color: cGreyBoxColor,
                            //         borderRadius: BorderRadius.circular(26),
                            //         border: Border.all(color: cPrimaryColor, width: 1),
                            //       ),
                            //       child: SvgPicture.asset(kiBadge1SvgImageUrl)),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 60,
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            // profileHelper.coverPhotoUploadBottomSheet(context);//!needed
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
                            userName ?? "",
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
                            "500 Followers",
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
                                  // Get.toNamed(krEditProfile);
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
                        kH12sizedBox,
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
                                    color: cIconColor,
                                  ),
                                  onPressed: null,
                                  prefixText: '${ksPage.tr} ',
                                  suffixText: ksKid.tr,
                                ),
                                // if (profileController.currentCityData.value?.city != null && profileController.currentCityData.value?.isCurrent == 1)
                                KidStoreProfileLinkUpIconTextRow(
                                  iconOrSvg: SvgPicture.asset(kiParentSvgImageUrl),
                                  prefixText: 'Father',
                                  suffixText: ' Emma Isabella',
                                  onPressed: null,
                                ),
                                CustomTextButton(
                                  text: ksSeeYourAboutInfo.tr,
                                  textStyle: medium16TextStyle(cPrimaryColor),
                                  onPressed: () {
                                    // Get.toNamed(krEditProfile);
                                  },
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  padding: EdgeInsets.zero,
                                ),
                                kH16sizedBox,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kH8sizedBox,
                  Container(
                    color: cWhiteColor,
                    child: CustomPostButton(
                      name: userName ?? ksNA,
                      profilePic: profilePicture ?? '',
                      onPressed: () {
                        // Get.find<CreatePostController>().isPostedFromProfile.value = true;
                        // CreatePostHelper().resetCreatePostData();
                        Get.toNamed(krCreatePost);
                      },
                    ),
                  ),
                  kH12sizedBox,
                  // if (profileController.postSectionVisible.value) PostTab(),
                  // if (!profileController.postSectionVisible.value) FriendFamilyTab(),
                  // kHBottomSizedBox,
                  //! This section Must Chnage When the kid post is available
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => kH8sizedBox,
                      itemCount: Get.find<HomeController>().allTimelinePostList.length,
                      itemBuilder: (context, index) {
                        var item = Get.find<HomeController>().allTimelinePostList[index];
                        return Container(
                          color: cWhiteColor,
                          width: width,
                          child: CommonPostWidget(
                            isCommented: false,
                            isLiked: false,
                            isSharedPost: false,
                            showBottomSection: true,
                            userName: item.user!.fullName!,
                            postTime: Get.find<HomeController>().postTimeDifference(item.createdAt),
                            isCategorized: true,
                            subCategory: null, //API
                            category: item.postCategory == null ? null : item.postCategory!.name, //API
                            categoryIcon:
                                item.postCategory == null ? null : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                            categoryIconColor:
                                item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
                            privacy: BipHip.world,
                            brandName: item.store == null ? null : item.store!.name, //API
                            kidName: item.kid == null ? null : item.kid!.name, //API
                            kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                            title: item.title, //API
                            postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
                            price: null, //API

                            // mediaList: item.imageUrls, //API
                            mediaList: item.images,
                            isSelfPost: true,
                            isInStock: true,
                            isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!, postID: item.id!,
                            userImage: item.user!.profilePicture ?? '', taggedFriends: item.taggedFriends,
                            reactCount: item.countReactions,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
      // ),
      // ),
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
