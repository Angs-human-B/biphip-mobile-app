import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

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
        // InkWell(
        //   onTap: likeOnTap,
        //   onLongPress: () {
        //     ll('Hi This is on Long pressed');
        //     // ReactionButton<String>(
        //     //   itemSize: const Size.square(40),
        //     //   onReactionChanged: (Reaction<String>? reaction) {
        //     //     ll('Selected value: ${reaction?.value}');
        //     //   },
        //     //   reactions: Get.find<HomeController>().reactions,
        //     //   // placeholder: ,
        //     //   selectedReaction: Get.find<HomeController>().reactions.first,
        //     // );

        //   },
        //   child: SizedBox(
        //     width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
        //     height: 44,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           ksLove.tr,
        //           style: semiBold12TextStyle(sectionColor ?? cIconColor),
        //         ),
        //         kW4sizedBox,
        //         Icon(
        //           BipHip.love,
        //           color: sectionColor ?? cIconColor,
        //           size: kIconSize20,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        InkWell(
          onTap: () {
            if (Get.find<HomeController>().selectedReactionText.value != null && Get.find<HomeController>().selectedReactionIcon.value != null) {
              Get.find<HomeController>().selectedReactionText.value = null;
              Get.find<HomeController>().selectedReactionIcon.value = null;
            }
          },
          onLongPress: () {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(90),
            //       ),
            //       content: Container(
            //         height: 20,
            //         width: double.infinity,
            //         child: ReactionButton<String>(
            //           itemSize: const Size.square(20),
            //           onReactionChanged: (Reaction<String>? reaction) {
            //             ll('Selected value: ${reaction?.value}');
            //             Get.find<HomeController>().selectedReaction = reaction;
            //             Get.back();
            //             ll(Get.find<HomeController>().reactions.length);
            //           },
            //           reactions: Get.find<HomeController>().reactions,
            //           selectedReaction: Get.find<HomeController>().selectedReaction,
            //         ),
            //       ),
            //     );
            //   },
            // );

            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(180),
            //       ),
            //       content: Container(
            //         width: double.infinity,
            //         child: ReactionButton<String>(
            //           itemSize: const Size.square(40),
            //           onReactionChanged: (Reaction<String>? reaction) {
            //             ll('Selected value: ${reaction?.value}');
            //             Get.find<HomeController>().selectedReaction = reaction;
            //             Get.back();
            //           },
            //           reactions: Get.find<HomeController>().reactions,
            //           selectedReaction: Get.find<HomeController>().selectedReaction,
            //         ),
            //       ),
            //     );
            //   },
            // );
            //*Initial
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(180),
            //         ),
            //         content: ReactionButton<String>(
            //           boxRadius: 50,
            //           boxPadding: const EdgeInsets.all(4),
            //           itemSize: const Size.square(40),
            //           onReactionChanged: (Reaction<String>? reaction) {
            //             ll('Selected value: ${reaction?.value}');
            //           },
            //           reactions: const <Reaction<String>>[
            //             Reaction<String>(
            //               value: 'love',
            //               icon: Icon(Icons.favorite, color: Colors.pink),
            //             ),
            //             Reaction<String>(
            //               value: 'like',
            //               icon: Icon(Icons.thumb_up, color: Colors.blue),
            //             ),
            //             Reaction<String>(
            //               value: 'angry',
            //               icon: Icon(Icons.sentiment_very_dissatisfied, color: Colors.red),
            //             ),
            //             Reaction<String>(
            //               value: 'haha',
            //               icon: Icon(Icons.mood, color: Colors.yellow),
            //             ),
            //             Reaction<String>(
            //               value: 'wow',
            //               icon: Icon(Icons.sentiment_very_satisfied, color: Colors.green),
            //             ),
            //             Reaction<String>(
            //               value: 'sad',
            //               icon: Icon(Icons.sentiment_dissatisfied, color: Colors.purple),
            //             ),
            //           ],
            //           //  initialReaction: Reaction<String>(
            //           //     value: 'like',
            //           //     icon: Icon(Icons.thumb_up, color: Colors.blue),
            //           //  ),

            //           selectedReaction: Reaction<String>(
            //             value: 'sad',
            //             icon: Icon(Icons.sentiment_dissatisfied, color: Colors.blue),
            //           ),
            //         ),
            //       );
            //     });

            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       contentPadding: EdgeInsets.all(16), // Adjusted contentPadding
            //       content: Container(
            //         width: double.maxFinite, // Adjusted width
            //         child: ReactionButton<String>(
            //           boxRadius: 8,
            //           boxPadding: const EdgeInsets.all(8),
            //           itemSize: const Size.square(40),
            //           onReactionChanged: (Reaction<String>? reaction) {
            //             print('Selected value: ${reaction?.value}');
            //           },
            //           reactions: const <Reaction<String>>[
            //             Reaction<String>(
            //               value: 'love',
            //               icon: Icon(Icons.favorite, color: Colors.pink),
            //             ),
            //             Reaction<String>(
            //               value: 'like',
            //               icon: Icon(Icons.thumb_up, color: Colors.blue),
            //             ),
            //             Reaction<String>(
            //               value: 'angry',
            //               icon: Icon(Icons.sentiment_very_dissatisfied, color: Colors.red),
            //             ),
            //             Reaction<String>(
            //               value: 'haha',
            //               icon: Icon(Icons.mood, color: Colors.yellow),
            //             ),
            //             Reaction<String>(
            //               value: 'wow',
            //               icon: Icon(Icons.sentiment_very_satisfied, color: Colors.green),
            //             ),
            //             Reaction<String>(
            //               value: 'sad',
            //               icon: Icon(Icons.sentiment_dissatisfied, color: Colors.purple),
            //             ),
            //           ],
            //           selectedReaction: Reaction<String>(
            //             value: 'sad',
            //             icon: Icon(Icons.sentiment_dissatisfied, color: Colors.blue),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(180),
                  ),
                  contentPadding: const EdgeInsets.all(k8Padding),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReactionButton<String>(
                        // boxRadius: 8,
                        // boxPadding: const EdgeInsets.all(8),
                        itemSize: const Size.square(50),
                        onReactionChanged: (Reaction<String>? reaction) {
                          ll('Selected value: ${reaction?.value}');
                          Get.find<HomeController>().selectedReactionIcon.value = Icons.favorite;
                          Get.find<HomeController>().selectedReactionText.value = 'Love';
                          Get.back();
                        },
                        reactions: const <Reaction<String>>[
                          Reaction<String>(
                            value: 'love',
                            icon: Icon(Icons.favorite, color: Colors.pink),
                          ),
                        ],
                        selectedReaction: const Reaction<String>(
                          value: 'love',
                          icon: Icon(Icons.favorite, color: Colors.pink),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      ReactionButton<String>(
                        animateBox: true,
                        boxAnimationDuration: Duration(milliseconds: 500),
                        itemAnimationDuration: Duration(milliseconds: 500),
                        // boxRadius: 8,
                        // boxPadding: const EdgeInsets.all(8),
                        itemSize: const Size.square(50),
                        onReactionChanged: (Reaction<String>? reaction) {
                          Get.find<HomeController>().selectedReactionIcon.value = Icons.thumb_up;
                          Get.find<HomeController>().selectedReactionText.value = 'Like';
                          Get.back();
                        },
                        reactions: const <Reaction<String>>[
                          Reaction<String>(
                            value: 'like',
                            icon: Icon(Icons.thumb_up, color: Colors.blue),
                          ),
                        ],
                        selectedReaction: const Reaction<String>(
                          value: 'like',
                          icon: Icon(Icons.thumb_up, color: Colors.blue),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      ReactionButton<String>(
                        // boxRadius: 8,
                        // boxPadding: const EdgeInsets.all(k4Padding),
                        itemSize: const Size.square(50),
                        onReactionChanged: (Reaction<String>? reaction) {
                          ll('Selected value: ${reaction?.value}');
                          Get.find<HomeController>().selectedReactionIcon.value = Icons.mood;
                          Get.find<HomeController>().selectedReactionText.value = 'Haha';
                          Get.back();
                        },
                        reactions: const <Reaction<String>>[
                          Reaction<String>(
                            value: 'haha',
                            icon: Icon(Icons.mood, color: cAmberColor),
                          ),
                        ],
                        selectedReaction: const Reaction<String>(
                          value: 'haha',
                          icon: Icon(Icons.mood, color: cAmberColor),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      ReactionButton<String>(
                        // boxRadius: 8,
                        // boxPadding: const EdgeInsets.all(k4Padding),
                        itemSize: const Size.square(50),
                        onReactionChanged: (Reaction<String>? reaction) {
                          ll('Selected value: ${reaction?.value}');
                          Get.find<HomeController>().selectedReactionIcon.value = Icons.sentiment_very_satisfied;
                          Get.find<HomeController>().selectedReactionText.value = 'Wow';
                          Get.back();
                        },
                        reactions: const <Reaction<String>>[
                          Reaction<String>(
                            value: 'wow',
                            icon: Icon(Icons.sentiment_very_satisfied, color: cAmberColor),
                          ),
                        ],
                        selectedReaction: const Reaction<String>(
                          value: 'wow',
                          icon: Icon(Icons.sentiment_very_satisfied, color: cAmberColor),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      ReactionButton<String>(
                        // boxRadius: 8,
                        // boxPadding: const EdgeInsets.all(k4Padding),
                        itemSize: const Size.square(50),
                        onReactionChanged: (Reaction<String>? reaction) {
                          ll('Selected value: ${reaction?.value}');
                          Get.find<HomeController>().selectedReactionIcon.value = Icons.sentiment_dissatisfied;
                          Get.find<HomeController>().selectedReactionText.value = 'Sad';
                          Get.back();
                        },
                        reactions: const <Reaction<String>>[
                          Reaction<String>(
                            value: 'sad',
                            icon: Icon(Icons.sentiment_dissatisfied, color: cAmberColor),
                          ),
                        ],
                        selectedReaction: const Reaction<String>(
                          value: 'sad',
                          icon: Icon(Icons.sentiment_dissatisfied, color: cAmberColor),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      ReactionButton<String>(
                        // boxRadius: 8,
                        // boxPadding: const EdgeInsets.all(k4Padding),
                        itemSize: const Size.square(50),
                        onReactionChanged: (Reaction<String>? reaction) {
                          ll('Selected value: ${reaction?.value}');
                          Get.find<HomeController>().selectedReactionIcon.value = Icons.sentiment_very_dissatisfied;
                          Get.find<HomeController>().selectedReactionText.value = 'Angry';
                          Get.back();
                        },
                        reactions: const <Reaction<String>>[
                          Reaction<String>(
                            value: 'angry',
                            icon: Icon(Icons.sentiment_very_dissatisfied, color: cAmberColor),
                          ),
                        ],
                        selectedReaction: const Reaction<String>(
                          value: 'angry',
                          icon: Icon(Icons.sentiment_very_dissatisfied, color: cAmberColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: SizedBox(
            width: isGiftShown ? (width - 40) / 4 : (width - 40) / 3,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                      Get.find<HomeController>().selectedReactionText.value ?? ksLove.tr,
                      style: semiBold12TextStyle(sectionColor ?? cIconColor),
                    )),
                kW4sizedBox,
                Obx(() => Icon(
                      Get.find<HomeController>().selectedReactionIcon.value ?? BipHip.love,
                      color: sectionColor ?? cIconColor,
                      size: kIconSize20,
                    )),
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
