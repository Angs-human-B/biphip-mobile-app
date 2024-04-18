import 'dart:io';

// import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

class CommentTextField extends StatelessWidget {
  CommentTextField({super.key, this.onPressEmoji, this.onPressedCamera, this.onPressedSend, this.hintText});

  final VoidCallback? onPressEmoji, onPressedCamera, onPressedSend;
  final String? hintText;

  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(color: cGreyBoxColor, borderRadius: k8CircularBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(k8Padding),
          child: Column(
            children: [
              FlutterMentions(
                onMentionAdd: (p0) {
                  // ll(p0["id"]);
                  postReactionController.commentMentionList.add(p0["id"]);
                },
                onChanged: (value) {
                  postReactionController.commentTextEditingController.text = postReactionController.commentMentionKey.currentState!.controller!.markupText;
                  ll(postReactionController.commentTextEditingController.text);
                  postReactionController.commentSendEnabled();
                },
                key: postReactionController.commentMentionKey,
                //  controller: postReactionController.commentTextEditingController,
                focusNode: postReactionController.commentFocusNode,
                // autofocus: true,
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
                  hintText: ksWriteAComment.tr,
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
              //   controller: postReactionController.commentTextEditingController,
              //   focusNode: postReactionController.commentFocusNode,
              //   hint: hintText ?? ksWriteAReply.tr,
              //   inputType: TextInputType.multiline,
              //   minLines: 1,
              //   maxLines: 2,
              //   onChanged: (value) {
              //     postReactionController.commentSendEnabled();
              //   },
              //   inputAction: TextInputAction.newline,
              //   contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
              //   borderRadius: 8,
              // ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  kW4sizedBox,
                  InkWell(
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
                  ),
                  kW16sizedBox,
                  const Spacer(),
                  InkWell(
                    onTap: onPressedSend,
                    child: Icon(
                      Icons.send,
                      color: postReactionController.isCommentSendEnable.value ? cPrimaryColor : cIconColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
