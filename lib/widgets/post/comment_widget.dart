import 'package:any_link_preview/any_link_preview.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:bip_hip/widgets/post/reply_textfield.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {super.key,
      required this.profileImage,
      this.comment,
      this.timePassed,
      required this.isLikeButtonShown,
      required this.isReplyButtonShown,
      required this.isReactButtonShown,
      required this.isLink,
      required this.reactCount,
      required this.replyList,
      required this.userName,
      this.likeButtonOnPressed,
      required this.isSendMessageShown,
      this.replyButtonOnPressed,
      this.sendMessageOnPressed,
      required this.isHideButtonShown,
      this.hideButtonOnPressed,
      this.profileOnPressed,
      this.commentLink,
      this.image,
      required this.isImageComment,
      this.refType = 0,
      this.refId = 0,
      this.commentId,
      this.selfReaction,
      this.onLikePressed,
      this.onLovePressed,
      this.onWowPressed,
      this.onHahaPressed,
      this.onSadPressed,
      this.onAngryPressed,
      this.commentOnPressed});
  final String profileImage, userName;
  final String? commentLink, image, timePassed, selfReaction;
  final dynamic comment;
  final bool isImageComment, isLikeButtonShown, isReplyButtonShown, isReactButtonShown, isLink, isSendMessageShown, isHideButtonShown;
  final int reactCount, refId, refType;
  final List replyList;
  final int? commentId;
  final VoidCallback? likeButtonOnPressed, replyButtonOnPressed, sendMessageOnPressed, hideButtonOnPressed, profileOnPressed, commentOnPressed;
  final void Function(Reaction<String>? reaction)? onLikePressed, onLovePressed, onWowPressed, onHahaPressed, onSadPressed, onAngryPressed;

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
                profileImage,
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
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: k8CircularBorderRadius,
                onTap: commentOnPressed,
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
                            userName,
                            style: semiBold14TextStyle(cBlackColor),
                          ),
                        ),
                        kH8sizedBox,
                        // if (comment != null)
                        comment is String
                            ? Text(
                                comment ?? '',
                                overflow: TextOverflow.clip,
                                style: regular14TextStyle(cBlackColor),
                              )
                            : comment,

                        if (isLink)
                          Text(
                            commentLink ?? '',
                            overflow: TextOverflow.clip,
                            style: regular14TextStyle(isLink ? cPrimaryColor : cBlackColor),
                          )
                      ],
                    ),
                  ),
                ),
              ),

              if (isLink || isImageComment) kH4sizedBox,
              if (isLink && !isImageComment)
                Container(
                  width: width - 80,
                  decoration: BoxDecoration(color: cWhiteColor, border: Border.all(color: cLineColor), borderRadius: k8CircularBorderRadius),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: AnyLinkPreview(
                      link: commentLink ?? '',
                      removeElevation: true,
                      backgroundColor: cWhiteColor,
                      displayDirection: UIDirection.uiDirectionHorizontal,
                      showMultimedia: true,
                      bodyMaxLines: 2,
                      previewHeight: 84,
                      bodyTextOverflow: TextOverflow.ellipsis,
                      titleStyle: semiBold14TextStyle(cBlackColor),
                      bodyStyle: regular12TextStyle(cSmallBodyTextColor),
                    ),
                  ),
                ),
              if (!isLink && image != null)
                SizedBox(
                  width: isDeviceScreenLarge() ? 150 : 120,
                  height: isDeviceScreenLarge() ? 150 : 120,
                  child: ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: Image.network(
                      image!,
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
              if (timePassed != null)
                SizedBox(
                  width: width - 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: k8Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '$timePassed',
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
                                            onReactionChanged: onLovePressed!,
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
                                            onReactionChanged: onLikePressed!,
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
                                            onReactionChanged: onHahaPressed!,
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
                                            onReactionChanged: onWowPressed!,
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
                                            onReactionChanged: onSadPressed!,
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
                                            onReactionChanged: onAngryPressed!,
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
                              child: Get.find<GlobalController>().getColoredCommentReaction(selfReaction),
                            ),
                          ),

                        kW16sizedBox,
                        if (isReplyButtonShown)
                          InkWell(
                            onTap: replyButtonOnPressed,
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
                            onTap: hideButtonOnPressed,
                            child: Text(
                              ksHide.tr,
                              style: regular10TextStyle(cSmallBodyTextColor),
                            ),
                          ),
                        const Spacer(),
                        if (isReactButtonShown) const ReactionView(isPost: false, reactCount: null)
                      ],
                    ),
                  ),
                ),
              kH4sizedBox,
              // if (replyList == []) Text('View 7 more replies', style: semiBold14TextStyle(cSmallBodyTextColor)),
              // if (replyList != [])
              // ListView.builder(
              //   itemCount: replyList.length,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     return ReplyCommentWidget(
              //       selfReaction: replyList[index].myReaction,
              //       onReplyLikePressed: (Reaction<String>? reaction) {
              //         replyList[index].myReaction =
              //             Get.find<GlobalController>().getReaction(replyList[index].myReaction, "like", refType, replyList[index].id);
              //         replyList[index] = replyList[index];
              //         // postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
              //       },
              //       onReplyLovePressed: (Reaction<String>? reaction) {
              //         replyList[index].myReaction =
              //             Get.find<GlobalController>().getReaction(replyList[index].myReaction, "love", refType, replyList[index].id);
              //         replyList[index] = replyList[index];
              //         // postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
              //       },
              //       onReplyHahaPressed: (Reaction<String>? reaction) {
              //         replyList[index].myReaction =
              //             Get.find<GlobalController>().getReaction(replyList[index].myReaction, "haha", refType, replyList[index].id);
              //         replyList[index] = replyList[index];
              //         // postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
              //       },
              //       onReplyWowPressed: (Reaction<String>? reaction) {
              //         replyList[index].myReaction =
              //             Get.find<GlobalController>().getReaction(replyList[index].myReaction, "wow", refType, replyList[index].id);
              //         replyList[index] = replyList[index];
              //         // postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
              //       },
              //       onReplySadPressed: (Reaction<String>? reaction) {
              //         replyList[index].myReaction =
              //             Get.find<GlobalController>().getReaction(replyList[index].myReaction, "sad", refType, replyList[index].id);
              //         replyList[index] = replyList[index];
              //         // postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
              //       },
              //       onReplyAngryPressed: (Reaction<String>? reaction) {
              //         replyList[index].myReaction =
              //             Get.find<GlobalController>().getReaction(replyList[index].myReaction, "angry", refType, replyList[index].id);
              //         replyList[index] = replyList[index];
              //         // postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
              //       },
              //       commentOnPressed: () {
              //         Get.find<PostReactionController>().replyId.value = replyList[index].id!;
              //         Get.find<PostReactionController>().selectedReplyIndex.value = index;
              //         Get.find<PostReactionController>().commentId.value = commentId!;
              //         Get.find<GlobalController>().commonBottomSheet(
              //             context: context,
              //             bottomSheetHeight: height * 0.4,
              //             content: ReplyBottomSheetContent(),
              //             onPressCloseButton: () {
              //               Get.back();
              //             },
              //             onPressRightButton: () {},
              //             rightText: "",
              //             rightTextStyle: regular10TextStyle(cWhiteColor),
              //             title: "",
              //             isRightButtonShow: false);
              //       },
              //       profileImage: replyList[index].user?.profilePicture ?? "",
              //       timePassed: Get.find<HomeController>().postTimeDifference(replyList[index].createdAt),
              //       isLikeButtonShown: true,
              //       isReplyButtonShown: true,
              //       isReactButtonShown: true,
              //       isLink: false,
              //       reactCount: 2,
              //       userName: replyList[index].user?.fullName ?? ksNA.tr,
              //       isImageComment: replyList[index].image != null ? true : false,
              //       comment: Get.find<PostReactionController>().formatMentions(replyList[index].reply ?? "", context),
              //       commentLink: "",
              //       image: replyList[index].image,
              //     );
              //   },
              // ),
              kH8sizedBox,
              if (Get.find<PostReactionController>().commentId.value == commentId && Get.find<PostReactionController>().isReplyTextFieldShow.value)
                SizedBox(
                    width: width - 80,
                    height: 132,
                    child: ReplyTextField(
                      onPressedCamera: () async {
                        await Get.find<GlobalController>().selectImageSource(Get.find<PostReactionController>().isReplyImageChanged,
                            Get.find<PostReactionController>().replyImageLink, Get.find<PostReactionController>().replyImageFile, 'gallery', false);
                        Get.find<PostReactionController>().replySendEnabled();
                      },
                      onPressedSend: Get.find<PostReactionController>().isReplySendEnable.value
                          ? () async {
                              if (Get.find<PostReactionController>().isUpdateReply.value) {
                                await Get.find<PostReactionController>().updateReply(context);
                              } else {
                                await Get.find<PostReactionController>().postReply(context);
                                Get.find<PostReactionController>().replyMentionKey.currentState!.controller!.text = "";
                              }
                            }
                          : null,
                    )),
              if (Get.find<PostReactionController>().commentId.value == commentId) kH8sizedBox,
            ],
          ),
        ),
      ],
    );
  }
}

class ReplyCommentWidget extends StatelessWidget {
  const ReplyCommentWidget(
      {super.key,
      required this.profileImage,
      this.comment,
      required this.timePassed,
      required this.isLikeButtonShown,
      required this.isReplyButtonShown,
      required this.isReactButtonShown,
      required this.isLink,
      required this.reactCount,
      required this.userName,
      this.replyButtonOnPressed,
      this.profileOnPressed,
      this.commentLink,
      this.image,
      required this.isImageComment,
      this.commentOnPressed,
      this.selfReaction,
      this.onReplyLikePressed,
      this.onReplyLovePressed,
      this.onReplyWowPressed,
      this.onReplyHahaPressed,
      this.onReplySadPressed,
      this.onReplyAngryPressed});
  final String profileImage, timePassed, userName;
  final String? commentLink, image, selfReaction;
  final dynamic comment;

  final bool isImageComment, isLikeButtonShown, isReplyButtonShown, isReactButtonShown, isLink;
  final int reactCount;
  final VoidCallback? replyButtonOnPressed, profileOnPressed, commentOnPressed;
  final void Function(Reaction<String>? reaction)? onReplyLikePressed,
      onReplyLovePressed,
      onReplyWowPressed,
      onReplyHahaPressed,
      onReplySadPressed,
      onReplyAngryPressed;

  @override
  Widget build(BuildContext context) {
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
                profileImage,
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
              onTap: commentOnPressed,
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
                          userName,
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
                      comment is String
                          ? Text(
                              comment ?? '',
                              overflow: TextOverflow.clip,
                              style: regular14TextStyle(cBlackColor),
                            )
                          : comment,
                      if (isLink)
                        Text(
                          commentLink ?? '',
                          overflow: TextOverflow.clip,
                          style: regular14TextStyle(isLink ? cPrimaryColor : cBlackColor),
                        )
                    ],
                  ),
                ),
              ),
            ),
            if (isLink || isImageComment) kH4sizedBox,
            if (isLink && !isImageComment)
              Container(
                width: width - 120,
                decoration: BoxDecoration(color: cWhiteColor, border: Border.all(color: cLineColor), borderRadius: k8CircularBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AnyLinkPreview(
                    link: commentLink ?? '',
                    removeElevation: true,
                    backgroundColor: cWhiteColor,
                    displayDirection: UIDirection.uiDirectionHorizontal,
                    showMultimedia: true,
                    bodyMaxLines: 2,
                    previewHeight: 84,
                    bodyTextOverflow: TextOverflow.ellipsis,
                    titleStyle: semiBold14TextStyle(cBlackColor),
                    bodyStyle: regular12TextStyle(cSmallBodyTextColor),
                  ),
                ),
              ),
            // if (!isLink && isImageComment)
            if (!isLink && image != null)
              SizedBox(
                width: isDeviceScreenLarge() ? 150 : 120,
                height: isDeviceScreenLarge() ? 150 : 120,
                child: ClipRRect(
                  borderRadius: k8CircularBorderRadius,
                  child: Image.network(
                    image ?? "",
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
            SizedBox(
              width: width - 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: k8Padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      timePassed,
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
                                        onReactionChanged: onReplyLovePressed!,
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
                                        onReactionChanged: onReplyLikePressed!,
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
                                        onReactionChanged: onReplyHahaPressed!,
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
                                        onReactionChanged: onReplyWowPressed!,
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
                                        onReactionChanged: onReplySadPressed!,
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
                                        onReactionChanged: onReplyAngryPressed!,
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
                          child: Get.find<GlobalController>().getColoredCommentReaction(selfReaction),
                        ),
                      ),
                    // Text(
                    //   ksLike.tr,
                    //   style: regular10TextStyle(cSmallBodyTextColor),
                    // ),
                    kW16sizedBox,
                    if (isReplyButtonShown)
                      // InkWell(
                      //   onTap: replyButtonOnPressed,
                      //   child: Text(
                      //     ksReply.tr,
                      //     style: regular10TextStyle(cSmallBodyTextColor),
                      //   ),
                      // ),
                      const Spacer(),
                    if (isReactButtonShown) const ReactionView(isPost: false, reactCount: null)
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
