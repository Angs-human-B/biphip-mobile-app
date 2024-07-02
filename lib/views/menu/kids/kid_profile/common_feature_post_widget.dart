import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
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
  final bool isCommented, isLiked, isCategorized, isSelfPost, isCommentShown, isSharedPost, isInStock;
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
  final List<FriendFamilyUserData> taggedFriends;
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
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Aminul Islam Rana ', style: semiBold14TextStyle(cBlackColor)),
                  TextSpan(text: 'commented.', style: regular14TextStyle(cSmallBodyTextColor))
                ])),
              ],
            ),
          ),
        if (isCommented || isLiked) const CustomDivider(thickness: 1),
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
                  Row(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () async {
                          if ((postText != null && postText?.trim() != '') || mediaList.length > 1) {
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
      ],
    );
  }
}

