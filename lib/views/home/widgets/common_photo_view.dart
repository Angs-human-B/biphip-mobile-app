import 'dart:math';

import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/home_post_details_screen.dart';
import 'package:bip_hip/views/menu/photos/photos.dart';
import 'package:bip_hip/widgets/post/comment_textfield.dart';
import 'package:bip_hip/widgets/post/comment_widget.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CommonPhotoView extends StatelessWidget {
  const CommonPhotoView(
      {super.key, required this.image, this.postIndex = 0, this.onPressed, this.description, this.isLikeSectionShow = true, this.topRightIcon});
  final String image;
  final int postIndex;
  final String? description;
  final VoidCallback? onPressed;
  final bool? isLikeSectionShow;
  final IconData? topRightIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: Obx(() => CustomAppBar(
                  systemUiOverlayStyle: SystemUiOverlayStyle.light,
                  appBarColor: Colors.black,
                  hasBackButton: true,
                  iconColor: cWhiteColor,
                  isCenterTitle: true,
                  onBack: () {
                    Get.back();
                  },
                  action: [
                    if (Get.find<AwardController>().isOthersWinner.value == false)
                      Padding(
                        padding: const EdgeInsets.only(right: k8Padding),
                        child: CustomIconButton(
                          onPress: onPressed,
                          icon: topRightIcon ?? BipHip.system,
                          iconColor: cWhiteColor,
                          size: kIconSize20,
                        ),
                      ),
                  ],
                )),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        height: height * 0.6,
                        child: Image.network(
                          image,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.imageFile,
                            size: kIconSize100,
                            color: cIconColor,
                          ),
                          loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              Get.find<GalleryController>().imageData.value?.description ?? "",
                              style: semiBold14TextStyle(cWhiteColor),
                            )),
                        kH16sizedBox,
                        if (isLikeSectionShow == true)
                          Container(
                            color: cWhiteColor,
                            height: 1,
                            width: width - 40,
                          ),
                        if (isLikeSectionShow == true)
                          LikeSectionWidget(
                            postIndex: postIndex,
                            sectionColor: cWhiteColor,
                            isGiftShown: false,
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryWidget extends StatelessWidget {
  GalleryWidget({super.key, required this.urlImages, required this.imageIndex, this.imageDescriptions, required this.postIndex})
      : pageController = PageController(initialPage: imageIndex);
  final RxList<ImageElement> urlImages;
  final int imageIndex;
  final int postIndex;
  final String? imageDescriptions;
  final PageController pageController;
  static RxString imageDescription = RxString("");
  static RxString selfReaction = RxString("");
  static Rx<CountReactions>? sharePostCountReaction;
  static int temporaryImageIndex = 0;
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    temporaryImageIndex = imageIndex;
    imageDescription.value = "";
    if (urlImages[imageIndex].description != null) {
      imageDescription.value = urlImages[imageIndex].description!;
    }
    if (urlImages[imageIndex].countReactions?.value == null || urlImages[imageIndex].countReactions?.value.all?.value == 0) {
      sharePostCountReaction = null;
    } else {
      sharePostCountReaction = urlImages[imageIndex].countReactions;
    }
    selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              systemUiOverlayStyle: SystemUiOverlayStyle.light,
              appBarColor: Colors.black,
              hasBackButton: true,
              iconColor: cWhiteColor,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k8Padding),
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        BipHip.system,
                        color: cWhiteColor,
                        size: kIconSize20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              PhotoViewGallery.builder(
                pageController: pageController,
                itemCount: urlImages.length,
                onPageChanged: (index) {
                  if (urlImages[index].description != null) {
                    imageDescription.value = urlImages[index].description!;
                  } else {
                    imageDescription.value = "";
                  }
                  sharePostCountReaction = urlImages[index].countReactions;
                  selfReaction.value = urlImages[index].myReaction?.value ?? "";
                  temporaryImageIndex = index;
                },
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(urlImages[index].fullPath!),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 5,
                  );
                },
              ),
              Positioned(
                bottom: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Obx(
                    () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Text(
                          imageDescription.value,
                          style: semiBold14TextStyle(cWhiteColor),
                        ),
                      ),
                      kH16sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: SizedBox(
                          width: width - 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (urlImages[imageIndex].countReactions == null)
                                const Expanded(
                                  child: SizedBox(),
                                ),
                              if (urlImages[imageIndex].countReactions != null)
                                InkWell(
                                  child: ReactionView(
                                    isPost: true,
                                    reactCount: sharePostCountReaction,
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
                      ),
                      kH12sizedBox,
                      Container(
                        color: cWhiteColor,
                        height: 1,
                        width: width - 40,
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
                                              urlImages[temporaryImageIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                                  "love", urlImages[temporaryImageIndex].myReaction, urlImages[temporaryImageIndex].countReactions);
                                              urlImages[temporaryImageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[temporaryImageIndex].myReaction, "love", 2, urlImages[temporaryImageIndex].id!);
                                              sharePostCountReaction = urlImages[temporaryImageIndex].countReactions;
                                              selfReaction.value = urlImages[temporaryImageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(temporaryImageIndex, temporaryImageIndex + 1, [urlImages[temporaryImageIndex]]);
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
                                              urlImages[temporaryImageIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                                  "like", urlImages[temporaryImageIndex].myReaction, urlImages[temporaryImageIndex].countReactions);
                                              urlImages[temporaryImageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[temporaryImageIndex].myReaction, "like", 2, urlImages[temporaryImageIndex].id!);
                                              sharePostCountReaction = urlImages[temporaryImageIndex].countReactions;
                                              selfReaction.value = urlImages[temporaryImageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(temporaryImageIndex, temporaryImageIndex + 1, [urlImages[temporaryImageIndex]]);
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
                                              urlImages[temporaryImageIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                                  "haha", urlImages[temporaryImageIndex].myReaction, urlImages[temporaryImageIndex].countReactions);
                                              urlImages[temporaryImageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[temporaryImageIndex].myReaction, "haha", 2, urlImages[temporaryImageIndex].id!);
                                              sharePostCountReaction = urlImages[temporaryImageIndex].countReactions;
                                              selfReaction.value = urlImages[temporaryImageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(temporaryImageIndex, temporaryImageIndex + 1, [urlImages[temporaryImageIndex]]);
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
                                              urlImages[temporaryImageIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                                  "wow", urlImages[temporaryImageIndex].myReaction, urlImages[temporaryImageIndex].countReactions);
                                              urlImages[temporaryImageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[temporaryImageIndex].myReaction, "wow", 2, urlImages[temporaryImageIndex].id!);
                                              sharePostCountReaction = urlImages[temporaryImageIndex].countReactions;
                                              selfReaction.value = urlImages[temporaryImageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(temporaryImageIndex, temporaryImageIndex + 1, [urlImages[temporaryImageIndex]]);
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
                                              urlImages[temporaryImageIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                                  "sad", urlImages[temporaryImageIndex].myReaction, urlImages[temporaryImageIndex].countReactions);
                                              sharePostCountReaction = urlImages[temporaryImageIndex].countReactions;
                                              urlImages[temporaryImageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[temporaryImageIndex].myReaction, "sad", 2, urlImages[temporaryImageIndex].id!);
                                              selfReaction.value = urlImages[temporaryImageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(temporaryImageIndex, temporaryImageIndex + 1, [urlImages[temporaryImageIndex]]);
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
                                              urlImages[temporaryImageIndex].countReactions = Get.find<GlobalController>().updateReaction(
                                                  "angry", urlImages[temporaryImageIndex].myReaction, urlImages[temporaryImageIndex].countReactions);
                                              sharePostCountReaction = urlImages[temporaryImageIndex].countReactions;
                                              urlImages[temporaryImageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[temporaryImageIndex].myReaction, "angry", 2, urlImages[temporaryImageIndex].id!);
                                              urlImages.replaceRange(temporaryImageIndex, temporaryImageIndex + 1, [urlImages[temporaryImageIndex]]);
                                              selfReaction.value = urlImages[temporaryImageIndex].myReaction?.value ?? "";
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
                                child: selfReaction.value == ""
                                    ? Get.find<GlobalController>().getColoredReactionIcon(null)
                                    : Get.find<GlobalController>().getColoredReactionIcon(selfReaction),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (!postReactionController.isRouteFromHomePage.value) {
                                postReactionController.imageId.value =
                                    Get.find<GalleryController>().imageDataList[postIndex].imageList[temporaryImageIndex].id!;
                              } else {
                                postReactionController.imageId.value = Get.find<GlobalController>().commonPostList[postIndex].images[temporaryImageIndex].id!;
                              }
                              globalController.blankBottomSheetForImageComment(
                                context: context,
                                isScrollControlled: true,
                                bottomSheetHeight: height * 0.9,
                                content: Obx(() => postReactionController.isCommentLoading.value
                                    ? const CommentCommonShimmer()
                                    : Column(
                                        children: [
                                          if (postReactionController.commentList.isEmpty)
                                            SizedBox(
                                              height: height * 0.738,
                                              child: Column(
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
                                              ),
                                            ),
                                          if (postReactionController.commentList.isNotEmpty)
                                            SingleChildScrollView(
                                              child: SizedBox(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: postReactionController.commentList.length,
                                                  itemBuilder: (context, index) {
                                                    return Obx(() => Column(
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
                                                                padding: const EdgeInsets.only(left: k60Padding, right: k60Padding, bottom: k10Padding),
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
                                                              for (int i = 0; i < postReactionController.commentList[index].commentReplies.length; i++)
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
                                                        ));
                                                  },
                                                ),
                                              ),
                                            ),
                                          CommentTextField(
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
                                                if (!postReactionController.isRouteFromHomePage.value) {
                                                  await postReactionController.postComment(
                                                      2,
                                                      Get.find<GalleryController>().imageDataList[postIndex].imageList[temporaryImageIndex].id!,
                                                      context,
                                                      "comment",
                                                      postIndex);
                                                } else {
                                                  await postReactionController.postComment(
                                                      2,
                                                      globalController.commonPostList[postIndex].images[temporaryImageIndex].id!,
                                                      context,
                                                      "comment",
                                                      postIndex);
                                                }
                                                Get.find<FriendController>().mentionsList.removeLast();
                                                Get.find<GlobalController>().updateCommentCount(globalController.commonPostList, postIndex, true);
                                              } else if (postReactionController.commentId.value != -1) {
                                                if (!postReactionController.isRouteFromHomePage.value) {
                                                  await Get.find<PostReactionController>().postComment(
                                                      2,
                                                      Get.find<GalleryController>().imageDataList[postIndex].imageList[temporaryImageIndex].id!,
                                                      context,
                                                      "reply",
                                                      postIndex);
                                                } else {
                                                  await Get.find<PostReactionController>().postComment(
                                                      2,
                                                      Get.find<GlobalController>().commonPostList[postIndex].images[temporaryImageIndex].id!,
                                                      context,
                                                      "reply",
                                                      postIndex);
                                                }
                                                Get.find<FriendController>().mentionsList.removeLast();
                                                Get.find<GlobalController>().updateCommentCount(globalController.commonPostList, postIndex, true);
                                              }
                                            },
                                          ),
                                        ],
                                      )),
                              );
                              postReactionController.resetCommentAndReplyData();
                              if (!postReactionController.isRouteFromHomePage.value) {
                                await postReactionController.getCommentList(
                                    2, Get.find<GalleryController>().imageDataList[postIndex].imageList[temporaryImageIndex].id!, postIndex);
                              } else {
                                await postReactionController.getCommentList(
                                    2, globalController.commonPostList[postIndex].images[temporaryImageIndex].id!, postIndex);
                              }
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
                          // InkWell(
                          //   child: SizedBox(
                          //     width: (width - 40) / 3,
                          //     height: 44,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           ksShare.tr,
                          //           style: semiBold12TextStyle(cIconColor),
                          //         ),
                          //         kW4sizedBox,
                          //         const Icon(
                          //           BipHip.shareOutline,
                          //           color: cIconColor,
                          //           size: kIconSize20,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              if (!postReactionController.isRouteFromHomePage.value) {
                                Get.find<GlobalController>().blankBottomSheet(
                                  context: context,
                                  bottomSheetHeight: height * 0.38,
                                  content: GalleryImageShareBottomSheetContent(
                                    photoData: Get.find<GalleryController>().imageDataList[postIndex],
                                    imageIndex: temporaryImageIndex,
                                  ),
                                );
                              } else {
                                Get.find<GlobalController>().blankBottomSheet(
                                  context: context,
                                  bottomSheetHeight: height * 0.38,
                                  content: ImageShareBottomSheetContent(
                                    postData: Get.find<GlobalController>().commonPostList[postIndex],
                                    imageIndex: temporaryImageIndex,
                                  ),
                                );
                              }
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
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
