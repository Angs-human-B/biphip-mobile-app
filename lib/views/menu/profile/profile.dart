import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';

import 'package:bip_hip/helpers/profile/profile_helper.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_friends_gridview.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_post_tab.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();
  final ProfileHelper profileHelper = ProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => profileController.isProfileLoading.value
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
                      title: '${(profileController.userData.value?.firstName)} ${profileController.userData.value?.lastName}',
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
                        if (homeController.timelinePostListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                            scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                            !homeController.timelinePostListScrolled.value) {
                          homeController.timelinePostListScrolled.value = true;
                          if (Get.find<GlobalController>().commonPostList.isNotEmpty) {
                            homeController.getMoreTimelinePostList();
                          }
                          if (homeController.allTimelinePostList.isNotEmpty && profileController.interestCatagoriesIndex.value != 0) {
                            homeController.getMoreFilteredTimelinePostList(categoryId: profileController.interestCatagoriesIndex.value, type: 2);
                          }
                          return true;
                        }
                        return false;
                      },
                      child: SingleChildScrollView(
                        controller: homeController.timelinePostListScrollController,
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
                                      profileHelper.coverPhotoEditBottomSheet(context);
                                    },
                                    child: Container(
                                      height: 150,
                                      width: width,
                                      decoration: const BoxDecoration(color: cBlackColor, border: Border(bottom: BorderSide(color: cLineColor))),
                                      child: Image.network(
                                        profileController.userData.value!.coverPhoto.toString(),
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
                                            profileHelper.profilePicEditBottomSheet(context);
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
                                                profileController.userData.value!.profilePicture.toString(),
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
                                              profileHelper.profilePicUploadBottomSheet(context);
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
                                        if (profileController.userData.value!.userPendent != null)
                                          Positioned(
                                            right: 6,
                                            top: 10,
                                            child: Container(
                                                height: h28,
                                                width: h28,
                                                decoration: BoxDecoration(
                                                  color: cTransparentColor,
                                                  borderRadius: BorderRadius.circular(26),
                                                ),
                                                child: Image.network(
                                                  profileController.userData.value!.userPendent!.pendent!.icon.toString(),
                                                  fit: BoxFit.cover,
                                                  filterQuality: FilterQuality.high,
                                                  errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(
                                                    context,
                                                    error,
                                                    stackTrace,
                                                    BipHip.badgesOutline,
                                                    kIconSize18,
                                                  ),
                                                  loadingBuilder: imageLoadingBuilder,
                                                )),
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
                                        profileHelper.coverPhotoUploadBottomSheet(context);
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
                                        '${profileController.userData.value!.firstName} ${profileController.userData.value!.lastName}',
                                        style: medium24TextStyle(cBlackColor),
                                      ),
                                    ),
                                    kH10sizedBox,
                                    if (profileController.userData.value!.starBalance != null)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.attach_money_sharp,
                                              color: cSecondaryColor,
                                              size: kIconSize14,
                                            ),
                                            Text(
                                              '2.57',
                                              style: medium14TextStyle(cSmallBodyTextColor),
                                            ),
                                            kW4sizedBox,
                                            const Icon(
                                              BipHip.giftNew,
                                              color: cSecondaryColor,
                                              size: kIconSize14,
                                            ),
                                            kW4sizedBox,
                                            Text(
                                              profileController.userData.value!.starBalance!.toString(),
                                              style: medium14TextStyle(cSmallBodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    kH12sizedBox,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          CustomElevatedButton(
                                            label: ksAddSelfie.tr,
                                            buttonHeight: 32,
                                            buttonWidth: 130,
                                            prefixIcon: BipHip.selfieNew,
                                            textStyle: semiBold16TextStyle(cWhiteColor),
                                            prefixIconSize: screenWiseSize(kIconSize18, 4),
                                            onPressed: () {},
                                          ),
                                          kW16sizedBox,
                                          CustomElevatedButton(
                                            label: ksEditProfile.tr,
                                            onPressed: () {
                                              Get.toNamed(krEditProfile);
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
                              kH12sizedBox,
                              DefaultTabController(
                                length: 2,
                                initialIndex: profileController.postSectionVisible.value ? 0 : 1,
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
                                              profileHelper.showProfileTabSection(value);
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
                                                  ksFriendsAndFamily.tr,
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
                              if (profileController.postSectionVisible.value) PostTab(),
                              if (!profileController.postSectionVisible.value) FriendFamilyTab(),
                              kHBottomSizedBox
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
