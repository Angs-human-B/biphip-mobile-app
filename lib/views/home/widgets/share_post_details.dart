import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class SharePostDetails extends StatelessWidget {
  SharePostDetails({super.key, required this.sharePostData});
  final GlobalController globalController = Get.find<GlobalController>();
  final SharePosts sharePostData;
  static RxString selfReaction = RxString("");
  static Rx<CountReactions>? sharePostCountReaction;

  @override
  Widget build(BuildContext context) {
    if (sharePostData.countReactions?.value == null || sharePostData.countReactions?.value.all?.value == 0) {
      sharePostCountReaction = null;
    } else {
      sharePostCountReaction = sharePostData.countReactions;
    }
    selfReaction.value = sharePostData.myReaction?.value ?? "";
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              hasBackButton: true,
              isCenterTitle: true,
              title: sharePostData.user?.fullName ?? ksNA.tr,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Obx(
            () => SizedBox(
              height: height - kAppBarSize - MediaQuery.of(context).padding.top,
              child: SingleChildScrollView(
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
                                    width: (sharePostData.kid?.profilePicture != null || sharePostData.store?.profilePicture != null) ? 70 : h44,
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
                                              sharePostData.user!.profilePicture ?? '',
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
                                  if (sharePostData.kid?.profilePicture != null || sharePostData.store?.profilePicture != null)
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
                                            sharePostData.kid?.profilePicture ?? sharePostData.store?.profilePicture ?? "",
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
                                                    text: sharePostData.user!.fullName!,
                                                    style: semiBold16TextStyle(cBlackColor),
                                                  ),
                                                  if (sharePostData.postCategory != null)
                                                    TextSpan(
                                                      text: ' ${ksPostedOn.tr} ',
                                                      style: regular16TextStyle(cSmallBodyTextColor),
                                                    ),
                                                  if (sharePostData.postCategory != null)
                                                    WidgetSpan(
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(bottom: 0),
                                                            child: Icon(
                                                              Get.find<GlobalController>().getCategoryIcon(sharePostData.postCategory!.id),
                                                              color: Get.find<GlobalController>().getCategoryColor(sharePostData.postCategory!.id),
                                                              size: kIconSize14,
                                                            ),
                                                          ),
                                                          if (sharePostData.postCategory != null)
                                                            Text(
                                                              " ${sharePostData.postCategory!.name!}",
                                                              style: semiBold14TextStyle(
                                                                  Get.find<GlobalController>().getCategoryColor(sharePostData.postCategory!.id)),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  if (sharePostData.taggedFriends.isNotEmpty)
                                                    TextSpan(
                                                      text: ' ${ksWith.tr} ',
                                                      style: regular16TextStyle(cSmallBodyTextColor),
                                                    ),
                                                  if (sharePostData.taggedFriends.isNotEmpty)
                                                    TextSpan(
                                                      text: '${sharePostData.taggedFriends[0].fullName}',
                                                      style: semiBold16TextStyle(cBlackColor),
                                                    ),
                                                  if (sharePostData.taggedFriends.isNotEmpty && sharePostData.taggedFriends.length == 2)
                                                    TextSpan(
                                                      text: ' & ${sharePostData.taggedFriends[1].fullName}',
                                                      style: semiBold16TextStyle(cBlackColor),
                                                    ),
                                                  if (sharePostData.taggedFriends.isNotEmpty && sharePostData.taggedFriends.length > 2)
                                                    WidgetSpan(
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.find<GlobalController>().commonBottomSheet(
                                                              context: context,
                                                              isScrollControlled: true,
                                                              bottomSheetHeight: sharePostData.taggedFriends.length > 10 ? height * 0.6 : null,
                                                              content: TaggedFriendContent(
                                                                taggedFriend: sharePostData.taggedFriends,
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
                                                          ' & ${sharePostData.taggedFriends.length - 1} others',
                                                          style: semiBold16TextStyle(cBlackColor),
                                                        ),
                                                      ),
                                                    ),
                                                  const TextSpan(text: '\n'),
                                                  const WidgetSpan(
                                                    baseline: TextBaseline.alphabetic,
                                                    alignment: PlaceholderAlignment.baseline,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(bottom: 0),
                                                      child: Icon(
                                                        BipHip.world,
                                                        color: cIconColor,
                                                        size: kIconSize12,
                                                      ),
                                                    ),
                                                  ),
                                                  if (sharePostData.postCategory?.name == 'Selling' && sharePostData.store != null)
                                                    TextSpan(text: ' (${sharePostData.store?.name})', style: semiBold14TextStyle(cBlackColor)),
                                                  if (sharePostData.postCategory?.name == 'Kids' && sharePostData.kid != null)
                                                    TextSpan(
                                                        text: ' (${sharePostData.kid?.name}, ${sharePostData.kid?.age})',
                                                        style: semiBold14TextStyle(cBlackColor)),
                                                  TextSpan(
                                                      text: ' ${Get.find<GlobalController>().postTimeDifference(sharePostData.createdAt!)}',
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
                          if (sharePostData.title != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
                              child: Text(
                                sharePostData.title!,
                                overflow: TextOverflow.clip,
                                style: semiBold14TextStyle(cBlackColor),
                              ),
                            ),
                          if (sharePostData.content != null)
                            Padding(
                              padding: EdgeInsets.only(
                                  left: kHorizontalPadding, right: kHorizontalPadding, bottom: (sharePostData.images.isNotEmpty) ? k16Padding : 0),
                              child: RichText(
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                maxLines: (sharePostData.content!.length > 256) ? 5 : null,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: sharePostData.content!,
                                      style: (sharePostData.content!.length < 150 && sharePostData.images.isEmpty)
                                          ? regular20TextStyle(cBlackColor)
                                          : regular14TextStyle(cBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (sharePostData.images.isNotEmpty)
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
                                            height: sharePostData.images.length < 2 ? 302 : 150,
                                            width: sharePostData.images.length > 3 ? (width - 42) / 2 : (width - 40),
                                            child: ClipRRect(
                                              borderRadius: k8CircularBorderRadius,
                                              child: Image.network(
                                                Environment.imageBaseUrl + sharePostData.images[0].path.toString(),
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
                                        if (sharePostData.images.length > 3)
                                          const SizedBox(
                                            width: 2,
                                          ),
                                        if (sharePostData.images.length > 3)
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
                                                  Environment.imageBaseUrl + sharePostData.images[1].path.toString(),
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
                                    if (sharePostData.images.length > 1)
                                      const SizedBox(
                                        height: 2,
                                      ),
                                    Row(
                                      children: [
                                        if (sharePostData.images.length < 4 && sharePostData.images.length > 1)
                                          TextButton(
                                            style: kTextButtonStyle,
                                            onPressed: () {
                                              // Get.toNamed(krHomePostDetailsScreen);
                                              //! need to create for shared post
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                              height: 150,
                                              width: sharePostData.images.length < 3 ? (width - 40) : (width - 42) / 2,
                                              child: ClipRRect(
                                                borderRadius: k8CircularBorderRadius,
                                                child: Image.network(
                                                  Environment.imageBaseUrl + sharePostData.images[1].path.toString(),
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
                                        if (sharePostData.images.length < 4 && sharePostData.images.length > 2)
                                          const SizedBox(
                                            width: 2,
                                          ),
                                        if (sharePostData.images.length > 2)
                                          TextButton(
                                            style: kTextButtonStyle,
                                            onPressed: () {
                                              // Get.toNamed(krHomePostDetailsScreen);
                                              //! need to create for shared post
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                              height: 150,
                                              width: sharePostData.images.length > 4 ? (width - 44) / 3 : (width - 42) / 2,
                                              child: ClipRRect(
                                                borderRadius: k8CircularBorderRadius,
                                                child: Image.network(
                                                  Environment.imageBaseUrl + sharePostData.images[2].path.toString(),
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
                                        if (sharePostData.images.length > 3)
                                          const SizedBox(
                                            width: 2,
                                          ),
                                        if (sharePostData.images.length > 3)
                                          TextButton(
                                            style: kTextButtonStyle,
                                            onPressed: () {
                                              // Get.toNamed(krHomePostDetailsScreen);
                                              //! need to create for shared post
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                              height: 150,
                                              width: sharePostData.images.length < 5 ? (width - 42) / 2 : (width - 44) / 3,
                                              child: ClipRRect(
                                                borderRadius: k8CircularBorderRadius,
                                                child: Image.network(
                                                  Environment.imageBaseUrl + sharePostData.images[3].path.toString(),
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
                                        if (sharePostData.images.length > 4)
                                          const SizedBox(
                                            width: 2,
                                          ),
                                        if (sharePostData.images.length >= 5)
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
                                                      Environment.imageBaseUrl + sharePostData.images[4].path.toString(),
                                                      color: sharePostData.images.length > 5 ? cBlackColor.withOpacity(0.3) : null,
                                                      colorBlendMode: sharePostData.images.length > 5 ? BlendMode.multiply : null,
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
                                              if (sharePostData.images.length > 5)
                                                Positioned(
                                                  child: TextButton(
                                                    style: kTextButtonStyle,
                                                    onPressed: () {
                                                      // Get.toNamed(krHomePostDetailsScreen);
                                                    },
                                                    child: Text(
                                                      "${sharePostData.images.length - 5} More",
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
                                if (sharePostData.countReactions == null)
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                if (sharePostData.countReactions != null)
                                  InkWell(
                                    child: ReactionView(
                                      isPost: true,
                                      reactCount: sharePostCountReaction?.value == null ? null : sharePostCountReaction,
                                    ),
                                  ),
                                CommentShareRecord(
                                  commentCount: sharePostData.countComment!,
                                  isGiftShown: !(Get.find<GlobalController>().userId.value == sharePostData.user!.id),
                                  giftCount: sharePostData.countStar!,
                                  shareCount: sharePostData.countShare!,
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
                                                  sharePostData.countReactions =
                                                      globalController.updateReaction("love", sharePostData.myReaction, sharePostData.countReactions);
                                                  sharePostCountReaction = sharePostData.countReactions;
                                                  sharePostData.myReaction =
                                                      globalController.getReaction(sharePostData.myReaction, "love", 1, sharePostData.id!);
                                                  selfReaction.value = sharePostData.myReaction?.value ?? "";
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
                                                  sharePostData.countReactions =
                                                      globalController.updateReaction("like", sharePostData.myReaction, sharePostData.countReactions);
                                                  sharePostCountReaction = sharePostData.countReactions;
                                                  sharePostData.myReaction =
                                                      globalController.getReaction(sharePostData.myReaction, "like", 1, sharePostData.id!);
                                                  selfReaction.value = sharePostData.myReaction?.value ?? "";
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
                                                  sharePostData.countReactions =
                                                      globalController.updateReaction("haha", sharePostData.myReaction, sharePostData.countReactions);
                                                  sharePostCountReaction = sharePostData.countReactions;
                                                  sharePostData.myReaction =
                                                      globalController.getReaction(sharePostData.myReaction, "haha", 1, sharePostData.id!);
                                                  selfReaction.value = sharePostData.myReaction?.value ?? "";
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
                                                  sharePostData.countReactions =
                                                      globalController.updateReaction("wow", sharePostData.myReaction, sharePostData.countReactions);
                                                  sharePostCountReaction = sharePostData.countReactions;
                                                  sharePostData.myReaction =
                                                      globalController.getReaction(sharePostData.myReaction, "wow", 1, sharePostData.id!);
                                                  selfReaction.value = sharePostData.myReaction?.value ?? "";
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
                                                  sharePostData.countReactions =
                                                      globalController.updateReaction("sad", sharePostData.myReaction, sharePostData.countReactions);
                                                  sharePostCountReaction = sharePostData.countReactions;
                                                  sharePostData.myReaction =
                                                      globalController.getReaction(sharePostData.myReaction, "sad", 1, sharePostData.id!);
                                                  selfReaction.value = sharePostData.myReaction?.value ?? "";
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
                                                  sharePostData.countReactions =
                                                      globalController.updateReaction("angry", sharePostData.myReaction, sharePostData.countReactions);
                                                  sharePostCountReaction = sharePostData.countReactions;
                                                  sharePostData.myReaction =
                                                      globalController.getReaction(sharePostData.myReaction, "angry", 1, sharePostData.id!);
                                                  selfReaction.value = sharePostData.myReaction?.value ?? "";
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
                                    width: !(Get.find<GlobalController>().userId.value == sharePostData.user!.id) ? (width - 40) / 4 : (width - 40) / 3,
                                    height: 44,
                                    child: selfReaction.value == ""
                                        ? globalController.getColoredReactionIcon(null)
                                        : globalController.getColoredReactionIcon(selfReaction),
                                  ),
                                ),
                              ),
                              InkWell(
                                // onTap: commentOnPressed,
                                child: SizedBox(
                                  width: !(Get.find<GlobalController>().userId.value == sharePostData.user!.id) ? (width - 40) / 4 : (width - 40) / 3,
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
                                  width: !(Get.find<GlobalController>().userId.value == sharePostData.user!.id) ? (width - 40) / 4 : (width - 40) / 3,
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
                              if (!(Get.find<GlobalController>().userId.value == sharePostData.user!.id))
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
