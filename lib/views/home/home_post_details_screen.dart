import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePostDetailsScreen extends StatelessWidget {
  HomePostDetailsScreen({super.key, required this.postIndex});
  final int postIndex;

  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    PostDataRx postData = globalController.commonPostList[postIndex];
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
              title: postData.user!.fullName!,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
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
                                width: (postData.kid?.profilePicture != null || postData.store?.profilePicture != null) ? 70 : h44,
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
                                          postData.user!.profilePicture ?? '',
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
                              if (postData.kid?.profilePicture != null || postData.store?.profilePicture != null)
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
                                        postData.kid?.profilePicture ?? postData.store?.profilePicture ?? "",
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
                                                text: postData.user!.fullName!,
                                                style: semiBold16TextStyle(cBlackColor),
                                              ),
                                              if (postData.postCategory != null)
                                                TextSpan(
                                                  text: ' ${ksPostedOn.tr} ',
                                                  style: regular16TextStyle(cSmallBodyTextColor),
                                                ),
                                              if (postData.postCategory != null)
                                                WidgetSpan(
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 0),
                                                        child: Icon(
                                                          globalController.getCategoryIcon(postData.postCategory!.id),
                                                          color: globalController.getCategoryColor(postData.postCategory!.id),
                                                          size: kIconSize14,
                                                        ),
                                                      ),
                                                      if (postData.postCategory != null)
                                                        Text(
                                                          " ${postData.postCategory!.name!}",
                                                          style: semiBold14TextStyle(Get.find<GlobalController>().getCategoryColor(postData.postCategory!.id)),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              if (postData.taggedFriends.isNotEmpty)
                                                TextSpan(
                                                  text: ' ${ksWith.tr} ',
                                                  style: regular16TextStyle(cSmallBodyTextColor),
                                                ),
                                              if (postData.taggedFriends.isNotEmpty)
                                                TextSpan(
                                                  text: '${postData.taggedFriends[0].fullName}',
                                                  style: semiBold16TextStyle(cBlackColor),
                                                ),
                                              if (postData.taggedFriends.isNotEmpty && postData.taggedFriends.length == 2)
                                                TextSpan(
                                                  text: ' & ${postData.taggedFriends[1].fullName}',
                                                  style: semiBold16TextStyle(cBlackColor),
                                                ),
                                              if (postData.taggedFriends.isNotEmpty && postData.taggedFriends.length > 2)
                                                WidgetSpan(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.find<GlobalController>().commonBottomSheet(
                                                          context: context,
                                                          isScrollControlled: true,
                                                          bottomSheetHeight: postData.taggedFriends.length > 10 ? height * 0.6 : null,
                                                          content: TaggedFriendContent(
                                                            taggedFriend: postData.taggedFriends,
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
                                                      ' & ${postData.taggedFriends.length - 1} others',
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
                                              if (postData.postCategory?.name == 'Selling' && postData.store != null)
                                                TextSpan(text: ' (${postData.store?.name})', style: semiBold14TextStyle(cBlackColor)),
                                              if (postData.postCategory?.name == 'Kids' && postData.kid != null)
                                                TextSpan(text: ' (${postData.kid?.name}, ${postData.kid?.age})', style: semiBold14TextStyle(cBlackColor)),
                                              TextSpan(
                                                  text: ' ${globalController.postTimeDifference(postData.createdAt!)}',
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
                      ),
                    ),
                    kH12sizedBox,
                    CommonPostDetailsScreenWidget(
                      postIndex: postIndex,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonPostDetailsScreenWidget extends StatelessWidget {
  CommonPostDetailsScreenWidget({
    super.key,
    required this.postIndex,
  });

  final int postIndex;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    PostDataRx postData = globalController.commonPostList[postIndex];
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (postData.title != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
                child: Text(
                  postData.title!,
                  overflow: TextOverflow.clip,
                  style: semiBold14TextStyle(cBlackColor),
                ),
              ),
            if (postData.content != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: postData.content!,
                        style: regular14TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k8Padding),
              child: PostActivityStatusWidget(
                postIndex: postIndex,
                reactionOnPressed: () {
                  //globalController.blankBottomSheet(
                  // context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                },
                isGiftShown: true,
                giftOnPressed: () {
                  // postReactionController.giftFilter(0);
                  // globalController.blankBottomSheet(
                  //     context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                },
              ),
            ),
            LikeSectionWidget(
              postIndex: postIndex,
              isGiftShown: globalController.userId.value == globalController.commonPostList[postIndex].user!.id! ? false : true,
              giftOnPressed: () {},
              commentOnPressed: () async {
                // postReactionController.commentMentionKey.currentState?.controller?.text = "";
                // postReactionController.commentId.value = -1;
                // showComment.value = !showComment.value;
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: CustomDivider(),
            ),
            kH12sizedBox,
            if (postData.images.isNotEmpty)
              Container(
                color: cWhiteColor,
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: postData.images.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TextButton(
                                style: kTextButtonStyle,
                                onPressed: () {
                                  Get.to(() => GalleryWidget(
                                        urlImages: postData.images,
                                        imageIndex: index,
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                  height: 300,
                                  width: (width - 40),
                                  child: ClipRRect(
                                    borderRadius: k8CircularBorderRadius,
                                    child: Image.network(
                                      Environment.imageBaseUrl + postData.images[index].path.toString(),
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
                              if (postData.images[index].description != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: kHorizontalPadding, top: k8Padding, bottom: k8Padding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        postData.images[index].description.toString(),
                                        style: regular14TextStyle(cBlackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              if (postData.images[index].description == null) kH12sizedBox,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (postData.images[index].countReactions == null)
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                    if (postData.images[index].countReactions != null)
                                      InkWell(
                                        child: ReactionView(
                                          isPost: true,
                                          reactCount: postData.images[index].countReactions,
                                        ),
                                      ),
                                    CommentShareRecord(
                                      commentCount: RxInt(0),
                                      isGiftShown: false,
                                      giftCount: RxInt(0),
                                      shareCount: RxInt(0),
                                    )
                                  ],
                                ),
                              ),
                              kH12sizedBox,
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                child: CustomDivider(),
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
                                                      postData.images[index].countReactions = globalController.updateReaction(
                                                          "love", postData.images[index].myReaction, postData.images[index].countReactions);
                                                      postData.images[index].myReaction = globalController.getReaction(
                                                          postData.images[index].myReaction, "love", 2, postData.images[index].id!);
                                                      postData.images.replaceRange(index, index + 1, [postData.images[index]]);
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
                                                      postData.images[index].countReactions = globalController.updateReaction(
                                                          "like", postData.images[index].myReaction, postData.images[index].countReactions);
                                                      postData.images[index].myReaction = globalController.getReaction(
                                                          postData.images[index].myReaction, "like", 2, postData.images[index].id!);
                                                      postData.images.replaceRange(index, index + 1, [postData.images[index]]);
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
                                                      postData.images[index].countReactions = globalController.updateReaction(
                                                          "haha", postData.images[index].myReaction, postData.images[index].countReactions);
                                                      postData.images[index].myReaction = globalController.getReaction(
                                                          postData.images[index].myReaction, "haha", 2, postData.images[index].id!);
                                                      postData.images.replaceRange(index, index + 1, [postData.images[index]]);
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
                                                      postData.images[index].countReactions = globalController.updateReaction(
                                                          "wow", postData.images[index].myReaction, postData.images[index].countReactions);
                                                      postData.images[index].myReaction =
                                                          globalController.getReaction(postData.images[index].myReaction, "wow", 2, postData.images[index].id!);
                                                      postData.images.replaceRange(index, index + 1, [postData.images[index]]);
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
                                                      postData.images[index].countReactions = globalController.updateReaction(
                                                          "sad", postData.images[index].myReaction, postData.images[index].countReactions);
                                                      postData.images[index].myReaction =
                                                          globalController.getReaction(postData.images[index].myReaction, "sad", 2, postData.images[index].id!);
                                                      postData.images.replaceRange(index, index + 1, [postData.images[index]]);
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
                                                      postData.images[index].countReactions = globalController.updateReaction(
                                                          "angry", postData.images[index].myReaction, postData.images[index].countReactions);
                                                      postData.images[index].myReaction = globalController.getReaction(
                                                          postData.images[index].myReaction, "angry", 2, postData.images[index].id!);
                                                      postData.images.replaceRange(index, index + 1, [postData.images[index]]);
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
                                        width: (width - 40) / 3,
                                        height: 44,
                                        child: globalController.getColoredReactionIcon(postData.images[index].myReaction),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    // onTap: commentOnPressed,
                                    child: SizedBox(
                                      width: (width - 40) / 3,
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
                                      width: (width - 40) / 3,
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
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                child: CustomDivider(),
                              ),
                              kH12sizedBox,
                            ],
                          );
                        }),
                  ],
                ),
              ),
          ],
        ));
  }
}
