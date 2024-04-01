import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

class LikeSectionWidget extends StatelessWidget {
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  LikeSectionWidget(
      {super.key,
      this.likeOnLongPressed,
      this.commentOnPressed,
      this.shareOnPressed,
      this.giftOnPressed,
      this.likeOnTap,
      required this.isGiftShown,
      this.sectionColor,
      this.postIndex = 0,
      this.refType = 0,
      this.refId = 0});

  final VoidCallback? likeOnTap, likeOnLongPressed, commentOnPressed, shareOnPressed, giftOnPressed;
  final Color? sectionColor;
  final bool isGiftShown;
  final int postIndex;
  final int refType;
  final int refId;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
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
                            onReactionChanged: (Reaction<String>? reaction) async {
                              postReactionController.postIndex.value = postIndex + 1;
                              Get.back();
                              if (postReactionController.reactions[postIndex]['reaction'].value == "Love") {
                                await postReactionController.postReaction(refType, refId);
                                postReactionController.reactions[postIndex]['reaction'].value = "";
                                postReactionController.reactions[postIndex]['state'].value = false;
                                postReactionController.selectedReactionText.value = "";
                              } else {
                                postReactionController.reactions[postIndex]['reaction'].value = 'Love';
                                postReactionController.reactions[postIndex]['state'].value = true;
                                postReactionController.selectedReactionText.value = "Love";
                                await postReactionController.postReaction(refType, refId);
                              }
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
                            onReactionChanged: (Reaction<String>? reaction) async {
                              postReactionController.postIndex.value = postIndex + 1;
                              Get.back();
                              if (postReactionController.reactions[postIndex]['reaction'].value == "Like") {
                                await postReactionController.postReaction(refType, refId);
                                postReactionController.reactions[postIndex]['reaction'].value = "";
                                Get.find<PostReactionController>().reactions[postIndex]['state'].value = false;
                                postReactionController.selectedReactionText.value = "";
                              } else {
                                Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Like';
                                Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                                postReactionController.selectedReactionText.value = "Like";
                                await postReactionController.postReaction(refType, refId);
                              }
                              // Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Like';
                              // Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                              // postReactionController.postIndex.value = postIndex + 1;
                              // postReactionController.selectedReactionText.value = "Like";
                              // Get.back();
                              // await Get.find<PostReactionController>().postReaction(1);
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
                            onReactionChanged: (Reaction<String>? reaction) async {
                              postReactionController.postIndex.value = postIndex + 1;
                              Get.back();
                              if (postReactionController.reactions[postIndex]['reaction'].value == "Haha") {
                                await postReactionController.postReaction(refType, refId);
                                postReactionController.reactions[postIndex]['reaction'].value = "";
                                Get.find<PostReactionController>().reactions[postIndex]['state'].value = false;
                                postReactionController.selectedReactionText.value = "";
                              } else {
                                Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Haha';
                                Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                                postReactionController.selectedReactionText.value = "Haha";
                                await postReactionController.postReaction(refType, refId);
                              }
                              // Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Haha';
                              // Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                              // postReactionController.postIndex.value = postIndex + 1;
                              // postReactionController.selectedReactionText.value = "Haha";
                              // Get.back();
                              // await Get.find<PostReactionController>().postReaction(1);
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
                            onReactionChanged: (Reaction<String>? reaction) async {
                              postReactionController.postIndex.value = postIndex + 1;
                              Get.back();
                              if (postReactionController.reactions[postIndex]['reaction'].value == "Wow") {
                                await postReactionController.postReaction(refType, refId);
                                postReactionController.reactions[postIndex]['reaction'].value = "";
                                Get.find<PostReactionController>().reactions[postIndex]['state'].value = false;
                                postReactionController.selectedReactionText.value = "";
                              } else {
                                Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Wow';
                                Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                                postReactionController.selectedReactionText.value = "Wow";
                                await postReactionController.postReaction(refType, refId);
                              }
                              // Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Wow';
                              // Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                              // postReactionController.postIndex.value = postIndex + 1;
                              // postReactionController.selectedReactionText.value = "Wow";
                              // Get.back();
                              // await Get.find<PostReactionController>().postReaction(1);
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
                            onReactionChanged: (Reaction<String>? reaction) async {
                              postReactionController.postIndex.value = postIndex + 1;
                              Get.back();
                              if (postReactionController.reactions[postIndex]['reaction'].value == "Sad") {
                                await postReactionController.postReaction(refType, refId);

                                postReactionController.reactions[postIndex]['reaction'].value = "";
                                postReactionController.reactions[postIndex]['state'].value = false;
                                postReactionController.selectedReactionText.value = "";
                              } else {
                                postReactionController.reactions[postIndex]['reaction'].value = 'Sad';
                                postReactionController.reactions[postIndex]['state'].value = true;
                                postReactionController.selectedReactionText.value = "Sad";
                                await postReactionController.postReaction(refType, refId);
                              }
                              // Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Sad';
                              // Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                              // postReactionController.postIndex.value = postIndex + 1;
                              // postReactionController.selectedReactionText.value = "Sad";
                              // Get.back();
                              // await Get.find<PostReactionController>().postReaction(1);
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
                              Get.find<PostReactionController>().reactions[postIndex]['reaction'].value = 'Angry';
                              Get.find<PostReactionController>().reactions[postIndex]['state'].value = true;
                              Get.back();
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
              child: SizedBox(
                width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Get.find<HomeController>().allPostList[postIndex].myReaction == null && postReactionController.selectedReactionText.value == ""
                          ? ksLove.tr
                          : postReactionController.selectedReactionText.value != ""
                              ? postReactionController.selectedReactionText.value
                              : Get.find<HomeController>().allPostList[postIndex].myReaction!,
                      style: semiBold12TextStyle(sectionColor ?? cIconColor),
                    ),
                    // Text(
                    //   Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == ''
                    //       ? ksLove.tr
                    //       : Get.find<PostReactionController>().reactions[postIndex]['reaction'].value,
                    //   style: semiBold12TextStyle(sectionColor ?? cIconColor),
                    // ),
                    kW4sizedBox,
                    // Get.find<HomeController>().allPostList[postIndex].myReaction == null
                    //     ? const Icon(
                    //         BipHip.love,
                    //         color: cIconColor,
                    //         size: kIconSize20,
                    //       )
                    //     : postReactionController.selectedReaction(postIndex),
                    Get.find<HomeController>().allPostList[postIndex].myReaction != null || postReactionController.selectedReactionText.value != ""
                        ? postReactionController.selectedReaction(postIndex)
                        : const Icon(
                            BipHip.love,
                            color: cIconColor,
                            size: kIconSize20,
                          ),
                  ],
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
      ),
    );
  }
}
