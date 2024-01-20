import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/comment_widget.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';

class PostBottomSection extends StatelessWidget {
  PostBottomSection({super.key, required this.isCommentShown});

  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final bool isCommentShown;
  final RxBool showComment = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            // kH12sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: PostActivityStatusWidget(
                // reactCount: 440,
                reactionOnPressed: () {
                  postReactionController.giftFilter(0);
                  globalController.blankBottomSheet(
                      context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                },
                giftCount: 50,
                commentCount: 200,
                shareCount: 340,
                isGiftShown: true,
                giftOnPressed: () {
                  postReactionController.giftFilter(0);
                  globalController.blankBottomSheet(
                      context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
              ),
              child: LikeSectionWidget(
                isGiftShown: true,
                giftOnPressed: () {
                  globalController.blankBottomSheet(context: context, content: GiftContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                },
                commentOnPressed: () {
                  showComment.value = !showComment.value;
                  ll(showComment);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: CustomDivider(),
            ),
            kH12sizedBox,
            if (isCommentShown && showComment.value)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: CommentWidget(
                  profileImage: kiDummyImage3ImageUrl,
                  comment:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam nisi, cras neque, lorem vel vulputate vitae aliquam. Pretium tristique nisi, ut commodo fames. Porttitor et sagittis egestas vitae metus, odio tristique amet, duis.',
                  timePassed: '30',
                  isLikeButtonShown: true,
                  commentLink: 'https://itnext.io/showing-url-preview-in-flutter-a3ad4ff9927e',
                  isReplyButtonShown: true,
                  isReactButtonShown: true,
                  isImageComment: true,
                  image: kiDummyImage3ImageUrl,
                  isLink: false,
                  reactCount: 1234,
                  userName: 'Monjurul Sharker Omi',
                  isSendMessageShown: false,
                  isHideButtonShown: true,
                  replyList: replyComment,
                ),
              ),
          ],
        ));
  }
}

class BadgeTabViewContent extends StatelessWidget {
  BadgeTabViewContent({super.key});

  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 40,
              child: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                controller: postReactionController.tabController,
                isScrollable: true,
                tabs: [
                  ReactionBottomSheetTab(
                    isReactionImageShown: false,
                    reactionImage: '',
                    text: ksAll.tr,
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge1SvgImageUrl,
                    text: postReactionController.badgeCount1.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge2SvgImageUrl,
                    text: postReactionController.badgeCount2.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge1SvgImageUrl,
                    text: postReactionController.badgeCount3.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge1SvgImageUrl,
                    text: postReactionController.badgeCount4.value.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (height * 0.9) - 65,
              child: TabBarView(controller: postReactionController.tabController, children: [
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftContent extends StatelessWidget {
  GiftContent({super.key});

  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h40,
                  width: h40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(kiProfileDefaultImageUrl),
                ),
                kW12sizedBox,
                SizedBox(
                  height: 40,
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        children: [
                          TextSpan(text: '${ksSupport.tr} ', style: regular12TextStyle(cBlackColor)),
                          TextSpan(
                            text: 'Monjurul Sharker Omi',
                            style: semiBold12TextStyle(cBlackColor),
                          ),
                          TextSpan(
                            text: '\nby sending stars',
                            style: regular12TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            kH8sizedBox,
            Text(
              ksStarsLetThis.tr,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              ksAllStars.tr,
              style: semiBold14TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            SizedBox(
              height: 380,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: giftPackages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .8,
                  crossAxisCount: 3,
                  crossAxisSpacing: k16Padding,
                  mainAxisSpacing: k16Padding,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      postReactionController.selectedPackage.value = giftPackages[index];
                      postReactionController.selectedGiftIndex.value = index;
                      postReactionController.isPackageSelected.value = true;
                    },
                    child: PackageGridViewContainer(
                      index: index,
                    ),
                  );
                },
              ),
            ),
            kH24sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(kiProfilePicImageUrl),
                  ),
                ),
                kW12sizedBox,
                Expanded(
                  child: CustomModifiedTextField(
                      hint: '${ksAddAComment.tr}...',
                      inputAction: TextInputAction.done,
                      contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
                      borderRadius: 8,
                      controller: postReactionController.giftTextEditingController),
                ),
              ],
            ),
            kH16sizedBox,
            CustomElevatedButton(
                label: ksGetStars.tr,
                buttonWidth: width - 40,
                onPressed: postReactionController.isPackageSelected.value
                    ? () {
                        globalController.commonBottomSheet(
                            context: context,
                            content: PurchaseStarContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: null,
                            rightText: '',
                            rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                            title: ksPurchaseStar.tr,
                            isRightButtonShow: false,
                            isScrollControlled: true,
                            bottomSheetHeight: height * .9);
                      }
                    : null)
          ],
        ),
      ),
    );
  }
}

class PurchaseStarContent extends StatelessWidget {
  PurchaseStarContent({super.key});

  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${ksYourCurrentBalance.tr} (${postReactionController.balance} of 200)',
                style: regular12TextStyle(cIconColor),
              ),
              IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    BipHip.info,
                    size: kIconSize14,
                    color: cIconColor,
                  ))
            ],
          ),
          kH4sizedBox,
          Container(
            height: 44,
            width: width,
            decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  BipHip.giftNew,
                  color: cSecondaryColor,
                  size: kIconSize16,
                ),
                Text(
                  '${postReactionController.balance}',
                  style: semiBold20TextStyle(cBlackColor).copyWith(foreground: Paint()..shader = linearGradient),
                ),
                Text(
                  ' Stars',
                  style: regular12TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
          ),
          kH24sizedBox,
          const CustomDivider(),
          kH16sizedBox,
          Text(
            '${ksYourCurrentBalance.tr} (${postReactionController.balance} of 200)',
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          CustomListTile(
            title: '${postReactionController.selectedPackage.value!['amount']} stars',
            borderColor: cPrimaryColor,
            itemColor: cPrimaryTint2Color,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$${postReactionController.selectedPackage.value!['cost']}',
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Radio(
                  value: 0,
                  groupValue: 0,
                  onChanged: (v) {},
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                ),
              ],
            ),
          ),
          kH16sizedBox,
          const CustomDivider(),
          kH16sizedBox,
          Text(
            ksAllStars.tr,
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ksStarsThatYouPurchase.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                TextSpan(
                  text: ksLearnMoreAboutStars.tr,
                  style: regular12TextStyle(cPrimaryColor),
                ),
              ],
            ),
          ),
          kH16sizedBox,
          SizedBox(
            height: 230,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      onPressed: () {
                        postReactionController.selectedPackage.value = packages[index];
                      },
                      title: '${packages[index]['amount']} stars',
                      borderColor: postReactionController.selectedPackage.value == packages[index] ? cPrimaryColor : cLineColor,
                      itemColor: postReactionController.selectedPackage.value == packages[index] ? cPrimaryTint3Color : cWhiteColor,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${packages[index]['cost']}',
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                          Radio(
                            value: packages[index],
                            groupValue: postReactionController.selectedPackage.value,
                            onChanged: (v) {
                              postReactionController.selectedPackage.value = v;
                            },
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          kH20sizedBox,
          const CustomDivider(),
          kH8sizedBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: postReactionController.giftCheckBox.value,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (v) {
                  postReactionController.giftCheckBox.value = !postReactionController.giftCheckBox.value;
                },
              ),
              kW8sizedBox,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)),
                    TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                  ],
                ),
              ),
            ],
          ),
          kH10sizedBox,
          CustomElevatedButton(
              label: postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount'])
                  ? '${ksBuy.tr} ${postReactionController.selectedPackage.value!['amount']} stars'
                  : '${ksGive.tr} ${postReactionController.selectedPackage.value!['amount']} stars',
              buttonHeight: 42,
              buttonWidth: width - 40,
              onPressed: () {})
        ],
      ),
    );
  }
}

