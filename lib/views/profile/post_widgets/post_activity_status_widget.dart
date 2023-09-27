import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostActivityStatusWidget extends StatelessWidget {
  const PostActivityStatusWidget(
      {super.key,
      required this.reactCount,
      required this.commentCount,
      required this.giftCount,
      required this.shareCount,
      required this.isGiftShown,
      this.commentOnPressed,
      this.shareOnPressed,
      this.giftOnPressed, this.reactionOnPressed});
  final int reactCount, commentCount, giftCount, shareCount;
  final bool isGiftShown;
  final VoidCallback? reactionOnPressed,commentOnPressed, shareOnPressed, giftOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
  const ReactionView({super.key, required this.isPost, required this.reactCount});
  final bool isPost;
  final int reactCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isPost)
          Text(
            reactCount >= 1000 ? '${(reactCount / 1000).toStringAsFixed(1)}k' : reactCount.toString(),
            style: regular10TextStyle(cSmallBodyTextColor),
          ),
        kW4sizedBox,
        Stack(
          children: [
            const SizedBox(
              width: 35,
              height: 15,
            ),
            for (int index = 0; index < 3; index++)
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
                      'assets/svg/wow.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
        kW4sizedBox,
        if (isPost)
          Text(
            reactCount > 1000 ? '${(reactCount / 1000).toStringAsFixed(1)}k' : reactCount.toString(),
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
        InkWell(
          onTap: commentOnPressed,
          child: Text(
            commentCount >= 1000 ? '${(commentCount / 1000).toStringAsFixed(1)}k comments' : '$commentCount comments',
            style: regular10TextStyle(cSmallBodyTextColor),
          ),
        ),
        kW8sizedBox,
        InkWell(
          onTap: shareOnPressed,
          child: Text(
            shareCount > 1000 ? '${(shareCount / 1000).toStringAsFixed(1)}k shares' : '$shareCount shares',
            style: regular10TextStyle(cSmallBodyTextColor),
          ),
        ),
        kW8sizedBox,
        InkWell(
          onTap: giftOnPressed,
          child: Text(
            giftCount > 1000 ? '${(giftCount / 1000).toStringAsFixed(1)}k gifts' : '$giftCount gifts',
            style: regular10TextStyle(cSmallBodyTextColor),
          ),
        ),
      ],
    );
  }
}
