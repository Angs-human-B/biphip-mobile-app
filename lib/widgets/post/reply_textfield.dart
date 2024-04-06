import 'dart:io';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

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
            CustomModifiedTextField(
              controller: postReactionController.replyTextEditingController,
              hint: hintText ?? ksWriteAReply.tr,
              inputType: TextInputType.multiline,
              minLines: 1,
              maxLines: 4,
              onChanged: (value) {
                postReactionController.replySendEnabled();
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
                                          size: kIconSize12,
                                          iconColor: cIconColor,
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
                InkWell(
                  onTap: onPressEmoji,
                  child: const Icon(
                    BipHip.emojiOutline,
                    color: cIconColor,
                  ),
                ),
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
