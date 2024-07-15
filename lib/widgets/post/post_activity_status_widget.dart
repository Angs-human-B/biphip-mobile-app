import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostActivityStatusWidget extends StatelessWidget {
  PostActivityStatusWidget(
      {super.key, required this.isGiftShown, this.commentOnPressed, this.shareOnPressed, this.giftOnPressed, this.reactionOnPressed, required this.postIndex});
  final bool isGiftShown;
  final int postIndex;
  final VoidCallback? reactionOnPressed, commentOnPressed, shareOnPressed, giftOnPressed;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (globalController.commonPostList[postIndex].countReactions == null)
          const Expanded(
            child: SizedBox(),
          ),
        if (globalController.commonPostList[postIndex].countReactions != null)
          InkWell(
            onTap: reactionOnPressed,
            child: Obx(() => ReactionView(
                  isPost: true,
                  reactCount: globalController.commonPostList[postIndex].countReactions,
                )),
          ),
        CommentShareRecord(
          commentCount: globalController.commonPostList[postIndex].countComment!,
          commentOnPressed: commentOnPressed,
          isGiftShown: isGiftShown,
          giftCount: globalController.commonPostList[postIndex].countStar!,
          giftOnPressed: giftOnPressed,
          shareCount: globalController.commonPostList[postIndex].countShare!,
          shareOnPressed: shareOnPressed,
        )
      ],
    );
  }
}

class ReactionView extends StatelessWidget {
  const ReactionView({super.key, required this.isPost, this.reactCount});
  final bool isPost;
  final Rx<CountReactions?>? reactCount;

  @override
  Widget build(BuildContext context) {
    if (reactCount != null) Get.find<PostReactionController>().reactionView(reactCount?.value?.toJson());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isPost && reactCount?.value?.all != null)
          Text(
            reactCount!.value!.all!.value >= 1000 ? '${(reactCount!.value!.all!.value / 1000).toStringAsFixed(1)}k' : reactCount!.value!.all!.value.toString(),
            style: regular10TextStyle(cSmallBodyTextColor),
          ),
        kW4sizedBox,
        if (reactCount != null)
          Stack(
            children: [
              SizedBox(
                width: Get.find<PostReactionController>().reactStackWidthGetter(),
                height: 15,
              ),
              for (int index = 0; index < Get.find<PostReactionController>().reactionView(reactCount!.value!.toJson()).length; index++)
                Positioned(
                  left: index * 10,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cWhiteColor, width: 1),
                    ),
                    child: ClipOval(
                      child: SvgPicture.asset(
                        Get.find<PostReactionController>().reactionView(reactCount?.value!.toJson())[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        kW4sizedBox,
        if (isPost && reactCount != null)
          Text(
            reactCount!.value!.all!.value > 1000 ? '${(reactCount!.value!.all!.value / 1000).toStringAsFixed(1)}k' : reactCount!.value!.all!.value.toString(),
            style: regular10TextStyle(cSmallBodyTextColor),
          ),
      ],
    );
  }
}

class CommentShareRecord extends StatelessWidget {
  const CommentShareRecord(
      {super.key,
      required this.commentCount,
      required this.shareCount,
      required this.giftCount,
      required this.isGiftShown,
      this.commentOnPressed,
      this.shareOnPressed,
      this.giftOnPressed});

  final RxInt commentCount, shareCount, giftCount;
  final bool isGiftShown;
  final VoidCallback? commentOnPressed, shareOnPressed, giftOnPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (commentCount.value != 0)
          InkWell(
            onTap: commentOnPressed,
            child: Obx(() => Text(
                  commentCount.value >= 1000 ? '${(commentCount.value / 1000).toStringAsFixed(1)}k ${ksComments.tr}' : '${commentCount.value} ${ksComments.tr}',
                  style: regular10TextStyle(cSmallBodyTextColor),
                )),
          ),
        kW8sizedBox,
        if (shareCount.value != 0)
          InkWell(
            onTap: shareOnPressed,
            child: Obx(() => Text(
                  shareCount.value > 1000 ? '${(shareCount.value / 1000).toStringAsFixed(1)}k ${ksShares.tr}' : '${shareCount.value} ${ksShares.tr}',
                  style: regular10TextStyle(cSmallBodyTextColor),
                )),
          ),
        kW8sizedBox,
        if (giftCount.value != 0)
          InkWell(
            onTap: giftOnPressed,
            child: Obx(() => Text(
                  giftCount.value > 1000 ? '${(giftCount.value / 1000).toStringAsFixed(1)}k ${ksStars.tr}' : '${giftCount.value} ${ksStars.tr}',
                  style: regular10TextStyle(cSmallBodyTextColor),
                )),
          ),
      ],
    );
  }
}
