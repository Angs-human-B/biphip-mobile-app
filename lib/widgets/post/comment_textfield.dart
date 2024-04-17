import 'dart:io';

import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

class CommentTextField extends StatelessWidget {
  CommentTextField({super.key, this.onPressEmoji, this.onPressedCamera, this.onPressedSend, this.hintText});

  final VoidCallback? onPressEmoji, onPressedCamera, onPressedSend;
  final String? hintText;
  final GlobalKey<FlutterMentionsState> mentionKey = GlobalKey<FlutterMentionsState>();

  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: cGreyBoxColor, borderRadius: k8CircularBorderRadius),
      child: Padding(
        padding: const EdgeInsets.all(k8Padding),
        child: Column(
          children: [
            FlutterMentions(
              key: mentionKey,
              // decoration: InputDecoration(

              // ),
              mentions: [
                Mention(
                    trigger: "@",
                    data: postReactionController.mentionUserList,
                    style: semiBold14TextStyle(cPrimaryColor),
                    suggestionBuilder: (data) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: k4Padding),
                        child: Container(
                          color: cWhiteColor,
                          child: Row(
                            children: [
                              // ClipOval(
                              //   child: Container(
                              //     width: 30,
                              //     height: 30,
                              //     decoration: const BoxDecoration(
                              //       shape: BoxShape.circle,
                              //     ),
                              //     child: Image.network(data["photo"]),
                              //   ),
                              // ),
                              kW12sizedBox,
                              Text(
                                data["display"],
                                style: semiBold14TextStyle(cBlackColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
            CustomModifiedTextField(
              controller: postReactionController.commentTextEditingController,
              focusNode: postReactionController.commentFocusNode,
              hint: hintText ?? ksWriteAReply.tr,
              inputType: TextInputType.multiline,
              minLines: 1,
              maxLines: 2,
              onChanged: (value) {
                postReactionController.commentSendEnabled();
              },
              inputAction: TextInputAction.newline,
              contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
              borderRadius: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                kW4sizedBox,
                Obx(() => InkWell(
                      onTap: onPressedCamera,
                      child: postReactionController.commentImage.value != ""
                          ? Stack(
                              children: [
                                Image.network(
                                  postReactionController.commentImage.value,
                                  width: h40,
                                  height: h40,
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 14,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: CustomIconButton(
                                      onPress: () {
                                        postReactionController.commentImage.value = "";
                                        postReactionController.commentSendEnabled();
                                      },
                                      icon: BipHip.circleCrossNew,
                                      size: kIconSize12,
                                      iconColor: cIconColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : postReactionController.isCommentImageChanged.value != false
                              ? Stack(
                                  children: [
                                    Image.file(
                                      postReactionController.commentImageFile.value,
                                      width: h40,
                                      height: h40,
                                    ),
                                    Positioned(
                                      left: 10,
                                      bottom: 14,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: CustomIconButton(
                                          onPress: () {
                                            postReactionController.isCommentImageChanged.value = false;
                                            postReactionController.commentImageLink.value = "";
                                            postReactionController.commentImageFile.value = File("");
                                            postReactionController.commentSendEnabled();
                                          },
                                          icon: BipHip.circleCrossNew,
                                          size: kIconSize12,
                                          iconColor: cRedColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const Icon(
                                  BipHip.cameraOutline,
                                  color: cIconColor,
                                ),
                    )),
                kW16sizedBox,
                // InkWell(
                //   onTap: onPressEmoji,
                //   child: const Icon(
                //     BipHip.emojiOutline,
                //     color: cIconColor,
                //   ),
                // ),
                const Spacer(),
                Obx(() => InkWell(
                      onTap: onPressedSend,
                      child: Icon(
                        Icons.send,
                        color: postReactionController.isCommentSendEnable.value ? cPrimaryColor : cIconColor,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
