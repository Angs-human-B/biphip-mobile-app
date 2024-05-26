import 'dart:developer';

import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class LikeSectionWidget extends StatelessWidget {
  LikeSectionWidget({
    super.key,
    this.commentOnPressed,
    this.shareOnPressed,
    this.giftOnPressed,
    required this.isGiftShown,
    this.sectionColor,
    required this.postIndex,
  });

  final VoidCallback? commentOnPressed, shareOnPressed, giftOnPressed;
  final Color? sectionColor;
  final bool isGiftShown;
  final int postIndex;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: PopupMenuButton(
            padding: EdgeInsets.zero,
            offset: const Offset(0, -60),
            elevation: 1,
            onCanceled: () {},
            position: PopupMenuPosition.over,
            tooltip: '',
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                height: 25,
                onTap: null,
                value: 1,
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(48),
                          onReactionChanged: (Reaction<String>? reaction) {
                            globalController.commonPostList[postIndex].countReactions = globalController.updateReaction(
                                "love", globalController.commonPostList[postIndex].myReaction, globalController.commonPostList[postIndex].countReactions);
                            globalController.commonPostList[postIndex].myReaction = globalController.getReaction(
                                globalController.commonPostList[postIndex].myReaction, "love", 1, globalController.commonPostList[postIndex].id!);
                            log(globalController.commonPostList[postIndex].myReaction.toString());
                            globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'love',
                              icon: SvgPicture.asset(
                                kiLoveSvgImageUrl,
                                width: 38,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'love',
                            icon: SvgPicture.asset(
                              kiLoveSvgImageUrl,
                              width: 38,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          animateBox: true,
                          boxAnimationDuration: const Duration(milliseconds: 500),
                          itemAnimationDuration: const Duration(milliseconds: 500),
                          itemSize: const Size.square(48),
                          onReactionChanged: (Reaction<String>? reaction) {
                            globalController.commonPostList[postIndex].countReactions = globalController.updateReaction(
                                "like", globalController.commonPostList[postIndex].myReaction, globalController.commonPostList[postIndex].countReactions);
                            globalController.commonPostList[postIndex].myReaction = globalController.getReaction(
                                globalController.commonPostList[postIndex].myReaction, "like", 1, globalController.commonPostList[postIndex].id!);
                            globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'like',
                              icon: SvgPicture.asset(
                                kiLikeSvgImageUrl,
                                width: 38,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'like',
                            icon: SvgPicture.asset(
                              kiLikeSvgImageUrl,
                              width: 38,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(48),
                          onReactionChanged: (Reaction<String>? reaction) {
                            globalController.commonPostList[postIndex].countReactions = globalController.updateReaction(
                                "haha", globalController.commonPostList[postIndex].myReaction, globalController.commonPostList[postIndex].countReactions);
                            globalController.commonPostList[postIndex].myReaction = globalController.getReaction(
                                globalController.commonPostList[postIndex].myReaction, "haha", 1, globalController.commonPostList[postIndex].id!);
                            globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'haha',
                              icon: SvgPicture.asset(
                                kiHahaSvgImageUrl,
                                width: 38,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'haha',
                            icon: SvgPicture.asset(
                              kiHahaSvgImageUrl,
                              width: 38,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(48),
                          onReactionChanged: (Reaction<String>? reaction) {
                            globalController.commonPostList[postIndex].countReactions = globalController.updateReaction(
                                "wow", globalController.commonPostList[postIndex].myReaction, globalController.commonPostList[postIndex].countReactions);
                            globalController.commonPostList[postIndex].myReaction = globalController.getReaction(
                                globalController.commonPostList[postIndex].myReaction, "wow", 1, globalController.commonPostList[postIndex].id!);
                            globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'wow',
                              icon: SvgPicture.asset(
                                kiWowSvgImageUrl,
                                width: 38,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'wow',
                            icon: SvgPicture.asset(
                              kiWowSvgImageUrl,
                              width: 38,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(48),
                          onReactionChanged: (Reaction<String>? reaction) {
                            globalController.commonPostList[postIndex].countReactions = globalController.updateReaction(
                                "sad", globalController.commonPostList[postIndex].myReaction, globalController.commonPostList[postIndex].countReactions);
                            globalController.commonPostList[postIndex].myReaction = globalController.getReaction(
                                globalController.commonPostList[postIndex].myReaction, "sad", 1, globalController.commonPostList[postIndex].id!);
                            globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'sad',
                              icon: SvgPicture.asset(
                                kiSadSvgImageUrl,
                                width: 38,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'sad',
                            icon: SvgPicture.asset(
                              kiSadSvgImageUrl,
                              width: 38,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        child: ReactionButton<String>(
                          itemSize: const Size.square(48),
                          onReactionChanged: (Reaction<String>? reaction) {
                            globalController.commonPostList[postIndex].countReactions = globalController.updateReaction(
                                "angry", globalController.commonPostList[postIndex].myReaction, globalController.commonPostList[postIndex].countReactions);
                            globalController.commonPostList[postIndex].myReaction = globalController.getReaction(
                                globalController.commonPostList[postIndex].myReaction, "angry", 1, globalController.commonPostList[postIndex].id!);
                            globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                          },
                          reactions: <Reaction<String>>[
                            Reaction<String>(
                              value: 'angry',
                              icon: SvgPicture.asset(
                                kiAngrySvgImageUrl,
                                width: 38,
                              ),
                            ),
                          ],
                          selectedReaction: Reaction<String>(
                            value: 'angry',
                            icon: SvgPicture.asset(
                              kiAngrySvgImageUrl,
                              width: 38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(180),
            ),
            child: Obx(
              () => SizedBox(
                width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
                height: 44,
                child: globalController.getColoredReactionIcon(globalController.commonPostList[postIndex].myReaction),
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
