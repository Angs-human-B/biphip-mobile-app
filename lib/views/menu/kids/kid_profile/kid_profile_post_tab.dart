import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/common_feature_post_widget.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/post/post_button_widget.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class KidProfilePostSection extends StatelessWidget {
  KidProfilePostSection({super.key, required this.seeAllAboutOnPressed});
  final KidsController kidsController = Get.find<KidsController>();
  final VoidCallback? seeAllAboutOnPressed;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
                      color: cIconColor,
                    ),
                    onPressed: null,
                    prefixText: ksPage.tr,
                    suffixText: kidsController.kidOverviewData.value?.kids?.pageType ?? ksNA.tr,
                  ),
                  // if (profileController.currentCityData.value?.city != null && profileController.currentCityData.value?.isCurrent == 1)
                  KidStoreProfileLinkUpIconTextRow(
                    iconOrSvg: SvgPicture.asset(kiParentSvgImageUrl),
                    prefixText: kidsController.kidOverviewData.value?.kids?.relation ?? ksNA,
                    suffixText: kidsController.kidOverviewData.value?.parent?.fullName ?? ksNA,
                    onPressed: null,
                  ),
                  CustomTextButton(
                    text: ksSeeYourAboutInfo.tr,
                    textStyle: medium16TextStyle(cPrimaryColor),
                    onPressed: seeAllAboutOnPressed,
                    mainAxisAlignment: MainAxisAlignment.start,
                    padding: EdgeInsets.zero,
                  ),
                  kH16sizedBox,
                ],
              ),
            ),
          ),
          kH8sizedBox,
          Container(
            color: cWhiteColor,
            child: CustomPostButton(
              name: kidsController.kidOverviewData.value?.kids?.name ?? ksNA,
              profilePic: kidsController.kidOverviewData.value?.kids?.profilePicture ?? '',
              onPressed: () async {
                // Get.find<CreatePostController>().isPostedFromProfile.value = true;
                // CreatePostHelper().resetCreatePostData();
                CreatePostHelper().resetCreatePostData();
                Get.find<CreatePostController>().category.value = "Kids";
                kidsController.isRouteFromKid.value = true;
                Get.find<CreatePostController>().kidID.value = kidsController.selectedKidId.value;
                Get.find<CreatePostController>().postSecondaryCircleAvatar.value = kidsController.kidOverviewData.value?.kids?.profilePicture ?? "";
                await Get.find<CreatePostController>().getCreatePost();
                Get.toNamed(krCreatePost);
              },
            ),
          ),
          kH8sizedBox,
          Container(
            color: cWhiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
                  child: Text(
                    ksCatagories.tr,
                    style: semiBold14TextStyle(cBlackColor),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: 50,
                  child: ListView.builder(
                    itemCount: interestProfile.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, i) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                          child: CustomChoiceChips(
                            label: interestProfile[i],
                            isSelected: (kidsController.kidInterestCatagoriesIndex.value == i && kidsController.isKidInterestSelected.value),
                            onSelected: (value) {
                              kidsController.kidInterestCatagoriesIndex.value = i;
                              kidsController.isKidInterestSelected.value = value;
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
                                showBottomSection: false,
                                userName: item.user!.fullName!,
                                postTime: Get.find<HomeController>().postTimeDifference(item.createdAt!),
                                isCategorized: true,
                                subCategory: null, //API
                                category: item.postCategory == null ? null : item.postCategory!.name, //API
                                categoryIcon:
                                    item.postCategory == null ? null : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                                categoryIconColor:
                                    item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
                                privacy: BipHip.world,
                                // brandName: item.store == null ? null : item.store!.name, //API
                                kidName: item.kid == null ? null : item.kid!.name, //API
                                kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                                title: item.title, //API
                                postText: item.content ?? '', //API
                                price: null, //API
                                // mediaList: item.images,
                                mediaList: item.images,
                                isSelfPost: true,
                                isInStock: true,
                                isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
                                postID: item.id!,
                                userImage: kidsController.kidOverviewData.value?.kids?.profilePicture ?? '',
                                taggedFriends: const [],
                                // reactCount: item.countReactions,
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
          if (kidsController.allPostList.isNotEmpty)
            Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => kH8sizedBox,
                  itemCount: kidsController.allPostList.length,
                  itemBuilder: (context, index) {
                    var item = kidsController.allPostList[index];
                    return Container(
                      color: cWhiteColor,
                      width: width,
                      child: CommonPostWidget(
                        isCommented: index % 2 == 0,
                        isLiked: index % 2 != 0,
                        postIndex: index,
                        refType: 1,
                        refId: item.id!,
                        isSharedPost: false,
                        showBottomSection: true,
                        userName: item.user!.fullName!,
                        postTime: Get.find<HomeController>().postTimeDifference(item.createdAt),
                        isCategorized: true,
                        subCategory: null, //API
                        category: item.postCategory == null ? null : item.postCategory!.name,
                        categoryIcon: item.postCategory == null ? null : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                        categoryIconColor:
                            item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
                        privacy: BipHip.world,
                        kidName: item.kid!.name!,
                        kidAge: item.kid!.age?.toString(),
                        title: item.title,
                        postText: item.content ?? '',
                        price: null,
                        mediaList: item.images ,
                        isSelfPost: true,
                        isInStock: true,
                        isCommentShown: true, commentCount: item.countComment ?? 0, shareCount: item.countShare ?? 0, giftCount: item.countStar ?? 0,
                        postID: item.id!,
                        userImage: item.user!.profilePicture ?? '',
                        taggedFriends: const [],
                        onAngryPressed: (Reaction<String>? reaction) {
                          item.myReaction = Get.find<GlobalController>().getReaction(item.myReaction, "angry", 1, item.id);
                          kidsController.allPostList.replaceRange(index, index + 1, [item]);
                        },
                        onHahaPressed: (Reaction<String>? reaction) {
                          item.myReaction = Get.find<GlobalController>().getReaction(item.myReaction, "haha", 1, item.id);
                          kidsController.allPostList.replaceRange(index, index + 1, [item]);
                        },
                        onLikePressed: (Reaction<String>? reaction) {
                          item.myReaction = Get.find<GlobalController>().getReaction(item.myReaction, "like", 1, item.id);
                          kidsController.allPostList.replaceRange(index, index + 1, [item]);
                        },
                        onLovePressed: (Reaction<String>? reaction) {
                          item.myReaction = Get.find<GlobalController>().getReaction(item.myReaction, "love", 1, item.id);
                          kidsController.allPostList.replaceRange(index, index + 1, [item]);
                        },
                        onSadPressed: (Reaction<String>? reaction) {
                          item.myReaction = Get.find<GlobalController>().getReaction(item.myReaction, "sad", 1, item.id);
                          kidsController.allPostList.replaceRange(index, index + 1, [item]);
                        },
                        onWowPressed: (Reaction<String>? reaction) {
                          item.myReaction = Get.find<GlobalController>().getReaction(item.myReaction, "wow", 1, item.id);
                          kidsController.allPostList.replaceRange(index, index + 1, [item]);
                        },
                        selfReaction: item.myReaction,
                      ),
                    );
                  }),
            ),
          if (kidsController.allPostList.isNotEmpty && kidsController.postListScrolled.value && kidsController.postListSubLink.value != null)
            const HomePagePaginationShimmer(),
        ],
      ),
    );
  }
}
