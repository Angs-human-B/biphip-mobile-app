import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/shimmers/menu/badges/badge_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/home_post_details_screen.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/views/menu/badges/badges_star_page.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/biding_insight.dart';
import 'package:bip_hip/widgets/post/biding_widget.dart';
import 'package:bip_hip/widgets/post/comment_widget.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/platform_action_section.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CommonPostWidget extends StatelessWidget {
  CommonPostWidget({
    super.key,
    required this.isCommented,
    required this.isLiked,
    required this.isCategorized,
    required this.userName,
    required this.postTime,
    required this.privacy,
    this.category,
    this.brandName,
    this.kidName,
    this.kidAge,
    this.title,
    this.price,
    this.categoryIcon,
    this.categoryIconColor,
    this.postText,
    required this.mediaList,
    required this.isSelfPost,
    required this.isCommentShown,
    required this.isSharedPost,
    required this.showBottomSection,
    this.postUpperContainerOnPressed,
    required this.commentCount,
    required this.shareCount,
    required this.giftCount,
    required this.postID,
    this.subCategory,
    this.productCategory,
    this.productCondition,
    this.discount,
    this.discountedPrice,
    required this.isInStock,
    this.mainPrice,
    this.platformName,
    this.platformLink,
    this.actionName,
    this.secondaryImage,
    required this.userImage,
    required this.taggedFriends,
    this.reactCount,
    this.postIndex = 0,
    this.refType = 0,
    this.refId = 0,
    this.onLikePressed,
    this.onLovePressed,
    this.onWowPressed,
    this.onHahaPressed,
    this.onSadPressed,
    this.onAngryPressed,
    this.selfReaction,
  });
  final bool isCommented, isLiked, isCategorized, isSelfPost, isCommentShown, isSharedPost, showBottomSection, isInStock;
  // final RxBool sharedPostSeeMore = RxBool(false);
  // final RxBool postSeeMore = RxBool(false);
  final String userName, postTime, userImage;
  final String? category,
      subCategory,
      productCategory,
      productCondition,
      discount,
      discountedPrice,
      brandName,
      kidName,
      kidAge,
      title,
      price,
      mainPrice,
      postText,
      platformName,
      platformLink,
      actionName,
      secondaryImage,
      selfReaction;
  final IconData? categoryIcon;
  final IconData privacy;
  final Color? categoryIconColor;
  final List mediaList;
  final List<TaggedFriend> taggedFriends;
  final CountReactions? reactCount;
  final int commentCount, shareCount, giftCount, postID;
  final int postIndex;
  final int refType;
  final int refId;
  final VoidCallback? postUpperContainerOnPressed;
  final void Function(Reaction<String>? reaction)? onLikePressed, onLovePressed, onWowPressed, onHahaPressed, onSadPressed, onAngryPressed;
  final HomeController homeController = Get.find<HomeController>();
  final RxBool showComment = RxBool(false);
  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLiked)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
            child: Row(
              children: [
                Stack(
                  children: [
                    const SizedBox(
                      width: 40,
                      height: 20,
                    ),
                    for (int index = 0; index < 3; index++)
                      Positioned(
                        left: index * 10,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: cWhiteColor, width: 1),
                          ),
                          child: Image.asset(
                            kiProfilePicImageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  ],
                ),
                kW8sizedBox,
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Aminul Islam Rana and 10 other ', style: semiBold14TextStyle(cBlackColor)),
                  TextSpan(text: 'liked it.', style: regular14TextStyle(cSmallBodyTextColor))
                ]))
              ],
            ),
          ),
        if (isCommented)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
            child: Row(
              children: [
                // kW8sizedBox,
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Aminul Islam Rana ', style: semiBold14TextStyle(cBlackColor)),
                  TextSpan(text: 'commented.', style: regular14TextStyle(cSmallBodyTextColor))
                ])),
              ],
            ),
          ),
        if (isCommented || isLiked) const CustomDivider(thickness: 1),
        kH10sizedBox,
        InkWell(
          onTap: () async {
            Get.to(() => HomePostDetails(
                  postIndex: postIndex,
                ));
            await Get.find<HomeController>().getPostData(postID);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: PostUpperContainer(
              userName: userName,
              postTime: postTime,
              isCategorized: isCategorized,
              category: category,
              categoryIcon: categoryIcon,
              categoryIconColor: categoryIconColor,
              privacy: privacy,
              brandName: brandName,
              kidName: kidName,
              kidAge: kidAge,
              title: title,
              subCategory: subCategory,
              userImage: userImage,
              secondaryImage: secondaryImage,
              taggedFriend: taggedFriends,
            ),
          ),
        ),
        kH8sizedBox,
        if ((category == 'News' || category == 'Selling') && isCategorized && title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
            child: Text(
              title!,
              overflow: TextOverflow.clip,
              style: semiBold14TextStyle(cBlackColor),
            ),
          ),
        if (productCondition != null && productCategory != null && category == 'Selling')
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding, right: kHorizontalPadding),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '$productCategory ${ksCondition.tr.toLowerCase()}: ',
                  style: semiBold14TextStyle(cSmallBodyTextColor),
                ),
                TextSpan(
                  text: '$productCondition',
                  style: semiBold14TextStyle(cBlackColor),
                ),
              ]),
            ),
          ),
        // check if it is selling post
        if (category == 'Selling' && isSelfPost)
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding, right: kHorizontalPadding),
            child: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: k4Padding),
                      child: Icon(
                        BipHip.info,
                        color: cIconColor,
                        size: kIconSize16,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: '${ksDuration.tr}: ',
                    style: semiBold14TextStyle(cSmallBodyTextColor),
                  ),
                  WidgetSpan(
                    child: Countdown(
                      seconds: homeController.getBiddingDuration(DateTime.parse('2024-01-04 20:18:04Z')),
                      build: (BuildContext context, double time) {
                        int hours = (time ~/ 3600).toInt();
                        int minutes = ((time % 3600) ~/ 60).toInt();
                        int seconds = (time % 60).toInt();
                        return Text(
                          '${hours}h: ${minutes}m: $seconds sec',
                          style: semiBold14TextStyle(cRedColor),
                        );
                      },
                      interval: const Duration(milliseconds: 100),
                      onFinished: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        if (category == 'Selling' && !isSelfPost)
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding, right: kHorizontalPadding),
            child: RichText(
              text: TextSpan(
                children: [
                  if (discount != null)
                    WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.baseline,
                      child: Padding(
                        padding: const EdgeInsets.only(right: k4Padding),
                        child: Text(
                          '-$discount% ',
                          style: regular14TextStyle(cRedColor),
                        ),
                      ),
                    ),
                  TextSpan(
                    text: '$price\$ ',
                    style: semiBold20TextStyle(cBlackColor),
                  ),
                  TextSpan(
                    text: isInStock ? '• ${ksInStock.tr}' : '• ${ksStockOut.tr}',
                    style: semiBold20TextStyle(isInStock ? cLinkColor : cRedColor),
                  ),
                ],
              ),
            ),
          ),
        if (discount != null && category == 'Selling' && !isSelfPost)
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding),
            child: Text(
              '${ksLastPrice.tr}: $mainPrice\$ ',
              style: regular14TextStyle(cSmallBodyTextColor).copyWith(decoration: TextDecoration.lineThrough),
            ),
          ),
        if (postText != '')
          Obx(() => Padding(
                padding: EdgeInsets.only(
                    left: kHorizontalPadding, right: kHorizontalPadding, bottom: (mediaList.isNotEmpty || category == 'Selling') ? k12Padding : 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: (homeController.seeMore.value && postText!.length > 256) ? 5 : null,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: postText,
                        style: (postText!.length < 150 && category != 'Selling' && mediaList.isEmpty)
                            ? regular20TextStyle(cBlackColor)
                            : regular14TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                ),
              )),
        if (postText!.length > 256)
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () {
                    homeController.seeMore.value = !homeController.seeMore.value;
                  },
                  child: Text(
                    homeController.seeMore.value ? ksSeeMore.tr : ksShowLess.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              )),
        if (isSharedPost)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: k8CircularBorderRadius,
                  border: Border.all(color: cLineColor),
                ),
                child: CommonPostWidget(
                  taggedFriends: [],
                  postID: 0,
                  reactCount: null,
                  isCommented: false,
                  isLiked: false,
                  mediaList: const [],
                  isCategorized: false,
                  userName: 'Steve Sanchez',
                  postTime: '5 hrs ago',
                  privacy: BipHip.world,
                  isSelfPost: false,
                  isCommentShown: false,
                  isSharedPost: false,
                  showBottomSection: false,
                  postText:
                      'When i was sixteen i won a great victory. I thought i would live to be a hundred. Now i know i shall not see thirty. None of us knows how our life may end.',
                  commentCount: 10,
                  shareCount: 10,
                  giftCount: 10,
                  isInStock: false,
                  userImage: userImage,
                )),
          ),
        if (mediaList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Container(
              color: cWhiteColor,
              height: 302,
              width: width - 40,
              child: Column(
                children: [
                  // if (mediaList.length > 0 )
                  Row(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () async {
                          if ((postText != null && postText?.trim() != '') || mediaList.length > 1) {
                            Get.toNamed(krHomePostDetailsScreen);
                            await Get.find<HomeController>().getPostData(postID);
                          } else {
                            Get.to(() => CommonPhotoView(
                                  image: Environment.imageBaseUrl + mediaList[0].path.toString(),
                                  postIndex: postIndex,
                                ));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                          height: mediaList.length < 2 ? 302 : 150,
                          width: mediaList.length > 3 ? (width - 42) / 2 : (width - 40),
                          child: ClipRRect(
                            borderRadius: k8CircularBorderRadius,
                            child: Image.network(
                              mediaList[0].fullPath.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.imageFile,
                                size: kIconSize120,
                                color: cIconColor,
                              ),
                              loadingBuilder: imageLoadingBuilder,
                              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                return child;
                              },
                            ),
                          ),
                        ),
                      ),
                      if (mediaList.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                            await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                mediaList[1].fullPath.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (mediaList.length > 1)
                    const SizedBox(
                      height: 2,
                    ),
                  Row(
                    children: [
                      if (mediaList.length < 4 && mediaList.length > 1)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                            await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length < 3 ? (width - 40) : (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                mediaList[1].fullPath.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                      if (mediaList.length < 4 && mediaList.length > 2)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 2)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                            await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length > 4 ? (width - 44) / 3 : (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                mediaList[2].fullPath.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                      if (mediaList.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            Get.toNamed(krHomePostDetailsScreen);
                            await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length < 5 ? (width - 42) / 2 : (width - 44) / 3,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                mediaList[3].fullPath.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                      if (mediaList.length > 4)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length >= 5)
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () async {
                                Get.to(() => HomePostDetailsScreen(
                                      postIndex: postIndex,
                                    ));
                                await Get.find<HomeController>().getPostData(postID);
                              },
                              child: Container(
                                  decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                  height: 150,
                                  width: (width - 44) / 3,
                                  child: ClipRRect(
                                    borderRadius: k8CircularBorderRadius,
                                    child: Image.network(
                                      mediaList[4].fullPath.toString(),
                                      fit: BoxFit.cover,
                                      color: mediaList.length > 5 ? cBlackColor.withOpacity(0.3) : null,
                                      colorBlendMode: mediaList.length > 5 ? BlendMode.multiply : null,
                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                        BipHip.imageFile,
                                        size: kIconSize120,
                                        color: cIconColor,
                                      ),
                                      loadingBuilder: imageLoadingBuilder,
                                      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                        return child;
                                      },
                                    ),
                                  )),
                            ),
                            if (mediaList.length > 5)
                              Positioned(
                                child: TextButton(
                                  style: kTextButtonStyle,
                                  onPressed: () {
                                    //Get.toNamed(krUploadedImageListPage);
                                  },
                                  child: Text(
                                    "${mediaList.length - 5} More",
                                    style: semiBold16TextStyle(cWhiteColor),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        if (showBottomSection)
          PostBottomSection(
            postIndex: postIndex,
            refType: refType,
            refId: refId,
            isSelfPost: isSelfPost,
            isCommentShown: isCommentShown,
            commentCount: commentCount,
            shareCount: shareCount,
            giftCount: giftCount,
            category: category,
            platformName: platformName,
            platformLink: platformLink,
            actionName: actionName,
            actionOnPressed: isSelfPost ? null : () {},
          ),
        if (reactCount != null || commentCount != 0 || shareCount != 0 || giftCount != 0)
          Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
            child: PostActivityStatusWidget(
              reactCount: (reactCount == null || reactCount!.all == 0) ? null : reactCount,
              reactionOnPressed: () {
                postReactionController.giftFilter(0);
                globalController.blankBottomSheet(context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
              },
              giftCount: giftCount,
              commentCount: commentCount,
              shareCount: shareCount,
              isGiftShown: true,
              giftOnPressed: () {
                postReactionController.giftFilter(0);
                globalController.blankBottomSheet(context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
          ),
          child: LikeSectionWidget(
            selfReaction: selfReaction,
            onAngryPressed: onAngryPressed,
            onHahaPressed: onHahaPressed,
            onLikePressed: onLikePressed,
            onLovePressed: onLovePressed,
            onSadPressed: onSadPressed,
            onWowPressed: onWowPressed,
            postIndex: postIndex,
            refType: refType,
            refId: refId,
            isGiftShown: true,
            likeOnTap: () {},
            giftOnPressed: () async {
              Get.find<PendentBadgesController>().resetBadgesData();
              postReactionController.postId.value = refId;
              globalController.commonBottomSheet(
                context: context,
                content: Obx(() =>
                    Get.find<PendentBadgesController>().isUserBadgeLoading.value || Get.find<PendentBadgesController>().isgetStarPriceLoading.value
                        ? const BadgeBottomSheetShimmer()
                        : GiftContent()),
                isScrollControlled: true,
                bottomSheetHeight: height * .9,
                onPressCloseButton: () {
                  Get.back();
                },
                onPressRightButton: null,
                rightText: '',
                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                title: ksSendGift.tr,
                isRightButtonShow: false,
              );
              await Get.find<PendentBadgesController>().getUserBadges();
              await Get.find<PendentBadgesController>().getStarPrice();
            },
            commentOnPressed: () async {
              showComment.value = !showComment.value;
              postReactionController.resetCommentAndReplyData();
              Get.to(() => HomePostDetails(
                    postIndex: postIndex,
                    images: mediaList,
                    userName: userName,
                    userImage: userImage,
                    postTime: postTime,
                    refId: refId,
                    category: category == null ? null : category ?? "",
                    categoryIcon: categoryIcon,
                    categoryIconColor: categoryIconColor,
                    kidName: kidName,
                    kidAge: kidAge,
                    brandName: brandName,
                    secondaryImage: secondaryImage,
                    title: title,
                    postText: postText,
                  ));
              // }
              // }
              postReactionController.refId.value = postID;
              await postReactionController.getCommentList(1, refId);
              await Get.find<FriendController>().getFriendList();
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CustomDivider(),
        ),
        kH12sizedBox,
        // PostBottomSection(isSelfPost: isSelfPost, isCommentShown: isCommentShown)
      ],
    );
  }
}

class PostBottomSection extends StatelessWidget {
  PostBottomSection(
      {super.key,
      required this.isSelfPost,
      required this.isCommentShown,
      required this.commentCount,
      required this.shareCount,
      required this.giftCount,
      this.category,
      this.platformName,
      this.platformLink,
      this.actionName,
      this.actionOnPressed,
      this.postIndex = 0,
      this.refType = 0,
      this.refId = 0});

  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final bool isSelfPost, isCommentShown;
  final int commentCount, shareCount, giftCount;
  final int postIndex;
  final int refType;
  final int refId;
  final String? category, platformName, platformLink, actionName;
  final VoidCallback? actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (category == 'Selling' && platformName != null)
          Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, bottom: k4Padding),
            child: PlatformActionSection(
              actionOnPressed: actionOnPressed,
              platformName: 'Jane clothing store',
              platformLink: 'www.facebook.com/janeclothing/sdasdsads',
              actionName: 'Learn more',
            ),
          ),
        if (isSelfPost && category == 'Selling')
          Padding(
            padding: const EdgeInsets.only(
              left: kHorizontalPadding,
              right: kHorizontalPadding,
            ),
            child: BiddingWidget(
              totalBids: 25,
              yourBid: 300,
              isPlaceBid: false,
              bidingOnPressed: () {
                globalController.blankBottomSheet(
                    context: context,
                    content: BiddingInsightsContent(
                      comment: bidingComments,
                    ),
                    isScrollControlled: true,
                    bottomSheetHeight: height * 0.7);
              },
            ),
          ),
        if (!isSelfPost && category == 'Selling')
          Padding(
            padding: const EdgeInsets.only(
              left: kHorizontalPadding,
              right: kHorizontalPadding,
            ),
            child: BiddingWidget(
              totalBids: 25,
              yourBid: postReactionController.yourBid.value,
              bidingOnPressed: () {
                if (postReactionController.yourBid.value == null) {
                  globalController.commonBottomSheet(
                    bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : null,
                    context: context,
                    content: PlaceBidContent(
                      desiredAmount: '100',
                      minimumBiddingAmount: '50',
                    ),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      postReactionController.yourBid.value = int.parse(postReactionController.bidingTextEditingController.text);
                      Get.back();
                    },
                    rightText: ksSubmit.tr,
                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                    title: ksPlaceABid.tr,
                    isRightButtonShow: true,
                    isScrollControlled: true,
                  );
                } else {
                  globalController.commonBottomSheet(
                    bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : null,
                    context: context,
                    content: BidAmount(
                      highestAmount: '350',
                      totalBid: '56',
                      desireAmount: '400',
                      yourBid: postReactionController.yourBid.value.toString(),
                    ),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      Get.back();
                      globalController.commonBottomSheet(
                        bottomSheetHeight: isDeviceScreenLarge() ? height * 0.3 : null,
                        context: context,
                        content: UpdateBidding(
                          yourBid: postReactionController.yourBid.value.toString(),
                        ),
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () {
                          Get.back();
                        },
                        rightText: ksUpdate.tr,
                        rightTextStyle: medium14TextStyle(cPrimaryColor),
                        title: ksUpdateBiddingAmount.tr,
                        isRightButtonShow: true,
                        isScrollControlled: true,
                      );
                    },
                    rightText: ksEdit.tr,
                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                    title: ksYourBidAmount.tr,
                    isRightButtonShow: true,
                    isScrollControlled: true,
                  );
                }
              },
              isPlaceBid: true,
            ),
          ),
      ],
    );
  }
}

class BiddingInsightsContent extends StatelessWidget {
  BiddingInsightsContent({super.key, required this.comment});

  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final List comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BidingInsight(highest: 500, lowest: 150),
            kH16sizedBox,
            Text(
              ksBids.tr,
              style: semiBold16TextStyle(cBlackColor),
            ),
            kH8sizedBox,
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: postReactionController.showMoreBiddingInsights.value ? 4 : comment.length,
                itemBuilder: (context, index) {
                  return CommentWidget(
                    profileImage: comment[index]['image'],
                    timePassed: '5',
                    isLikeButtonShown: true,
                    isReplyButtonShown: false,
                    isReactButtonShown: true,
                    comment: comment[index]['comment'],
                    isLink: false,
                    userName: comment[index]['userName'],
                    isImageComment: false,
                    isSendMessageShown: true,
                    isHideButtonShown: false,
                    replyList: const [],
                    refType: 1,
                    refId: 1,
                  );
                }),
            kH8sizedBox,
            if (postReactionController.showMoreBiddingInsights.value)
              SizedBox(
                width: width - 40,
                child: Center(
                    child: InkWell(
                        onTap: () {
                          postReactionController.showMoreBiddingInsights.value = false;
                        },
                        child: Text('Show more (40 more biddings)', style: medium16TextStyle(cPrimaryColor)))),
              )
          ],
        ),
      ),
    );
  }
}

class PlaceBidContent extends StatelessWidget {
  PlaceBidContent({super.key, this.desiredAmount, this.minimumBiddingAmount});

  final String? desiredAmount, minimumBiddingAmount;
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // height: h60,
          decoration: BoxDecoration(color: cPrimaryTint2Color, borderRadius: k8CircularBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: k20Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 110,
                  // height: 46,
                  child: Column(
                    children: [
                      Text(
                        ksDesiredAmount.tr,
                        style: semiBold14TextStyle(cBlackColor),
                      ),
                      kH4sizedBox,
                      InkWell(
                        onTap: () {
                          postReactionController.bidingTextEditingController.text = desiredAmount!;
                        },
                        child: Container(
                          height: 40,
                          width: 67,
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius, border: kLineBorder),
                          child: Center(child: Text('\$$desiredAmount', style: semiBold14TextStyle(cBlackColor))),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: k12Padding),
                  child: Container(
                    width: 1,
                    height: 60,
                    color: cPrimaryColor,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      ksMinimumBiddingAmount.tr,
                      textAlign: TextAlign.center,
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    InkWell(
                      onTap: () {
                        postReactionController.bidingTextEditingController.text = minimumBiddingAmount!;
                      },
                      child: Container(
                          height: 40,
                          width: 67,
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius, border: kLineBorder),
                          child: Center(child: Text('\$$minimumBiddingAmount', style: semiBold14TextStyle(cBlackColor)))),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        kH16sizedBox,
        Text(
          ksBidAmount.tr,
          style: semiBold14TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
            prefixIcon: Icons.attach_money_rounded, borderRadius: k8BorderRadius, controller: postReactionController.bidingTextEditingController)
      ],
    );
  }
}

class BidAmount extends StatelessWidget {
  const BidAmount({super.key, this.highestAmount, this.totalBid, this.desireAmount, this.yourBid});
  final String? highestAmount, totalBid, desireAmount, yourBid;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        kH16sizedBox,
        Text(ksDuration, style: regular16TextStyle(cSmallBodyTextColor)),
        kH8sizedBox,
        Countdown(
          seconds: Get.find<HomeController>().getBiddingDuration(DateTime.parse('2023-12-25 20:18:04Z')),
          build: (BuildContext context, double time) {
            int hours = (time ~/ 3600).toInt();
            int minutes = ((time % 3600) ~/ 60).toInt();
            int seconds = (time % 60).toInt();
            return Text(
              '${hours}h: ${minutes}m: $seconds sec',
              style: medium24TextStyle(cRedColor),
            );
          },
          interval: const Duration(milliseconds: 100),
          onFinished: () {},
        ),
        kH20sizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(color: cGreyBoxColor, borderRadius: k4CircularBorderRadius, border: kLineBorder),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: k4Padding, horizontal: k8Padding),
                child: Column(children: [
                  Text(
                    '\$$highestAmount',
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  Text(
                    ksHighestAmount.tr,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                ]),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: cGreyBoxColor, borderRadius: k4CircularBorderRadius, border: kLineBorder),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: k4Padding, horizontal: k8Padding),
                child: Column(children: [
                  Text(
                    '\$$totalBid',
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  Text(
                    ksTotalBid.tr,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                ]),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: cGreyBoxColor, borderRadius: k4CircularBorderRadius, border: kLineBorder),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: k4Padding, horizontal: k8Padding),
                child: Column(
                  children: [
                    Text(
                      '\$$desireAmount',
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksDesiredAmount1.tr,
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        kH24sizedBox,
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: cPrimaryTint2Color,
            borderRadius: k4CircularBorderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: k12Padding),
                child: Text('${ksYourBiddingAmountIs.tr}:', style: regular16TextStyle(cBlackColor)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: k12Padding),
                child: Text('\$$yourBid', style: regular16TextStyle(cBlackColor)),
              )
            ],
          ),
        )
      ],
    );
  }
}

class UpdateBidding extends StatelessWidget {
  const UpdateBidding({super.key, this.yourBid});
  final String? yourBid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentWidget(
          profileImage: kiProfileDefaultImageUrl,
          isLikeButtonShown: false,
          isReplyButtonShown: false,
          isReactButtonShown: false,
          comment: '\$$yourBid',
          isLink: false,
          userName: 'Omi',
          isImageComment: false,
          isSendMessageShown: false,
          isHideButtonShown: false,
          replyList: const [],
          refType: 1,
          refId: 1,
        ),
        kH4sizedBox,
        Wrap(
          alignment: WrapAlignment.start,
          spacing: h8,
          children: [
            CustomChoiceChips(label: 'Desired amount \$580', isSelected: false, onSelected: (v) {}),
            CustomChoiceChips(label: 'Highest amount \$580', isSelected: false, onSelected: (v) {}),
            CustomChoiceChips(label: 'Suggested amount \$580', isSelected: false, onSelected: (v) {})
          ],
        )
      ],
    );
  }
}

class BadgeTabViewContent extends StatelessWidget {
  BadgeTabViewContent({super.key});

  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 40,
              child: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                controller: postReactionController.tabController,
                isScrollable: true,
                tabs: [
                  ReactionBottomSheetTab(
                    isReactionImageShown: false,
                    reactionImage: '',
                    text: ksAll.tr,
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiLikeSvgImageUrl,
                    text: postReactionController.badgeCount1.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiLoveSvgImageUrl,
                    text: postReactionController.badgeCount2.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiHahaSvgImageUrl,
                    text: postReactionController.badgeCount3.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiWowSvgImageUrl,
                    text: postReactionController.badgeCount4.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiAngrySvgImageUrl,
                    text: postReactionController.badgeCount4.value.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (height * 0.9) - 65,
              child: TabBarView(controller: postReactionController.tabController, children: [
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionBottomSheetTab extends StatelessWidget {
  const ReactionBottomSheetTab({super.key, required this.isReactionImageShown, required this.reactionImage, required this.text});

  final bool isReactionImageShown;
  final String reactionImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width - 30) / 5,
      child: Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isReactionImageShown)
              SvgPicture.asset(
                reactionImage,
                width: 20,
              ),
            if (isReactionImageShown) kW8sizedBox,
            Text(
              text,
              style: isReactionImageShown ? regular12TextStyle(cBlackColor) : semiBold12TextStyle(cBlackColor),
            )
          ],
        ),
      ),
    );
  }
}

class ReactionTabPage extends StatelessWidget {
  const ReactionTabPage({super.key, required this.list});
  final List list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => kH8sizedBox,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          var item = list[index];
          return Padding(
            padding: const EdgeInsets.only(left: h8, right: h8),
            child: CustomListTile(
              leading: Stack(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(
                      child: Image.asset(item['image']),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        item['giftImage'],
                        height: 16,
                        width: 16,
                      ))
                ],
              ),
              title: item['name'],
              trailing: item['isFriend']
                  ? Text(
                      ksMessage.tr,
                      style: regular14TextStyle(cPrimaryColor),
                    )
                  : Text(
                      ksAddFriend.tr,
                      style: regular14TextStyle(cPrimaryColor),
                    ),
            ),
          );
        });
  }
}

class GiftContent extends StatelessWidget {
  GiftContent({super.key});

  // final PostReactionController postReactionController = Get.find<PostReactionController>();
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kH16sizedBox,
          // Text(
          //   ksAllStars.tr,
          //   style: semiBold14TextStyle(cBlackColor),
          // ),
          // kH16sizedBox,
          // SizedBox(
          //   child: GridView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: giftPackages.length,
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
          //       crossAxisCount: 3,
          //       crossAxisSpacing: k16Padding,
          //       mainAxisSpacing: k16Padding,
          //     ),
          //     itemBuilder: (BuildContext context, int index) {
          //       return InkWell(
          //         onTap: () {
          //           postReactionController.selectedPackage.value = giftPackages[index];
          //           postReactionController.selectedGiftIndex.value = index;
          //           postReactionController.isPackageSelected.value = true;
          //         },
          //         child: PackageGridViewContainer(
          //           index: index,
          //         ),
          //       );
          //     },
          //   ),
          // ),

          Text(
            ksAllBadges.tr,
            style: semiBold16TextStyle(cBlackColor),
          ),
          kH16sizedBox,
          SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pendentBadgesController.allBadgesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                crossAxisCount: 3,
                crossAxisSpacing: k16Padding,
                mainAxisSpacing: k16Padding,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    pendentBadgesController.isPackageSelected.value = true;
                    pendentBadgesController.selectedBadgeIndex.value = index;
                    pendentBadgesController.badgesCheckBox.value = false;
                    pendentBadgesController.badgesPaymentCheckBox.value = false;
                    pendentBadgesController.temporarytotalStarBuyAmount.value = 0;
                    pendentBadgesController.totalStarBuyAmount.value = 0;
                    pendentBadgesController.temporaryTotalStars.value = '';
                    pendentBadgesController.totalStars.value = '';
                    pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                    pendentBadgesController.starAmountTextEditingController.clear();
                    pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.allBadgesList[index].icon!;
                    pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.allBadgesList[index].star.toString();
                    pendentBadgesController.selectedBadgePrice.value = pendentBadgesController.allBadgesList[index].price.toString();
                    pendentBadgesController.selectedBadgeDescription.value = pendentBadgesController.allBadgesList[index].description!;
                    pendentBadgesController.badgeId.value = pendentBadgesController.allBadgesList[index].id!;
                    pendentBadgesController.badgesCheckBox.value = false;
                    pendentBadgesController.badgesPaymentCheckBox.value = false;
                    pendentBadgesController.badgesCardNumberTextEditingController.clear();
                    pendentBadgesController.badgesMMYYTextEditingController.clear();
                    pendentBadgesController.badgesCvvTextEditingController.clear();

                    // Get.toNamed(krPurchaseStar);
                  },
                  child: BadgesGridViewContainer(
                    index: index,
                    recommendedOrAllBadgesList: pendentBadgesController.allBadgesList,
                    badgeIcon: pendentBadgesController.allBadgesList[index].icon,
                    badgeName: pendentBadgesController.allBadgesList[index].name,
                    badgeStar: pendentBadgesController.allBadgesList[index].star.toString(),
                  ),
                );
              },
            ),
          ),
          kH20sizedBox,

          kH20sizedBox,
          CustomElevatedButton(
              label: ksGetStars.tr,
              buttonWidth: width - 40,
              onPressed: pendentBadgesController.isPackageSelected.value
                  ? () {
                      pendentBadgesController.selectedBadgeIndex.value = -1;
                      globalController.commonBottomSheet(
                          context: context,
                          content: PurchaseStarContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {},
                          rightText: '',
                          rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                          title: ksGiveStars.tr,
                          isRightButtonShow: false,
                          isScrollControlled: true,
                          bottomSheetHeight: height * .9);
                    }
                  : null),
        ],
      ),
    );
  }
}

class PackageGridViewContainer extends StatelessWidget {
  PackageGridViewContainer({
    super.key,
    required this.index,
  });

  final int index;
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: k8CircularBorderRadius,
            color: (postReactionController.selectedGiftIndex.value == index) ? cPrimaryTint3Color : cWhiteColor,
            border: Border.all(color: (postReactionController.selectedGiftIndex.value == index) ? cPrimaryColor : cLineColor)),
        child: Padding(
          padding: const EdgeInsets.all(k8Padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: k8CircularBorderRadius,
                child: SvgPicture.asset(
                  giftPackages[index]['badge'],
                  fit: BoxFit.fill,
                ),
              ),
              kH4sizedBox,
              Expanded(
                child: Text(
                  giftPackages[index]['packageName'],
                  style: semiBold14TextStyle(cBlackColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              kH4sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    BipHip.giftNew,
                    color: cSecondaryColor,
                    size: kIconSize12,
                  ),
                  kW4sizedBox,
                  Text(
                    giftPackages[index]['amount'],
                    style: regular10TextStyle(cBlackColor),
                  ),
                  kH12sizedBox,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchaseStarContent extends StatelessWidget {
  PurchaseStarContent({super.key});

  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  final FocusNode giftCommentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Row(
              children: [
                Text(
                  ksYourCurrentStar.tr,
                  style: regular12TextStyle(cIconColor),
                ),
                Text(
                  " (${pendentBadgesController.userBadgesData.value?.starBalance} of 200)",
                  style: regular12TextStyle(cIconColor),
                )
              ],
            ),
            kH4sizedBox,
            Container(
              height: 44,
              width: width,
              decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    BipHip.giftNew,
                    color: cSecondaryColor,
                    size: kIconSize16,
                  ),
                  kW4sizedBox,
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [cBlueLinearColor1, cBlueLinearColor2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      '${pendentBadgesController.userBadgesData.value?.starBalance}',
                      style: semiBold20TextStyle(cWhiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: k8Padding, left: 1),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        ksStars,
                        style: regular12TextStyle(cSmallBodyTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            kH24sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              ksYourSelectedPackage.tr,
              style: regular12TextStyle(cSmallBodyTextColor),
            ),
            kH8sizedBox,
            Obx(() => CustomListTile(
                  leading: Image.network(
                    pendentBadgesController.selectedBadgeIcon.value,
                    width: h20,
                    height: h20,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        kiProfileDefaultImageUrl,
                        height: h40,
                        width: h40,
                      );
                    },
                    loadingBuilder: imageLoadingBuilder,
                  ),
                  title: pendentBadgesController.totalStars.value != ''
                      ? '${pendentBadgesController.totalStars.value} stars'
                      : '${pendentBadgesController.selectedBadgeStar.value} stars',
                  borderColor: cPrimaryColor,
                  itemColor: cPrimaryTint2Color,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (pendentBadgesController.totalStars.value != '' &&
                                (int.parse(pendentBadgesController.totalStars.value) > pendentBadgesController.userBadgesData.value!.starBalance!))
                            ? '\$${pendentBadgesController.totalStarBuyAmount.value.toStringAsFixed(2)}'
                            : (int.parse(pendentBadgesController.selectedBadgeStar.value) > pendentBadgesController.userBadgesData.value!.starBalance!)
                                ? '\$${pendentBadgesController.selectedBadgePrice.value}'
                                : "",
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                )),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              ksAllStars.tr,
              style: regular12TextStyle(cIconColor),
            ),
            kH8sizedBox,
            Text(
              pendentBadgesController.selectedBadgeDescription.value,
              style: regular14TextStyle(cBlackColor),
            ),
            //*Not need now.
            // kH16sizedBox,
            // for (int i = 0; i < pendentBadgesController.benefitsList.length; i++)
            //   Padding(
            //     padding: const EdgeInsets.only(top: k4Padding),
            //     child: Row(
            //       children: [
            //         Container(
            //           width: 4,
            //           height: 4,
            //           decoration: const BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: cBlackColor,
            //           ),
            //         ),
            //         kW8sizedBox,
            //         Text(
            //           pendentBadgesController.benefitsList[i],
            //           style: regular12TextStyle(cBlackColor),
            //           overflow: TextOverflow.clip,
            //         ),
            //       ],
            //     ),
            //   ),
      
            kH16sizedBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${ksYouCanSendStars.tr}.",
                    style: regular12TextStyle(cBlackColor),
                  ),
                  TextSpan(
                    text: " ${ksLearnMoreAboutStars.tr}",
                    style: regular12TextStyle(cPrimaryColor),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                pendentBadgesController.temporarytotalStarBuyAmount.value = pendentBadgesController.totalStarBuyAmount.value;
                pendentBadgesController.temporaryTotalStars.value = pendentBadgesController.totalStars.value;
                pendentBadgesController.starAmountTextEditingController.text = pendentBadgesController.totalStars.value;
                if (pendentBadgesController.starAmountTextEditingController.text.toString().trim() == '') {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
                    content: PurchaseCustomStarContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: null,
                    rightText: '',
                    rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                    title: ksBuyCustomStar.tr,
                    isRightButtonShow: false);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: k16Padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      BipHip.plus,
                      color: cPrimaryColor,
                    ),
                    kW4sizedBox,
                    Text(
                      ksPurchaseCustomStar.tr,
                      style: semiBold14TextStyle(cPrimaryColor),
                    )
                  ],
                ),
              ),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              ksPopularPackage.tr,
              style: regular10TextStyle(cIconColor),
            ),
            kH16sizedBox,
            SizedBox(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pendentBadgesController.popularBadgesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: k8Padding),
                      child: Obx(() => CustomListTile(
                            onPressed: () {
                              // pendentBadgesController.selectedPackage.value = packages[index];
                              pendentBadgesController.selectedBadgeIndex.value = index;
                              pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.popularBadgesList[index].icon!;
                              pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.popularBadgesList[index].star.toString();
                              pendentBadgesController.selectedBadgePrice.value = pendentBadgesController.popularBadgesList[index].price.toString();
                              pendentBadgesController.selectedBadgeDescription.value = pendentBadgesController.popularBadgesList[index].description!;
                              pendentBadgesController.badgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                              pendentBadgesController.badgesCheckBox.value = false;
                              pendentBadgesController.badgesPaymentCheckBox.value = false;
                              pendentBadgesController.badgesCardNumberTextEditingController.clear();
                              pendentBadgesController.badgesMMYYTextEditingController.clear();
                              pendentBadgesController.badgesCvvTextEditingController.clear();
                              pendentBadgesController.resetPurchaseCustomStar();
                            },
                            leading: Image.network(
                              pendentBadgesController.popularBadgesList[index].icon!,
                              width: h20,
                              height: h20,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  kiProfileDefaultImageUrl,
                                  height: h20,
                                  width: h20,
                                );
                              },
                              loadingBuilder: imageLoadingBuilder,
                            ),
                            title: '${pendentBadgesController.popularBadgesList[index].star} stars',
                            borderColor: pendentBadgesController.selectedBadgeIndex.value == index ? cPrimaryColor : cLineColor,
                            itemColor: pendentBadgesController.selectedBadgeIndex.value == index ? cPrimaryTint3Color : cWhiteColor,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  (pendentBadgesController.popularBadgesList[index].star! > pendentBadgesController.userBadgesData.value!.starBalance!)
                                      ? '\$${pendentBadgesController.popularBadgesList[index].price}'
                                      : "",
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                kW8sizedBox,
                                Radio(
                                  value: index,
                                  groupValue: pendentBadgesController.selectedBadgeIndex.value,
                                  onChanged: (v) {
                                    pendentBadgesController.selectedBadgeIndex.value = int.parse(v.toString());
                                    pendentBadgesController.selectedBadgeIndex.value = index;
                                    pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.popularBadgesList[index].icon!;
                                    pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.popularBadgesList[index].star.toString();
                                    pendentBadgesController.selectedBadgePrice.value = pendentBadgesController.popularBadgesList[index].price.toString();
                                    pendentBadgesController.selectedBadgeDescription.value = pendentBadgesController.popularBadgesList[index].description!;
                                    pendentBadgesController.badgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                                    pendentBadgesController.badgesCheckBox.value = false;
                                    pendentBadgesController.badgesPaymentCheckBox.value = false;
                                    pendentBadgesController.badgesCardNumberTextEditingController.clear();
                                    pendentBadgesController.badgesMMYYTextEditingController.clear();
                                    pendentBadgesController.badgesCvvTextEditingController.clear();
                                    pendentBadgesController.resetPurchaseCustomStar();
                                  },
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Transform.translate(
                      offset: const Offset(-10.0, 0.0),
                      child: Checkbox(
                        value: pendentBadgesController.badgesCheckBox.value,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (v) {
                          pendentBadgesController.badgesCheckBox.value = !pendentBadgesController.badgesCheckBox.value;
                        },
                      ),
                    )),
                kW12sizedBox,
                Transform.translate(
                  offset: const Offset(-20, 0.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: InkWell(
                                onTap: () {
                                  pendentBadgesController.badgesCheckBox.value = !pendentBadgesController.badgesCheckBox.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.8),
                                  child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)),
                                ))),
                        TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            kH20sizedBox,
      
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    Get.find<GlobalController>().userImage.toString(),
                    width: h32,
                    height: h32,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(kiDummyImage1ImageUrl);
                    },
                    loadingBuilder: imageLoadingBuilder,
                  ),
                ),
                kW8sizedBox,
                Expanded(
                  child: CustomModifiedTextField(
                      borderRadius: h8,
                      focusNode: giftCommentFocusNode,
                      controller: Get.find<PostReactionController>().giftAddCommentTextEditingController,
                      prefixIcon: BipHip.search,
                      suffixIcon: Get.find<PostReactionController>().isGiftAddCommentSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                      hint: ksSearch.tr,
                      contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                      textInputStyle: regular16TextStyle(cBlackColor),
                      onSuffixPress: () {
                        Get.find<PostReactionController>().isGiftAddCommentSuffixIconVisible.value = false;
                        Get.find<PostReactionController>().giftAddCommentTextEditingController.clear();
                      },
                      onSubmit: (v) {
                        unfocus(context);
                        Get.find<PostReactionController>().isGiftAddCommentSuffixIconVisible.value = true;
                      },
                      onChanged: (v) {
                        if (Get.find<PostReactionController>().giftAddCommentTextEditingController.text.toString().trim() != '') {
                          Get.find<PostReactionController>().isGiftAddCommentSuffixIconVisible.value = true;
                        } else {
                          Get.find<PostReactionController>().isGiftAddCommentSuffixIconVisible.value = false;
                        }
                      }),
                ),
              ],
            ),
      
            kH24sizedBox,
            CustomElevatedButton(
                label: pendentBadgesController.totalStars.value == "" &&
                        (int.parse(pendentBadgesController.selectedBadgeStar.value) < pendentBadgesController.userBadgesData.value!.starBalance!)
                    ? "Send ${pendentBadgesController.selectedBadgeStar.value} stars"
                    : pendentBadgesController.totalStars.value != "" &&
                            ((int.parse(pendentBadgesController.totalStars.value) < pendentBadgesController.userBadgesData.value!.starBalance!))
                        ? "Send ${pendentBadgesController.totalStars.value} stars"
                        : ksNext.tr,
                buttonWidth: width - 40,
                onPressed: pendentBadgesController.badgesCheckBox.value
                    ? () async {
                        pendentBadgesController.badgesCheckBox.value = false;
                        pendentBadgesController.badgesPaymentCheckBox.value = false;
                        pendentBadgesController.badgesCardNumberTextEditingController.clear();
                        pendentBadgesController.badgesMMYYTextEditingController.clear();
                        pendentBadgesController.badgesCvvTextEditingController.clear();
                        if (pendentBadgesController.totalStars.value == "" &&
                                (int.parse(pendentBadgesController.selectedBadgeStar.value) < pendentBadgesController.userBadgesData.value!.starBalance!) ||
                            pendentBadgesController.totalStars.value != "" &&
                                ((int.parse(pendentBadgesController.totalStars.value) < pendentBadgesController.userBadgesData.value!.starBalance!))) {
                                  Get.back();
                                  Get.back();
                          Get.find<PostReactionController>().giftStar(pendentBadgesController.totalStars.value == ""
                              ? pendentBadgesController.selectedBadgeStar.value
                              : pendentBadgesController.totalStars.value);
                        } else {
                          Get.find<GlobalController>().commonBottomSheet(
                              context: context,
                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                              isScrollControlled: true,
                              content: GiftPurchasePaymentContent(),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {},
                              rightText: '',
                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                              title: ksPayNow.tr,
                              isRightButtonShow: false);
                        }
                      }
                    : null),
            kH20sizedBox,
          ],
        ),
      ),
    );
  }
}

class PurchaseCustomStarContent extends StatelessWidget {
  PurchaseCustomStarContent({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  BipHip.giftNew,
                  color: cSecondaryColor,
                  size: kIconSize50,
                ),
                kW12sizedBox,
                kH8sizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${pendentBadgesController.temporarytotalStarBuyAmount.value.toStringAsFixed(2)}',
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      pendentBadgesController.starAmountTextEditingController.text.toString().trim() == ''
                          ? '0 ${ksStarNew.tr}'
                          : '${pendentBadgesController.starAmountTextEditingController.text} ${ksStars.tr}',
                      style: semiBold14TextStyle(cPlaceHolderColor),
                    ),
                  ],
                ),
              ],
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            CustomModifiedTextField(
              controller: pendentBadgesController.starAmountTextEditingController,
              hint: ksAmountOfStar.tr,
              onChanged: (text) {
                if (pendentBadgesController.starAmountTextEditingController.text.toString().trim() != '' &&
                    pendentBadgesController.starAmountTextEditingController.text.toString().trim() != '0') {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = true;
                  pendentBadgesController.temporarytotalStarBuyAmount.value =
                      (double.parse(pendentBadgesController.starAmountTextEditingController.text.toString()) *
                          pendentBadgesController.starPriceData.value!.starPrice!.toDouble());
                  pendentBadgesController.temporaryTotalStars.value = pendentBadgesController.starAmountTextEditingController.text.toString().trim();
                } else {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                  pendentBadgesController.temporarytotalStarBuyAmount.value = 0;
                }
              },
              onSubmit: (text) {},
              inputAction: TextInputAction.done,
              inputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              fillColor: cWhiteColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: cLineColor2,
                  width: 1.0,
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ksYouWillPay.tr,
                    style: regular10TextStyle(cIconColor),
                  ),
                  TextSpan(
                    text: ' ${pendentBadgesController.starPriceData.value!.starPrice.toString()}\$ ',
                    style: regular10TextStyle(cGreenColor),
                  ),
                  TextSpan(
                    text: ksForEveryStar.tr,
                    style: regular10TextStyle(cIconColor),
                  ),
                ],
              ),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Obx(() => CustomElevatedButton(
                  buttonWidth: width - 40,
                  label: ksConfirm.tr,
                  onPressed: pendentBadgesController.isStarAmountConfirmButtonEnabled.value
                      ? () {
                          pendentBadgesController.totalStarBuyAmount.value = pendentBadgesController.temporarytotalStarBuyAmount.value;
                          pendentBadgesController.totalStars.value = pendentBadgesController.temporaryTotalStars.value;
                          pendentBadgesController.selectedBadgeIndex.value = -1;
                          pendentBadgesController.isPackageSelected.value = false;
                          pendentBadgesController.selectedBadgeDescription.value = "";
                          pendentBadgesController.badgeId.value = -1;
                          pendentBadgesController.badgeStar.value = pendentBadgesController.totalStars.value;
                          pendentBadgesController.badgePrice.value = pendentBadgesController.totalStarBuyAmount.value.toString();
                          pendentBadgesController.badgesCheckBox.value = false;
                          pendentBadgesController.badgesPaymentCheckBox.value = false;
                          pendentBadgesController.badgesCardNumberTextEditingController.clear();
                          pendentBadgesController.badgesMMYYTextEditingController.clear();
                          pendentBadgesController.badgesCvvTextEditingController.clear();
                          Get.back();
                          // Get.find<GlobalController>().commonBottomSheet(
                          //     context: context,
                          //     bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                          //     isScrollControlled: true,
                          //     content: GiftPurchasePaymentContent(),
                          //     onPressCloseButton: () {
                          //       Get.back();
                          //     },
                          //     onPressRightButton: () {},
                          //     rightText: '',
                          //     rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                          //     title: ksPayNow.tr,
                          //     isRightButtonShow: false);
                        }
                      : null,
                  textStyle: semiBold14TextStyle(cWhiteColor),
                )),
          ],
        ));
  }
}

// class PurchaseCustomStarContent extends StatelessWidget {
//   PurchaseCustomStarContent({super.key});
//   final PostReactionController postReactionController = Get.find<PostReactionController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Icon(
//                   BipHip.giftNew,
//                   color: cSecondaryColor,
//                   size: kIconSize50,
//                 ),
//                 kW12sizedBox,
//                 kH8sizedBox,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '\$${postReactionController.temporarytotalStarBuyAmount.value.toStringAsFixed(2)}',
//                       style: semiBold18TextStyle(cBlackColor),
//                     ),
//                     kH4sizedBox,
//                     Text(
//                       postReactionController.starAmountTextEditingController.text.toString().trim() == ''
//                           ? '0 ${ksStarNew.tr}'
//                           : '${postReactionController.starAmountTextEditingController.text} ${ksStars.tr}',
//                       style: semiBold14TextStyle(cPlaceHolderColor),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             kH16sizedBox,
//             const CustomDivider(),
//             kH16sizedBox,
//             CustomModifiedTextField(
//               controller: postReactionController.starAmountTextEditingController,
//               hint: ksAmountOfStar.tr,
//               onChanged: (text) {
//                 if (postReactionController.starAmountTextEditingController.text.toString().trim() != '' &&
//                     postReactionController.starAmountTextEditingController.text.toString().trim() != '0') {
//                   postReactionController.isStarAmountConfirmButtonEnabled.value = true;
//                   postReactionController.temporarytotalStarBuyAmount.value =
//                       (double.parse(postReactionController.starAmountTextEditingController.text.toString()) * postReactionController.perStarAmount.value);
//                   postReactionController.temporaryTotalStars.value = postReactionController.starAmountTextEditingController.text.toString().trim();
//                 } else {
//                   postReactionController.isStarAmountConfirmButtonEnabled.value = false;
//                   postReactionController.temporarytotalStarBuyAmount.value = 0;
//                 }
//               },
//               onSubmit: (text) {},
//               inputAction: TextInputAction.done,
//               inputType: TextInputType.number,
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               maxLength: 10,
//               fillColor: cWhiteColor,
//               border: const OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: cLineColor2,
//                   width: 1.0,
//                 ),
//               ),
//             ),
//             RichText(
//               textAlign: TextAlign.left,
//               overflow: TextOverflow.clip,
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: ksYouWillPay.tr,
//                     style: regular10TextStyle(cIconColor),
//                   ),
//                   TextSpan(
//                     text: ' ${postReactionController.perStarAmount.value}\$ ',
//                     style: regular10TextStyle(cGreenColor),
//                   ),
//                   TextSpan(
//                     text: ksForEveryStar.tr,
//                     style: regular10TextStyle(cIconColor),
//                   ),
//                 ],
//               ),
//             ),
//             kH16sizedBox,
//             const CustomDivider(),
//             kH16sizedBox,
//             Obx(() => CustomElevatedButton(
//                   buttonWidth: width - 40,
//                   label: ksConfirm.tr,
//                   onPressed: postReactionController.isStarAmountConfirmButtonEnabled.value
//                       ? () {
//                           postReactionController.totalStarBuyAmount.value = postReactionController.temporarytotalStarBuyAmount.value;
//                           postReactionController.totalStars.value = postReactionController.temporaryTotalStars.value;
//                           postReactionController.selectedPackage.value = giftPackages[0];
//                           postReactionController.selectedGiftIndex.value = -1;
//                           postReactionController.isPackageSelected.value = false;
//                           Get.back();
//                         }
//                       : null,
//                   textStyle: semiBold14TextStyle(cWhiteColor),
//                 )),
//           ],
//         ));
//   }
// }

class GiftPurchasePaymentContent extends StatelessWidget {
  GiftPurchasePaymentContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                kiPayment,
                width: h40,
                height: h40,
              ),
            ),
            kW12sizedBox,
            kH8sizedBox,
            Column(
              children: [
                Text(
                  '\$105.00',
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  '1000 stars',
                  style: semiBold14TextStyle(cPlaceHolderColor),
                ),
              ],
            ),
          ],
        ),
        kH20sizedBox,
        const CustomDivider(),
        kH20sizedBox,
        CustomModifiedTextField(
          controller: postReactionController.cardNumberController,
          hint: ksCardNumber.tr,
          inputType: TextInputType.number,
          inputAction: TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 16,
          textHintStyle: regular14TextStyle(cPlaceHolderColor),
          prefixIcon: BipHip.calendarFill,
          fillColor: cWhiteColor,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: cLineColor2,
              width: 1.0,
            ),
          ),
        ),
        kH20sizedBox,
        Row(
          children: [
            Expanded(
              child: CustomModifiedTextField(
                controller: postReactionController.mmyyStarController,
                hint: 'MM/YY',
                textHintStyle: regular14TextStyle(cPlaceHolderColor),
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (String value) {},
                maxLength: 6,
                fillColor: cWhiteColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: cLineColor2,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            kW20sizedBox,
            Expanded(
              child: CustomModifiedTextField(
                controller: postReactionController.cvvController,
                hint: ksCVV.tr,
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
                textHintStyle: regular14TextStyle(cPlaceHolderColor),
                fillColor: cWhiteColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: cLineColor2,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Transform.translate(
                  offset: const Offset(-10.0, 0.0),
                  child: Checkbox(
                    value: postReactionController.giftAgreeCheckBox.value,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (v) {
                      postReactionController.giftAgreeCheckBox.value = !postReactionController.giftAgreeCheckBox.value;
                    },
                  ),
                )),
            kW12sizedBox,
            Transform.translate(
              offset: const Offset(-20, 0.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: InkWell(
                            onTap: () {
                              postReactionController.giftAgreeCheckBox.value = !postReactionController.giftAgreeCheckBox.value;
                            },
                            child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)))),
                    TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                  ],
                ),
              ),
            ),
          ],
        ),
        kH16sizedBox,
        const CustomDivider(),
        kH16sizedBox,
        Obx(() => CustomElevatedButton(
            label: ksPayNow.tr,
            buttonHeight: 42,
            buttonWidth: width - 40,
            onPressed: postReactionController.giftAgreeCheckBox.value
                ? () {
                    Get.offAllNamed(krHome);
                  }
                : null)),
      ],
    );
  }
}
