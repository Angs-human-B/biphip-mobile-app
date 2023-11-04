import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/common_post_widget.dart';
import 'package:bip_hip/views/home/home_page_widgets/post_upper_container.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/widgets/post_widgets/comment_textfield.dart';
import 'package:bip_hip/widgets/post_widgets/comment_widget.dart';
import 'package:bip_hip/widgets/post_widgets/like_section_widget.dart';
import 'package:bip_hip/widgets/post_widgets/post_activity_status_widget.dart';

class HomePostDetails extends StatelessWidget {
  HomePostDetails({super.key});

  final HomeController _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _homeController.isPostDetailsPageLoading.value
          ? const HomePostDetailsShimmer()
          : Container(
              color: cWhiteColor,
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: height,
                  child: Scaffold(
                    backgroundColor: cWhiteColor,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kAppBarSize),
                      //* info:: appBar
                      child: CustomAppBar(
                        hasBackButton: true,
                        isCenterTitle: true,
                        title: 'Wahid Murad',
                        onBack: () {
                          Get.back();
                        },
                      ),
                    ),
                    floatingActionButton: Container(
                      decoration: const BoxDecoration(color: cWhiteColor, border: Border(top: BorderSide(color: cLineColor))),
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: k12Padding,
                          horizontal: k20Padding,
                        ),
                        child: CommentTextField(
                          hintText: '${ksWriteAComment.tr} ...',
                        ),
                      ),
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    body: SizedBox(
                      height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: k12Padding),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                child: PostUpperContainer(userName: 'Wahid Murad', isCategorized: false, privacy: BipHip.world, postTime: '1hr'),
                              ),
                              kH12sizedBox,
                              CommonPostWidget(
                                isTextualPost: true,
                                mediaList: _homeController.postData.value!.post.imageUrls,
                                isCommentShown: true,
                                showBottomSection: true,
                                postText: _homeController.postData.value!.post.content,
                              ),
                              const SizedBox(
                                height: 110,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class CommonPostWidget extends StatelessWidget {
  CommonPostWidget({
    super.key,
    required this.isTextualPost,
    this.category,
    this.title,
    this.postText,
    required this.mediaList,
    required this.isCommentShown,
    required this.showBottomSection,
  });
  final bool isTextualPost, isCommentShown, showBottomSection;
  final String? category, title, postText;
  final List mediaList;
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTextualPost)
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: (_homeController.seeMore.value && postText!.length > 256) ? 5 : null,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: postText!,
                        style: regular14TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                ),
              )),
        if (postText!.length > 256)
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () {
                    _homeController.seeMore.value = !_homeController.seeMore.value;
                  },
                  child: Text(
                    _homeController.seeMore.value ? ksSeeMore.tr : ksShowLess.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              )),
        kH16sizedBox,
        if (mediaList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Container(
              color: cWhiteColor,
              height: 302,
              width: width - 40,
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {
                          Get.toNamed(krHomePostDetailsScreen);
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                          height: mediaList.length < 2 ? 302 : 150,
                          width: mediaList.length > 3 ? (width - 42) / 2 : (width - 40),
                          child: Image.network(
                            Environment.imageBaseUrl + mediaList[0].path.toString(),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              BipHip.imageFile,
                              size: kIconSize120,
                              color: cIconColor,
                            ),
                            loadingBuilder: imageLoadingBuilder,
                            frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                              return child;
                            },
                          ),
                        ),
                      ),
                      if (mediaList.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: (width - 42) / 2,
                            child: Image.network(
                              Environment.imageBaseUrl + mediaList[1].path.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.imageFile,
                                size: kIconSize120,
                                color: cIconColor,
                              ),
                              loadingBuilder: imageLoadingBuilder,
                              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                return child;
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (mediaList.length > 1)
                    const SizedBox(
                      height: 2,
                    ),
                  Row(
                    children: [
                      if (mediaList.length < 4 && mediaList.length > 1)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length < 3 ? (width - 40) : (width - 42) / 2,
                            child: Image.network(
                              Environment.imageBaseUrl + mediaList[1].path.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.imageFile,
                                size: kIconSize120,
                                color: cIconColor,
                              ),
                              loadingBuilder: imageLoadingBuilder,
                              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                return child;
                              },
                            ),
                          ),
                        ),
                      if (mediaList.length < 4 && mediaList.length > 2)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 2)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length > 4 ? (width - 44) / 3 : (width - 42) / 2,
                            child: Image.network(
                              Environment.imageBaseUrl + mediaList[2].path.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.imageFile,
                                size: kIconSize120,
                                color: cIconColor,
                              ),
                              loadingBuilder: imageLoadingBuilder,
                              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                return child;
                              },
                            ),
                          ),
                        ),
                      if (mediaList.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length < 5 ? (width - 42) / 2 : (width - 44) / 3,
                            child: Image.network(
                              Environment.imageBaseUrl + mediaList[3].path.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.imageFile,
                                size: kIconSize120,
                                color: cIconColor,
                              ),
                              loadingBuilder: imageLoadingBuilder,
                              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                return child;
                              },
                            ),
                          ),
                        ),
                      if (mediaList.length > 4)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length >= 5)
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {
                                Get.toNamed(krHomePostDetailsScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                height: 150,
                                width: (width - 44) / 3,
                                child: Image.network(
                                  Environment.imageBaseUrl + mediaList[4].path.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize120,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                  frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                    return child;
                                  },
                                ),
                              ),
                            ),
                            if (mediaList.length > 5)
                              Positioned(
                                child: TextButton(
                                  style: kTextButtonStyle,
                                  onPressed: () {
                                    // Get.toNamed(krUploadedImageListPage);
                                    Get.toNamed(krHomePostDetailsScreen);
                                  },
                                  child: Text(
                                    "${mediaList.length - 5} More",
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
        if (showBottomSection) PostBottomSection(isCommentShown: isCommentShown),
      ],
    );
  }
}

class PostBottomSection extends StatelessWidget {
  PostBottomSection({super.key, required this.isCommentShown});

  final GlobalController _globalController = Get.find<GlobalController>();
  final PostReactionController _postReactionController = Get.find<PostReactionController>();
  final bool isCommentShown;
  final RxBool showComment = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            commentOnPressed: () {
              //showComment.value = !showComment.value;
              ll(showComment);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CustomDivider(),
        ),
        kH12sizedBox,
        // if (isCommentShown && showComment.value)
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
            SizedBox(
              height: 40,
              child: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                controller: _postReactionController.tabController,
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
                    text: _postReactionController.badgeCount1.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge2SvgImageUrl,
                    text: _postReactionController.badgeCount2.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge1SvgImageUrl,
                    text: _postReactionController.badgeCount3.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge1SvgImageUrl,
                    text: _postReactionController.badgeCount4.value.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (height * 0.9) - 65,
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

class _GiftContent extends StatelessWidget {
  _GiftContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
                      controller: _postReactionController.giftTextEditingController),
                ),
              ],
            ),
            kH16sizedBox,
            CustomElevatedButton(
                label: ksGetStars.tr,
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
                '${ksYourCurrentBalance.tr} (${_postReactionController.balance} of 200)',
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
            '${ksYourCurrentBalance.tr} (${_postReactionController.balance} of 200)',
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
                    TextSpan(text: '${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)),
                    TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                  ],
                ),
              ),
            ],
          ),
          kH10sizedBox,
          CustomElevatedButton(
              label: _postReactionController.balance < int.parse(_postReactionController.selectedPackage.value!['amount'])
                  ? '${ksBuy.tr} ${_postReactionController.selectedPackage.value!['amount']} stars'
                  : '${ksGive.tr} ${_postReactionController.selectedPackage.value!['amount']} stars',
              buttonHeight: 42,
              buttonWidth: width - 40,
              onPressed: () {})
        ],
      ),
    );
  }
}

class HomePostDetailsShimmer extends StatelessWidget {
  const HomePostDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: height - kAppBarSize - MediaQuery.of(context).padding.top,
            child: Scaffold(
              backgroundColor: cWhiteColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kAppBarSize),
                //* info:: appBar
                child: CustomAppBar(
                  hasBackButton: true,
                  isCenterTitle: true,
                  title: ShimmerCommon(
                    widget: Container(decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius), height: h20, width: width * 0.6),
                  ),
                  onBack: () {
                    Get.back();
                  },
                ),
              ),
              body: SizedBox(
                height: height - kAppBarSize,
                width: width,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        color: cWhiteColor,
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h40,
                                      width: h40,
                                      decoration: const BoxDecoration(
                                        color: cWhiteColor,
                                        shape: BoxShape.circle,
                                      )),
                                ),
                                kW8sizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                          height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                    ),
                                    kH8sizedBox,
                                    ShimmerCommon(
                                      widget: Container(
                                          height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            kH16sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h10, width: width * 0.4, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH8sizedBox,
                            Row(
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                    height: 130,
                                    width: (width - 42) / 2,
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                ShimmerCommon(
                                  widget: Container(
                                    height: 130,
                                    width: (width - 42) / 2,
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            ShimmerCommon(
                              widget: Container(
                                height: 130,
                                width: width - 40,
                                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              ),
                            ),
                            kH12sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                )
                              ],
                            ),
                            kH16sizedBox,
                            ShimmerCommon(widget: const CustomDivider()),
                            kH16sizedBox,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
                                  ),
                                ),
                                kW8sizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                        width: width - 130,
                                        height: 60,
                                        decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            kH8sizedBox,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
                                  ),
                                ),
                                kW8sizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                        width: width - 180,
                                        height: 50,
                                        decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
