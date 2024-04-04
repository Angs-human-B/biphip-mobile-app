import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/shimmers/home/home_page_details_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_details_widget.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/comment_textfield.dart';
import 'package:bip_hip/widgets/post/comment_widget.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';

class HomePostDetails extends StatelessWidget {
  HomePostDetails({super.key, this.postIndex = 0});
  final int postIndex;

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.isPostDetailsPageLoading.value || Get.find<PostReactionController>().isCommentLoading.value
          ? const HomePostDetailsShimmer()
          : Container(
              color: cWhiteColor,
              child: Stack(
                children: [
                  SafeArea(
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
                            title: homeController.postData.value?.post.user?.fullName ?? ksNA.tr,
                            onBack: () {
                              Get.back();
                            },
                          ),
                        ),
                        // floatingActionButton: Container(
                        //   decoration: const BoxDecoration(color: cWhiteColor, border: Border(top: BorderSide(color: cLineColor))),
                        //   height: 120,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //       vertical: k12Padding,
                        //       horizontal: k20Padding,
                        //     ),
                        //     child: CommentTextField(
                        //       hintText: '${ksWriteAComment.tr} ...',
                        //     ),
                        //   ),
                        // ),
                        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                        body: SizedBox(
                          height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: k12Padding),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: PostUpperContainer(
                                      taggedFriend: homeController.postData.value?.post.taggedFriends,
                                      userName: homeController.postData.value?.post.user?.fullName ?? ksNA.tr,
                                      isCategorized: false,
                                      privacy: BipHip.world,
                                      postTime: homeController.postTimeDifference(homeController.postData.value!.post.createdAt),
                                      userImage: homeController.postData.value!.post.user!.profilePicture.toString(),
                                      category: homeController.postData.value?.post.postCategory == null
                                          ? null
                                          : homeController.postData.value?.post.postCategory?.name ?? "",
                                      categoryIcon: homeController.postData.value!.post.postCategory == null
                                          ? null
                                          : homeController.getCategoryIcon(homeController.postData.value!.post.postCategory?.id),
                                      categoryIconColor: homeController.postData.value!.post.postCategory == null
                                          ? null
                                          : homeController.getCategoryColor(homeController.postData.value!.post.postCategory?.id),
                                      kidName: homeController.postData.value!.post.kid == null ? null : homeController.postData.value!.post.kid!.name, //API
                                      kidAge: homeController.postData.value!.post.kid == null
                                          ? null
                                          : homeController.postData.value!.post.kid!.age.toString(), //API
                                      brandName:
                                          homeController.postData.value!.post.store == null ? null : homeController.postData.value!.post.store!.name, //API
                                      secondaryImage:
                                          homeController.postData.value!.post.kid?.profilePicture ?? homeController.postData.value!.post.store?.profilePicture,
                                    ),
                                  ),
                                  kH12sizedBox,
                                  CommonPostDetailsWidget(
                                    mediaList: homeController.postData.value!.post.images,
                                    isCommentShown: true,
                                    showBottomSection: true,
                                    postIndex: postIndex,
                                    postText: homeController.postData.value!.post.postCategory?.name == 'News'
                                        ? homeController.postData.value!.post.description ?? ''
                                        : homeController.postData.value!.post.content ?? '', //API
                                    // title: homeController.postData.value!.post.title, //API
                                    title: homeController.postData.value!.post.title, //API
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
                  if (Get.find<PostReactionController>().isCommentDeleteLoading.value || Get.find<PostReactionController>().isCommentHideLoading.value)
                    Positioned(
                      child: CommonLoadingAnimation(
                        onWillPop: () async {
                          if (Get.find<PostReactionController>().isCommentDeleteLoading.value ||
                              Get.find<PostReactionController>().isCommentHideLoading.value) {
                            return false;
                          }
                          return true;
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

class PostDetailsBottomSection extends StatelessWidget {
  PostDetailsBottomSection(
      {super.key,
      required this.isSelfPost,
      required this.isCommentShown,
      required this.commentCount,
      required this.shareCount,
      required this.giftCount,
      this.category,
      this.actionName,
      this.actionOnPressed,
      this.reactCount,
      this.postIndex = 0,
      this.refType = 0,
      this.refId = 0});

  final GlobalController globalController = Get.find<GlobalController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final bool isSelfPost, isCommentShown;
  final RxBool showComment = RxBool(false);
  final int commentCount, shareCount, giftCount;
  final int postIndex;
  final int refType;
  final int refId;
  final CountReactions? reactCount;
  final String? category, actionName;
  final VoidCallback? actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (isSelfPost && category == 'Selling')
        //   Padding(
        //     padding: const EdgeInsets.only(
        //       left: kHorizontalPadding,
        //       right: kHorizontalPadding,
        //     ),
        //     child: BiddingWidget(
        //       totalBids: 25,
        //       yourBid: 300,
        //       isPlaceBid: false,
        //       bidingOnPressed: () {
        //         globalController.blankBottomSheet(
        //             context: context,
        //             content: BiddingInsightsContent(
        //               comment: bidingComments,
        //             ),
        //             isScrollControlled: true,
        //             bottomSheetHeight: height * 0.7);
        //       },
        //     ),
        //   ),
        // if (!isSelfPost && category == 'Selling')
        //   Padding(
        //     padding: const EdgeInsets.only(
        //       left: kHorizontalPadding,
        //       right: kHorizontalPadding,
        //     ),
        //     child: BiddingWidget(
        //       totalBids: 25,
        //       yourBid: postReactionController.yourBid.value,
        //       bidingOnPressed: () {
        //         if (postReactionController.yourBid.value == null) {
        //           globalController.commonBottomSheet(
        //             bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : null,
        //             context: context,
        //             content: PlaceBidContent(
        //               desiredAmount: '100',
        //               minimumBiddingAmount: '50',
        //             ),
        //             onPressCloseButton: () {
        //               Get.back();
        //             },
        //             onPressRightButton: () {
        //               postReactionController.yourBid.value = int.parse(postReactionController.bidingTextEditingController.text);
        //               Get.back();
        //             },
        //             rightText: ksSubmit.tr,
        //             rightTextStyle: medium14TextStyle(cPrimaryColor),
        //             title: ksPlaceABid.tr,
        //             isRightButtonShow: true,
        //             isScrollControlled: true,
        //           );
        //         } else {
        //           globalController.commonBottomSheet(
        //             bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : null,
        //             context: context,
        //             content: BidAmount(
        //               highestAmount: '350',
        //               totalBid: '56',
        //               desireAmount: '400',
        //               yourBid: postReactionController.yourBid.value.toString(),
        //             ),
        //             onPressCloseButton: () {
        //               Get.back();
        //             },
        //             onPressRightButton: () {
        //               Get.back();
        //               globalController.commonBottomSheet(
        //                 bottomSheetHeight: isDeviceScreenLarge() ? height * 0.3 : null,
        //                 context: context,
        //                 content: UpdateBidding(
        //                   yourBid: postReactionController.yourBid.value.toString(),
        //                 ),
        //                 onPressCloseButton: () {
        //                   Get.back();
        //                 },
        //                 onPressRightButton: () {
        //                   Get.back();
        //                 },
        //                 rightText: ksUpdate.tr,
        //                 rightTextStyle: medium14TextStyle(cPrimaryColor),
        //                 title: ksUpdateBiddingAmount.tr,
        //                 isRightButtonShow: true,
        //                 isScrollControlled: true,
        //               );
        //             },
        //             rightText: ksEdit.tr,
        //             rightTextStyle: medium14TextStyle(cPrimaryColor),
        //             title: ksYourBidAmount.tr,
        //             isRightButtonShow: true,
        //             isScrollControlled: true,
        //           );
        //         }
        //       },
        //       isPlaceBid: true,
        //     ),
        //   ),

        if (reactCount != null || commentCount != 0 || shareCount != 0 || giftCount != 0)
          Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
            child: PostActivityStatusWidget(
              reactCount: reactCount,
              reactionOnPressed: () {
                postReactionController.giftFilter(0);
                globalController.blankBottomSheet(context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
              },
              giftCount: giftCount,
              commentCount: commentCount,
              shareCount: shareCount,
              isGiftShown: true,
              giftOnPressed: () {
                postReactionController.giftFilter(0);
                globalController.blankBottomSheet(context: context, content: BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
          ),
          child: LikeSectionWidget(
            postIndex: postIndex,
            refType: refType,
            refId: refId,
            isGiftShown: true,
            likeOnTap: () {},
            giftOnPressed: () {
              postReactionController.resetGiftData();
              globalController.commonBottomSheet(
                context: context,
                content: GiftContent(),
                isScrollControlled: true,
                bottomSheetHeight: height * .9,
                onPressCloseButton: () {
                  Get.back();
                },
                onPressRightButton: null,
                rightText: '',
                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                title: ksSendGift.tr,
                isRightButtonShow: false,
              );
            },
            commentOnPressed: () async {
              // ll("12");
              showComment.value = !showComment.value;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CustomDivider(),
        ),
        kH12sizedBox,
        // if (isCommentShown && showComment.value)
        // ListView.separated(
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {
        //       return
        for (int i = 0; i < postReactionController.commentList.length; i++)
          InkWell(
            onTap: () {
              postReactionController.commentId.value = postReactionController.commentList[i].id!;
              postReactionController.selectedCommentIndex.value = i;
              Get.find<GlobalController>().commonBottomSheet(
                  context: context,
                  bottomSheetHeight: height * 0.4,
                  content: CommentBottomSheetContent(),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: () {},
                  rightText: "",
                  rightTextStyle: regular10TextStyle(cWhiteColor),
                  title: "",
                  isRightButtonShow: false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: CommentWidget(
                profileImage: postReactionController.commentList[i].user?.profilePicture ?? "",
                comment: postReactionController.commentList[i].comment ?? "",
                timePassed: '30',
                isLikeButtonShown: true,
                commentLink: 'https://itnext.io/showing-url-preview-in-flutter-a3ad4ff9927e',
                isReplyButtonShown: true,
                isReactButtonShown: true,
                isImageComment: true,
                image: postReactionController.commentList[i].image,
                isLink: false,
                reactCount: 1234,
                // userName: postReactionController.commentList[1].user?.fullName ?? ksNA,
                userName: postReactionController.commentList[i].user?.fullName ?? ksNA.tr,
                isSendMessageShown: false,
                isHideButtonShown: true,
                replyList: postReactionController.commentList[i].commentReplies,
                refType: refType,
                refId: refId,
              ),
            ),
          ),
        //   );
        // },
        // separatorBuilder: (context, index) => kH4sizedBox,
        // itemCount: postReactionController.commentList.length),
        SizedBox(
            width: width - 40,
            height: 108,
            child: CommentTextField(
              hintText: "${ksWriteAComment.tr} ...",
              onPressedCamera: () async {
                await globalController.selectImageSource(postReactionController.isCommentImageChanged, postReactionController.commentImageLink,
                    postReactionController.commentImageFile, 'gallery', false);
                postReactionController.commentSendEnabled();
              },
              onPressedSend: () async {
                if (postReactionController.isUpdateComment.value) {
                  await Get.find<PostReactionController>().updateComment();
                } else {
                  await Get.find<PostReactionController>().postComment(1, postReactionController.refId.value);
                }
              },
            )),
      ],
    );
  }
}

class CommentBottomSheetContent extends StatelessWidget {
  CommentBottomSheetContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: postReactionController.commentActionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: k8Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      postReactionController.commentActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: postReactionController.commentActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  onPressed: () async {
                    Get.back();
                    if (postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                      await postReactionController.deleteComment();
                    }
                    if (postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Hide Comment".toLowerCase()) {
                      await postReactionController.hideComment();
                    }
                    if (postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Update Comment".toLowerCase()) {
                      postReactionController.isUpdateComment.value = true;
                      postReactionController.commentTextEditingController.text =
                          postReactionController.commentList[postReactionController.selectedCommentIndex.value].comment ?? "";
                      if (postReactionController.commentList[postReactionController.selectedCommentIndex.value].image != null) {
                        postReactionController.commentImage.value = postReactionController.commentList[postReactionController.selectedCommentIndex.value].image;
                      }
                      //  await postReactionController.update();
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
