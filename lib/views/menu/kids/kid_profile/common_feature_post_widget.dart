import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/biding_insight.dart';
import 'package:bip_hip/widgets/post/biding_widget.dart';
import 'package:bip_hip/widgets/post/comment_widget.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/platform_action_section.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CommonFeaturePostWidget extends StatelessWidget {
  CommonFeaturePostWidget({
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
      secondaryImage;
  final IconData? categoryIcon;
  final IconData privacy;
  final Color? categoryIconColor;
  final List mediaList;
  final List<TaggedFriend> taggedFriends;
  final CountReactions? reactCount;
  final int commentCount, shareCount, giftCount, postID;
  final int postIndex;
  final VoidCallback? postUpperContainerOnPressed;
  final HomeController homeController = Get.find<HomeController>();

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
            // Get.to(() => HomePostDetails(
            //       postIndex: postIndex,
            //     ));
            // await Get.find<HomeController>().getPostData(postID);
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
          Padding(
            padding: EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, bottom: mediaList.isNotEmpty ? k8Padding : 0),
            // child: RichText(
            //   textAlign: TextAlign.left,
            //   overflow: TextOverflow.ellipsis,
            //   maxLines: (homeController.seeMore.value && postText!.length > 100) ? 3 : null,
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: postText,
            //         style: (postText!.length < 150 && category != 'Selling' && mediaList.isEmpty)
            //             ? regular20TextStyle(cBlackColor)
            //             : regular14TextStyle(cBlackColor),
            //       ),
            //     ],
            //   ),
            // ),
            child: Container(
              constraints: BoxConstraints.tight(Size.fromHeight(52)),
              child: Text(
                postText ?? '',
                style: regular14TextStyle(cBlackColor),
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        if (postText!.length > 60)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: TextButton(
              style: kTextButtonStyle,
              onPressed: () {
                // Get.find<KidsController>().seeMore.value = !Get.find<KidsController>().seeMore.value;
              },
              child: Text(
                ksSeeMore.tr,
                style: semiBold14TextStyle(cPrimaryColor),
              ),
            ),
          ),
        kH8sizedBox,
        if (isSharedPost)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: k8CircularBorderRadius,
                  border: Border.all(color: cLineColor),
                ),
                child: CommonFeaturePostWidget(
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
              height: 252,
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
                            // Get.toNamed(krHomePostDetailsScreen);
                            // await Get.find<HomeController>().getPostData(postID);
                          } else {
                            Get.to(() => CommonPhotoView(
                                  image: mediaList[0].fullPath.toString(),
                                  postIndex: postIndex,
                                ));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                          height: mediaList.length < 2 ? 252 : 125,
                          width: mediaList.length > 3 ? (width - 46) / 2 : (width - 42),
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
                            // Get.to(() => HomePostDetailsScreen(
                            //       postIndex: postIndex,
                            //     ));
                            // await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 125,
                            width: (width - 46) / 2,
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
                            // Get.to(() => HomePostDetailsScreen(
                            //       postIndex: postIndex,
                            //     ));
                            // await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 125,
                            width: mediaList.length < 3 ? (width - 42) : (width - 46) / 2,
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
                            // Get.to(() => HomePostDetailsScreen(
                            //       postIndex: postIndex,
                            //     ));
                            // await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 125,
                            width: mediaList.length > 4 ? (width - 50) / 3 : (width - 42) / 2,
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
                            // Get.toNamed(krHomePostDetailsScreen);
                            // await Get.find<HomeController>().getPostData(postID);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 125,
                            width: mediaList.length < 5 ? (width - 46) / 2 : (width - 44) / 3,
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
                                // Get.to(() => HomePostDetailsScreen(
                                //       postIndex: postIndex,
                                //     ));
                                // await Get.find<HomeController>().getPostData(postID);
                              },
                              child: Container(
                                  decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                  height: 125,
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
            isSelfPost: isSelfPost,
            isCommentShown: isCommentShown,
            commentCount: commentCount,
            reactCount: reactCount,
            shareCount: shareCount,
            giftCount: giftCount,
            category: category,
            platformName: platformName,
            platformLink: platformLink,
            actionName: actionName,
            actionOnPressed: isSelfPost ? null : () {},
          ),
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
      this.reactCount,
      this.postIndex = 0});

  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final bool isSelfPost, isCommentShown;
  final RxBool showComment = RxBool(false);
  final int commentCount, shareCount, giftCount;
  final int postIndex;
  final CountReactions? reactCount;
  final String? category, platformName, platformLink, actionName;
  final VoidCallback? actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
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
            if (reactCount != null || commentCount != 0 || shareCount != 0 || giftCount != 0)
              Padding(
                padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
                child: PostActivityStatusWidget(
                  reactCount: reactCount,
                  reactionOnPressed: () {
                    postReactionController.giftFilter(0);
                    globalController.blankBottomSheet(
                        context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                  },
                  giftCount: giftCount,
                  commentCount: commentCount,
                  shareCount: shareCount,
                  isGiftShown: true,
                  giftOnPressed: () {
                    postReactionController.giftFilter(0);
                    globalController.blankBottomSheet(
                        context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
              ),
              child: LikeSectionWidget(
                postIndex: postIndex,
                isGiftShown: true,
                likeOnTap: () {},
                giftOnPressed: () {
                  postReactionController.resetGiftData();
                  globalController.commonBottomSheet(
                    context: context,
                    content: GiftContent(),
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
                },
                commentOnPressed: () {
                  showComment.value = !showComment.value;
                  ll(showComment);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: CustomDivider(),
            ),
            kH12sizedBox,
            if (isCommentShown && showComment.value)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: CommentWidget(
                  profileImage: kiDummyImage3ImageUrl,
                  comment:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam nisi, cras neque, lorem vel vulputate vitae aliquam. Pretium tristique nisi, ut commodo fames. Porttitor et sagittis egestas vitae metus, odio tristique amet, duis.',
                  timePassed: '30',
                  isLikeButtonShown: true,
                  commentLink: 'https://itnext.io/showing-url-preview-in-flutter-a3ad4ff9927e',
                  isReplyButtonShown: true,
                  isReactButtonShown: true,
                  isImageComment: true,
                  image: kiDummyImage3ImageUrl,
                  isLink: false,
                  reactCount: 1234,
                  userName: 'Monjurul Sharker Omi',
                  isSendMessageShown: false,
                  isHideButtonShown: true,
                  replyList: replyComment,
                ),
              ),
          ],
        ));
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
                    reactCount: 440,
                    userName: comment[index]['userName'],
                    isImageComment: false,
                    isSendMessageShown: true,
                    isHideButtonShown: false,
                    replyList: const [],
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
          reactCount: 0,
          userName: 'Omi',
          isImageComment: false,
          isSendMessageShown: false,
          isHideButtonShown: false,
          replyList: const [],
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

  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kH16sizedBox,
          Text(
            ksAllStars.tr,
            style: semiBold14TextStyle(cBlackColor),
          ),
          kH16sizedBox,
          SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: giftPackages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                crossAxisCount: 3,
                crossAxisSpacing: k16Padding,
                mainAxisSpacing: k16Padding,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    postReactionController.selectedPackage.value = giftPackages[index];
                    postReactionController.selectedGiftIndex.value = index;
                    postReactionController.isPackageSelected.value = true;
                  },
                  child: PackageGridViewContainer(
                    index: index,
                  ),
                );
              },
            ),
          ),
          kH20sizedBox,
          CustomElevatedButton(
              label: ksGetStars.tr,
              buttonWidth: width - 40,
              onPressed: postReactionController.isPackageSelected.value
                  ? () {
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

  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                ksYourCurrentStar.tr,
                style: regular12TextStyle(cIconColor),
              ),
              Text(
                " (${postReactionController.balance} of 200)",
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
                    '${postReactionController.balance}',
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
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          Obx(() => CustomListTile(
                leading: SvgPicture.asset(
                  kiBadgeSvgImageUrl,
                  width: 20,
                  height: 20,
                ),
                title: postReactionController.totalStars.value != ''
                    ? '${postReactionController.totalStars.value} stars'
                    : '${postReactionController.selectedPackage.value!['amount']} stars',
                borderColor: cPrimaryColor,
                itemColor: cPrimaryTint2Color,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount']) ||
                        (postReactionController.totalStars.value != '' && postReactionController.balance < int.parse(postReactionController.totalStars.value)))
                      Text(
                        postReactionController.totalStars.value != ''
                            ? "\$${postReactionController.totalStarBuyAmount.value.toStringAsFixed(2)}"
                            : "\$${postReactionController.selectedPackage.value!['cost']}",
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
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ksStarsThatYouPurchase.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                TextSpan(
                  text: ksLearnMoreAboutStars.tr,
                  style: regular12TextStyle(cPrimaryColor),
                ),
              ],
            ),
          ),
          if (postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount']) ||
              (postReactionController.totalStars.value != '' && postReactionController.balance < int.parse(postReactionController.totalStars.value)))
            InkWell(
              onTap: () {
                postReactionController.temporarytotalStarBuyAmount.value = postReactionController.totalStarBuyAmount.value;
                postReactionController.temporaryTotalStars.value = postReactionController.totalStars.value;
                postReactionController.starAmountTextEditingController.text = postReactionController.totalStars.value;
                if (postReactionController.starAmountTextEditingController.text.toString().trim() == '') {
                  postReactionController.isStarAmountConfirmButtonEnabled.value = false;
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
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      onPressed: () {
                        postReactionController.selectedPackage.value = packages[index];
                        postReactionController.resetPurchaseCustomStar();
                      },
                      leading: SvgPicture.asset(kiBadgeSvgImageUrl, width: 20, height: 20),
                      title: '${packages[index]['amount']} stars',
                      borderColor: postReactionController.selectedPackage.value == packages[index] ? cPrimaryColor : cLineColor,
                      itemColor: postReactionController.selectedPackage.value == packages[index] ? cPrimaryTint3Color : cWhiteColor,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (postReactionController.balance < int.parse(packages[index]['amount']))
                            Text(
                              '\$${packages[index]['cost']}',
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                          kW8sizedBox,
                          Radio(
                            value: packages[index],
                            groupValue: postReactionController.selectedPackage.value,
                            onChanged: (v) {
                              postReactionController.selectedPackage.value = v;
                            },
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      value: postReactionController.giftCheckBox.value,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (v) {
                        postReactionController.giftCheckBox.value = !postReactionController.giftCheckBox.value;
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
                                postReactionController.giftCheckBox.value = !postReactionController.giftCheckBox.value;
                              },
                              child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)))),
                      TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                    ],
                  ),
                ),
              ),
            ],
          ),
          kH8sizedBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(kiProfilePicImageUrl),
                ),
              ),
              kW8sizedBox,
              Expanded(
                child: CustomModifiedTextField(
                    hint: ksAddAommentWithYourGift.tr,
                    textHintStyle: regular12TextStyle(cSmallBodyTextColor),
                    inputAction: TextInputAction.done,
                    contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
                    borderRadius: 8,
                    controller: postReactionController.giftAddCommentTextEditingController),
              ),
            ],
          ),
          kH12sizedBox,
          CustomElevatedButton(
              label: postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount'])
                  ? ksNext.tr
                  : postReactionController.totalStars.value != ''
                      ? (postReactionController.balance < int.parse(postReactionController.totalStars.value))
                          ? ksNext.tr
                          : "${ksSend.tr} ${postReactionController.totalStars.value} ${ksStars.tr}"
                      : "${ksSend.tr} ${postReactionController.selectedPackage.value!['amount']} ${ksStars.tr}",
              buttonHeight: 42,
              buttonWidth: width - 40,
              onPressed: postReactionController.giftCheckBox.value
                  ? () {
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
                  : null),
        ],
      ),
    );
  }
}

class PurchaseCustomStarContent extends StatelessWidget {
  PurchaseCustomStarContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

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
                      '\$${postReactionController.temporarytotalStarBuyAmount.value.toStringAsFixed(2)}',
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      postReactionController.starAmountTextEditingController.text.toString().trim() == ''
                          ? '0 ${ksStarNew.tr}'
                          : '${postReactionController.starAmountTextEditingController.text} ${ksStars.tr}',
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
              controller: postReactionController.starAmountTextEditingController,
              hint: ksAmountOfStar.tr,
              onChanged: (text) {
                if (postReactionController.starAmountTextEditingController.text.toString().trim() != '' &&
                    postReactionController.starAmountTextEditingController.text.toString().trim() != '0') {
                  postReactionController.isStarAmountConfirmButtonEnabled.value = true;
                  postReactionController.temporarytotalStarBuyAmount.value =
                      (double.parse(postReactionController.starAmountTextEditingController.text.toString()) * postReactionController.perStarAmount.value);
                  postReactionController.temporaryTotalStars.value = postReactionController.starAmountTextEditingController.text.toString().trim();
                } else {
                  postReactionController.isStarAmountConfirmButtonEnabled.value = false;
                  postReactionController.temporarytotalStarBuyAmount.value = 0;
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
                    text: ' ${postReactionController.perStarAmount.value}\$ ',
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
                  onPressed: postReactionController.isStarAmountConfirmButtonEnabled.value
                      ? () {
                          postReactionController.totalStarBuyAmount.value = postReactionController.temporarytotalStarBuyAmount.value;
                          postReactionController.totalStars.value = postReactionController.temporaryTotalStars.value;
                          postReactionController.selectedPackage.value = giftPackages[0];
                          postReactionController.selectedGiftIndex.value = -1;
                          postReactionController.isPackageSelected.value = false;
                          Get.back();
                        }
                      : null,
                  textStyle: semiBold14TextStyle(cWhiteColor),
                )),
          ],
        ));
  }
}

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
