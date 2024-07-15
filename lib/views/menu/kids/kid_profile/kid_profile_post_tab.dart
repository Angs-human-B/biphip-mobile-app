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
                                userName: item.user!.fullName!,
                                postTime: Get.find<GlobalController>().postTimeDifference(item.createdAt!),
                                isCategorized: true,
                                subCategory: null, 
                                category: item.postCategory == null ? null : item.postCategory!.name,
                                categoryIcon:
                                    item.postCategory == null ? null : Get.find<GlobalController>().getCategoryIcon(item.postCategory!.id),
                                categoryIconColor:
                                    item.postCategory == null ? null : Get.find<GlobalController>().getCategoryColor(item.postCategory!.id),
                                privacy: BipHip.world,
                                kidName: item.kid == null ? null : item.kid!.name, 
                                kidAge: item.kid == null ? null : item.kid!.age.toString(),
                                title: item.title, 
                                postText: item.content ?? '',
                                price: null, 
                                mediaList: item.images,
                                isSelfPost: true,
                                isInStock: true,
                                isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
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
                  kH12sizedBox,
                ],
              ),
            ),
          ),
          kH8sizedBox,
          if (Get.find<GlobalController>().commonPostList.isNotEmpty)
            Obx(
              () => ListView.separated(
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
            ),
          if (Get.find<GlobalController>().commonPostList.isNotEmpty && kidsController.postListScrolled.value && kidsController.postListSubLink.value != null)
            const HomePagePaginationShimmer(),
        ],
      ),
    );
  }
}
