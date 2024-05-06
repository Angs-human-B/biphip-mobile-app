import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/post/new_post_comment.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({
    super.key,
    required this.isLikeButtonShown,
    required this.isReplyButtonShown,
    required this.isReactButtonShown,
    required this.isHideButtonShown,
    this.profileOnPressed,
    required this.postIndex,
    required this.commentIndex,
  });
  final bool isLikeButtonShown, isReplyButtonShown, isReactButtonShown, isHideButtonShown;
  final int postIndex, commentIndex;
  final VoidCallback? profileOnPressed;
  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();

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
                globalController.commonPostList[postIndex].comments[commentIndex].user!.profilePicture!,
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
                postReactionController.commentId.value = globalController.commonPostList[postIndex].comments[commentIndex].id!;
                postReactionController.selectedCommentIndex.value = commentIndex;
                postReactionController.commentedUserId.value = globalController.commonPostList[postIndex].comments[commentIndex].user!.id!;
                postReactionController.isUpdateReply.value = false;
                globalController.commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.4,
                    content: CommentBottomSheetContent(
                      postIndex: postIndex,
                      userId: globalController.commonPostList[postIndex].comments[commentIndex].user!.id!,
                    ),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {},
                    rightText: "",
                    rightTextStyle: regular10TextStyle(cWhiteColor),
                    title: "",
                    isRightButtonShow: false);
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
                          globalController.commonPostList[postIndex].comments[commentIndex].user!.fullName!,
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ),
                      kH8sizedBox,
                      // if (comment != null)
                      // globalController.commonPostList[postIndex].comments[commentIndex].comment is String
                      //     ? Text(
                      //         , ?? '',
                      //         overflow: TextOverflow.clip,
                      //         style: regular14TextStyle(cBlackColor),
                      //       )
                      //     : comment,
                      if (globalController.commonPostList[postIndex].comments[commentIndex].comment != null)
                        postReactionController.formatMentions(globalController.commonPostList[postIndex].comments[commentIndex].comment, context),

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
            if (globalController.commonPostList[postIndex].comments[commentIndex].image != null) kH4sizedBox,
            // if (isLink && !isImageComment)
            //   Container(
            //     width: width - 80,
            //     decoration: BoxDecoration(color: cWhiteColor, border: Border.all(color: cLineColor), borderRadius: k8CircularBorderRadius),
            //     child: Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: AnyLinkPreview(
            //         link: commentLink ?? '',
            //         removeElevation: true,
            //         backgroundColor: cWhiteColor,
            //         displayDirection: UIDirection.uiDirectionHorizontal,
            //         showMultimedia: true,
            //         bodyMaxLines: 2,
            //         previewHeight: 84,
            //         bodyTextOverflow: TextOverflow.ellipsis,
            //         titleStyle: semiBold14TextStyle(cBlackColor),
            //         bodyStyle: regular12TextStyle(cSmallBodyTextColor),
            //       ),
            //     ),
            //   ),
            if (globalController.commonPostList[postIndex].comments[commentIndex].image != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  width: isDeviceScreenLarge() ? 150 : 120,
                  height: isDeviceScreenLarge() ? 150 : 120,
                  child: ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: Image.network(
                      globalController.commonPostList[postIndex].comments[commentIndex].image!,
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
                      globalController.postTimeDifference(globalController.commonPostList[postIndex].comments[commentIndex].createdAt!),
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
                                        globalController.commonPostList[postIndex].comments[commentIndex].countReactions = Get.find<GlobalController>()
                                            .updateReaction("love", globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                                globalController.commonPostList[postIndex].comments[commentIndex].countReactions);
                                        globalController.commonPostList[postIndex].comments[commentIndex].myReaction = await globalController.getReaction(
                                            globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                            "love",
                                            3,
                                            globalController.commonPostList[postIndex].comments[commentIndex].id);
                                        globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                        globalController.commonPostList[postIndex].comments[commentIndex].countReactions = Get.find<GlobalController>()
                                            .updateReaction("like", globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                                globalController.commonPostList[postIndex].comments[commentIndex].countReactions);
                                        globalController.commonPostList[postIndex].comments[commentIndex].myReaction = await globalController.getReaction(
                                            globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                            "like",
                                            3,
                                            globalController.commonPostList[postIndex].comments[commentIndex].id);
                                        globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                        globalController.commonPostList[postIndex].comments[commentIndex].countReactions = Get.find<GlobalController>()
                                            .updateReaction("haha", globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                                globalController.commonPostList[postIndex].comments[commentIndex].countReactions);
                                        globalController.commonPostList[postIndex].comments[commentIndex].myReaction = await globalController.getReaction(
                                            globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                            "haha",
                                            3,
                                            globalController.commonPostList[postIndex].comments[commentIndex].id);
                                        globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                        globalController.commonPostList[postIndex].comments[commentIndex].countReactions = Get.find<GlobalController>()
                                            .updateReaction("wow", globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                                globalController.commonPostList[postIndex].comments[commentIndex].countReactions);
                                        globalController.commonPostList[postIndex].comments[commentIndex].myReaction = await globalController.getReaction(
                                            globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                            "wow",
                                            3,
                                            globalController.commonPostList[postIndex].comments[commentIndex].id);
                                        globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                        globalController.commonPostList[postIndex].comments[commentIndex].countReactions = Get.find<GlobalController>()
                                            .updateReaction("sad", globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                                globalController.commonPostList[postIndex].comments[commentIndex].countReactions);
                                        globalController.commonPostList[postIndex].comments[commentIndex].myReaction = await globalController.getReaction(
                                            globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                            "sad",
                                            3,
                                            globalController.commonPostList[postIndex].comments[commentIndex].id);
                                        globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                      onReactionChanged: (Reaction<String>? reaction) async {
                                        globalController.commonPostList[postIndex].comments[commentIndex].countReactions = Get.find<GlobalController>()
                                            .updateReaction("angry", globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                                globalController.commonPostList[postIndex].comments[commentIndex].countReactions);
                                        globalController.commonPostList[postIndex].comments[commentIndex].myReaction = await globalController.getReaction(
                                            globalController.commonPostList[postIndex].comments[commentIndex].myReaction,
                                            "angry",
                                            3,
                                            globalController.commonPostList[postIndex].comments[commentIndex].id);
                                        globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                        child: globalController.getColoredCommentReaction(globalController.commonPostList[postIndex].comments[commentIndex].myReaction),
                      ),
                    ),

                    kW16sizedBox,
                    if (isReplyButtonShown)
                      InkWell(
                        onTap: () {
                          Get.find<PostReactionController>().commentMentionKey.currentState?.controller?.text = "";
                          Get.find<FriendController>()
                              .mentionsList
                              .removeWhere((map) => map['id'] == globalController.commonPostList[postIndex].comments[commentIndex].user!.id.toString());
                          if (globalController.userId.value != globalController.commonPostList[postIndex].comments[commentIndex].user!.id) {
                            Map<String, dynamic> friendMap = {
                              'id': globalController.commonPostList[postIndex].comments[commentIndex].user!.id.toString(),
                              'display': globalController.commonPostList[postIndex].comments[commentIndex].user!.fullName,
                              'full_name': globalController.commonPostList[postIndex].comments[commentIndex].user!.fullName,
                              'photo': globalController.commonPostList[postIndex].comments[commentIndex].user!.profilePicture,
                            };
                            Get.find<FriendController>().mentionsList.add(friendMap);
                            Get.find<PostReactionController>().commentMentionKey.currentState?.controller?.text =
                                "@${globalController.commonPostList[postIndex].comments[commentIndex].user?.fullName} ";
                          }
                          Get.find<PostReactionController>().commentFocusNode.requestFocus();
                          Get.find<PostReactionController>().commentId.value = globalController.commonPostList[postIndex].comments[commentIndex].id!;
                          Get.find<PostReactionController>().isComment.value = false;
                        },
                        child: Text(
                          ksReply.tr,
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    // if (isSendMessageShown)
                    // InkWell(
                    //   onTap: sendMessageOnPressed,
                    //   child: Text(
                    //     ksSendMessage.tr,
                    //     style: regular10TextStyle(cSmallBodyTextColor),
                    //   ),
                    // ),
                    kW16sizedBox,
                    if (isHideButtonShown)
                      InkWell(
                        onTap: () async {
                          Get.find<PostReactionController>().commentId.value = globalController.commonPostList[postIndex].comments[commentIndex].id!;
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
                          reactCount: (globalController.commonPostList[postIndex].comments[commentIndex].countReactions == null ||
                                  globalController.commonPostList[postIndex].comments[commentIndex].countReactions!.value.all!.value == 0)
                              ? null
                              : globalController.commonPostList[postIndex].comments[commentIndex].countReactions)
                  ],
                ),
              ),
            ),
            // kH8sizedBox,
            // if (Get.find<PostReactionController>().commentId.value == commentId && Get.find<PostReactionController>().isReplyTextFieldShow.value)
            // SizedBox(
            //     width: width - 80,
            //     height: 132,
            //     child: ReplyTextField(
            //       onPressedCamera: () async {
            //         await Get.find<GlobalController>().selectImageSource(Get.find<PostReactionController>().isReplyImageChanged,
            //             Get.find<PostReactionController>().replyImageLink, Get.find<PostReactionController>().replyImageFile, 'gallery', false);
            //         Get.find<PostReactionController>().replySendEnabled();
            //       },
            //       onPressedSend: Get.find<PostReactionController>().isReplySendEnable.value
            //           ? () async {
            //               if (Get.find<PostReactionController>().isUpdateReply.value) {
            //                 await Get.find<PostReactionController>().updateReply(context);
            //               } else {
            //                 await Get.find<PostReactionController>().postReply(context);
            //                 Get.find<PostReactionController>().replyMentionKey.currentState!.controller!.text = "";
            //               }
            //             }
            //           : null,
            //     )),

            // if (Get.find<PostReactionController>().commentId.value == commentId) kH8sizedBox,
          ],
          // ),
        ),
      ],
    );
  }
}

class ReplyCommentWidget extends StatelessWidget {
  ReplyCommentWidget({
    super.key,
    required this.isLikeButtonShown,
    required this.isReplyButtonShown,
    required this.isReactButtonShown,
    this.profileOnPressed,
    required this.postIndex,
    required this.commentIndex,
    required this.replyIndex,
  });

  final bool isLikeButtonShown, isReplyButtonShown, isReactButtonShown;
  final int postIndex, commentIndex, replyIndex;
  final VoidCallback? profileOnPressed;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    CommentReply reply = globalController.commonPostList[postIndex].comments[commentIndex].commentReplies[replyIndex];
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
                Get.find<PostReactionController>().commentId.value = globalController.commonPostList[postIndex].comments[commentIndex].id!;
                Get.find<PostReactionController>().replyUserId.value = reply.user!.id!;
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.4,
                    content: ReplyBottomSheetContent(
                      postIndex: postIndex,
                      userId: reply.user!.id!,
                    ),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {},
                    rightText: "",
                    rightTextStyle: regular10TextStyle(cWhiteColor),
                    title: "",
                    isRightButtonShow: false);
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
                      // if (comment != null)
                      // Text(
                      //   comment ?? '',
                      //   overflow: TextOverflow.clip,
                      //   style: regular14TextStyle(cBlackColor),
                      // ),
                      // comment is String
                      //     ? Text(
                      //         comment ?? '',
                      //         overflow: TextOverflow.clip,
                      //         style: regular14TextStyle(cBlackColor),
                      //       )
                      //     : comment,
                      if (reply.reply != null) Get.find<PostReactionController>().formatMentions(reply.reply, context),
                      // if (isLink)
                      //   Text(
                      //     commentLink ?? '',
                      //     overflow: TextOverflow.clip,
                      //     style: regular14TextStyle(isLink ? cPrimaryColor : cBlackColor),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            if (reply.image != null) kH4sizedBox,
            // if (isLink && !isImageComment)
            //   Container(
            //     width: width - 120,
            //     decoration: BoxDecoration(color: cWhiteColor, border: Border.all(color: cLineColor), borderRadius: k8CircularBorderRadius),
            //     child: Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: AnyLinkPreview(
            //         link: commentLink ?? '',
            //         removeElevation: true,
            //         backgroundColor: cWhiteColor,
            //         displayDirection: UIDirection.uiDirectionHorizontal,
            //         showMultimedia: true,
            //         bodyMaxLines: 2,
            //         previewHeight: 84,
            //         bodyTextOverflow: TextOverflow.ellipsis,
            //         titleStyle: semiBold14TextStyle(cBlackColor),
            //         bodyStyle: regular12TextStyle(cSmallBodyTextColor),
            //       ),
            //     ),
            //   ),
            // if (!isLink && isImageComment)
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
                                          globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                          globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                          globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                          globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                          globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                                          globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
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
                    // Text(
                    //   ksLike.tr,
                    //   style: regular10TextStyle(cSmallBodyTextColor),
                    // ),
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
                          Get.find<PostReactionController>().commentId.value = globalController.commonPostList[postIndex].comments[commentIndex].id!;
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

class CommentBottomSheetContent extends StatelessWidget {
  CommentBottomSheetContent({super.key, required this.postIndex, required this.userId});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final int postIndex;
  final int userId;

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
                  : Get.find<GlobalController>().userId.value == userId
                      ? postReactionController.othersCommentActionList.length
                      : postReactionController.othersPostOtherUserCommentActionList.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      leading: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cNeutralColor,
                        ),
                        height: h28,
                        width: h28,
                        child: Icon(
                          globalController.userId.value == postReactionController.commentedUserId.value
                              ? postReactionController.commentActionList[index]['icon']
                              : Get.find<GlobalController>().userId.value == userId
                                  ? postReactionController.othersCommentActionList[index]['icon']
                                  : postReactionController.othersPostOtherUserCommentActionList[index]['icon'],
                          color: cBlackColor,
                          size: isDeviceScreenLarge() ? h18 : h14,
                        ),
                      ),
                      title: Get.find<GlobalController>().userId.value == postReactionController.commentedUserId.value
                          ? postReactionController.commentActionList[index]['action'].toString().tr
                          : Get.find<GlobalController>().userId.value == userId
                              ? postReactionController.othersCommentActionList[index]['action'].toString().tr
                              : postReactionController.othersPostOtherUserCommentActionList[index]['action'].toString().tr,
                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                      subTitleTextStyle: regular14TextStyle(cBlackColor),
                      onPressed: () async {
                        Get.back();
                        if (Get.find<GlobalController>().userId.value == postReactionController.commentedUserId.value &&
                            postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                          await postReactionController.deleteComment(postIndex, globalController.commonPostList[postIndex].id);
                          Get.find<GlobalController>().updateCommentCount(globalController.commonPostList, postIndex, false);
                        }
                        if (Get.find<GlobalController>().userId.value == postReactionController.commentedUserId.value &&
                            postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Hide Comment".toLowerCase()) {
                          await postReactionController.hideComment();
                        }
                        if (Get.find<GlobalController>().userId.value == postReactionController.commentedUserId.value &&
                            postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Update Comment".toLowerCase()) {
                          postReactionController.isUpdateComment.value = true;
                          postReactionController.isComment.value = true;
                          postReactionController.commentTextEditingController.text =
                              postReactionController.commentList[postReactionController.selectedCommentIndex.value].comment ?? "";
                          postReactionController.commentMentionKey.currentState!.controller!.text = postReactionController
                              .formatComment(postReactionController.commentList[postReactionController.selectedCommentIndex.value].comment ?? "");
                          if (postReactionController.commentList[postReactionController.selectedCommentIndex.value].image != null) {
                            postReactionController.commentImage.value =
                                postReactionController.commentList[postReactionController.selectedCommentIndex.value].image;
                          }
                          postReactionController.commentFocusNode.requestFocus();
                        }

                        if (Get.find<GlobalController>().userId.value == postReactionController.commentedUserId.value &&
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
                        if (Get.find<GlobalController>().userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Report Comment".toLowerCase()) {}
                        if (Get.find<GlobalController>().userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase()) {
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
                        if (Get.find<GlobalController>().userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                          // await postReactionController.deleteComment();
                        }
                        if (Get.find<GlobalController>().userId.value != postReactionController.commentedUserId.value &&
                            postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Hide Comment".toLowerCase()) {
                          // await postReactionController.hideComment();
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

class ReplyBottomSheetContent extends StatelessWidget {
  ReplyBottomSheetContent({super.key, required this.userId, required this.postIndex});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final int userId, postIndex;

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
                padding: const EdgeInsets.only(bottom: k8Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
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
                      await postReactionController.deleteReply(postIndex, globalController.commonPostList[postIndex].id);
                    }
                    if (Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value &&
                        postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Hide Reply".toLowerCase()) {
                      await postReactionController.hideReply(postIndex, globalController.commonPostList[postIndex].id);
                    }
                    if (Get.find<GlobalController>().userId.value == postReactionController.replyUserId.value &&
                        postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Update Reply".toLowerCase()) {
                      postReactionController.isUpdateReply.value = true;
                      for (int i = 0; i < postReactionController.commentList.length; i++) {
                        for (int j = 0; j < postReactionController.commentList[i].commentReplies.length; j++) {
                          if (postReactionController.replyId.value == postReactionController.commentList[i].commentReplies[j].id) {
                            postReactionController.commentMentionKey.currentState!.controller!.text =
                                postReactionController.formatComment(postReactionController.commentList[i].commentReplies[j].reply ?? "");
                            if (postReactionController.commentList[i].commentReplies[j].image != null) {
                              postReactionController.commentImage.value = postReactionController.commentList[i].commentReplies[j].image;
                            }
                          }
                        }
                      }
                    }
                    if (Get.find<GlobalController>().userId.value != postReactionController.replyUserId.value &&
                        postReactionController.othersReplyActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                      // await postReactionController.deleteReply();
                    }
                    if (Get.find<GlobalController>().userId.value != postReactionController.replyUserId.value &&
                        postReactionController.othersReplyActionList[index]['action'].toString().toLowerCase() == "Hide Reply".toLowerCase()) {
                      // await postReactionController.hideReply();
                    }
                    if (Get.find<GlobalController>().userId.value != postReactionController.replyUserId.value &&
                        postReactionController.othersReplyActionList[index]['action'].toString().toLowerCase() == "Report Reply".toLowerCase()) {}
                    // if (postReactionController.othersReplyActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase() ||
                    //     postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase() ||
                    //     postReactionController.othersPostOtherUserReplyActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase()) {
                    //   postReactionController.commentMentionKey.currentState?.controller?.text = "";
                    //   for (int i = 0; i < postReactionController.commentList.length; i++) {
                    //     for (int j = 0; j < postReactionController.commentList[i].commentReplies.length; j++) {
                    //       ll(postReactionController.commentList[i].commentReplies[j].user!.fullName);
                    //       Get.find<FriendController>()
                    //           .mentionsList
                    //           .removeWhere((map) => map['id'] == postReactionController.commentList[i].commentReplies[j].user!.id.toString());
                    //       Map<String, dynamic> friendMap = {
                    //         'id': postReactionController.commentList[i].commentReplies[j].user!.id.toString(),
                    //         'display': postReactionController.commentList[i].commentReplies[j].user!.fullName,
                    //         'full_name': postReactionController.commentList[i].commentReplies[j].user!.fullName,
                    //         'photo': postReactionController.commentList[i].commentReplies[j].user!.profilePicture,
                    //       };

                    //       if (Get.find<GlobalController>().userId.value != postReactionController.commentList[i].commentReplies[j].user!.id) {
                    //         Get.find<FriendController>().mentionsList.add(friendMap);
                    //         ll(Get.find<FriendController>().mentionsList);
                    //         postReactionController.commentMentionKey.currentState?.controller?.text =
                    //             "@${postReactionController.commentList[i].commentReplies[j].user!.fullName} ";
                    //       }
                    //       postReactionController.commentFocusNode.requestFocus();
                    //       postReactionController.commentId.value = postReactionController.commentList[i].id!;
                    //     }
                    //   }
                    // }
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
