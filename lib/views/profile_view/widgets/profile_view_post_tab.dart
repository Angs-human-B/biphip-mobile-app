import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/common_feature_post_widget.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_post_tab.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_friend_family_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:flutter_svg/svg.dart';

class ProfileViewPostTab extends StatelessWidget {
  ProfileViewPostTab({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final HomeController homeController = Get.find<HomeController>();
  final KidsController kidsController = Get.find<KidsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: cWhiteColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ksDetails.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH12sizedBox,
                    if (profileViewController.isKidOrStoreProfile.value)
                      Column(
                        children: [
                          KidStoreProfileLinkUpIconTextRow(
                            iconOrSvg: const Icon(
                              BipHip.info,
                              size: kIconSize20,
                              color: cIconColor,
                            ),
                            onPressed: null,
                            prefixText: ksPage.tr,
                            suffixText: kidsController.kidOverviewData.value?.kids?.pageType ?? ksNA.tr,
                          ),
                          KidStoreProfileLinkUpIconTextRow(
                            iconOrSvg: SvgPicture.asset(kiParentSvgImageUrl),
                            prefixText: kidsController.kidOverviewData.value?.kids?.relation ?? ksNA,
                            suffixText: kidsController.kidOverviewData.value?.parent?.fullName ?? ksNA,
                            onPressed: null,
                          ),
                          CustomTextButton(
                            text: "See ${profileController.userData.value?.lastName}'s about info",
                            textStyle: medium16TextStyle(cPrimaryColor),
                            onPressed: () {
                              // Get.toNamed(); //!route a page from here
                            },
                            mainAxisAlignment: MainAxisAlignment.start,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    if (profileViewController.isKidOrStoreProfile.value == false)
                      Column(
                        children: [
                          LinkUpIconTextRow(
                            icon: BipHip.address,
                            onPressed: null,
                            prefixText: '${ksLivesIn.tr} ',
                            // suffixText: DateFormat("MMMM dd, yyyy").format(profileController.userData.value!.dob!),
                            suffixText: '${profileController.currentCityData.value?.city}',
                          ),
                          if (profileController.currentCityData.value?.city != null && profileController.currentCityData.value?.isCurrent == 1)
                            LinkUpIconTextRow(
                              icon: BipHip.location,
                              prefixText: '${ksLivesIn.tr} ',
                              suffixText: '${profileController.currentCityData.value?.city}',
                              onPressed: null,
                            ),
                          CustomTextButton(
                            text: "See ${profileController.userData.value?.lastName}'s about info",
                            textStyle: medium16TextStyle(cPrimaryColor),
                            onPressed: () {
                              Get.toNamed(krProfileViewAbout);
                            },
                            mainAxisAlignment: MainAxisAlignment.start,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            kH16sizedBox,
            if (Get.find<ProfileViewController>().isKidOrStoreProfile.value == false)
              Container(
                height: h8,
                color: cBackgroundColor,
              ),
            if (Get.find<ProfileViewController>().isKidOrStoreProfile.value == false) ProfileViewFriendFamilyWidget(),
            Container(
              height: h8,
              color: cBackgroundColor,
            ),
            kH16sizedBox,
            Container(
              color: cWhiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profileViewController.isKidOrStoreProfile.value == false)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Text(
                        ksCatagories.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                    ),
                  if (profileViewController.isKidOrStoreProfile.value == false)
                    SizedBox(
                      width: width,
                      height: 50,
                      child: ListView.builder(
                        itemCount: Get.find<CreatePostController>().createPostCategoryList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, i) {
                          return Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                              child: CustomChoiceChips(
                                label: Get.find<CreatePostController>().createPostCategoryList[i].name ?? "",
                                isSelected:
                                    (profileViewController.interestCatagoriesIndex.value == Get.find<CreatePostController>().createPostCategoryList[i].id),
                                onSelected: (value) {
                                  profileViewController.interestCatagoriesIndex.value = Get.find<CreatePostController>().createPostCategoryList[i].id!;
                                  if (profileViewController.interestCatagoriesIndex.value == 0) {
                                    Get.find<HomeController>().getTimelinePostList();
                                  } else if (profileViewController.interestCatagoriesIndex.value != 0) {
                                    Get.find<HomeController>()
                                        .getFilteredTimelinePostList(categoryId: profileViewController.interestCatagoriesIndex.value, type: 2);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            if (profileViewController.isKidOrStoreProfile.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          itemCount: kidsController.featuredPostList.length,
                          itemBuilder: (context, index) {
                            var item = kidsController.featuredPostList[index];
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
                                userName: item.user!.fullName!,
                                postTime: Get.find<GlobalController>().postTimeDifference(item.createdAt!),
                                isCategorized: true,
                                subCategory: null,
                                category: item.postCategory == null ? null : item.postCategory!.name,
                                categoryIcon: item.postCategory == null ? null : Get.find<GlobalController>().getCategoryIcon(item.postCategory!.id),
                                categoryIconColor: item.postCategory == null ? null : Get.find<GlobalController>().getCategoryColor(item.postCategory!.id),
                                privacy: BipHip.world,
                                kidName: item.kid == null ? null : item.kid!.name,
                                kidAge: item.kid == null ? null : item.kid!.age.toString(),
                                title: item.title,
                                postText: item.content ?? '',
                                price: null,
                                mediaList: item.images,
                                isSelfPost: true,
                                isInStock: true,
                                isCommentShown: true,
                                commentCount: item.countComment!,
                                shareCount: item.countShare!,
                                giftCount: item.countStar!,
                                postID: item.id!,
                                userImage: kidsController.kidOverviewData.value?.kids?.profilePicture ?? '',
                                taggedFriends: const [],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            kH12sizedBox,
            if (profileViewController.isKidOrStoreProfile.value)
              Container(
                height: h8,
                color: cBackgroundColor,
              ),
            Get.find<HomeController>().isTimelinePostLoading.value
                ? const PostCommonShimmer()
                : ListView.separated(
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
            if (Get.find<GlobalController>().commonPostList.isNotEmpty &&
                homeController.timelinePostListScrolled.value &&
                homeController.timelinePostListSubLink.value != null)
              const HomePagePaginationShimmer(),
            kH8sizedBox,
          ],
        ));
  }
}
