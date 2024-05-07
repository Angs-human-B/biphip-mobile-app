import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/models/post/new_post_comment.dart';
import 'package:bip_hip/shimmers/home/home_page_details_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/comment_textfield.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class SharePostDetails extends StatelessWidget {
  SharePostDetails({super.key});
  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    postReactionController.isFromSharePage.value = true;
    return Obx(
      () => homeController.isPostDetailsPageLoading.value
          ? const HomePostDetailsShimmer()
          : Container(
              color: cWhiteColor,
              child: Stack(
                children: [
                  SafeArea(
                    top: false,
                    child: Scaffold(
                      backgroundColor: cWhiteColor,
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(kAppBarSize),
                        //* info:: appBar
                        child: CustomAppBar(
                          hasBackButton: true,
                          isCenterTitle: true,
                          title: homeController.postData.value!.post.user?.fullName ?? ksNA.tr,
                          onBack: () {
                            Get.back();
                          },
                        ),
                      ),
                      body: Stack(
                        children: [
                          NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              if (homeController.postCommentListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                  scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                  !homeController.getPostCommentScrolled.value) {
                                homeController.getPostCommentScrolled.value = true;
                                if (homeController.postData.value!.post.comments.isNotEmpty) {
                                  homeController.getMorePostCommentList(null, 1, homeController.postData.value!.post.id!);
                                }
                                return true;
                              }
                              return false;
                            },
                            child: SizedBox(
                              height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                              child: SingleChildScrollView(
                                controller: homeController.postCommentListScrollController,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: k12Padding),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  SizedBox(
                                                    width: (homeController.postData.value!.post.kid?.profilePicture != null ||
                                                            homeController.postData.value!.post.store?.profilePicture != null)
                                                        ? 70
                                                        : h44,
                                                    child: Row(
                                                      children: [
                                                        ClipOval(
                                                          child: Container(
                                                            height: h44,
                                                            width: h44,
                                                            decoration: const BoxDecoration(
                                                              color: cBlackColor,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: Image.network(
                                                              homeController.postData.value!.post.user!.profilePicture ?? '',
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context, error, stackTrace) => const Icon(
                                                                BipHip.user,
                                                                size: kIconSize24,
                                                                color: cIconColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (homeController.postData.value!.post.kid?.profilePicture != null ||
                                                      homeController.postData.value!.post.store?.profilePicture != null)
                                                    Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      top: 0,
                                                      child: ClipOval(
                                                        child: Container(
                                                          height: h45,
                                                          width: h45,
                                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                                                          child: Image.network(
                                                            homeController.postData.value!.post.kid?.profilePicture ??
                                                                homeController.postData.value!.post.store?.profilePicture ??
                                                                "",
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context, error, stackTrace) => const Icon(
                                                              BipHip.user,
                                                              size: kIconSize24,
                                                              color: cIconColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              kW8sizedBox,
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 2.0),
                                                            child: RichText(
                                                              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.clip,
                                                              maxLines: 3,
                                                              text: TextSpan(
                                                                style: DefaultTextStyle.of(context).style.copyWith(height: 1.4),
                                                                children: [
                                                                  TextSpan(
                                                                    text: homeController.postData.value!.post.user!.fullName!,
                                                                    style: semiBold16TextStyle(cBlackColor),
                                                                  ),
                                                                  if (homeController.postData.value!.post.postCategory != null)
                                                                    TextSpan(
                                                                      text: ' ${ksPostedOn.tr} ',
                                                                      style: regular16TextStyle(cSmallBodyTextColor),
                                                                    ),
                                                                  if (homeController.postData.value!.post.postCategory != null)
                                                                    WidgetSpan(
                                                                      child: Row(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 0),
                                                                            child: Icon(
                                                                              Get.find<GlobalController>()
                                                                                  .getCategoryIcon(homeController.postData.value!.post.postCategory!.id),
                                                                              color: Get.find<GlobalController>()
                                                                                  .getCategoryColor(homeController.postData.value!.post.postCategory!.id),
                                                                              size: kIconSize14,
                                                                            ),
                                                                          ),
                                                                          if (homeController.postData.value!.post.postCategory != null)
                                                                            Text(
                                                                              " ${homeController.postData.value!.post.postCategory!.name!}",
                                                                              style: semiBold14TextStyle(Get.find<GlobalController>()
                                                                                  .getCategoryColor(homeController.postData.value!.post.postCategory!.id)),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  if (homeController.postData.value!.post.taggedFriends.isNotEmpty)
                                                                    TextSpan(
                                                                      text: ' ${ksWith.tr} ',
                                                                      style: regular16TextStyle(cSmallBodyTextColor),
                                                                    ),
                                                                  if (homeController.postData.value!.post.taggedFriends.isNotEmpty)
                                                                    TextSpan(
                                                                      text: '${homeController.postData.value!.post.taggedFriends[0].fullName}',
                                                                      style: semiBold16TextStyle(cBlackColor),
                                                                    ),
                                                                  if (homeController.postData.value!.post.taggedFriends.isNotEmpty &&
                                                                      homeController.postData.value!.post.taggedFriends.length == 2)
                                                                    TextSpan(
                                                                      text: ' & ${homeController.postData.value!.post.taggedFriends[1].fullName}',
                                                                      style: semiBold16TextStyle(cBlackColor),
                                                                    ),
                                                                  if (homeController.postData.value!.post.taggedFriends.isNotEmpty &&
                                                                      homeController.postData.value!.post.taggedFriends.length > 2)
                                                                    WidgetSpan(
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          Get.find<GlobalController>().commonBottomSheet(
                                                                              context: context,
                                                                              isScrollControlled: true,
                                                                              bottomSheetHeight: homeController.postData.value!.post.taggedFriends.length > 10
                                                                                  ? height * 0.6
                                                                                  : null,
                                                                              content: TaggedFriendContent(
                                                                                taggedFriend: homeController.postData.value!.post.taggedFriends,
                                                                              ),
                                                                              onPressCloseButton: () {
                                                                                Get.back();
                                                                              },
                                                                              onPressRightButton: () {},
                                                                              rightText: ksDone.tr,
                                                                              rightTextStyle: regular14TextStyle(cPrimaryColor),
                                                                              title: ksTaggedFriends.tr,
                                                                              isRightButtonShow: false);
                                                                        },
                                                                        child: Text(
                                                                          ' & ${homeController.postData.value!.post.taggedFriends.length - 1} others',
                                                                          style: semiBold16TextStyle(cBlackColor),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  const TextSpan(text: '\n'),
                                                                  WidgetSpan(
                                                                    baseline: TextBaseline.alphabetic,
                                                                    alignment: PlaceholderAlignment.baseline,
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(bottom: 0),
                                                                      child: Icon(
                                                                        globalController.privacyList.firstWhere(
                                                                          (element) => element['id'] == homeController.postData.value!.post.isPublic,
                                                                        )["icon"],
                                                                        color: cIconColor,
                                                                        size: kIconSize12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (homeController.postData.value!.post.postCategory?.name == 'Selling' &&
                                                                      homeController.postData.value!.post.store != null)
                                                                    TextSpan(
                                                                        text: ' (${homeController.postData.value!.post.store?.name})',
                                                                        style: semiBold14TextStyle(cBlackColor)),
                                                                  if (homeController.postData.value!.post.postCategory?.name == 'Kids' &&
                                                                      homeController.postData.value!.post.kid != null)
                                                                    TextSpan(
                                                                        text:
                                                                            ' (${homeController.postData.value!.post.kid?.name}, ${homeController.postData.value!.post.kid?.age})',
                                                                        style: semiBold14TextStyle(cBlackColor)),
                                                                  TextSpan(
                                                                      text:
                                                                          ' ${Get.find<GlobalController>().postTimeDifference(homeController.postData.value!.post.dateTime!)}',
                                                                      style: regular14TextStyle(cSmallBodyTextColor))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                      kH12sizedBox,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (homeController.postData.value!.post.title != null)
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
                                              child: Text(
                                                homeController.postData.value!.post.title!,
                                                overflow: TextOverflow.clip,
                                                style: semiBold14TextStyle(cBlackColor),
                                              ),
                                            ),
                                          if (homeController.postData.value!.post.content != null)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: kHorizontalPadding,
                                                  right: kHorizontalPadding,
                                                  bottom: (homeController.postData.value!.post.images.isNotEmpty) ? k16Padding : 0),
                                              child: RichText(
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.clip,
                                                maxLines: (homeController.postData.value!.post.content!.length > 256) ? 5 : null,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: homeController.postData.value!.post.content!,
                                                      style: (homeController.postData.value!.post.content!.length < 150 &&
                                                              homeController.postData.value!.post.images.isEmpty)
                                                          ? regular20TextStyle(cBlackColor)
                                                          : regular14TextStyle(cBlackColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (homeController.postData.value!.post.images.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, bottom: k12Padding),
                                              child: Container(
                                                color: cWhiteColor,
                                                height: 302,
                                                width: width - 40,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        TextButton(
                                                          style: kTextButtonStyle,
                                                          onPressed: () async {},
                                                          child: Container(
                                                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                                            height: homeController.postData.value!.post.images.length < 2 ? 302 : 150,
                                                            width: homeController.postData.value!.post.images.length > 3 ? (width - 42) / 2 : (width - 40),
                                                            child: ClipRRect(
                                                              borderRadius: k8CircularBorderRadius,
                                                              child: Image.network(
                                                                Environment.imageBaseUrl + homeController.postData.value!.post.images[0].path.toString(),
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
                                                        if (homeController.postData.value!.post.images.length > 3)
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                        if (homeController.postData.value!.post.images.length > 3)
                                                          TextButton(
                                                            style: kTextButtonStyle,
                                                            onPressed: () {
                                                              // Get.toNamed(krHomePostDetailsScreen);
                                                              //! need to create for shared post
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                                              height: 150,
                                                              width: (width - 42) / 2,
                                                              child: ClipRRect(
                                                                borderRadius: k8CircularBorderRadius,
                                                                child: Image.network(
                                                                  Environment.imageBaseUrl + homeController.postData.value!.post.images[1].path.toString(),
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
                                                    if (homeController.postData.value!.post.images.length > 1)
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                    Row(
                                                      children: [
                                                        if (homeController.postData.value!.post.images.length < 4 &&
                                                            homeController.postData.value!.post.images.length > 1)
                                                          TextButton(
                                                            style: kTextButtonStyle,
                                                            onPressed: () {
                                                              // Get.toNamed(krHomePostDetailsScreen);
                                                              //! need to create for shared post
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                                              height: 150,
                                                              width: homeController.postData.value!.post.images.length < 3 ? (width - 40) : (width - 42) / 2,
                                                              child: ClipRRect(
                                                                borderRadius: k8CircularBorderRadius,
                                                                child: Image.network(
                                                                  Environment.imageBaseUrl + homeController.postData.value!.post.images[1].path.toString(),
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
                                                        if (homeController.postData.value!.post.images.length < 4 &&
                                                            homeController.postData.value!.post.images.length > 2)
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                        if (homeController.postData.value!.post.images.length > 2)
                                                          TextButton(
                                                            style: kTextButtonStyle,
                                                            onPressed: () {
                                                              // Get.toNamed(krHomePostDetailsScreen);
                                                              //! need to create for shared post
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                                              height: 150,
                                                              width:
                                                                  homeController.postData.value!.post.images.length > 4 ? (width - 44) / 3 : (width - 42) / 2,
                                                              child: ClipRRect(
                                                                borderRadius: k8CircularBorderRadius,
                                                                child: Image.network(
                                                                  Environment.imageBaseUrl + homeController.postData.value!.post.images[2].path.toString(),
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
                                                        if (homeController.postData.value!.post.images.length > 3)
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                        if (homeController.postData.value!.post.images.length > 3)
                                                          TextButton(
                                                            style: kTextButtonStyle,
                                                            onPressed: () {
                                                              // Get.toNamed(krHomePostDetailsScreen);
                                                              //! need to create for shared post
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                                              height: 150,
                                                              width:
                                                                  homeController.postData.value!.post.images.length < 5 ? (width - 42) / 2 : (width - 44) / 3,
                                                              child: ClipRRect(
                                                                borderRadius: k8CircularBorderRadius,
                                                                child: Image.network(
                                                                  Environment.imageBaseUrl + homeController.postData.value!.post.images[3].path.toString(),
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
                                                        if (homeController.postData.value!.post.images.length > 4)
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                        if (homeController.postData.value!.post.images.length >= 5)
                                                          Stack(
                                                            alignment: AlignmentDirectional.center,
                                                            children: [
                                                              TextButton(
                                                                style: kTextButtonStyle,
                                                                onPressed: () {
                                                                  // Get.toNamed(krHomePostDetailsScreen);
                                                                  //! need to create for shared post
                                                                },
                                                                child: Container(
                                                                  decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                                                                  height: 150,
                                                                  width: (width - 44) / 3,
                                                                  child: ClipRRect(
                                                                    borderRadius: k8CircularBorderRadius,
                                                                    child: Image.network(
                                                                      Environment.imageBaseUrl + homeController.postData.value!.post.images[4].path.toString(),
                                                                      color: homeController.postData.value!.post.images.length > 5
                                                                          ? cBlackColor.withOpacity(0.3)
                                                                          : null,
                                                                      colorBlendMode:
                                                                          homeController.postData.value!.post.images.length > 5 ? BlendMode.multiply : null,
                                                                      fit: BoxFit.cover,
                                                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                                                        BipHip.imageFile,
                                                                        size: kIconSize120,
                                                                        color: cIconColor,
                                                                      ),
                                                                      loadingBuilder: imageLoadingBuilder,
                                                                      frameBuilder:
                                                                          (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                                                        return child;
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (homeController.postData.value!.post.images.length > 5)
                                                                Positioned(
                                                                  child: TextButton(
                                                                    style: kTextButtonStyle,
                                                                    onPressed: () {
                                                                      // Get.toNamed(krHomePostDetailsScreen);
                                                                    },
                                                                    child: Text(
                                                                      "${homeController.postData.value!.post.images.length - 5} More",
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                if (homeController.sharePostCountReaction.value == null)
                                                  const Expanded(
                                                    child: SizedBox(),
                                                  ),
                                                if (homeController.sharePostCountReaction.value != null)
                                                  InkWell(
                                                    child: ReactionView(
                                                      isPost: true,
                                                      reactCount: homeController.sharePostCountReaction,
                                                    ),
                                                  ),
                                                CommentShareRecord(
                                                  commentCount: homeController.postData.value!.post.countComment!,
                                                  isGiftShown: !(Get.find<GlobalController>().userId.value == homeController.postData.value!.post.user!.id),
                                                  giftCount: homeController.postData.value!.post.countStar!,
                                                  shareCount: homeController.postData.value!.post.countShare!,
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Theme(
                                                data: ThemeData(
                                                  splashColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                ),
                                                child: PopupMenuButton(
                                                  padding: EdgeInsets.zero,
                                                  offset: const Offset(0, -60),
                                                  elevation: 1,
                                                  onCanceled: () {},
                                                  position: PopupMenuPosition.over,
                                                  tooltip: '',
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem<int>(
                                                      height: 25,
                                                      onTap: null,
                                                      value: 1,
                                                      padding: EdgeInsets.zero,
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              splashFactory: InkRipple.splashFactory,
                                                              child: ReactionButton<String>(
                                                                itemSize: const Size.square(48),
                                                                onReactionChanged: (Reaction<String>? reaction) {
                                                                  homeController.postData.value!.post.countReactions = globalController.updateReaction(
                                                                      "love",
                                                                      homeController.postData.value!.post.myReaction,
                                                                      homeController.postData.value!.post.countReactions);
                                                                  homeController.sharePostCountReaction.value =
                                                                      homeController.postData.value!.post.countReactions?.value;
                                                                  homeController.postData.value!.post.myReaction = globalController.getReaction(
                                                                      homeController.postData.value!.post.myReaction,
                                                                      "love",
                                                                      1,
                                                                      homeController.postData.value!.post.id!);
                                                                  homeController.sharedPostMyReaction.value =
                                                                      homeController.postData.value!.post.myReaction?.value ?? "";
                                                                  // globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                                                                },
                                                                reactions: <Reaction<String>>[
                                                                  Reaction<String>(
                                                                    value: 'love',
                                                                    icon: SvgPicture.asset(
                                                                      kiLoveSvgImageUrl,
                                                                      width: 38,
                                                                    ),
                                                                  ),
                                                                ],
                                                                selectedReaction: Reaction<String>(
                                                                  value: 'love',
                                                                  icon: SvgPicture.asset(
                                                                    kiLoveSvgImageUrl,
                                                                    width: 38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                            ),
                                                            InkWell(
                                                              splashFactory: InkRipple.splashFactory,
                                                              child: ReactionButton<String>(
                                                                animateBox: true,
                                                                boxAnimationDuration: const Duration(milliseconds: 500),
                                                                itemAnimationDuration: const Duration(milliseconds: 500),
                                                                itemSize: const Size.square(48),
                                                                onReactionChanged: (Reaction<String>? reaction) {
                                                                  homeController.postData.value!.post.countReactions = globalController.updateReaction(
                                                                      "like",
                                                                      homeController.postData.value!.post.myReaction,
                                                                      homeController.postData.value!.post.countReactions);
                                                                  homeController.sharePostCountReaction.value =
                                                                      homeController.postData.value!.post.countReactions?.value;
                                                                  homeController.postData.value!.post.myReaction = globalController.getReaction(
                                                                      homeController.postData.value!.post.myReaction,
                                                                      "like",
                                                                      1,
                                                                      homeController.postData.value!.post.id!);
                                                                  homeController.sharedPostMyReaction.value =
                                                                      homeController.postData.value!.post.myReaction?.value ?? "";
                                                                  // globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                                                                },
                                                                reactions: <Reaction<String>>[
                                                                  Reaction<String>(
                                                                    value: 'like',
                                                                    icon: SvgPicture.asset(
                                                                      kiLikeSvgImageUrl,
                                                                      width: 38,
                                                                    ),
                                                                  ),
                                                                ],
                                                                selectedReaction: Reaction<String>(
                                                                  value: 'like',
                                                                  icon: SvgPicture.asset(
                                                                    kiLikeSvgImageUrl,
                                                                    width: 38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                            ),
                                                            InkWell(
                                                              splashFactory: InkRipple.splashFactory,
                                                              child: ReactionButton<String>(
                                                                itemSize: const Size.square(48),
                                                                onReactionChanged: (Reaction<String>? reaction) {
                                                                  homeController.postData.value!.post.countReactions = globalController.updateReaction(
                                                                      "haha",
                                                                      homeController.postData.value!.post.myReaction,
                                                                      homeController.postData.value!.post.countReactions);
                                                                  homeController.sharePostCountReaction.value =
                                                                      homeController.postData.value!.post.countReactions?.value;
                                                                  homeController.postData.value!.post.myReaction = globalController.getReaction(
                                                                      homeController.postData.value!.post.myReaction,
                                                                      "haha",
                                                                      1,
                                                                      homeController.postData.value!.post.id!);
                                                                  homeController.sharedPostMyReaction.value =
                                                                      homeController.postData.value!.post.myReaction?.value ?? "";
                                                                  // globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                                                                },
                                                                reactions: <Reaction<String>>[
                                                                  Reaction<String>(
                                                                    value: 'haha',
                                                                    icon: SvgPicture.asset(
                                                                      kiHahaSvgImageUrl,
                                                                      width: 38,
                                                                    ),
                                                                  ),
                                                                ],
                                                                selectedReaction: Reaction<String>(
                                                                  value: 'haha',
                                                                  icon: SvgPicture.asset(
                                                                    kiHahaSvgImageUrl,
                                                                    width: 38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                            ),
                                                            InkWell(
                                                              splashFactory: InkRipple.splashFactory,
                                                              child: ReactionButton<String>(
                                                                itemSize: const Size.square(48),
                                                                onReactionChanged: (Reaction<String>? reaction) {
                                                                  homeController.postData.value!.post.countReactions = globalController.updateReaction(
                                                                      "wow",
                                                                      homeController.postData.value!.post.myReaction,
                                                                      homeController.postData.value!.post.countReactions);
                                                                  homeController.sharePostCountReaction.value =
                                                                      homeController.postData.value!.post.countReactions?.value;
                                                                  homeController.postData.value!.post.myReaction = globalController.getReaction(
                                                                      homeController.postData.value!.post.myReaction,
                                                                      "wow",
                                                                      1,
                                                                      homeController.postData.value!.post.id!);
                                                                  homeController.sharedPostMyReaction.value =
                                                                      homeController.postData.value!.post.myReaction?.value ?? "";
                                                                  // globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                                                                },
                                                                reactions: <Reaction<String>>[
                                                                  Reaction<String>(
                                                                    value: 'wow',
                                                                    icon: SvgPicture.asset(
                                                                      kiWowSvgImageUrl,
                                                                      width: 38,
                                                                    ),
                                                                  ),
                                                                ],
                                                                selectedReaction: Reaction<String>(
                                                                  value: 'wow',
                                                                  icon: SvgPicture.asset(
                                                                    kiWowSvgImageUrl,
                                                                    width: 38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                            ),
                                                            InkWell(
                                                              splashFactory: InkRipple.splashFactory,
                                                              child: ReactionButton<String>(
                                                                itemSize: const Size.square(48),
                                                                onReactionChanged: (Reaction<String>? reaction) {
                                                                  homeController.postData.value!.post.countReactions = globalController.updateReaction(
                                                                      "sad",
                                                                      homeController.postData.value!.post.myReaction,
                                                                      homeController.postData.value!.post.countReactions);
                                                                  homeController.sharePostCountReaction.value =
                                                                      homeController.postData.value!.post.countReactions?.value;
                                                                  homeController.postData.value!.post.myReaction = globalController.getReaction(
                                                                      homeController.postData.value!.post.myReaction,
                                                                      "sad",
                                                                      1,
                                                                      homeController.postData.value!.post.id!);
                                                                  homeController.sharedPostMyReaction.value =
                                                                      homeController.postData.value!.post.myReaction?.value ?? "";
                                                                  // globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                                                                },
                                                                reactions: <Reaction<String>>[
                                                                  Reaction<String>(
                                                                    value: 'sad',
                                                                    icon: SvgPicture.asset(
                                                                      kiSadSvgImageUrl,
                                                                      width: 38,
                                                                    ),
                                                                  ),
                                                                ],
                                                                selectedReaction: Reaction<String>(
                                                                  value: 'sad',
                                                                  icon: SvgPicture.asset(
                                                                    kiSadSvgImageUrl,
                                                                    width: 38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                            ),
                                                            InkWell(
                                                              splashFactory: InkRipple.splashFactory,
                                                              child: ReactionButton<String>(
                                                                itemSize: const Size.square(48),
                                                                onReactionChanged: (Reaction<String>? reaction) {
                                                                  homeController.postData.value!.post.countReactions = globalController.updateReaction(
                                                                      "angry",
                                                                      homeController.postData.value!.post.myReaction,
                                                                      homeController.postData.value!.post.countReactions);
                                                                  homeController.sharePostCountReaction.value =
                                                                      homeController.postData.value!.post.countReactions?.value;
                                                                  homeController.postData.value!.post.myReaction = globalController.getReaction(
                                                                      homeController.postData.value!.post.myReaction,
                                                                      "angry",
                                                                      1,
                                                                      homeController.postData.value!.post.id!);
                                                                  homeController.sharedPostMyReaction.value =
                                                                      homeController.postData.value!.post.myReaction?.value ?? "";
                                                                  // globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                                                                },
                                                                reactions: <Reaction<String>>[
                                                                  Reaction<String>(
                                                                    value: 'angry',
                                                                    icon: SvgPicture.asset(
                                                                      kiAngrySvgImageUrl,
                                                                      width: 38,
                                                                    ),
                                                                  ),
                                                                ],
                                                                selectedReaction: Reaction<String>(
                                                                  value: 'angry',
                                                                  icon: SvgPicture.asset(
                                                                    kiAngrySvgImageUrl,
                                                                    width: 38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(180),
                                                  ),
                                                  child: SizedBox(
                                                    width: !(globalController.userId.value == homeController.postData.value!.post.user!.id)
                                                        ? (width - 40) / 4
                                                        : (width - 40) / 3,
                                                    height: 44,
                                                    child: homeController.sharedPostMyReaction.value == ""
                                                        ? globalController.getColoredReactionIcon(null)
                                                        : globalController.getColoredReactionIcon(homeController.sharedPostMyReaction),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                // onTap: commentOnPressed,
                                                child: SizedBox(
                                                  width: !(globalController.userId.value == homeController.postData.value!.post.user!.id)
                                                      ? (width - 40) / 4
                                                      : (width - 40) / 3,
                                                  height: 44,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        ksComment.tr,
                                                        style: semiBold12TextStyle(cIconColor),
                                                      ),
                                                      kW4sizedBox,
                                                      const Icon(
                                                        BipHip.commentOutline,
                                                        color: cIconColor,
                                                        size: kIconSize20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                child: SizedBox(
                                                  width: !(globalController.userId.value == homeController.postData.value!.post.user!.id)
                                                      ? (width - 40) / 4
                                                      : (width - 40) / 3,
                                                  height: 44,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        ksShare.tr,
                                                        style: semiBold12TextStyle(cIconColor),
                                                      ),
                                                      kW4sizedBox,
                                                      const Icon(
                                                        BipHip.shareOutline,
                                                        color: cIconColor,
                                                        size: kIconSize20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (!(globalController.userId.value == homeController.postData.value!.post.user!.id))
                                                InkWell(
                                                  child: SizedBox(
                                                    width: (width - 40) / 4,
                                                    height: 44,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          ksGift.tr,
                                                          style: semiBold12TextStyle(cIconColor),
                                                        ),
                                                        kW4sizedBox,
                                                        const Icon(
                                                          BipHip.gift,
                                                          color: cIconColor,
                                                          size: kIconSize20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
                                            child: CustomDivider(),
                                          ),
                                          kH12sizedBox,
                                          //* COMMENT SECTION
                                          if (postReactionController.isCommentPostLoading.value)
                                            const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                              child: SingleCommentShimmer(),
                                            ),
                                          if (homeController.postData.value!.post.comments.isNotEmpty)
                                            ListView.separated(
                                                separatorBuilder: (context, index) => kH8sizedBox,
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: homeController.postData.value!.post.comments.length,
                                                itemBuilder: (context, i) {
                                                  return Obx(() => Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                                            child: SharedPostCommentWidget(
                                                              sharedPostData: homeController.postData.value!.post,
                                                              commentIndex: i,
                                                              isLikeButtonShown: true,
                                                              isReplyButtonShown: true,
                                                              isReactButtonShown: true,
                                                              isHideButtonShown:
                                                                  globalController.userId.value == homeController.postData.value!.post.comments[i].user!.id,
                                                            ),
                                                          ),
                                                          kH8sizedBox,
                                                          if (homeController.postReplyShow.isNotEmpty &&
                                                              !homeController.postReplyShow[i] &&
                                                              homeController.postData.value!.post.comments[i].commentReplies.isNotEmpty)
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: k60Padding, right: k60Padding, bottom: k10Padding),
                                                              child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: InkWell(
                                                                      onTap: () async {
                                                                        homeController.postData.value!.post.comments[i].commentReplies.clear();
                                                                        homeController.postReplyShow[i] = true;
                                                                        await homeController.getPostReplyList(
                                                                            homeController.postData.value!.post.comments[i].id!, i);
                                                                      },
                                                                      child: Text(
                                                                        "View Replies",
                                                                        style: semiBold14TextStyle(cSmallBodyTextColor),
                                                                      ))),
                                                            ),
                                                          //* REPLY COMMENT SECTION
                                                          if (homeController.postReplyShow[i])
                                                            for (int index = 0;
                                                                index < homeController.postData.value!.post.comments[i].commentReplies.length;
                                                                index++)
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 0, right: kHorizontalPadding),
                                                                child: PostReplyCommentWidget(
                                                                  sharedPostData: homeController.postData.value!.post,
                                                                  commentIndex: i,
                                                                  replyIndex: index,
                                                                  isLikeButtonShown: true,
                                                                  isReplyButtonShown: true,
                                                                  isReactButtonShown: true,
                                                                ),
                                                              )
                                                        ],
                                                      ));
                                                }),
                                          if (homeController.isPostCommentLoading.value && !postReactionController.isCommentPostLoading.value)
                                            const CommentCommonShimmer()
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 110,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              decoration: const BoxDecoration(color: cWhiteColor, border: Border(top: BorderSide(color: cLineColor))),
                              padding: EdgeInsets.zero,
                              child: SizedBox(
                                  width: width,
                                  child: CommentTextField(
                                    hintText: postReactionController.commentId.value == -1 || postReactionController.isComment.value
                                        ? "${ksWriteAComment.tr} ..."
                                        : "${ksWriteAReply.tr} ...",
                                    onPressedCamera: () async {
                                      await Get.find<GlobalController>().selectImageSource(postReactionController.isCommentImageChanged,
                                          postReactionController.commentImageLink, postReactionController.commentImageFile, 'gallery', false);
                                      postReactionController.commentSendEnabled();
                                    },
                                    onPressedSend: () async {
                                      if (postReactionController.isUpdateComment.value) {
                                        await postReactionController.updateComment(context, homeController.postData.value!.post.id);
                                      } else if (postReactionController.isUpdateReply.value) {
                                        await postReactionController.updateReply(context, homeController.postData.value!.post.id);
                                      } else if (postReactionController.commentId.value == -1) {
                                        await postReactionController.postComment(1, homeController.postData.value!.post.id!, context, "comment");
                                        Get.find<FriendController>().mentionsList.removeLast();
                                        globalController.updateSharedPostCommentCount(true);
                                      } else if (postReactionController.commentId.value != -1) {
                                        await postReactionController.postComment(1, postReactionController.commentId.value, context, "reply");
                                        Get.find<FriendController>().mentionsList.removeLast();
                                        globalController.updateSharedPostCommentCount(true);
                                      }
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (postReactionController.isCommentDeleteLoading.value ||
                      postReactionController.isCommentHideLoading.value ||
                      postReactionController.isUpdateCommentLoading.value ||
                      postReactionController.isReplyDeleteLoading.value ||
                      postReactionController.isReplyHideLoading.value ||
                      postReactionController.isUpdateReplyLoading.value)
                    Positioned(
                      child: CommonLoadingAnimation(
                        onWillPop: () async {
                          if (postReactionController.isCommentDeleteLoading.value ||
                              postReactionController.isCommentHideLoading.value ||
                              postReactionController.isUpdateCommentLoading.value ||
                              postReactionController.isReplyDeleteLoading.value ||
                              postReactionController.isReplyHideLoading.value ||
                              postReactionController.isUpdateReplyLoading.value) {
                            return false;
                          }
                          return true;
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

class SharedPostCommentWidget extends StatelessWidget {
  SharedPostCommentWidget({
    super.key,
    required this.isLikeButtonShown,
    required this.isReplyButtonShown,
    required this.isReactButtonShown,
    required this.isHideButtonShown,
    this.profileOnPressed,
    required this.commentIndex,
    required this.sharedPostData,
  });
  final bool isLikeButtonShown, isReplyButtonShown, isReactButtonShown, isHideButtonShown;
  final int commentIndex;
  final VoidCallback? profileOnPressed;
  final PostDataRx sharedPostData;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: profileOnPressed,
          child: Container(
            width: h32,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.network(
                sharedPostData.comments[commentIndex].user!.profilePicture!,
                fit: BoxFit.cover,
                width: h32,
                height: h32,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  BipHip.user,
                  size: kIconSize16,
                  color: cIconColor,
                ),
                loadingBuilder: smallImageLoadingBuilder,
              ),
            ),
          ),
        ),
        kW8sizedBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: k8CircularBorderRadius,
              onTap: () {
                Get.find<PostReactionController>().commentId.value = sharedPostData.comments[commentIndex].id!;
                Get.find<PostReactionController>().selectedCommentIndex.value = commentIndex;
                Get.find<PostReactionController>().commentedUserId.value = sharedPostData.comments[commentIndex].user!.id!;
                Get.find<PostReactionController>().isUpdateReply.value = false;
                Get.find<GlobalController>().blankBottomSheet(
                  context: context,
                  bottomSheetHeight: height * 0.34,
                  content: PostCommentBottomSheetContent(
                    sharedPostData: sharedPostData,
                    commentIndex: commentIndex,
                  ),
                );
              },
              child: Container(
                width: width - 80,
                decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
                child: Padding(
                  padding: const EdgeInsets.all(k10Padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: profileOnPressed,
                        child: Text(
                          sharedPostData.comments[commentIndex].user!.fullName!,
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ),
                      kH8sizedBox,
                      if (sharedPostData.comments[commentIndex].comment != null)
                        Get.find<PostReactionController>().formatMentions(sharedPostData.comments[commentIndex].comment, context),

                      // if (isLink)
                      //   Text(
                      //     commentLink ?? '',
                      //     overflow: TextOverflow.clip,
                      //     style: regular14TextStyle(isLink ? cPrimaryColor : cBlackColor),
                      //   )
                    ],
                  ),
                ),
              ),
            ),
            if (sharedPostData.comments[commentIndex].image != null) kH4sizedBox,
            if (sharedPostData.comments[commentIndex].image != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  width: isDeviceScreenLarge() ? 150 : 120,
                  height: isDeviceScreenLarge() ? 150 : 120,
                  child: ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: Image.network(
                      sharedPostData.comments[commentIndex].image!,
                      fit: BoxFit.cover,
                      // errorBuilder: (context, error, stackTrace) => const Icon(
                      //   BipHip.user,
                      //   size: kIconSize16,
                      //   color: cIconColor,
                      // ),
                      // loadingBuilder: imageLoadingBuilder,
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: width - 80,
              height: 15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: k8Padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      globalController.postTimeDifference(sharedPostData.comments[commentIndex].createdAt!),
                      style: regular10TextStyle(cSmallBodyTextColor),
                    ),
                    kW16sizedBox,
                    Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: PopupMenuButton(
                        padding: EdgeInsets.zero,
                        offset: const Offset(0, -60),
                        elevation: 1,
                        onCanceled: () {},
                        position: PopupMenuPosition.over,
                        tooltip: '',
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            height: 25,
                            onTap: null,
                            value: 1,
                            padding: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    child: ReactionButton<String>(
                                      itemSize: const Size.square(48),
                                      onReactionChanged: (Reaction<String>? reaction) async {
                                        sharedPostData.comments[commentIndex].countReactions = globalController.updateReaction(
                                            "love", sharedPostData.comments[commentIndex].myReaction, sharedPostData.comments[commentIndex].countReactions);
                                        sharedPostData.comments[commentIndex].myReaction = await globalController.getReaction(
                                            sharedPostData.comments[commentIndex].myReaction, "love", 3, sharedPostData.comments[commentIndex].id);
                                        sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                      },
                                      reactions: <Reaction<String>>[
                                        Reaction<String>(
                                          value: 'love',
                                          icon: SvgPicture.asset(
                                            kiLoveSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ],
                                      selectedReaction: Reaction<String>(
                                        value: 'love',
                                        icon: SvgPicture.asset(
                                          kiLoveSvgImageUrl,
                                          width: 38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                  ),
                                  InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    child: ReactionButton<String>(
                                      animateBox: true,
                                      boxAnimationDuration: const Duration(milliseconds: 500),
                                      itemAnimationDuration: const Duration(milliseconds: 500),
                                      itemSize: const Size.square(48),
                                      onReactionChanged: (Reaction<String>? reaction) async {
                                        sharedPostData.comments[commentIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                            "like", sharedPostData.comments[commentIndex].myReaction, sharedPostData.comments[commentIndex].countReactions);
                                        sharedPostData.comments[commentIndex].myReaction = await globalController.getReaction(
                                            sharedPostData.comments[commentIndex].myReaction, "like", 3, sharedPostData.comments[commentIndex].id);
                                        sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                      },
                                      reactions: <Reaction<String>>[
                                        Reaction<String>(
                                          value: 'like',
                                          icon: SvgPicture.asset(
                                            kiLikeSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ],
                                      selectedReaction: Reaction<String>(
                                        value: 'like',
                                        icon: SvgPicture.asset(
                                          kiLikeSvgImageUrl,
                                          width: 38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                  ),
                                  InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    child: ReactionButton<String>(
                                      itemSize: const Size.square(48),
                                      onReactionChanged: (Reaction<String>? reaction) async {
                                        sharedPostData.comments[commentIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                            "haha", sharedPostData.comments[commentIndex].myReaction, sharedPostData.comments[commentIndex].countReactions);
                                        sharedPostData.comments[commentIndex].myReaction = await globalController.getReaction(
                                            sharedPostData.comments[commentIndex].myReaction, "haha", 3, sharedPostData.comments[commentIndex].id);
                                        sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                      },
                                      reactions: <Reaction<String>>[
                                        Reaction<String>(
                                          value: 'haha',
                                          icon: SvgPicture.asset(
                                            kiHahaSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ],
                                      selectedReaction: Reaction<String>(
                                        value: 'haha',
                                        icon: SvgPicture.asset(
                                          kiHahaSvgImageUrl,
                                          width: 38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                  ),
                                  InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    child: ReactionButton<String>(
                                      itemSize: const Size.square(48),
                                      onReactionChanged: (Reaction<String>? reaction) async {
                                        sharedPostData.comments[commentIndex].countReactions = globalController.updateReaction(
                                            "wow", sharedPostData.comments[commentIndex].myReaction, sharedPostData.comments[commentIndex].countReactions);
                                        sharedPostData.comments[commentIndex].myReaction = await globalController.getReaction(
                                            sharedPostData.comments[commentIndex].myReaction, "wow", 3, sharedPostData.comments[commentIndex].id);
                                        sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                      },
                                      reactions: <Reaction<String>>[
                                        Reaction<String>(
                                          value: 'wow',
                                          icon: SvgPicture.asset(
                                            kiWowSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ],
                                      selectedReaction: Reaction<String>(
                                        value: 'wow',
                                        icon: SvgPicture.asset(
                                          kiWowSvgImageUrl,
                                          width: 38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                  ),
                                  InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    child: ReactionButton<String>(
                                      itemSize: const Size.square(48),
                                      onReactionChanged: (Reaction<String>? reaction) async {
                                        sharedPostData.comments[commentIndex].countReactions = globalController.updateReaction(
                                            "sad", sharedPostData.comments[commentIndex].myReaction, sharedPostData.comments[commentIndex].countReactions);
                                        sharedPostData.comments[commentIndex].myReaction = globalController.getReaction(
                                            sharedPostData.comments[commentIndex].myReaction, "sad", 3, sharedPostData.comments[commentIndex].id);
                                        sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                      },
                                      reactions: <Reaction<String>>[
                                        Reaction<String>(
                                          value: 'sad',
                                          icon: SvgPicture.asset(
                                            kiSadSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ],
                                      selectedReaction: Reaction<String>(
                                        value: 'sad',
                                        icon: SvgPicture.asset(
                                          kiSadSvgImageUrl,
                                          width: 38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                  ),
                                  InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    child: ReactionButton<String>(
                                      itemSize: const Size.square(48),
                                      onReactionChanged: (Reaction<String>? reaction) {
                                        sharedPostData.comments[commentIndex].countReactions = globalController.updateReaction(
                                            "angry", sharedPostData.comments[commentIndex].myReaction, sharedPostData.comments[commentIndex].countReactions);
                                        sharedPostData.comments[commentIndex].myReaction = globalController.getReaction(
                                            sharedPostData.comments[commentIndex].myReaction, "angry", 3, sharedPostData.comments[commentIndex].id);
                                        sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                      },
                                      reactions: <Reaction<String>>[
                                        Reaction<String>(
                                          value: 'angry',
                                          icon: SvgPicture.asset(
                                            kiAngrySvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ],
                                      selectedReaction: Reaction<String>(
                                        value: 'angry',
                                        icon: SvgPicture.asset(
                                          kiAngrySvgImageUrl,
                                          width: 38,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180),
                        ),
                        child: globalController.getColoredCommentReaction(sharedPostData.comments[commentIndex].myReaction),
                      ),
                    ),
                    kW16sizedBox,
                    if (isReplyButtonShown)
                      InkWell(
                        onTap: () {
                          Get.find<PostReactionController>().commentMentionKey.currentState?.controller?.text = "";
                          Get.find<FriendController>()
                              .mentionsList
                              .removeWhere((map) => map['id'] == sharedPostData.comments[commentIndex].user!.id.toString());
                          if (globalController.userId.value != sharedPostData.comments[commentIndex].user!.id) {
                            Map<String, dynamic> friendMap = {
                              'id': sharedPostData.comments[commentIndex].user!.id.toString(),
                              'display': sharedPostData.comments[commentIndex].user!.fullName,
                              'full_name': sharedPostData.comments[commentIndex].user!.fullName,
                              'photo': sharedPostData.comments[commentIndex].user!.profilePicture,
                            };
                            Get.find<FriendController>().mentionsList.add(friendMap);
                            Get.find<PostReactionController>().commentMentionKey.currentState?.controller?.text =
                                "@${sharedPostData.comments[commentIndex].user?.fullName} ";
                          }
                          Get.find<PostReactionController>().commentFocusNode.requestFocus();
                          Get.find<PostReactionController>().commentId.value = sharedPostData.comments[commentIndex].id!;
                          Get.find<PostReactionController>().isComment.value = false;
                        },
                        child: Text(
                          ksReply.tr,
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    kW16sizedBox,
                    if (isHideButtonShown)
                      InkWell(
                        onTap: () async {
                          Get.find<PostReactionController>().commentId.value = sharedPostData.comments[commentIndex].id!;
                          await Get.find<PostReactionController>().hideComment();
                        },
                        child: Text(
                          ksHide.tr,
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    const Spacer(),
                    if (isReactButtonShown)
                      ReactionView(
                          isPost: false,
                          reactCount: (sharedPostData.comments[commentIndex].countReactions == null ||
                                  sharedPostData.comments[commentIndex].countReactions!.value.all!.value == 0)
                              ? null
                              : sharedPostData.comments[commentIndex].countReactions)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PostReplyCommentWidget extends StatelessWidget {
  PostReplyCommentWidget({
    super.key,
    required this.isLikeButtonShown,
    required this.isReplyButtonShown,
    required this.isReactButtonShown,
    this.profileOnPressed,
    required this.commentIndex,
    required this.replyIndex,
    required this.sharedPostData,
  });

  final bool isLikeButtonShown, isReplyButtonShown, isReactButtonShown;
  final int commentIndex, replyIndex;
  final VoidCallback? profileOnPressed;
  final PostDataRx sharedPostData;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    CommentReply reply = sharedPostData.comments[commentIndex].commentReplies[replyIndex];
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: profileOnPressed,
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.network(
                reply.user!.profilePicture!,
                fit: BoxFit.cover,
                width: h32,
                height: h32,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  BipHip.user,
                  size: kIconSize30,
                  color: cIconColor,
                ),
                loadingBuilder: smallImageLoadingBuilder,
              ),
            ),
          ),
        ),
        kW8sizedBox,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: k8CircularBorderRadius,
              onTap: () {
                Get.find<PostReactionController>().replyId.value = reply.id!;
                Get.find<PostReactionController>().selectedReplyIndex.value = replyIndex;
                Get.find<PostReactionController>().commentId.value = sharedPostData.comments[commentIndex].id!;
                Get.find<PostReactionController>().replyUserId.value = reply.user!.id!;
                Get.find<GlobalController>().blankBottomSheet(
                  context: context,
                  bottomSheetHeight: height * 0.24,
                  content: PostReplyBottomSheetContent(
                    sharedPost: sharedPostData,
                    userId: reply.user!.id!,
                  ),
                );
              },
              child: Container(
                width: width - 120,
                decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
                child: Padding(
                  padding: const EdgeInsets.all(k10Padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: profileOnPressed,
                        child: Text(
                          reply.user!.fullName!,
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ),
                      kH8sizedBox,
                      if (reply.reply != null) Get.find<PostReactionController>().formatMentions(reply.reply, context),
                    ],
                  ),
                ),
              ),
            ),
            if (reply.image != null) kH4sizedBox,
            if (reply.image != null)
              SizedBox(
                width: isDeviceScreenLarge() ? 150 : 120,
                height: isDeviceScreenLarge() ? 150 : 120,
                child: ClipRRect(
                  borderRadius: k8CircularBorderRadius,
                  child: Image.network(
                    reply.image ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      BipHip.imageFile,
                      size: kIconSize120,
                      color: cIconColor,
                    ),
                    loadingBuilder: imageLoadingBuilder,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: k8Padding,
              ),
              child: SizedBox(
                width: width - 120,
                height: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      globalController.postTimeDifference(reply.createdAt),
                      style: regular10TextStyle(cSmallBodyTextColor),
                    ),
                    kW16sizedBox,
                    if (isLikeButtonShown)
                      Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          offset: const Offset(0, -60),
                          elevation: 1,
                          onCanceled: () {},
                          position: PopupMenuPosition.over,
                          tooltip: '',
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              height: 25,
                              onTap: null,
                              value: 1,
                              padding: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      child: ReactionButton<String>(
                                        itemSize: const Size.square(48),
                                        onReactionChanged: (Reaction<String>? reaction) {
                                          reply.countReactions = globalController.updateReaction("love", reply.myReaction, reply.countReactions);
                                          reply.myReaction = Get.find<GlobalController>().getReaction(reply.myReaction, "love", 4, reply.id);
                                          sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                        },
                                        reactions: <Reaction<String>>[
                                          Reaction<String>(
                                            value: 'love',
                                            icon: SvgPicture.asset(
                                              kiLoveSvgImageUrl,
                                              width: 38,
                                            ),
                                          ),
                                        ],
                                        selectedReaction: Reaction<String>(
                                          value: 'love',
                                          icon: SvgPicture.asset(
                                            kiLoveSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                    InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      child: ReactionButton<String>(
                                        animateBox: true,
                                        boxAnimationDuration: const Duration(milliseconds: 500),
                                        itemAnimationDuration: const Duration(milliseconds: 500),
                                        itemSize: const Size.square(48),
                                        onReactionChanged: (Reaction<String>? reaction) {
                                          reply.countReactions = globalController.updateReaction("like", reply.myReaction, reply.countReactions);
                                          reply.myReaction = Get.find<GlobalController>().getReaction(reply.myReaction, "like", 4, reply.id);
                                          sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                        },
                                        reactions: <Reaction<String>>[
                                          Reaction<String>(
                                            value: 'like',
                                            icon: SvgPicture.asset(
                                              kiLikeSvgImageUrl,
                                              width: 38,
                                            ),
                                          ),
                                        ],
                                        selectedReaction: Reaction<String>(
                                          value: 'like',
                                          icon: SvgPicture.asset(
                                            kiLikeSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                    InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      child: ReactionButton<String>(
                                        itemSize: const Size.square(48),
                                        onReactionChanged: (Reaction<String>? reaction) {
                                          reply.countReactions = globalController.updateReaction("haha", reply.myReaction, reply.countReactions);
                                          reply.myReaction = Get.find<GlobalController>().getReaction(reply.myReaction, "haha", 4, reply.id);
                                          sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                        },
                                        reactions: <Reaction<String>>[
                                          Reaction<String>(
                                            value: 'haha',
                                            icon: SvgPicture.asset(
                                              kiHahaSvgImageUrl,
                                              width: 38,
                                            ),
                                          ),
                                        ],
                                        selectedReaction: Reaction<String>(
                                          value: 'haha',
                                          icon: SvgPicture.asset(
                                            kiHahaSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                    InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      child: ReactionButton<String>(
                                        itemSize: const Size.square(48),
                                        onReactionChanged: (Reaction<String>? reaction) {
                                          reply.countReactions = globalController.updateReaction("wow", reply.myReaction, reply.countReactions);
                                          reply.myReaction = Get.find<GlobalController>().getReaction(reply.myReaction, "wow", 4, reply.id);
                                          sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                        },
                                        reactions: <Reaction<String>>[
                                          Reaction<String>(
                                            value: 'wow',
                                            icon: SvgPicture.asset(
                                              kiWowSvgImageUrl,
                                              width: 38,
                                            ),
                                          ),
                                        ],
                                        selectedReaction: Reaction<String>(
                                          value: 'wow',
                                          icon: SvgPicture.asset(
                                            kiWowSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                    InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      child: ReactionButton<String>(
                                        itemSize: const Size.square(48),
                                        onReactionChanged: (Reaction<String>? reaction) {
                                          reply.countReactions = globalController.updateReaction("wow", reply.myReaction, reply.countReactions);
                                          reply.myReaction = Get.find<GlobalController>().getReaction(reply.myReaction, "wow", 4, reply.id);
                                          sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                        },
                                        reactions: <Reaction<String>>[
                                          Reaction<String>(
                                            value: 'sad',
                                            icon: SvgPicture.asset(
                                              kiSadSvgImageUrl,
                                              width: 38,
                                            ),
                                          ),
                                        ],
                                        selectedReaction: Reaction<String>(
                                          value: 'sad',
                                          icon: SvgPicture.asset(
                                            kiSadSvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                    ),
                                    InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      child: ReactionButton<String>(
                                        itemSize: const Size.square(48),
                                        onReactionChanged: (Reaction<String>? reaction) {
                                          reply.countReactions = globalController.updateReaction("angry", reply.myReaction, reply.countReactions);
                                          reply.myReaction = Get.find<GlobalController>().getReaction(reply.myReaction, "angry", 4, reply.id);
                                          sharedPostData.comments.replaceRange(commentIndex, commentIndex + 1, [sharedPostData.comments[commentIndex]]);
                                        },
                                        reactions: <Reaction<String>>[
                                          Reaction<String>(
                                            value: 'angry',
                                            icon: SvgPicture.asset(
                                              kiAngrySvgImageUrl,
                                              width: 38,
                                            ),
                                          ),
                                        ],
                                        selectedReaction: Reaction<String>(
                                          value: 'angry',
                                          icon: SvgPicture.asset(
                                            kiAngrySvgImageUrl,
                                            width: 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180),
                          ),
                          child: globalController.getColoredCommentReaction(reply.myReaction),
                        ),
                      ),
                    kW16sizedBox,
                    if (isReplyButtonShown)
                      InkWell(
                        onTap: () {
                          Get.find<PostReactionController>().commentMentionKey.currentState?.controller?.text = "";
                          Get.find<FriendController>().mentionsList.removeWhere((map) => map['id'] == reply.user!.id.toString());
                          Map<String, dynamic> friendMap = {
                            'id': reply.user!.id.toString(),
                            'display': reply.user!.fullName,
                            'full_name': reply.user!.fullName,
                            'photo': reply.user!.profilePicture,
                          };
                          if (globalController.userId.value != reply.user!.id) {
                            Get.find<FriendController>().mentionsList.add(friendMap);
                            Get.find<PostReactionController>().commentMentionKey.currentState?.controller?.text = "@${reply.user!.fullName} ";
                          }
                          Get.find<PostReactionController>().commentFocusNode.requestFocus();
                          Get.find<PostReactionController>().commentId.value = sharedPostData.comments[commentIndex].id!;
                          Get.find<PostReactionController>().isComment.value = false;
                        },
                        child: Text(
                          ksReply.tr,
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    const Spacer(),
                    if (isReactButtonShown)
                      ReactionView(
                          isPost: false,
                          reactCount: (reply.countReactions == null || reply.countReactions!.value.all!.value == 0) ? null : reply.countReactions)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PostCommentBottomSheetContent extends StatelessWidget {
  PostCommentBottomSheetContent({super.key, required this.sharedPostData, required this.commentIndex});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final PostDataRx sharedPostData;
  final int commentIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            kH16sizedBox,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Get.find<GlobalController>().userId.value == postReactionController.commentedUserId.value
                  ? postReactionController.commentActionList.length
                  : Get.find<GlobalController>().userId.value == sharedPostData.id
                      ? postReactionController.othersCommentActionList.length
                      : postReactionController.othersPostOtherUserCommentActionList.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding, left: k10Padding, right: k10Padding),
                    child: CustomListTile(
                      leading: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cNeutralColor,
                        ),
                        height: h32,
                        width: h32,
                        child: Icon(
                          globalController.userId.value == postReactionController.commentedUserId.value
                              ? postReactionController.commentActionList[index]['icon']
                              : globalController.userId.value == sharedPostData.id
                                  ? postReactionController.othersCommentActionList[index]['icon']
                                  : postReactionController.othersPostOtherUserCommentActionList[index]['icon'],
                          color: cBlackColor,
                          size: isDeviceScreenLarge() ? h18 : h14,
                        ),
                      ),
                      title: globalController.userId.value == postReactionController.commentedUserId.value
                          ? postReactionController.commentActionList[index]['action'].toString().tr
                          : globalController.userId.value == sharedPostData.id
                              ? postReactionController.othersCommentActionList[index]['action'].toString().tr
                              : postReactionController.othersPostOtherUserCommentActionList[index]['action'].toString().tr,
                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                      subTitleTextStyle: regular14TextStyle(cBlackColor),
                      onPressed: () async {
                        Get.back();
                        if (globalController.userId.value == postReactionController.commentedUserId.value &&
                            postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                          await postReactionController.deleteComment(sharedPostData.id);
                          globalController.updateSharedPostCommentCount(false);
                        }
                        if (globalController.userId.value == postReactionController.commentedUserId.value &&
                            postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Hide Comment".toLowerCase()) {
                          await postReactionController.hideComment();
                        }
                        if (globalController.userId.value == postReactionController.commentedUserId.value &&
                            postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Update Comment".toLowerCase()) {
                          postReactionController.isUpdateComment.value = true;
                          postReactionController.isComment.value = true;
                          postReactionController.commentTextEditingController.text = sharedPostData.comments[commentIndex].comment ?? "";
                          postReactionController.commentMentionKey.currentState!.controller!.text =
                              postReactionController.formatComment(sharedPostData.comments[commentIndex].comment ?? "");
                          if (sharedPostData.comments[commentIndex].image != null) {
                            postReactionController.commentImage.value = sharedPostData.comments[commentIndex].image;
                          }
                          postReactionController.commentFocusNode.requestFocus();
                        }

                        if (globalController.userId.value == postReactionController.commentedUserId.value &&
                            postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase()) {
                          postReactionController.commentMentionKey.currentState?.controller?.text = "";
                          for (int i = 0; i < postReactionController.commentList.length; i++) {
                            Get.find<FriendController>()
                                .mentionsList
                                .removeWhere((map) => map['id'] == postReactionController.commentList[i].user!.id.toString());
                            if (Get.find<GlobalController>().userId.value != postReactionController.commentList[i].user!.id) {
                              Map<String, dynamic> friendMap = {
                                'id': postReactionController.commentList[i].user!.id.toString(),
                                'display': postReactionController.commentList[i].user!.fullName,
                                'full_name': postReactionController.commentList[i].user!.fullName,
                                'photo': postReactionController.commentList[i].user!.profilePicture,
                              };
                              Get.find<FriendController>().mentionsList.add(friendMap);
                              postReactionController.commentMentionKey.currentState?.controller?.text =
                                  "@${postReactionController.commentList[i].user?.fullName} ";
                            }
                            postReactionController.commentFocusNode.requestFocus();
                            postReactionController.commentId.value = postReactionController.commentList[i].id!;
                            postReactionController.isComment.value = false;
                          }
                        }
                        //*Others user post action
                        if (globalController.userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Report Comment".toLowerCase()) {}
                        if (globalController.userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase()) {
                          postReactionController.commentMentionKey.currentState?.controller?.text = "";
                          for (int i = 0; i < postReactionController.commentList.length; i++) {
                            Get.find<FriendController>()
                                .mentionsList
                                .removeWhere((map) => map['id'] == postReactionController.commentList[i].user!.id.toString());
                            if (globalController.userId.value != postReactionController.commentList[i].user!.id) {
                              Map<String, dynamic> friendMap = {
                                'id': postReactionController.commentList[i].user!.id.toString(),
                                'display': postReactionController.commentList[i].user!.fullName,
                                'full_name': postReactionController.commentList[i].user!.fullName,
                                'photo': postReactionController.commentList[i].user!.profilePicture,
                              };
                              Get.find<FriendController>().mentionsList.add(friendMap);
                              postReactionController.commentMentionKey.currentState?.controller?.text =
                                  "@${postReactionController.commentList[i].user?.fullName} ";
                            }
                            postReactionController.commentFocusNode.requestFocus();
                            postReactionController.commentId.value = postReactionController.commentList[i].id!;
                            postReactionController.isComment.value = false;
                          }
                        }
                        if (globalController.userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {}
                        if (globalController.userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Hide Comment".toLowerCase()) {}
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class PostReplyBottomSheetContent extends StatelessWidget {
  PostReplyBottomSheetContent({super.key, required this.userId, required this.sharedPost});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final int userId;
  final PostDataRx sharedPost;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value
              ? postReactionController.replyActionList.length
              : Get.find<GlobalController>().userId.value == userId
                  ? postReactionController.othersReplyActionList.length
                  : postReactionController.othersPostOtherUserReplyActionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: k8Padding, left: k10Padding, right: k10Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h32,
                    width: h32,
                    child: Icon(
                      Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value
                          ? postReactionController.replyActionList[index]['icon']
                          : Get.find<GlobalController>().userId.value == userId
                              ? postReactionController.othersReplyActionList[index]['icon']
                              : postReactionController.othersPostOtherUserReplyActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value
                      ? postReactionController.replyActionList[index]['action'].toString().tr
                      : Get.find<GlobalController>().userId.value == userId
                          ? postReactionController.othersReplyActionList[index]['action'].toString().tr
                          : postReactionController.othersPostOtherUserReplyActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  onPressed: () async {
                    Get.back();
                    if (Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value &&
                        postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                      await postReactionController.deleteReply(sharedPost.id);
                    }
                    if (Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value &&
                        postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Hide Reply".toLowerCase()) {
                      await postReactionController.hideReply(sharedPost.id);
                    }
                    if (Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value &&
                        postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Update Reply".toLowerCase()) {
                      postReactionController.isUpdateReply.value = true;
                      for (int i = 0; i < sharedPost.comments.length; i++) {
                        for (int j = 0; j < sharedPost.comments[i].commentReplies.length; j++) {
                          if (postReactionController.replyId.value == sharedPost.comments[i].commentReplies[j].id) {
                            postReactionController.commentMentionKey.currentState!.controller!.text =
                                postReactionController.formatComment(sharedPost.comments[i].commentReplies[j].reply ?? "");
                            if (sharedPost.comments[i].commentReplies[j].image != null) {
                              postReactionController.commentImage.value = sharedPost.comments[i].commentReplies[j].image;
                            }
                          }
                        }
                      }
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
