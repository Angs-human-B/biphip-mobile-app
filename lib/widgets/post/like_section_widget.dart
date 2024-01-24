import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class LikeSectionWidget extends StatelessWidget {
  const LikeSectionWidget(
      {super.key,
      this.likeOnLongPressed,
      this.commentOnPressed,
      this.shareOnPressed,
      this.giftOnPressed,
      this.likeOnTap,
      required this.isGiftShown,
      this.sectionColor,
      this.postIndex = 0});

  final VoidCallback? likeOnTap, likeOnLongPressed, commentOnPressed, shareOnPressed, giftOnPressed;
  final Color? sectionColor;
  final bool isGiftShown;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            ll(scrollNotification);
            return true;
          },
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: PopupMenuButton(
              padding: EdgeInsets.zero,
              offset: const Offset(0, -60),
              onCanceled: () {},
              position: PopupMenuPosition.over,
              tooltip: '',
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  onTap: null,
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(50),
                          onReactionChanged: (Reaction<String>? reaction) {
                            Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Love';
                            Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                            Get.back();
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'love',
                              icon: SvgPicture.asset(
                                kiLoveSvgImageUrl,
                                width: 20,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'love',
                            icon: SvgPicture.asset(
                              kiLoveSvgImageUrl,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          animateBox: true,
                          boxAnimationDuration: const Duration(milliseconds: 500),
                          itemAnimationDuration: const Duration(milliseconds: 500),
                          itemSize: const Size.square(50),
                          onReactionChanged: (Reaction<String>? reaction) {
                            Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Like';
                            Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                            Get.back();
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'like',
                              icon: SvgPicture.asset(
                                kiLikeSvgImageUrl,
                                width: 20,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'like',
                            icon: SvgPicture.asset(
                              kiLikeSvgImageUrl,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(50),
                          onReactionChanged: (Reaction<String>? reaction) {
                            Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Haha';
                            Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                            Get.back();
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'haha',
                              icon: SvgPicture.asset(
                                kiHahaSvgImageUrl,
                                width: 20,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'haha',
                            icon: SvgPicture.asset(
                              kiHahaSvgImageUrl,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(50),
                          onReactionChanged: (Reaction<String>? reaction) {
                            Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Wow';
                            Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                            Get.back();
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'wow',
                              icon: SvgPicture.asset(
                                kiWowSvgImageUrl,
                                width: 20,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'wow',
                            icon: SvgPicture.asset(
                              kiWowSvgImageUrl,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(50),
                          onReactionChanged: (Reaction<String>? reaction) {
                            Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Sad';
                            Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                            Get.back();
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'sad',
                              icon: SvgPicture.asset(
                                kiSadSvgImageUrl,
                                width: 20,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'sad',
                            icon: SvgPicture.asset(
                              kiSadSvgImageUrl,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(50),
                          onReactionChanged: (Reaction<String>? reaction) {
                            Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Angry';
                            Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                            Get.back();
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'angry',
                              icon: SvgPicture.asset(
                                kiAngrySvgImageUrl,
                                width: 20,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'angry',
                            icon: SvgPicture.asset(
                              kiAngrySvgImageUrl,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180),
              ),
              child: SizedBox(
                width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
                height: 44,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == ''
                              ? ksLove.tr
                              : Get.find<PostReactionController>().reactions[postIndex]['reaction'].value,
                          style: semiBold12TextStyle(sectionColor ?? cIconColor),
                        ),
                        kW4sizedBox,
                        Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == ''
                            ? const Icon(
                                BipHip.love,
                                color: cIconColor,
                                size: kIconSize20,
                              )
                            : Get.find<PostReactionController>().selectedReaction(postIndex),
                      ],
                    )),
              ),
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
