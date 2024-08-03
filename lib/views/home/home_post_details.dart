import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_details_widget.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/comment_textfield.dart';
import 'package:bip_hip/widgets/post/comment_widget.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter/rendering.dart';

class HomePostDetails extends StatelessWidget {
  //!post index value needed top be changed
  HomePostDetails({super.key, this.postIndex = 0});
  final int postIndex;

  final HomeController homeController = Get.find<HomeController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    postReactionController.isFromSharePage.value = false;
    return Obx(
      () => Container(
        color: cWhiteColor,
        child: Stack(
          children: [
            SafeArea(
              top: false,
              child: SizedBox(
                height: height,
                child: Scaffold(
                  backgroundColor: cWhiteColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kAppBarSize),
                    //* info:: appBar
                    child: CustomAppBar(
                      hasBackButton: true,
                      isCenterTitle: true,
                      title: globalController.commonPostList[postIndex].user?.fullName ?? ksNA.tr,
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: Stack(
                    children: [
                      NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (postReactionController.commentListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                              scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                              !postReactionController.getCommentScrolled.value) {
                            postReactionController.getCommentScrolled.value = true;
                            if (globalController.commonPostList[postIndex].comments.isNotEmpty) {
                              postReactionController.getMoreCommentList(null, 1, globalController.commonPostList[postIndex].id!, postIndex);
                            }
                            return true;
                          }
                          return false;
                        },
                        child: SizedBox(
                          height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                          child: SingleChildScrollView(
                            controller: postReactionController.commentListScrollController,
                            child: Padding(
                              padding: const EdgeInsets.only(top: k12Padding),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: PostUpperContainer(
                                      postIndex: postIndex,
                                    ),
                                  ),
                                  kH12sizedBox,
                                  CommonPostDetailsWidget(
                                    postIndex: postIndex,
                                  ),
                                  if (postReactionController.commentList.isNotEmpty &&
                                      postReactionController.getCommentScrolled.value &&
                                      postReactionController.getCommentSubLink.value != null)
                                    const Center(child: CommentCommonShimmer()),
                                  const SizedBox(
                                    height: 110,
                                  ),
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
                                    await Get.find<PostReactionController>().updateComment(context, globalController.commonPostList[postIndex].id, postIndex);
                                  } else if (Get.find<PostReactionController>().isUpdateReply.value) {
                                    await Get.find<PostReactionController>().updateReply(context, globalController.commonPostList[postIndex].id, postIndex);
                                  } else if (postReactionController.commentId.value == -1) {
                                    await Get.find<PostReactionController>()
                                        .postComment(1, globalController.commonPostList[postIndex].id!, context, "comment", postIndex);
                                    Get.find<FriendController>().mentionsList.removeLast();
                                    Get.find<GlobalController>().updateCommentCount(globalController.commonPostList, postIndex, true);
                                  } else if (postReactionController.commentId.value != -1) {
                                    await Get.find<PostReactionController>()
                                        .postComment(1, postReactionController.commentId.value, context, "reply", postIndex);
                                    Get.find<FriendController>().mentionsList.removeLast();
                                    Get.find<GlobalController>().updateCommentCount(globalController.commonPostList, postIndex, true);
                                  }
                                },
                              )),
                        ),
                      ),
                   
                    ],
                  ),
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

class PostDetailsBottomSection extends StatelessWidget {
  PostDetailsBottomSection({
    super.key,
    required this.isSelfPost,
    required this.isCommentShown,
    required this.commentCount,
    required this.shareCount,
    required this.giftCount,
    this.category,
    this.actionName,
    this.actionOnPressed,
    this.postIndex = 0,
    this.refType = 0,
    this.refId = 0,
    this.userId = 0,
  });

  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final bool isSelfPost, isCommentShown;
  final RxBool showComment = RxBool(false);
  final int commentCount, shareCount, giftCount;
  final int postIndex;
  final int refType;
  final int refId, userId;
  final String? category, actionName;
  final VoidCallback? actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
            child: PostActivityStatusWidget(
              postIndex: postIndex,
              reactionOnPressed: () {},
              isGiftShown: true,
              giftOnPressed: () {
                postReactionController.giftFilter(0);
                Get.toNamed(krGiftView);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
            ),
            child: LikeSectionWidget(
              postIndex: postIndex,
              isGiftShown: globalController.userId.value == globalController.commonPostList[postIndex].user!.id! ? false : true,
              giftOnPressed: () {
              },
              commentOnPressed: () async {
                postReactionController.commentMentionKey.currentState?.controller?.text = "";
                postReactionController.commentId.value = -1;
                showComment.value = !showComment.value;
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: CustomDivider(),
          ),
          kH12sizedBox,
          if (postReactionController.isCommentPostLoading.value) const SingleCommentShimmer(),
          (postReactionController.isCommentLoading.value && !postReactionController.isCommentPostLoading.value)
              ? const CommentCommonShimmer()
              : ListView.separated(
                  separatorBuilder: (context, index) => kH8sizedBox,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: globalController.commonPostList[postIndex].comments.length,
                  itemBuilder: (context, i) {
                    return Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: CommentWidget(
                                postIndex: postIndex,
                                commentIndex: i,
                                isLikeButtonShown: true,
                                isReplyButtonShown: true,
                                isReactButtonShown: true,
                                isHideButtonShown: globalController.userId.value == globalController.commonPostList[postIndex].comments[i].user!.id,
                              ),
                            ),
                            kH8sizedBox,
                            if (!postReactionController.replyShow[i] && globalController.commonPostList[postIndex].comments[i].commentReplies.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: k60Padding, right: k60Padding, bottom: k10Padding),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                        onTap: () async {
                                          globalController.commonPostList[postIndex].comments[i].commentReplies.clear();
                                          postReactionController.replyShow[i] = true;
                                          await postReactionController.getReplyList(globalController.commonPostList[postIndex].comments[i].id!, postIndex, i);
                                        },
                                        child: Text(
                                          "View Replies",
                                          style: semiBold14TextStyle(cSmallBodyTextColor),
                                        ))),
                              ),
                            if (postReactionController.replyShow[i])
                              for (int index = 0; index < globalController.commonPostList[postIndex].comments[i].commentReplies.length; index++)
                                Padding(
                                  padding: const EdgeInsets.only(top: 0, right: kHorizontalPadding),
                                  child: ReplyCommentWidget(
                                    postIndex: postIndex,
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
        ],
      ),
    );
  }
}

class SingleCommentShimmer extends StatelessWidget {
  const SingleCommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShimmerCommon(
              widget: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
              ),
            ),
            kW8sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerCommon(
                  widget: Container(
                    width: width - 80,
                    height: 60,
                    decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        kH16sizedBox,
      ],
    );
  }
}

class CommentCommonShimmer extends StatelessWidget {
  const CommentCommonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShimmerCommon(
              widget: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
              ),
            ),
            kW8sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerCommon(
                  widget: Container(
                    width: width - 80,
                    height: 60,
                    decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        kH8sizedBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerCommon(
              widget: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
              ),
            ),
            kW8sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerCommon(
                  widget: Container(
                    width: width - 160,
                    height: 80,
                    decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        kH10sizedBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShimmerCommon(
              widget: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
              ),
            ),
            kW8sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerCommon(
                  widget: Container(
                    width: width - 190,
                    height: 90,
                    decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        kH8sizedBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerCommon(
              widget: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
              ),
            ),
            kW8sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerCommon(
                  widget: Container(
                    width: width - 130,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
