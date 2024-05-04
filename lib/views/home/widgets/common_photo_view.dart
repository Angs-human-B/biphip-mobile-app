import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CommonPhotoView extends StatelessWidget {
  const CommonPhotoView(
      {super.key, required this.image, this.postIndex = 0, this.onPressed, this.description, this.isLikeSectionShow = true, this.topRightIcon});
  final String image;
  final int postIndex;
  final String? description;
  final VoidCallback? onPressed;
  final bool? isLikeSectionShow;
  final IconData? topRightIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: Obx(() => CustomAppBar(
                  systemUiOverlayStyle: SystemUiOverlayStyle.light,
                  appBarColor: Colors.black,
                  hasBackButton: true,
                  iconColor: cWhiteColor,
                  isCenterTitle: true,
                  onBack: () {
                    Get.back();
                  },
                  action: [
                    if (Get.find<AwardController>().isOthersWinner.value == false)
                      Padding(
                        padding: const EdgeInsets.only(right: k8Padding),
                        child: CustomIconButton(
                          onPress: onPressed,
                          icon: topRightIcon ?? BipHip.system,
                          iconColor: cWhiteColor,
                          size: kIconSize20,
                        ),
                      ),
                  ],
                )),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        height: height * 0.6,
                        child: Image.network(
                          image,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.imageFile,
                            size: kIconSize100,
                            color: cIconColor,
                          ),
                          loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              Get.find<GalleryController>().imageData.value?.description ?? description,
                              style: semiBold14TextStyle(cWhiteColor),
                            )),
                        kH16sizedBox,
                        if (isLikeSectionShow == true)
                          Container(
                            color: cWhiteColor,
                            height: 1,
                            width: width - 40,
                          ),
                        if (isLikeSectionShow == true)
                          LikeSectionWidget(
                            postIndex: postIndex,
                            sectionColor: cWhiteColor,
                            isGiftShown: false,
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryWidget extends StatelessWidget {
  GalleryWidget({super.key, required this.urlImages, required this.imageIndex, this.imageDescriptions})
      : pageController = PageController(initialPage: imageIndex);
  final RxList<ImageElement> urlImages;
  final int imageIndex;
  final String? imageDescriptions;
  final PageController pageController;
  static RxString imageDescription = RxString("");
  static RxString selfReaction = RxString("");
  static Rx<CountReactions>? sharePostCountReaction;
  @override
  Widget build(BuildContext context) {
    imageDescription.value = "";
    if (urlImages[imageIndex].description != null) {
      imageDescription.value = urlImages[imageIndex].description!;
    }
    if (urlImages[imageIndex].countReactions?.value == null || urlImages[imageIndex].countReactions?.value.all?.value == 0) {
      sharePostCountReaction = null;
    } else {
      sharePostCountReaction = urlImages[imageIndex].countReactions;
    }
    selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              systemUiOverlayStyle: SystemUiOverlayStyle.light,
              appBarColor: Colors.black,
              hasBackButton: true,
              iconColor: cWhiteColor,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Stack(
            children: [
              PhotoViewGallery.builder(
                pageController: pageController,
                itemCount: urlImages.length,
                onPageChanged: (index) {
                  if (urlImages[index].description != null) {
                    imageDescription.value = urlImages[index].description!;
                  } else {
                    imageDescription.value = "";
                  }
                  sharePostCountReaction = urlImages[index].countReactions;
                  selfReaction.value = urlImages[index].myReaction?.value ?? "";
                },
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(urlImages[index].fullPath!),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 5,
                  );
                },
              ),
              Positioned(
                bottom: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Obx(
                    () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Text(
                          imageDescription.value,
                          style: semiBold14TextStyle(cWhiteColor),
                        ),
                      ),
                      kH16sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: SizedBox(
                          width: width - 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (urlImages[imageIndex].countReactions == null)
                                const Expanded(
                                  child: SizedBox(),
                                ),
                              if (urlImages[imageIndex].countReactions != null)
                                InkWell(
                                  child: ReactionView(
                                    isPost: true,
                                    reactCount: sharePostCountReaction,
                                  ),
                                ),
                              CommentShareRecord(
                                commentCount: RxInt(0),
                                isGiftShown: false,
                                giftCount: RxInt(0),
                                shareCount: RxInt(0),
                              )
                            ],
                          ),
                        ),
                      ),
                      kH12sizedBox,
                      Container(
                        color: cWhiteColor,
                        height: 1,
                        width: width - 40,
                      ),
                      Row(
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
                                              urlImages[imageIndex].countReactions = Get.find<GlobalController>()
                                                  .updateReaction("love", urlImages[imageIndex].myReaction, urlImages[imageIndex].countReactions);
                                              urlImages[imageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[imageIndex].myReaction, "love", 2, urlImages[imageIndex].id!);
                                              sharePostCountReaction = urlImages[imageIndex].countReactions;
                                              selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(imageIndex, imageIndex + 1, [urlImages[imageIndex]]);
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
                                              urlImages[imageIndex].countReactions = Get.find<GlobalController>()
                                                  .updateReaction("like", urlImages[imageIndex].myReaction, urlImages[imageIndex].countReactions);
                                              urlImages[imageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[imageIndex].myReaction, "like", 2, urlImages[imageIndex].id!);
                                              sharePostCountReaction = urlImages[imageIndex].countReactions;
                                              selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(imageIndex, imageIndex + 1, [urlImages[imageIndex]]);
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
                                              urlImages[imageIndex].countReactions = Get.find<GlobalController>()
                                                  .updateReaction("haha", urlImages[imageIndex].myReaction, urlImages[imageIndex].countReactions);
                                              urlImages[imageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[imageIndex].myReaction, "haha", 2, urlImages[imageIndex].id!);
                                              sharePostCountReaction = urlImages[imageIndex].countReactions;
                                              selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(imageIndex, imageIndex + 1, [urlImages[imageIndex]]);
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
                                              urlImages[imageIndex].countReactions = Get.find<GlobalController>()
                                                  .updateReaction("wow", urlImages[imageIndex].myReaction, urlImages[imageIndex].countReactions);
                                              urlImages[imageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[imageIndex].myReaction, "wow", 2, urlImages[imageIndex].id!);
                                              sharePostCountReaction = urlImages[imageIndex].countReactions;
                                              selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(imageIndex, imageIndex + 1, [urlImages[imageIndex]]);
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
                                              urlImages[imageIndex].countReactions = Get.find<GlobalController>()
                                                  .updateReaction("sad", urlImages[imageIndex].myReaction, urlImages[imageIndex].countReactions);
                                              sharePostCountReaction = urlImages[imageIndex].countReactions;
                                              urlImages[imageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[imageIndex].myReaction, "sad", 2, urlImages[imageIndex].id!);
                                              selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
                                              urlImages.replaceRange(imageIndex, imageIndex + 1, [urlImages[imageIndex]]);
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
                                              urlImages[imageIndex].countReactions = Get.find<GlobalController>()
                                                  .updateReaction("angry", urlImages[imageIndex].myReaction, urlImages[imageIndex].countReactions);
                                              sharePostCountReaction = urlImages[imageIndex].countReactions;
                                              urlImages[imageIndex].myReaction = Get.find<GlobalController>()
                                                  .getReaction(urlImages[imageIndex].myReaction, "angry", 2, urlImages[imageIndex].id!);
                                              urlImages.replaceRange(imageIndex, imageIndex + 1, [urlImages[imageIndex]]);
                                              selfReaction.value = urlImages[imageIndex].myReaction?.value ?? "";
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
                                width: (width - 40) / 3,
                                height: 44,
                                child: selfReaction.value == ""
                                    ? Get.find<GlobalController>().getColoredReactionIcon(null)
                                    : Get.find<GlobalController>().getColoredReactionIcon(selfReaction),
                              ),
                            ),
                          ),
                          InkWell(
                            // onTap: commentOnPressed,
                            child: SizedBox(
                              width: (width - 40) / 3,
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
                            child: SizedBox(
                              width: (width - 40) / 3,
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
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
