import 'package:bip_hip/utils/constants/imports.dart';

class LikeSectionWidget extends StatelessWidget {
  const LikeSectionWidget(
      {super.key,
      this.likeOnLongPressed,
      this.commentOnPressed,
      this.shareOnPressed,
      this.giftOnPressed,
      this.likeOnTap,
      required this.isGiftShown,
      this.sectionColor});

  final VoidCallback? likeOnTap, likeOnLongPressed, commentOnPressed, shareOnPressed, giftOnPressed;
  final Color? sectionColor;
  final bool isGiftShown;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: likeOnTap,
          onLongPress: likeOnLongPressed,
          child: SizedBox(
            width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ksLove.tr,
                  style: semiBold12TextStyle(sectionColor ?? cIconColor),
                ),
                kW4sizedBox,
                Icon(
                  BipHip.love,
                  color: sectionColor ?? cIconColor,
                  size: kIconSize20,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: commentOnPressed,
          child: SizedBox(
            width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ksComment.tr,
                  style: semiBold12TextStyle(sectionColor ?? cIconColor),
                ),
                kW4sizedBox,
                Icon(
                  BipHip.commentOutline,
                  color: sectionColor ?? cIconColor,
                  size: kIconSize20,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: shareOnPressed,
          child: SizedBox(
            width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ksShare.tr,
                  style: semiBold12TextStyle(sectionColor ?? cIconColor),
                ),
                kW4sizedBox,
                Icon(
                  BipHip.shareOutline,
                  color: sectionColor ?? cIconColor,
                  size: kIconSize20,
                ),
              ],
            ),
          ),
        ),
        if (isGiftShown)
          InkWell(
            onTap: giftOnPressed,
            child: SizedBox(
              width: (width - 40) / 4,
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ksGift.tr,
                    style: semiBold12TextStyle(cIconColor),
                  ),
                  kW4sizedBox,
                  const Icon(
                    BipHip.gift,
                    color: cIconColor,
                    size: kIconSize20,
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
