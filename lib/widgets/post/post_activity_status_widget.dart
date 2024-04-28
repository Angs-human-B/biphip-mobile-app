import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostActivityStatusWidget extends StatelessWidget {
  const PostActivityStatusWidget(
      {super.key,
      this.reactCount,
      required this.commentCount,
      required this.giftCount,
      required this.shareCount,
      required this.isGiftShown,
      this.commentOnPressed,
      this.shareOnPressed,
      this.giftOnPressed,
      this.reactionOnPressed});
  final int commentCount, giftCount, shareCount;
  final CountReactions? reactCount;
  final bool isGiftShown;
  final VoidCallback? reactionOnPressed, commentOnPressed, shareOnPressed, giftOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (reactCount == null)
          const Expanded(
            child: SizedBox(),
          ),
        if (reactCount != null)
          InkWell(
            onTap: reactionOnPressed,
            child: ReactionView(
              isPost: true,
              reactCount: reactCount,
            ),
          ),
        CommentShareRecord(
          commentCount: commentCount,
          commentOnPressed: commentOnPressed,
          isGiftShown: isGiftShown,
          giftCount: giftCount,
          giftOnPressed: giftOnPressed,
          shareCount: shareCount,
          shareOnPressed: shareOnPressed,
        )
      ],
    );
  }
}

class ReactionView extends StatelessWidget {
  const ReactionView({super.key, required this.isPost, this.reactCount});
  final bool isPost;
  final CountReactions? reactCount;

  @override
  Widget build(BuildContext context) {
    if (reactCount != null) Get.find<PostReactionController>().reactionView(reactCount?.toJson());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isPost && reactCount?.all != null)
          Text(
            reactCount!.all! >= 1000 ? '${(reactCount!.all! / 1000).toStringAsFixed(1)}k' : reactCount!.all.toString(),
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
              for (int index = 0; index < Get.find<PostReactionController>().reactionView(reactCount?.toJson()).length; index++)
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
                        Get.find<PostReactionController>().reactionView(reactCount?.toJson())[index],
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
            reactCount!.all! > 1000 ? '${(reactCount!.all! / 1000).toStringAsFixed(1)}k' : reactCount!.all.toString(),
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

  final int commentCount, shareCount, giftCount;
  final bool isGiftShown;
  final VoidCallback? commentOnPressed, shareOnPressed, giftOnPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (commentCount != 0)
          InkWell(
            onTap: commentOnPressed,
            child: Text(
              commentCount >= 1000 ? '${(commentCount / 1000).toStringAsFixed(1)}k ${ksComments.tr}' : '$commentCount ${ksComments.tr}',
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
          ),
        kW8sizedBox,
        if (shareCount != 0)
          InkWell(
            onTap: shareOnPressed,
            child: Text(
              shareCount > 1000 ? '${(shareCount / 1000).toStringAsFixed(1)}k ${ksShare.tr}' : '$shareCount $ksShares',
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
          ),
        kW8sizedBox,
        if (giftCount != 0)
          InkWell(
            onTap: giftOnPressed,
            child: Text(
              giftCount > 1000 ? '${(giftCount / 1000).toStringAsFixed(1)}k ${ksStars.tr}' : '$giftCount ${ksStars.tr}',
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
          ),
      ],
    );
  }
}
