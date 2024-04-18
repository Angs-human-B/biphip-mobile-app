import 'dart:io';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

class ReplyTextField extends StatelessWidget {
  ReplyTextField({super.key, this.onPressEmoji, this.onPressedCamera, this.onPressedSend, this.hintText});

  final VoidCallback? onPressEmoji, onPressedCamera, onPressedSend;
  final String? hintText;

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
              // onMarkupChanged: (value) {
              //   ll(value);
              // },

              onMentionAdd: (p0) {
                // ll(p0["id"]);
                postReactionController.replyMentionList.add(p0["id"]);
              },
              onChanged: (value) {
                postReactionController.replyTextEditingController.text = postReactionController.replyMentionKey.currentState!.controller!.markupText;
                ll(postReactionController.replyTextEditingController.text);
                postReactionController.replySendEnabled();
              },
              key: postReactionController.replyMentionKey,
              focusNode: postReactionController.replyFocusNode,
              maxLines: 2,
              decoration: InputDecoration(
                errorStyle: regular12TextStyle(cRedColor),
                // isDense: true,
                // filled: true,
                prefixIconConstraints: const BoxConstraints(),
                suffixIconConstraints: const BoxConstraints(),

                fillColor: cGreyBoxColor,
                alignLabelWithHint: true,
                // labelText: ,
                hintText: ksWriteAReply.tr,
                // labelStyle: hintStyle,
                // hintStyle: textHintStyle ?? hintStyle,
                // counter: (counter == null) ? const SizedBox.shrink() : counter,
                contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k16Padding),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cRedColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cRedColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
              ),
              mentions: [
                Mention(
                  disableMarkup: false,
                  trigger: "@",
                  data: Get.find<FriendController>().mentionsList,
                  markupBuilder: (trigger, mention, value) {
                    return '@[$value]($mention)';
                  },
                  style: semiBold14TextStyle(cPrimaryColor),
                  suggestionBuilder: (data) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: k4Padding, horizontal: kHorizontalPadding),
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
                              data["full_name"],
                              style: semiBold14TextStyle(cBlackColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            // CustomModifiedTextField(
            //   controller: postReactionController.replyTextEditingController,
            //   focusNode: postReactionController.replyFocusNode,
            //   autoFocus: true,
            //   hint: hintText ?? ksWriteAReply.tr,
            //   inputType: TextInputType.multiline,
            //   minLines: 1,
            //   maxLines: 2,
            //   onChanged: (value) {
            //     postReactionController.replySendEnabled();
            //   },
            //   inputAction: TextInputAction.newline,
            //   contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
            //   borderRadius: 8,
            // ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                kW4sizedBox,
                Obx(() => InkWell(
                      onTap: onPressedCamera,
                      child: postReactionController.replyImage.value != ""
                          ? Stack(
                              children: [
                                Image.network(
                                  postReactionController.replyImage.value,
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
                                        postReactionController.replyImage.value = "";
                                        postReactionController.isReplyImageChanged.value = false;
                                        postReactionController.replyImageLink.value = "";
                                        postReactionController.replyImageFile.value = File("");
                                        ll(postReactionController.isReplyImageChanged.value);
                                        postReactionController.replySendEnabled();
                                      },
                                      icon: BipHip.circleCrossNew,
                                      size: kIconSize12,
                                      iconColor: cIconColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : postReactionController.isReplyImageChanged.value != false
                              ? Stack(
                                  children: [
                                    Image.file(
                                      postReactionController.replyImageFile.value,
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
                                            postReactionController.isReplyImageChanged.value = false;
                                            postReactionController.replyImageLink.value = "";
                                            postReactionController.replyImageFile.value = File("");
                                            postReactionController.replySendEnabled();
                                          },
                                          icon: BipHip.circleCrossNew,
                                          size: kIconSize14,
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
                        color: postReactionController.isReplySendEnable.value ? cPrimaryColor : cIconColor,
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
