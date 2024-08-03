import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_post_tab.dart';
import 'package:bip_hip/views/menu/store/store_profile/store_profile.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_friend_family_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:flutter_svg/svg.dart';

class ProfileViewPostTab extends StatelessWidget {
  ProfileViewPostTab({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final HomeController homeController = Get.find<HomeController>();
  // final KidsController kidsController = Get.find<KidsController>();
  final ProfileViewHelper profileViewHelper = ProfileViewHelper();

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
                    if (profileViewController.profileViewType.value == "kid")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KidStoreProfileLinkUpIconTextRow(
                            iconOrSvg: const Icon(
                              BipHip.info,
                              size: kIconSize20,
                              color: cIconColor,
                            ),
                            onPressed: null,
                            prefixText: ksPage.tr,
                            suffixText: profileViewController.userProfileViewKidData.value?.kid?.pageType ?? ksNA.tr,
                          ),
                          KidStoreProfileLinkUpIconTextRow(
                            iconOrSvg: SvgPicture.asset(kiParentSvgImageUrl),
                            prefixText: profileViewController.userProfileViewKidData.value?.kid?.relation ?? ksNA,
                            suffixText: profileViewController.userProfileViewKidData.value?.kid?.user?.fullName ?? ksNA,
                            onPressed: null,
                          ),
                        ],
                      ),
                    if (profileViewController.profileViewType.value == "store")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KidStoreProfileLinkUpIconTextRow(
                            iconOrSvg: const Icon(
                              BipHip.info,
                              size: kIconSize20,
                              color: cPrimaryColor,
                            ),
                            onPressed: null,
                            prefixText: '${ksPage.tr} ',
                            suffixText: profileViewController.profileViewStoreData.value?.store?.pageType ?? ksNA.tr,
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
                                "${profileViewController.profileViewStoreData.value?.store?.rating.toString() ?? ksNA.tr} (${profileViewController.profileViewStoreData.value?.store?.countPageReviews.toString() ?? ksNA.tr})",
                          ),
                        ],
                      ),
                    if ((profileViewController.profileViewType.value != "kid" && profileViewController.profileViewType.value != "store") &&
                        profileViewController.userProfileViewData.value?.currentCity?.city != null)
                      LinkUpIconTextRow(
                        icon: BipHip.address,
                        onPressed: null,
                        prefixText: '${ksLivesIn.tr} ',
                        suffixText: profileViewController.userProfileViewData.value!.currentCity?.city ?? ksNA.tr,
                      ),
                    if (profileViewController.userProfileViewData.value?.currentCity?.city != null &&
                        profileViewController.userProfileViewData.value?.currentCity?.isCurrent == 1)
                      LinkUpIconTextRow(
                        icon: BipHip.location,
                        prefixText: '${ksFrom.tr} ',
                        suffixText: profileViewController.userProfileViewData.value?.currentCity?.city ?? ksNA.tr,
                        onPressed: null,
                      ),
                    CustomTextButton(
                      text: "See ${ProfileViewHelper().getUserKidOrStoreLastName(type: profileViewController.profileViewType.value)} about info",
                      textStyle: medium16TextStyle(cPrimaryColor),
                      onPressed: () async {
                        if (profileViewController.profileViewType.value == "profile") {
                          await profileViewController.getProfileBasicInfo();
                          await profileViewController.getProfileViewWorkEducation();
                        }
                        if (profileViewController.profileViewType.value == "kid") {}
                        Get.toNamed(krProfileViewAbout);
                      },
                      mainAxisAlignment: MainAxisAlignment.start,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            kH16sizedBox,
            if (profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store")
              Container(
                height: h8,
                color: cBackgroundColor,
              ),
            if (profileViewController.profileViewType.value != "kid" || profileViewController.profileViewType.value != "store") ProfileViewFriendFamilyWidget(),
            // Container(
            //   height: h8,
            //   color: cBackgroundColor,
            // ),
            kH16sizedBox,
            Container(
              color: cWhiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profileViewController.profileViewType.value != "kid" && profileViewController.profileViewType.value != "store")
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Text(
                        ksCatagories.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                    ),
                  if (profileViewController.profileViewType.value != "kid" && profileViewController.profileViewType.value != "store")
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
                                    profileViewController.interestCatagoriesIndex.value++;
                                    profileViewController.getProfileViewPostList();
                                  } else if (profileViewController.interestCatagoriesIndex.value != 0) {
                                    profileViewController.getProfileViewPostList();
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
            //!for featured post
            // if (profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store")
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         ksFeatured.tr,
            //         style: semiBold18TextStyle(cBlackColor),
            //       ),
            //       kH16sizedBox,

            //       //! Kid and store feature post
            //       // SingleChildScrollView(
            //       //   scrollDirection: Axis.horizontal,
            //       //   child: FittedBox(
            //       //     child: SizedBox(
            //       //       width: width - 40,
            //       //       height: 420,
            //       //       child: ListView.separated(
            //       //         scrollDirection: Axis.horizontal,
            //       //         shrinkWrap: true,
            //       //         physics: const AlwaysScrollableScrollPhysics(),
            //       //         separatorBuilder: (context, index) => kW16sizedBox,
            //       //         itemCount: kidsController.featuredPostList.length,
            //       //         itemBuilder: (context, index) {
            //       //           var item = kidsController.featuredPostList[index];
            //       //           return Container(
            //       //             width: width,
            //       //             decoration: BoxDecoration(
            //       //               color: cWhiteColor,
            //       //               borderRadius: BorderRadius.circular(k8BorderRadius),
            //       //               border: Border.all(color: cLineColor2, width: 1),
            //       //             ),
            //       //             child: CommonFeaturePostWidget(
            //       //               isCommented: false,
            //       //               isLiked: false,
            //       //               isSharedPost: false,
            //       //               userName: item.user!.fullName!,
            //       //               postTime: Get.find<GlobalController>().postTimeDifference(item.createdAt!),
            //       //               isCategorized: true,
            //       //               subCategory: null,
            //       //               category: item.postCategory == null ? null : item.postCategory!.name,
            //       //               categoryIcon: item.postCategory == null ? null : Get.find<GlobalController>().getCategoryIcon(item.postCategory!.id),
            //       //               categoryIconColor: item.postCategory == null ? null : Get.find<GlobalController>().getCategoryColor(item.postCategory!.id),
            //       //               privacy: BipHip.world,
            //       //               kidName: item.kid == null ? null : item.kid!.name,
            //       //               kidAge: item.kid == null ? null : item.kid!.age.toString(),
            //       //               title: item.title,
            //       //               postText: item.content ?? '',
            //       //               price: null,
            //       //               mediaList: item.images,
            //       //               isSelfPost: true,
            //       //               isInStock: true,
            //       //               isCommentShown: true,
            //       //               commentCount: item.countComment!,
            //       //               shareCount: item.countShare!,
            //       //               giftCount: item.countStar!,
            //       //               postID: item.id!,
            //       //               userImage: kidsController.kidOverviewData.value?.kids?.profilePicture ?? '',
            //       //               taggedFriends: const [],
            //       //             ),
            //       //           );
            //       //         },
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),

            //     ],
            //   ),
            kH12sizedBox,
            profileViewController.isProfileViewPostLoading.value
                ? const PostCommonShimmer()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => kH8sizedBox,
                    itemCount: profileViewHelper.getUserKidOrStorePostsListLength(type: profileViewController.profileViewType.value),
                    itemBuilder: (context, index) {
                      return Container(
                        color: cWhiteColor,
                        width: width,
                        child: CommonPostWidget(
                          postIndex: index,
                        ),
                      );
                    }),
            if (profileViewController.profileViewPostList.isNotEmpty &&
                profileViewController.profileViewPostListScrolled.value &&
                profileViewController.profileViewPostListSubLink.value != null)
              const HomePagePaginationShimmer(),
            kH8sizedBox,
          ],
        ));
  }
}
