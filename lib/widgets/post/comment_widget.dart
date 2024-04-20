import 'package:any_link_preview/any_link_preview.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:bip_hip/widgets/post/reply_textfield.dart';

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
      this.commentId});
  final String profileImage, userName;
  final String? commentLink, image, timePassed;
  final dynamic comment;

  final bool isImageComment, isLikeButtonShown, isReplyButtonShown, isReactButtonShown, isLink, isSendMessageShown, isHideButtonShown;
  final int reactCount;
  final int refType;
  final int refId;
  final List replyList;
  final int? commentId;
  final VoidCallback? likeButtonOnPressed, replyButtonOnPressed, sendMessageOnPressed, hideButtonOnPressed, profileOnPressed;

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
                  size: kIconSize16,
                  color: cIconColor,
                ),
                loadingBuilder: imageLoadingBuilder,
              ),
            ),
          ),
        ),
        kW8sizedBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                        InkWell(
                          onTap: likeButtonOnPressed,
                          child: Text(
                            ksLike.tr,
                            style: regular10TextStyle(cSmallBodyTextColor),
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
            if (replyList != [])
              // SizedBox(
              // width: width - 80,
              // child: ListView.builder(
              // shrinkWrap: true,
              // itemCount: replyList.length,
              // itemBuilder: (context, index) {
              for (int index = 0; index < replyList.length; index++)
                // var item = replyList;
                InkWell(
                  onTap: () {
                    Get.find<PostReactionController>().replyId.value = replyList[index].id!;
                    Get.find<PostReactionController>().selectedReplyIndex.value = index;
                    Get.find<PostReactionController>().commentId.value = commentId!;
                    Get.find<GlobalController>().commonBottomSheet(
                        context: context,
                        bottomSheetHeight: height * 0.4,
                        content: ReplyBottomSheetContent(),
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () {},
                        rightText: "",
                        rightTextStyle: regular10TextStyle(cWhiteColor),
                        title: "",
                        isRightButtonShow: false);
                  },
                  child: ReplyCommentWidget(
                    profileImage: replyList[index].user?.profilePicture ?? "",
                    timePassed: Get.find<HomeController>().postTimeDifference(replyList[index].createdAt),
                    isLikeButtonShown: true,
                    isReplyButtonShown: true,
                    isReactButtonShown: true,
                    isLink: false,
                    reactCount: 2,
                    userName: replyList[index].user?.fullName ?? ksNA.tr,
                    isImageComment: replyList[index].image != null ? true : false,
                    comment: Get.find<PostReactionController>().formatMentions(replyList[index].reply ?? "", context),
                    commentLink: "",
                    image: replyList[index].image,
                  ),
                  // );
                  // }),
                ),
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
      this.likeButtonOnPressed,
      this.replyButtonOnPressed,
      this.profileOnPressed,
      this.commentLink,
      this.image,
      required this.isImageComment});
  final String profileImage, timePassed, userName;
  final String? commentLink, image;
  final dynamic comment;

  final bool isImageComment, isLikeButtonShown, isReplyButtonShown, isReactButtonShown, isLink;
  final int reactCount;
  final VoidCallback? likeButtonOnPressed, replyButtonOnPressed, profileOnPressed;

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
                loadingBuilder: imageLoadingBuilder,
              ),
            ),
          ),
        ),
        kW8sizedBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                      InkWell(
                        onTap: likeButtonOnPressed,
                        child: Text(
                          ksLike.tr,
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
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

            // kH4sizedBox,
            // if (replyList == []) Text('View 7 more replies', style: semiBold14TextStyle(cSmallBodyTextColor)),
            // if (replyList != [])
            //   SizedBox(
            //     width: width - 140,
            //     child: ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: replyList.length,
            //         itemBuilder: (context, index) {
            //           var item = replyList[index];
            //           return CommentWidget(
            //             profileImage: item['profileImage'],
            //             timePassed: item['timePassed'],
            //             isLikeButtonShown: item['isLikeButtonShown'],
            //             isReplyButtonShown: item['isReplyButtonShown'],
            //             isReactButtonShown: item['isReactButtonShown'],
            //             isLink: item['isLink'],
            //             reactCount: item['reactCount'],
            //             userName: item['userName'],
            //             isSendMessageShown: item['isSendMessageShown'],
            //             isHideButtonShown: item['isHideButtonShown'],
            //             isImageComment: item['isImageComment'],
            //             comment: item['comment'],
            //             commentLink: item['commentLink'],
            //             replyList: [],
            //           );
            //         }),
            //   )
          ],
        ),
      ],
    );
  }
}
