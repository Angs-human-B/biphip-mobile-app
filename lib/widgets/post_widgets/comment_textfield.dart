import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CommentTextField extends StatelessWidget {
  CommentTextField({super.key, this.onPressEmoji, this.onPressedCamera, this.onPressedSend, this.hintText});

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
              controller: postReactionController.commentTextEditingController,
              hint: hintText ?? ksWriteAReply.tr,
              inputType: TextInputType.multiline,
              minLines: 1,
              maxLines: 4,
              inputAction: TextInputAction.newline,
              contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
              borderRadius: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                kW4sizedBox,
                InkWell(
                  onTap: onPressedCamera,
                  child: const Icon(
                    BipHip.cameraOutline,
                    color: cIconColor,
                  ),
                ),
                kW16sizedBox,
                InkWell(
                  onTap: onPressEmoji,
                  child: const Icon(
                    BipHip.emojiOutline,
                    color: cIconColor,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onPressedSend,
                  child: const Icon(
                    Icons.send,
                    color: cIconColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
