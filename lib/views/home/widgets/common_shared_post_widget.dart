import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/home_post_details_screen.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CommonSharedPostWidget extends StatelessWidget {
  CommonSharedPostWidget({
    super.key,
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
    this.postUpperContainerOnPressed,
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
    this.postIndex = 0,
    this.postList,
  });
  final bool isCategorized, isInStock;
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
  final RxList<PostData>? postList;
  final List<TaggedFriend> taggedFriends;
  final int postIndex, postID;
  final VoidCallback? postUpperContainerOnPressed;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH10sizedBox,
        InkWell(
          onTap: () async {
            Get.find<PostReactionController>().resetCommentAndReplyData();
            // postReactionController.userId.value =
            Get.to(() => HomePostDetails(
                  postIndex: postIndex,
                  postList: postList,
                  images: mediaList,
                  userName: userName,
                  userImage: userImage,
                  postTime: postTime,
                  // refId: refId,
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
            Get.find<PostReactionController>().refId.value = postID;

            // ll(userI);
            await Get.find<PostReactionController>().getCommentList(1, Get.find<PostReactionController>().refId.value);
            await Get.find<FriendController>().getFriendList();
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
        if (category == 'Selling')
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
        if (category == 'Selling')
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
        if (discount != null && category == 'Selling')
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding),
            child: Text(
              '${ksLastPrice.tr}: $mainPrice\$ ',
              style: regular14TextStyle(cSmallBodyTextColor).copyWith(decoration: TextDecoration.lineThrough),
            ),
          ),
        if (postText != null && postText != '')
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
        if (postText != null && postText!.length > 256)
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
        if (mediaList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Container(
              color: cWhiteColor,
              height: 302,
              width: width - 82,
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
                          width: mediaList.length > 3 ? ((width - 82) / 2) - 1 : width - 82,
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
                            width: ((width - 82) / 2) - 1,
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
                            width: mediaList.length < 3 ? (width - 82) : ((width - 82) / 2) - 1,
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
                            width: mediaList.length > 4 ? (width - 86) / 3 : ((width - 82) / 2) - 1,
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
                            width: mediaList.length < 5 ? ((width - 82) / 2) - 1 : (width - 86) / 3,
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
                                  width: (width - 86) / 3,
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
        kH12sizedBox,
      ],
    );
  }
}
