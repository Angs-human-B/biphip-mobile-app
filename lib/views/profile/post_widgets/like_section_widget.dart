import 'package:bip_hip/utils/constants/imports.dart';

class LikeSectionWidget extends StatelessWidget {
  const LikeSectionWidget(
      {super.key, this.likeOnLongPressed, this.commentOnPressed, this.shareOnPressed, this.giftOnPressed, this.likeOnTap, required this.isGiftShown});

  final VoidCallback? likeOnTap;
  final VoidCallback? likeOnLongPressed;
  final VoidCallback? commentOnPressed;
  final VoidCallback? shareOnPressed;
  final bool isGiftShown;
  final VoidCallback? giftOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: likeOnTap,
          onLongPress: likeOnLongPressed,
          child: SizedBox(
            width: 83,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ksLove.tr,
                  style: semiBold12TextStyle(cIconColor),
                ),
                kW4sizedBox,
                const Icon(
                  BipHip.love,
                  color: cIconColor,
                  size: kIconSize20,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: commentOnPressed,
          child: SizedBox(
            width: 94,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ksComment.tr,
                  style: semiBold12TextStyle(cIconColor),
                ),
                kW4sizedBox,
                const Icon(
                  BipHip.commentOutline,
                  color: cIconColor,
                  size: kIconSize20,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: shareOnPressed,
          child: SizedBox(
            width: 86,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ksShare.tr,
                  style: semiBold12TextStyle(cIconColor),
                ),
                kW4sizedBox,
                const Icon(
                  BipHip.shareOutline,
                  color: cIconColor,
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
              width: 72,
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
