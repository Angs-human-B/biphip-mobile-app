import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
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
    return Column(
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
            onPressed: () {
              // Get.find<CreatePostController>().isPostedFromProfile.value = true;
              // CreatePostHelper().resetCreatePostData();
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
                              postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
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

                // ListView.separated(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     separatorBuilder: (context, index) => kW16sizedBox,
                //     itemCount: Get.find<HomeController>().allTimelinePostList.length,
                //     itemBuilder: (context, index) {
                //       var item = Get.find<HomeController>().allTimelinePostList[index];
                //       return Container(
                //         width: width - 80,
                //         decoration: BoxDecoration(
                //           color: cWhiteColor,
                //           borderRadius: BorderRadius.circular(k8BorderRadius),
                //           border: Border.all(color: cLineColor2, width: 1),
                //         ),
                //         child: CommonPostWidget(
                //           isCommented: false,
                //           isLiked: false,
                //           isSharedPost: false,
                //           showBottomSection: false,
                //           userName: item.user!.fullName!,
                //           postTime: Get.find<HomeController>().postTimeDifference(item.createdAt),
                //           isCategorized: true,
                //           subCategory: null, //API
                //           category: item.postCategory == null ? null : item.postCategory!.name, //API
                //           categoryIcon: item.postCategory == null ? null : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                //           categoryIconColor:
                //               item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
                //           privacy: BipHip.world,
                //           brandName: item.store == null ? null : item.store!.name, //API
                //           kidName: item.kid == null ? null : item.kid!.name, //API
                //           kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                //           title: item.title, //API
                //           postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
                //           price: null, //API

                //           // mediaList: item.imageUrls, //API
                //           mediaList: item.images,
                //           isSelfPost: true,
                //           isInStock: true,
                //           isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
                //           postID: item.id!,
                //           userImage: item.user!.profilePicture ?? '', taggedFriends: item.taggedFriends,
                //           reactCount: item.countReactions,
                //         ),
                //       );
                //     }),
                kH12sizedBox,
              ],
            ),
          ),
        ),
        // if (profileController.postSectionVisible.value) PostTab(),
        // if (!profileController.postSectionVisible.value) FriendFamilyTab(),
        // kHBottomSizedBox,
        kH8sizedBox,
        //! This section Must Chnage When the kid post is available
        // ListView.separated(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     separatorBuilder: (context, index) => kH8sizedBox,
        //     itemCount: Get.find<HomeController>().allTimelinePostList.length,
        //     itemBuilder: (context, index) {
        //       var item = Get.find<HomeController>().allTimelinePostList[index];
        //       return Container(
        //         color: cWhiteColor,
        //         width: width,
        //         child: CommonPostWidget(
        //           isCommented: false,
        //           isLiked: false,
        //           isSharedPost: false,
        //           showBottomSection: true,
        //           userName: item.user!.fullName!,
        //           postTime: Get.find<HomeController>().postTimeDifference(item.createdAt),
        //           isCategorized: true,
        //           subCategory: null, //API
        //           category: item.postCategory == null ? null : item.postCategory!.name, //API
        //           categoryIcon: item.postCategory == null ? null : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
        //           categoryIconColor: item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
        //           privacy: BipHip.world,
        //           brandName: item.store == null ? null : item.store!.name, //API
        //           kidName: item.kid == null ? null : item.kid!.name, //API
        //           kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
        //           title: item.title, //API
        //           postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
        //           price: null, //API

        //           // mediaList: item.imageUrls, //API
        //           mediaList: item.images,
        //           isSelfPost: true,
        //           isInStock: true,
        //           isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!, postID: item.id!,
        //           userImage: item.user!.profilePicture ?? '', taggedFriends: item.taggedFriends,
        //           reactCount: item.countReactions,
        //         ),
        //       );
        //     }),

        // // ],
        //   ),
        // ),

        if (kidsController.allPostList.isNotEmpty)
          ListView.separated(
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
                    postIndex: index,
                    isCommented: index % 2 == 0,
                    isLiked: index % 2 != 0,
                    isSharedPost: false,
                    showBottomSection: true,
                    userName: item.user!.fullName!,
                    // postTime: homeController.postTimeDifference(item.createdAt),
                    postTime: '1 hour ago',
                    isCategorized: true,
                    category: item.postCategory == null ? null : item.postCategory!.name, //API
                    categoryIcon: item.postCategory == null ? null : kidsController.getCategoryIcon(item.postCategory!.id), // need change API
                    categoryIconColor: item.postCategory == null ? null : kidsController.getCategoryColor(item.postCategory!.id), // Based on API
                    privacy: BipHip.world,
                    // brandName: item.store == null ? null : item.store!.name, //API
                    // kidName: item.kid == null ? null : item.kid!.name, //API
                    // kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                    postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
                    // mediaList: item.images??[], //API
                    mediaList: const [], //!Must change for image type post
                    isSelfPost: index % 2 != 0,
                    isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
                    reactCount: item.countReactions,
                    postID: item.id!,
                    // secondaryImage: item.kid?.profilePicture ?? item.store?.profilePicture,
                    subCategory: null,
                    platformName: 'Jane Clothing',
                    platformLink: 'www.facebook.com/Clothing/lorem',
                    actionName: null,
                    title: item.title, //API
                    price: item.price.toString(), //API
                    mainPrice: '400',
                    discount: item.discount.toString(),
                    isInStock: false,
                    // productCondition: 'New',
                    // productCategory: 'Phone',
                    userImage: item.user!.profilePicture ?? '',
                    taggedFriends: [],
                    // taggedFriends: item.taggedFriends,
                  ),
                );
              }),
      ],
    );
  }
}
