import 'package:any_link_preview/any_link_preview.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/post_widgets/post_activity_status_widget.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {super.key,
      required this.profileImage,
      this.comment,
      required this.timePassed,
      required this.isLikeButtonShown,
      required this.isReplyButtonShown,
      required this.isReactButtonShown,
      required this.isLink,
      required this.reactCount,
      this.replyList,
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
      this.isImageComment});
  final String profileImage, timePassed, userName;
  final String? commentLink, comment, image;
  final bool? isImageComment;
  final bool isLikeButtonShown, isReplyButtonShown, isReactButtonShown, isLink, isSendMessageShown, isHideButtonShown;
  final int reactCount;
  final List? replyList;
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
            height: 32,
            width: 32,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.asset(
                profileImage,
                fit: BoxFit.cover,
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
                    if (comment != null)
                      Text(
                        comment ?? '',
                        overflow: TextOverflow.clip,
                        style: regular14TextStyle(cBlackColor),
                      ),
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
            if (isLink || isImageComment!) kH4sizedBox,
            if (isLink && !isImageComment!)
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
            if (!isLink && isImageComment!)
              SizedBox(
                width: isDeviceScreenLarge() ? 150 : 120,
                height: isDeviceScreenLarge() ? 150 : 120,
                child: ClipRRect(
                  borderRadius: k8CircularBorderRadius,
                  child: Image.asset(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(
              width: width - 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: k8Padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${timePassed}m',
                      style: regular10TextStyle(cSmallBodyTextColor),
                    ),
                    kW16sizedBox,
                    if (isLikeButtonShown)
                      InkWell(
                        onTap: likeButtonOnPressed,
                        child: Text(
                          'Like',
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    kW16sizedBox,
                    if (isReplyButtonShown)
                      InkWell(
                        onTap: replyButtonOnPressed,
                        child: Text(
                          'Reply',
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    if (isSendMessageShown)
                      InkWell(
                        onTap: sendMessageOnPressed,
                        child: Text(
                          'Send Message',
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    kW16sizedBox,
                    if (isHideButtonShown)
                      InkWell(
                        onTap: hideButtonOnPressed,
                        child: Text(
                          'Hide',
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                    const Spacer(),
                    if (isReactButtonShown) ReactionView(isPost: false, reactCount: reactCount)
                  ],
                ),
              ),
            ),
            kH4sizedBox,
            if (replyList == []) Text('View 7 more replies', style: semiBold14TextStyle(cSmallBodyTextColor))
          ],
        ),
      ],
    );
  }
}