import 'package:bip_hip/controllers/home_controller.dart';
import 'package:bip_hip/controllers/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/post_upper_container.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/post_widgets/biding_insight.dart';
import 'package:bip_hip/views/profile/post_widgets/biding_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/comment_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/like_section_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/post_activity_status_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:flutter_svg/svg.dart';

class CommonPostWidget extends StatelessWidget {
  CommonPostWidget(
      {super.key,
      required this.isCommented,
      required this.isLiked,
      required this.isCategorized,
      required this.userName,
      required this.postTime,
      this.category,
      this.brandName,
      this.kidName,
      this.kidAge,
      this.title,
      this.price,
      this.categoryIcon,
      required this.privacy,
      this.categoryIconColor,
      required this.isTextualPost,
      this.postText,
      this.mediaList,
      required this.isSelfPost, required this.isCommentShown});
  final bool isCommented, isLiked, isCategorized, isTextualPost, isSelfPost, isCommentShown;
  final String userName, postTime;
  final String? category, brandName, kidName, kidAge, title, price, postText;
  final IconData? categoryIcon;
  final IconData privacy;
  final Color? categoryIconColor;
  final List? mediaList;
  final HomeController _homeController = Get.find<HomeController>();
  final PostReactionController _postReactionController = Get.find<PostReactionController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLiked)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
              child: Row(
                children: [
                  Stack(
                    children: [
                      const SizedBox(
                        width: 40,
                        height: 20,
                      ),
                      for (int index = 0; index < 3; index++)
                        Positioned(
                          left: index * 10,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: cWhiteColor, width: 1),
                            ),
                            child: Image.asset(
                              'assets/images/profileDefault.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                    ],
                  ),
                  kW8sizedBox,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: 'Aminul Islam Rana and 10 other ', style: semiBold14TextStyle(cBlackColor)),
                    TextSpan(text: 'liked it.', style: regular14TextStyle(cSmallBodyTextColor))
                  ]))
                ],
              ),
            ),
          if (isCommented)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
              child: Row(
                children: [
                  kW8sizedBox,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: 'Aminul Islam Rana ', style: semiBold14TextStyle(cBlackColor)),
                    TextSpan(text: 'commented.', style: regular14TextStyle(cSmallBodyTextColor))
                  ])),
                ],
              ),
            ),
          const CustomDivider(),
          kH10sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: PostUpperContainer(
              userName: userName,
              postTime: postTime,
              isCategorized: isCategorized,
              category: category,
              categoryIcon: categoryIcon,
              categoryIconColor: categoryIconColor,
              privacy: privacy,
              brandName: brandName,
              kidName: kidName,
              kidAge: kidAge,
              title: title,
            ),
          ),
          kH8sizedBox,
          if ((category == 'News' || category == 'Selling') && isCategorized)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
              child: Text(
                title!,
                overflow: TextOverflow.clip,
                style: semiBold14TextStyle(cBlackColor),
              ),
            ),
          if (category == 'Selling' && isCategorized)
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding, left: kHorizontalPadding, right: kHorizontalPadding),
              child: Text(
                'Price: $price\$',
                style: semiBold14TextStyle(cBlackColor),
              ),
            ),
          if (isTextualPost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: RichText(
                textAlign: TextAlign.left,
                overflow: TextOverflow.clip,
                maxLines: (postText!.length > 256 && _homeController.seeMore.value) ? 5 : null,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: postText,
                      style: regular14TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ),
            ),
          if (postText!.length > 256)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () {
                  _homeController.seeMore.value = !_homeController.seeMore.value;
                },
                child: Text(
                  _homeController.seeMore.value ? 'See More' : 'Show Less',
                  style: semiBold14TextStyle(cPrimaryColor),
                ),
              ),
            ),
          kH16sizedBox,
          if (mediaList!.isNotEmpty)
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Container(
                  color: cWhiteColor,
                  height: 302,
                  width: width - 40,
                  child: Column(
                    children: [
                      // if (mediaList!.length < 4)
                      //   TextButton(
                      //     style: kTextButtonStyle,
                      //     onPressed: () {},
                      //     child: Container(
                      //       height: mediaList!.length < 2 ? 302 : 150,
                      //       decoration: BoxDecoration(
                      //         borderRadius: k4CircularBorderRadius,
                      //         color: cWhiteColor,
                      //       ),
                      //       width: width - 40,
                      //       child: Image.asset(
                      //         mediaList![0],
                      //         fit: BoxFit.cover,
                      //       ),
                      //     ),
                      //   ),
                      if (mediaList!.length > 3)
                        Row(
                          children: [
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {},
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                height: mediaList!.length < 2 ? 302 : 150,
                                width: mediaList!.length > 2 ? (width - 42) / 2 : (width - 42),
                                child: Image.asset(
                                  mediaList![0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {},
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                height: 150,
                                width: (width - 42) / 2,
                                child: Image.asset(
                                  mediaList![1],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (mediaList!.length > 1)
                        const SizedBox(
                          height: 2,
                        ),
                      Row(
                        children: [
                          if (mediaList!.length < 4)
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {},
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                height: 150,
                                width: mediaList!.length < 3 ? (width - 40) : (width - 42) / 2,
                                child: Image.asset(
                                  mediaList![1],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (mediaList!.length > 3)
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {},
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                height: 150,
                                width: mediaList!.length == 4 ? (width - 42) / 2 : (width - 44) / 3,
                                child: Image.asset(
                                  mediaList![2],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (mediaList!.length > 2)
                            const SizedBox(
                              width: 2,
                            ),
                          if (mediaList!.length > 3)
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {},
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                height: 150,
                                width: mediaList!.length == 4 ? (width - 42) / 2 : (width - 44) / 3,
                                child: Image.asset(
                                  mediaList![3],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (mediaList!.length > 4)
                            const SizedBox(
                              width: 2,
                            ),
                          if (mediaList!.length >= 5)
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                TextButton(
                                  style: kTextButtonStyle,
                                  onPressed: () {},
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                    height: 150,
                                    width: (width - 44) / 3,
                                    child: Image.asset(
                                      mediaList![4],
                                      fit: BoxFit.cover,
                                      color: mediaList!.length > 5 ? cBlackColor.withOpacity(0.3) : null,
                                      colorBlendMode: mediaList!.length > 5 ? BlendMode.multiply : null,
                                    ),
                                  ),
                                ),
                                if (mediaList!.length > 5)
                                  Positioned(
                                    child: TextButton(
                                      style: kTextButtonStyle,
                                      onPressed: () {
                                        Get.toNamed(krUploadedImageListPage);
                                      },
                                      child: Text(
                                        "${mediaList!.length - 5} More",
                                        style: semiBold16TextStyle(cWhiteColor),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isSelfPost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: BiddingWidget(
                totalBids: 25,
                bidingAmount: 300,
                isPlaceBid: false,
                bidingOnPressed: () {
                  _globalController.blankBottomSheet(
                      context: context,
                      content: _BiddingInsightsContent(
                        comment: bidingComments,
                      ),
                      isScrollControlled: true,
                      bottomSheetHeight: height * 0.6);
                },
              ),
            ),
          if (!isSelfPost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: BiddingWidget(
                totalBids: 25,
                bidingAmount: 300,
                bidingOnPressed: () {
                  _globalController.commonBottomSheet(
                    context: context,
                    content: _PlaceBidContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      Get.back();
                    },
                    rightText: 'Send',
                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                    title: 'Place a Bid',
                    isRightButtonShow: true,
                    isScrollControlled: true,
                    // bottomSheetHeight: height * .4,
                  );
                },
                isPlaceBid: true,
              ),
            ),
          kH12sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: PostActivityStatusWidget(
              reactCount: 440,
              reactionOnPressed: () {
                _postReactionController.giftFilter(0);
                _globalController.blankBottomSheet(context: context, content: _BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
              },
              giftCount: 50,
              commentCount: 200,
              shareCount: 340,
              isGiftShown: true,
              giftOnPressed: () {
                _postReactionController.giftFilter(0);
                _globalController.blankBottomSheet(context: context, content: _BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
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
                _globalController.blankBottomSheet(context: context, content: _GiftContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: CustomDivider(),
          ),
          kH12sizedBox,
          if(isCommentShown)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: CommentWidget(
              profileImage: 'assets/images/pic5.jpeg',
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
      ),
    );
  }
}

class _BiddingInsightsContent extends StatelessWidget {
  const _BiddingInsightsContent({super.key, required this.comment});

  final List comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BidingInsight(highest: 500, lowest: 150),
        kH16sizedBox,
        Text(
          'Bids',
          style: semiBold16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comment.length,
            itemBuilder: (context, index) {
              return CommentWidget(
                profileImage: comment[index]['image'],
                timePassed: '5',
                isLikeButtonShown: true,
                isReplyButtonShown: false,
                isReactButtonShown: true,
                comment: comment[index]['comment'],
                isLink: false,
                reactCount: 440,
                userName: comment[index]['userName'],
                isImageComment: false,
                isSendMessageShown: true,
                isHideButtonShown: false,
                replyList: [],
              );
            })
      ],
    );
  }
}

class _PlaceBidContent extends StatelessWidget {
  _PlaceBidContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 225,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended',
              style: regular12TextStyle(cPlaceHolderColor),
            ),
            kH8sizedBox,
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: 10.0,
              children: [
                for (int i = 0; i < recommendedBid.length; i++)
                  CustomChoiceChips(
                    label: '\$${recommendedBid[i]}',
                    borderRadius: k8CircularBorderRadius,
                    isSelected: (_postReactionController.selectedBidIndex.value == i),
                    onSelected: (value) {
                      _postReactionController.selectedBidIndex.value = i;
                      _postReactionController.bidingTextEditingController.text = recommendedBid[i];
                    },
                  )
              ],
            ),
            kH24sizedBox,
            Text(
              'Bid amount',
              style: semiBold14TextStyle(cBlackColor),
            ),
            kH8sizedBox,
            CustomModifiedTextField(
                prefixIcon: Icons.attach_money_rounded, borderRadius: k8BorderRadius, controller: _postReactionController.bidingTextEditingController)
          ],
        ),
      ),
    );
  }
}

class _BadgeTabViewContent extends StatelessWidget {
  _BadgeTabViewContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Obx(
        () => Column(
          children: [
            TabBar(
              controller: _postReactionController.tabController,
              // onTap: (index) {
              //   _postReactionController.giftFilter(index);

              //   // ll(i);
              // },
              isScrollable: true,
              tabs: [
                const ReactionBottomSheetTab(
                  isReactionImageShown: false,
                  reactionImage: '',
                  text: 'All',
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge1.svg',
                  text: _postReactionController.badgeCount1.value.toString(),
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge2.svg',
                  text: _postReactionController.badgeCount2.value.toString(),
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge3.svg',
                  text: _postReactionController.badgeCount3.value.toString(),
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge4.svg',
                  text: _postReactionController.badgeCount4.value.toString(),
                ),
              ],
            ),
            SizedBox(
              height: (height * 0.9) - 90,
              width: width - 40,
              child: TabBarView(controller: _postReactionController.tabController, children: [
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionBottomSheetTab extends StatelessWidget {
  const ReactionBottomSheetTab({super.key, required this.isReactionImageShown, required this.reactionImage, required this.text});

  final bool isReactionImageShown;
  final String reactionImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          if (isReactionImageShown)
            SvgPicture.asset(
              reactionImage,
              width: 20,
            ),
          if (isReactionImageShown) kW8sizedBox,
          Text(
            text,
            style: isReactionImageShown ? regular12TextStyle(cBlackColor) : semiBold12TextStyle(cBlackColor),
          )
        ],
      ),
    );
  }
}

class ReactionTabPage extends StatelessWidget {
  const ReactionTabPage({super.key, required this.list});
  final List list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var item = list[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                leading: Stack(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipOval(
                        child: Image.asset(item['image']),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          item['giftImage'],
                          height: 16,
                          width: 16,
                        ))
                  ],
                ),
                title: Text(
                  item['name'],
                  style: semiBold14TextStyle(cBlackColor),
                ),
                trailing: item['isFriend']
                    ? Text(
                        'Message',
                        style: regular14TextStyle(cPrimaryColor),
                      )
                    : Text(
                        'Add Friend',
                        style: regular14TextStyle(cPrimaryColor),
                      ),
              ),
            );
          }),
    );
  }
}

class _GiftContent extends StatelessWidget {
  _GiftContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
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
                  child: Image.asset('assets/images/profileDefault.png'),
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
                          TextSpan(text: 'Support ', style: regular12TextStyle(cBlackColor)),
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
              'Stars let this creator earn money so that they can continue \nmaking content that you love.',
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              'All Stars',
              style: semiBold14TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            SizedBox(
              height: 380,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                      _postReactionController.selectedPackage.value = giftPackages[index];
                      _postReactionController.selectedGiftIndex.value = index;
                      _postReactionController.isPackageSelected.value = true;
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
                    child: Image.asset('assets/images/profileDefault.png'),
                  ),
                ),
                kW12sizedBox,
                Expanded(
                  child: CustomModifiedTextField(
                      hint: 'Add a comment....',
                      inputAction: TextInputAction.done,
                      contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
                      borderRadius: 8,
                      controller: _postReactionController.giftTextEditingController),
                ),
              ],
            ),
            kH16sizedBox,
            CustomElevatedButton(
                label: 'Get Stars',
                buttonWidth: width - 40,
                onPressed: _postReactionController.isPackageSelected.value
                    ? () {
                        _globalController.commonBottomSheet(
                            context: context,
                            content: _PurchaseStarContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: null,
                            rightText: '',
                            rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                            title: 'Purchase Star',
                            isRightButtonShow: false,
                            isScrollControlled: true,
                            bottomSheetHeight: height * .9);
                      }
                    : null)
          ],
        ));
  }
}

class PackageGridViewContainer extends StatelessWidget {
  PackageGridViewContainer({
    Key? key,
    required index,
  })  : _index = index,
        super(key: key);

  final int _index;
  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: k8CircularBorderRadius,
            color: (_postReactionController.selectedGiftIndex.value == _index) ? cPrimaryTint3Color : cWhiteColor,
            border: Border.all(color: (_postReactionController.selectedGiftIndex.value == _index) ? cPrimaryColor : cLineColor)),
        child: Padding(
          padding: const EdgeInsets.all(k16Padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: k8CircularBorderRadius,
                child: SvgPicture.asset(
                  giftPackages[_index]['badge'],
                  fit: BoxFit.fill,
                ),
              ),
              kH4sizedBox,
              Text(
                giftPackages[_index]['packageName'],
                style: semiBold14TextStyle(cBlackColor),
              ),
              kH4sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    BipHip.giftNew,
                    color: cSecondaryColor,
                    size: kIconSize12,
                  ),
                  kW4sizedBox,
                  Text(
                    giftPackages[_index]['amount'],
                    style: regular10TextStyle(cBlackColor),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseStarContent extends StatelessWidget {
  _PurchaseStarContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Your current balance (${_postReactionController.balance} of 200)',
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
                  '${_postReactionController.balance}',
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
            'Your current balance (${_postReactionController.balance} of 200)',
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          CustomListTile(
            title: '${_postReactionController.selectedPackage.value!['amount']} stars',
            borderColor: cPrimaryColor,
            itemColor: cPrimaryTint2Color,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$${_postReactionController.selectedPackage.value!['cost']}',
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
            'All stars',
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Stars that you purchase here are kept in your balance. You can send stars from your balance at any time. ',
                  style: regular12TextStyle(cBlackColor),
                ),
                TextSpan(
                  text: 'Learn more about Stars.',
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
                        _postReactionController.selectedPackage.value = packages[index];
                      },
                      title: '${packages[index]['amount']} stars',
                      borderColor: _postReactionController.selectedPackage.value == packages[index] ? cPrimaryColor : cLineColor,
                      itemColor: _postReactionController.selectedPackage.value == packages[index] ? cPrimaryTint3Color : cWhiteColor,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${packages[index]['cost']}',
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                          Radio(
                            value: packages[index],
                            groupValue: _postReactionController.selectedPackage.value,
                            onChanged: (v) {
                              _postReactionController.selectedPackage.value = v;
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
                value: _postReactionController.giftCheckBox.value,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (v) {
                  _postReactionController.giftCheckBox.value = !_postReactionController.giftCheckBox.value;
                },
              ),
              kW8sizedBox,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'I agree with the ', style: regular12TextStyle(cBlackColor)),
                    TextSpan(text: 'terms & condition', style: regular12TextStyle(cPrimaryColor))
                  ],
                ),
              ),
            ],
          ),
          kH10sizedBox,
          CustomElevatedButton(
              label: _postReactionController.balance < int.parse(_postReactionController.selectedPackage.value!['amount'])
                  ? 'Buy ${_postReactionController.selectedPackage.value!['amount']} stars'
                  : 'Give ${_postReactionController.selectedPackage.value!['amount']} stars',
              buttonHeight: 42,
              buttonWidth: width - 40,
              onPressed: () {})
        ],
      ),
    );
  }
}
