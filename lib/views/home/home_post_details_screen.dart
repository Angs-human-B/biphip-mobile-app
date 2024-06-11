import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_sheet_contents.dart';
import 'package:bip_hip/views/post/widgets/create_post_upper_section.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/comment_textfield.dart';
import 'package:bip_hip/widgets/post/comment_widget.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter/rendering.dart';
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
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  @override
  Widget build(BuildContext context) {
    PostDataRx postData = globalController.commonPostList[postIndex];
    // ll(MediaQuery.of(Get.context!).viewInsets.bottom);
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
              shareOnPressed: () {
                Get.find<GlobalController>().blankBottomSheet(
                  context: context,
                  bottomSheetHeight: height * 0.38,
                  content: ShareBottomSheetContent(
                    postData: globalController.commonPostList[postIndex],
                  ),
                );
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
                                  postReactionController.isRouteFromHomePage.value = true;
                                  Get.to(() => GalleryWidget(
                                        urlImages: postData.images,
                                        imageIndex: index,
                                        postIndex: postIndex,
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                  height: 300,
                                  width: (width - 40),
                                  child: ClipRRect(
                                    borderRadius: k8CircularBorderRadius,
                                    child: Image.network(
                                      postData.images[index].fullPath.toString(),
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
                                      commentCount: RxInt(postData.images[index].countComment!),
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
                                    onTap: () async {
                                      if (Get.currentRoute.toString().toLowerCase() == "/HomePostDetailsScreen".toLowerCase()) {
                                        postReactionController.imageId.value = Get.find<GlobalController>().commonPostList[postIndex].images[index].id!;
                                      }
                                      globalController.blankBottomSheetForImageComment(
                                        context: context,
                                        isScrollControlled: true,
                                        bottomSheetHeight: height * 0.9,
                                        action: CommentTextField(
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
                                              await postReactionController.updateComment(context, globalController.commonPostList[postIndex].id, postIndex);
                                            } else if (Get.find<PostReactionController>().isUpdateReply.value) {
                                              await postReactionController.updateReply(context, globalController.commonPostList[postIndex].id, postIndex);
                                            } else if (postReactionController.commentId.value == -1) {
                                              await postReactionController.postComment(
                                                  2, globalController.commonPostList[postIndex].images[index].id!, context, "comment", postIndex);
                                              Get.find<FriendController>().mentionsList.removeLast();
                                              Get.find<GlobalController>().updateCommentCount(globalController.commonPostList, postIndex, true);
                                            } else if (postReactionController.commentId.value != -1) {
                                              await Get.find<PostReactionController>()
                                                  .postComment(2, postReactionController.commentId.value, context, "reply", postIndex);
                                              Get.find<FriendController>().mentionsList.removeLast();
                                              Get.find<GlobalController>().updateCommentCount(globalController.commonPostList, postIndex, true);
                                            }
                                          },
                                        ),
                                        //                                 if (postReactionController.isCommentPostLoading.value) const SingleCommentShimmer(),
                                        // (postReactionController.isCommentLoading.value && !postReactionController.isCommentPostLoading.value)
                                        //     ? const CommentCommonShimmer()
                                        //     :
                                        content: Obx(
                                          () => (postReactionController.isCommentLoading.value && !postReactionController.isCommentPostLoading.value)
                                              ? const CommentCommonShimmer()
                                              : postReactionController.commentList.isEmpty
                                                  ? Column(
                                                      children: [
                                                        const Icon(
                                                          BipHip.comment,
                                                          color: cIconColor,
                                                          size: 80,
                                                        ),
                                                        kH4sizedBox,
                                                        Text(
                                                          ksNoCommentsYet.tr,
                                                          style: semiBold14TextStyle(cBlackColor),
                                                        ),
                                                        Text(
                                                          ksBeTheFirstToComment.tr,
                                                          style: regular12TextStyle(cSmallBodyTextColor),
                                                        ),
                                                      ],
                                                    )
                                                  : NotificationListener<ScrollNotification>(
                                                      onNotification: (scrollNotification) {
                                                        if (postReactionController.commentListScrollController.position.userScrollDirection ==
                                                                ScrollDirection.reverse &&
                                                            scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                                            !postReactionController.getCommentScrolled.value) {
                                                          postReactionController.getCommentScrolled.value = true;
                                                          if (globalController.commonPostList[postIndex].comments.isNotEmpty) {
                                                            postReactionController.getMoreCommentList(
                                                                null, 2, globalController.commonPostList[postIndex].images[index].id!, postIndex);
                                                          }
                                                          return true;
                                                        }
                                                        return false;
                                                      },
                                                      child: SizedBox(
                                                        height: Get.find<PostReactionController>().isKeyboardFocused.value
                                                            ? (height * .9) - 23 - 100 - globalController.keyboardHeight.value
                                                            : (height * .9) - 23 - 100,
                                                        child: SingleChildScrollView(
                                                          controller: postReactionController.commentListScrollController,
                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              if (postReactionController.isCommentPostLoading.value) const SingleCommentShimmer(),
                                                              for (int index = 0; index < postReactionController.commentList.length; index++)
                                                                (postReactionController.isCommentLoading.value &&
                                                                        !postReactionController.isCommentPostLoading.value)
                                                                    ? const CommentCommonShimmer()
                                                                    : Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                                                            child: CommentWidget(
                                                                              postIndex: postIndex,
                                                                              commentIndex: index,
                                                                              isLikeButtonShown: true,
                                                                              isReplyButtonShown: true,
                                                                              isReactButtonShown: true,
                                                                              isHideButtonShown: globalController.userId.value ==
                                                                                  globalController.commonPostList[postIndex].comments[index].user!.id,
                                                                            ),
                                                                          ),
                                                                          kH8sizedBox,
                                                                          if (!postReactionController.replyShow[index] &&
                                                                              postReactionController.commentList[index].commentReplies.isNotEmpty)
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  left: k60Padding, right: k60Padding, bottom: k10Padding),
                                                                              child: Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: InkWell(
                                                                                      onTap: () async {
                                                                                        // globalController.commonPostList[postIndex].comments[index].commentReplies.clear();
                                                                                        postReactionController.commentList[index].commentReplies.clear();
                                                                                        postReactionController.replyShow[index] = true;
                                                                                        // ll(postReactionController.commentList[index].commentReplies.length);
                                                                                        await postReactionController.getReplyList(
                                                                                            postReactionController.commentList[index].id!, postIndex, index);
                                                                                      },
                                                                                      child: Text(
                                                                                        "View Replies",
                                                                                        style: semiBold14TextStyle(cSmallBodyTextColor),
                                                                                      ))),
                                                                            ),
                                                                          // if (postReactionController.isReplyLoading.value)
                                                                          //   const Center(
                                                                          //       child: SizedBox(
                                                                          //           width: 20,
                                                                          //           height: 20,
                                                                          //           child: CircularProgressIndicator(
                                                                          //             strokeWidth: 2,
                                                                          //           ))),
                                                                          if (postReactionController.replyShow[index])
                                                                            for (int i = 0;
                                                                                i < postReactionController.commentList[index].commentReplies.length;
                                                                                i++)
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 0, right: kHorizontalPadding),
                                                                                child: ReplyCommentWidget(
                                                                                  postIndex: postIndex,
                                                                                  commentIndex: index,
                                                                                  replyIndex: i,
                                                                                  isLikeButtonShown: true,
                                                                                  isReplyButtonShown: true,
                                                                                  isReactButtonShown: true,
                                                                                ),
                                                                              )
                                                                        ],
                                                                      ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                        ),
                                      );
                                      postReactionController.resetCommentAndReplyData();
                                      await postReactionController.getCommentList(2, globalController.commonPostList[postIndex].images[index].id!, postIndex);
                                      await Get.find<FriendController>().getFriendList();
                                    },
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
                                    onTap: () {
                                      Get.find<GlobalController>().blankBottomSheet(
                                        context: context,
                                        bottomSheetHeight: height * 0.38,
                                        content: ImageShareBottomSheetContent(
                                          postData: globalController.commonPostList[postIndex],
                                          imageIndex: index,
                                        ),
                                      );
                                    },
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

class ImageShareBottomSheetContent extends StatelessWidget {
  ImageShareBottomSheetContent({super.key, required this.postData, required this.imageIndex});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final PostDataRx postData;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            // kH16sizedBox,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: postReactionController.shareActionList.length,
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
                          postReactionController.shareActionList[index]['icon'],
                          color: cBlackColor,
                          size: isDeviceScreenLarge() ? h18 : h14,
                        ),
                      ),
                      title: postReactionController.shareActionList[index]['action'].toString().tr,
                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                      subTitleTextStyle: regular14TextStyle(cBlackColor),
                      onPressed: () async {
                        Get.back();
                        if (postReactionController.shareActionList[index]['action'] == 'Share to Feed') {
                          Get.find<CreatePostController>().isPostedFromProfile.value = false;
                          CreatePostHelper().resetCreatePostData();
                          Get.find<KidsController>().isRouteFromKid.value = false;
                          Get.find<CreatePostController>().getCreatePost();
                          Get.find<CreatePostController>().isSharingPost.value = true;
                          ll(postData.images[index].id);
                          Get.find<GlobalController>().blankBottomSheet(
                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                              context: context,
                              content: SharePostImageBottomSheetContent(
                                postData: postData,
                                imageIndex: imageIndex,
                              ),
                              isScrollControlled: true);
                        }
                        if (postReactionController.shareActionList[index]['action'].toString().toLowerCase() == "Share to Your Kids Profile".toLowerCase()) {
                          createPostController.isKidListLoading.value = true;
                          createPostController.tempSelectedKid.value = null;
                          createPostController.tempKidID.value = -1;
                          if (createPostController.tempSelectedKid.value == null) {
                            createPostController.kidListBottomSheetRightButtonState.value = false;
                          } else {
                            createPostController.kidListBottomSheetRightButtonState.value = true;
                          }
                          Get.find<GlobalController>().commonBottomSheet(
                            isBottomSheetRightButtonActive: createPostController.kidListBottomSheetRightButtonState,
                            isScrollControlled: true,
                            bottomSheetHeight: height * .5,
                            context: Get.context,
                            content: KidListBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {
                              Get.back();
                              Get.find<CreatePostController>().isPostedFromProfile.value = false;
                              CreatePostHelper().resetCreatePostData();
                              createPostController.selectedKid.value = createPostController.tempSelectedKid.value;
                              createPostController.tempSelectedKid.value = null;
                              createPostController.category.value = "Kids";
                              createPostController.kidID.value = createPostController.tempKidID.value;
                              ll(createPostController.kidID.value);
                              createPostController.postSecondaryCircleAvatar.value = createPostController.selectedKid.value!.profilePicture.toString();
                              Get.find<KidsController>().isRouteFromKid.value = false;
                              Get.find<CreatePostController>().getCreatePost();
                              Get.find<CreatePostController>().isSharingPost.value = true;
                              Get.find<GlobalController>().blankBottomSheet(
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                                isScrollControlled: true,
                                context: context,
                                content: SharePostImageBottomSheetContent(
                                  postData: postData,
                                  imageIndex: imageIndex,
                                ),
                              );
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: ksSelectKids.tr,
                            isRightButtonShow: true,
                          );
                          await createPostController.getKidList();
                        }
                        if (postReactionController.shareActionList[index]['action'].toString().toLowerCase() == "Share to Your Store Profile".toLowerCase()) {
                          // createPostController.tempSelectedBrandId.value = createPostController.selectedBrandId.value;

                          if (createPostController.tempSelectedBrandId.value == -1) {
                            createPostController.storeListBottomSheetRightButtonState.value = false;
                          } else {
                            createPostController.storeListBottomSheetRightButtonState.value = true;
                          }
                          Get.find<GlobalController>().commonBottomSheet(
                            isBottomSheetRightButtonActive: createPostController.storeListBottomSheetRightButtonState,
                            isScrollControlled: true,
                            bottomSheetHeight: height * 0.5,
                            context: Get.context,
                            content: SelectBrandBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {
                              // createPostHelper.selectBrandTextChange();
                              Get.find<CreatePostController>().isPostedFromProfile.value = false;
                              CreatePostHelper().resetCreatePostData();
                              createPostController.selectedBrandId.value = createPostController.tempSelectedBrandId.value;
                              ll(createPostController.selectedBrandId.value);
                              Get.back();
                              createPostController.category.value = "Selling";
                              for (int i = 0; i < createPostController.storeList.length; i++) {
                                if (createPostController.selectedBrandId.value == createPostController.storeList[i].id) {
                                  createPostController.brandID.value = createPostController.storeList[i].id!;
                                  createPostController.postSecondaryCircleAvatar.value = createPostController.storeList[i].profilePicture.toString();
                                  createPostController.selectedBrandName.value = createPostController.storeList[i].name.toString();
                                }
                              }
                              Get.find<KidsController>().isRouteFromKid.value = false;
                              Get.find<CreatePostController>().getCreatePost();
                              Get.find<CreatePostController>().isSharingPost.value = true;
                              Get.find<GlobalController>().blankBottomSheet(
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                                isScrollControlled: true,
                                context: context,
                                // content: SharePostBottomSheetContent(
                                //   postData: postData,
                                // ),
                                content: SharePostImageBottomSheetContent(
                                  postData: postData,
                                  imageIndex: imageIndex,
                                ),
                              );
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: ksSelectBrands.tr,
                            isRightButtonShow: true,
                          );
                          await createPostController.getStoreList();
                        }
                        if (postReactionController.shareActionList[index]['action'].toString().toLowerCase() == "Copy Link".toLowerCase()) {
                          String baseUrl = "bip-hip-dev.vercel.app/posts";
                          Clipboard.setData(ClipboardData(text: "$baseUrl/${postData.id}/image/${postData.images[imageIndex].id}"));
                          // ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                          // ll(clipboardData!.text);
                          Get.find<GlobalController>()
                              .showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
                        }
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

class SharePostImageBottomSheetContent extends StatelessWidget {
  SharePostImageBottomSheetContent({super.key, required this.postData, required this.imageIndex});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final PostDataRx postData;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: 4),
          child: Column(
            children: [
              CreatePostUpperSection(),
              CustomModifiedTextField(
                controller: createPostController.createPostTextEditingController,
                maxLength: 1000,
                maxLines: 7,
                minLines: 1,
                isFilled: false,
                fillColor: cWhiteColor,
                inputAction: TextInputAction.newline,
                inputType: TextInputType.multiline,
                hint: "${ksSaySomethingAboutThis.tr}....",
                contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k16Padding),
                textHintStyle: regular16TextStyle(cPlaceHolderColor),
                textInputStyle: regular16TextStyle(cBlackColor),
                onChanged: (v) {},
              ),
              Row(
                children: [
                  const Spacer(),
                  CustomElevatedButton(
                      textStyle: semiBold14TextStyle(cWhiteColor),
                      buttonWidth: 80,
                      buttonHeight: 40,
                      label: ksShareNow.tr,
                      onPressed: () async {
                        Get.back();
                        await createPostController.sharePost(postData.id.toString());
                      }),
                ],
              )
            ],
          ),
        ),
        kH12sizedBox,
        Container(
          width: width,
          height: height * 0.4,
          color: cBackgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(kHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius, border: Border.all(color: cLineColor)),
                      child: Row(
                        children: [
                          if (postData.images.isNotEmpty && postData.sharePosts == null)
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)), color: cWhiteColor),
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)),
                                child: Image.network(
                                  postData.images[imageIndex].fullPath.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize20,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                  frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                    return child;
                                  },
                                ),
                              ),
                            ),
                          if (postData.sharePosts != null && postData.sharePosts!.images.isNotEmpty)
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)), color: cWhiteColor),
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)),
                                child: Image.network(
                                  postData.sharePosts!.images[imageIndex].fullPath.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize20,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                  frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                    return child;
                                  },
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                if (postData.images[imageIndex].description != null && postData.sharePosts == null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: SizedBox(
                                      width: width - 130,
                                      child: Text(
                                        postData.images[imageIndex].description!,
                                        style: semiBold16TextStyle(cBlackColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                // if (postData.sharePosts != null && postData.sharePosts!.images[imageIndex].description != null)
                                //   Padding(
                                //     padding: const EdgeInsets.only(bottom: 8.0),
                                //     child: SizedBox(
                                //       width: width - 130,
                                //       child: Text(
                                //         postData.sharePosts!.images[imageIndex].description ?? ksNA,
                                //         style: semiBold16TextStyle(cBlackColor),
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //   ),
                                if (postData.sharePosts == null)
                                  SizedBox(
                                    width: width - 130,
                                    child: Text(
                                      postData.user!.fullName!,
                                      style: postData.content != null ? regular14TextStyle(cSmallBodyTextColor) : semiBold16TextStyle(cBlackColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                if (postData.sharePosts != null)
                                  SizedBox(
                                    width: width - 130,
                                    child: Text(
                                      postData.sharePosts!.user!.fullName!,
                                      style: postData.sharePosts!.content != null ? regular14TextStyle(cSmallBodyTextColor) : semiBold16TextStyle(cBlackColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    kH20sizedBox,
                    Text(
                      ksShareTo.tr,
                      style: semiBold20TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width,
                height: 70,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: k20Padding),
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: createPostController.sharePostOthersList.length,
                    separatorBuilder: (context, index) => kW20sizedBox,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          String baseUrl = "bip-hip-dev.vercel.app/posts";
                          if (createPostController.sharePostOthersList[index]["text"].toString().toLowerCase() == "Copy Link".toLowerCase()) {
                            Clipboard.setData(ClipboardData(text: "$baseUrl/${postData.id}"));
                            // ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                            // ll(clipboardData!.text);
                            Get.back();
                            Get.find<GlobalController>()
                                .showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
                          } else {
                            Get.back();
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: h44,
                              height: h44,
                              decoration: const BoxDecoration(
                                color: cWhiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: CustomIconButton(
                                onPress: null,
                                icon: createPostController.sharePostOthersList[index]["icon"] as IconData,
                                iconColor: cBlackColor,
                                size: kIconSize20,
                              ),
                            ),
                            kH8sizedBox,
                            Text(
                              createPostController.sharePostOthersList[index]["text"].toString(),
                              style: regular12TextStyle(cBlackColor),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }
}
