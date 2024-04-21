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
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class HomePostDetails extends StatelessWidget {
  HomePostDetails(
      {super.key,
      this.postIndex = 0,
      this.userName,
      this.userImage,
      this.postTime,
      this.category,
      this.categoryIcon,
      this.categoryIconColor,
      this.kidName,
      this.kidAge,
      this.brandName,
      this.secondaryImage,
      this.images,
      this.postText,
      this.title,
      this.refId = 0});
  final int postIndex;
  final int refId;
  final String? userName;
  final String? userImage;
  final DateTime? postTime;
  final String? category;
  final IconData? categoryIcon;
  final Color? categoryIconColor;
  final String? kidName;
  final String? kidAge;
  final String? brandName;
  final String? secondaryImage;
  final String? postText;
  final String? title;
  final List? images;

  final HomeController homeController = Get.find<HomeController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.isPostDetailsPageLoading.value
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
                            title: userName ?? ksNA.tr,
                            onBack: () {
                              Get.back();
                            },
                          ),
                        ),

                        // floatingActionButton: Container(
                        //   decoration: const BoxDecoration(color: cWhiteColor, border: Border(top: BorderSide(color: cLineColor))),
                        //   padding: EdgeInsets.zero,
                        //   // height: 120,
                        //   // child: Padding(
                        //   //   padding: const EdgeInsets.symmetric(
                        //   //     vertical: k12Padding,
                        //   //     horizontal: k20Padding,
                        //   //   ),
                        //   //   child: CommentTextField(
                        //   //     hintText: '${ksWriteAComment.tr} ...',
                        //   //   ),
                        //   // ),
                        //   child: SizedBox(
                        //       width: width - 40,
                        //       height: 108,
                        //       child: CommentTextField(
                        //         hintText: "${ksWriteAComment.tr} ...",
                        //         onPressedCamera: () async {
                        //           await Get.find<GlobalController>().selectImageSource(postReactionController.isCommentImageChanged,
                        //               postReactionController.commentImageLink, postReactionController.commentImageFile, 'gallery', false);
                        //           postReactionController.commentSendEnabled();
                        //         },
                        //         onPressedSend: () async {
                        //           if (postReactionController.isUpdateComment.value) {
                        //             await Get.find<PostReactionController>().updateComment();
                        //           } else {
                        //             await Get.find<PostReactionController>().postComment(1, postReactionController.refId.value);
                        //           }
                        //         },
                        //       )),
                        // ),
                        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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
                                      taggedFriend: const [],
                                      userName: userName ?? ksNA.tr,
                                      isCategorized: false,
                                      privacy: BipHip.world,
                                      postTime: homeController.postTimeDifference(postTime ?? DateTime.now()),
                                      userImage: userImage ?? "",
                                      category: category,
                                      categoryIcon: categoryIcon,
                                      categoryIconColor: categoryIconColor,
                                      kidName: kidName, //API
                                      kidAge: kidAge, //API
                                      brandName: brandName, //API
                                      secondaryImage: secondaryImage,
                                    ),
                                  ),
                                  kH12sizedBox,
                                  CommonPostDetailsWidget(
                                    mediaList: images ?? [],
                                    isCommentShown: true,
                                    showBottomSection: true,
                                    postIndex: postIndex,
                                    postText: postText ?? '', //API
                                    title: title, //API
                                    refType: 1,
                                    refId: refId,
                                  ),
                                  // CommonPostDetailsWidget(//!Not used now
                                  //   mediaList: homeController.postData.value!.post.images,
                                  //   isCommentShown: true,
                                  //   showBottomSection: true,
                                  //   postIndex: postIndex,
                                  //   postText: homeController.postData.value!.post.postCategory?.name == 'News'
                                  //       ? homeController.postData.value!.post.description ?? ''
                                  //       : homeController.postData.value!.post.content ?? '', //API
                                  //   // title: homeController.postData.value!.post.title, //API
                                  //   title: homeController.postData.value!.post.title, //API
                                  // ),
                                  // SizedBox(
                                  //     width: width - 40,
                                  //     height: 108,
                                  //     child: CommentTextField(
                                  //       hintText: "${ksWriteAComment.tr} ...",
                                  //       onPressedCamera: () async {
                                  //         await Get.find<GlobalController>().selectImageSource(postReactionController.isCommentImageChanged,
                                  //             postReactionController.commentImageLink, postReactionController.commentImageFile, 'gallery', false);
                                  //         postReactionController.commentSendEnabled();
                                  //       },
                                  //       onPressedSend: () async {
                                  //         if (postReactionController.isUpdateComment.value) {
                                  //           await Get.find<PostReactionController>().updateComment();
                                  //         } else {
                                  //           await Get.find<PostReactionController>().postComment(1, postReactionController.refId.value);
                                  //         }
                                  //       },
                                  //     )),
                                  const SizedBox(
                                    height: 110,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // body: SizedBox(
                        //   height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                        //   child: SingleChildScrollView(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(top: k12Padding),
                        //       child: Column(
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        //             child: PostUpperContainer(
                        //               taggedFriend: homeController.postData.value?.post.taggedFriends,
                        //               userName: homeController.postData.value?.post.user?.fullName ?? ksNA.tr,
                        //               isCategorized: false,
                        //               privacy: BipHip.world,
                        //               postTime: homeController.postTimeDifference(homeController.postData.value!.post.createdAt),
                        //               userImage: homeController.postData.value!.post.user!.profilePicture.toString(),
                        //               category: homeController.postData.value?.post.postCategory == null
                        //                   ? null
                        //                   : homeController.postData.value?.post.postCategory?.name ?? "",
                        //               categoryIcon: homeController.postData.value!.post.postCategory == null
                        //                   ? null
                        //                   : homeController.getCategoryIcon(homeController.postData.value!.post.postCategory?.id),
                        //               categoryIconColor: homeController.postData.value!.post.postCategory == null
                        //                   ? null
                        //                   : homeController.getCategoryColor(homeController.postData.value!.post.postCategory?.id),
                        //               kidName: homeController.postData.value!.post.kid == null ? null : homeController.postData.value!.post.kid!.name, //API
                        //               kidAge: homeController.postData.value!.post.kid == null
                        //                   ? null
                        //                   : homeController.postData.value!.post.kid!.age.toString(), //API
                        //               brandName:
                        //                   homeController.postData.value!.post.store == null ? null : homeController.postData.value!.post.store!.name, //API
                        //               secondaryImage:
                        //                   homeController.postData.value!.post.kid?.profilePicture ?? homeController.postData.value!.post.store?.profilePicture,
                        //             ),
                        //           ),
                        //           kH12sizedBox,
                        //           CommonPostDetailsWidget(
                        //             mediaList: images,
                        //             isCommentShown: true,
                        //             showBottomSection: true,
                        //             postIndex: postIndex,
                        //             postText: homeController.postData.value!.post.postCategory?.name == 'News'
                        //                 ? homeController.postData.value!.post.description ?? ''
                        //                 : homeController.postData.value!.post.content ?? '', //API
                        //             // title: homeController.postData.value!.post.title, //API
                        //             title: homeController.postData.value!.post.title, //API
                        //           ),
                        //           // CommonPostDetailsWidget(
                        //           //   mediaList: homeController.postData.value!.post.images,
                        //           //   isCommentShown: true,
                        //           //   showBottomSection: true,
                        //           //   postIndex: postIndex,
                        //           //   postText: homeController.postData.value!.post.postCategory?.name == 'News'
                        //           //       ? homeController.postData.value!.post.description ?? ''
                        //           //       : homeController.postData.value!.post.content ?? '', //API
                        //           //   // title: homeController.postData.value!.post.title, //API
                        //           //   title: homeController.postData.value!.post.title, //API
                        //           // ),
                        //           const SizedBox(
                        //             height: 110,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  if (postReactionController.isCommentDeleteLoading.value ||
                      postReactionController.isCommentHideLoading.value ||
                      postReactionController.isPostCommentLoading.value ||
                      postReactionController.isUpdateCommentLoading.value ||
                      postReactionController.isReplyDeleteLoading.value ||
                      postReactionController.isReplyHideLoading.value ||
                      postReactionController.isPostReplyLoading.value ||
                      postReactionController.isUpdateReplyLoading.value)
                    Positioned(
                      child: CommonLoadingAnimation(
                        onWillPop: () async {
                          if (postReactionController.isCommentDeleteLoading.value ||
                              postReactionController.isCommentHideLoading.value ||
                              postReactionController.isPostCommentLoading.value ||
                              postReactionController.isUpdateCommentLoading.value ||
                              postReactionController.isReplyDeleteLoading.value ||
                              postReactionController.isReplyHideLoading.value ||
                              postReactionController.isPostReplyLoading.value ||
                              postReactionController.isUpdateReplyLoading.value) {
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
    return Obx(
      () => Column(
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
          postReactionController.isCommentLoading.value
              ? Padding(
                  padding: const EdgeInsets.only(bottom: k8Padding, top: k8Padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerCommon(
                        widget: Container(height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: LikeSectionWidget(
                    postIndex: postIndex,
                    refType: 1,
                    refId: postReactionController.postId.value,
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
          SizedBox(
              width: width - 40,
              height: 130,
              child: CommentTextField(
                hintText: "${ksWriteAComment.tr} ...",
                onPressedCamera: () async {
                  await Get.find<GlobalController>().selectImageSource(postReactionController.isCommentImageChanged, postReactionController.commentImageLink,
                      postReactionController.commentImageFile, 'gallery', false);
                  postReactionController.commentSendEnabled();
                },
                onPressedSend: postReactionController.isCommentSendEnable.value
                    ? () async {
                        if (postReactionController.isUpdateComment.value) {
                          await postReactionController.updateComment(context);
                          postReactionController.commentMentionKey.currentState!.controller!.text = "";
                        } else {
                          await postReactionController.postComment(1, postReactionController.refId.value, context);
                          postReactionController.commentMentionKey.currentState!.controller!.text = "";
                        }
                      }
                    : null,
              )),
          kH12sizedBox,
          // for (int i = 0; i < postReactionController.commentList.length; i++)
          postReactionController.isCommentLoading.value
              ? const CommentCommonShimmer()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: postReactionController.commentList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: CommentWidget(
                        commentOnPressed: () {
                          postReactionController.commentId.value = postReactionController.commentList[i].id!;
                          postReactionController.selectedCommentIndex.value = i;
                          postReactionController.commentedUserId.value = postReactionController.commentList[i].user!.id!;
                          postReactionController.isUpdateReply.value = false;
                          postReactionController.isReplyTextFieldShow.value = false;
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
                        profileImage: postReactionController.commentList[i].user?.profilePicture ?? "",
                        // comment: postReactionController.commentList[i].comment ?? "",
                        selfReaction: postReactionController.commentList[i].myReaction,
                        onLikePressed: (Reaction<String>? reaction) {
                          postReactionController.commentList[i].myReaction = globalController.getReaction(
                              postReactionController.commentList[i].myReaction, "like", refType, postReactionController.commentList[i].id);
                          postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
                        },
                        onLovePressed: (Reaction<String>? reaction) {
                          postReactionController.commentList[i].myReaction = globalController.getReaction(
                              postReactionController.commentList[i].myReaction, "love", refType, postReactionController.commentList[i].id);
                          postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
                        },
                        onHahaPressed: (Reaction<String>? reaction) {
                          postReactionController.commentList[i].myReaction = globalController.getReaction(
                              postReactionController.commentList[i].myReaction, "haha", refType, postReactionController.commentList[i].id);
                          postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
                        },
                        onSadPressed: (Reaction<String>? reaction) {
                          postReactionController.commentList[i].myReaction = globalController.getReaction(
                              postReactionController.commentList[i].myReaction, "sad", refType, postReactionController.commentList[i].id);
                          postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
                        },
                        onAngryPressed: (Reaction<String>? reaction) {
                          postReactionController.commentList[i].myReaction = globalController.getReaction(
                              postReactionController.commentList[i].myReaction, "angry", refType, postReactionController.commentList[i].id);
                          postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
                        },
                        onWowPressed: (Reaction<String>? reaction) {
                          postReactionController.commentList[i].myReaction = globalController.getReaction(
                              postReactionController.commentList[i].myReaction, "wow", refType, postReactionController.commentList[i].id);
                          postReactionController.commentList.replaceRange(i, i + 1, [postReactionController.commentList[i]]);
                        },
                        comment: postReactionController.formatMentions(postReactionController.commentList[i].comment ?? "", context),
                        timePassed: Get.find<HomeController>().postTimeDifference(postReactionController.commentList[i].createdAt),
                        isLikeButtonShown: true,
                        commentId: postReactionController.commentList[i].id,
                        commentLink: 'https://itnext.io/showing-url-preview-in-flutter-a3ad4ff9927e',
                        isReplyButtonShown: true,
                        isReactButtonShown: true,
                        isImageComment: true,
                        image: postReactionController.commentList[i].image,
                        isLink: false,
                        reactCount: 1234,
                        userName: postReactionController.commentList[i].user?.fullName ?? ksNA.tr,
                        isSendMessageShown: false,
                        isHideButtonShown: true,
                        replyList: postReactionController.commentList[i].commentReplies,
                        refType: refType,
                        refId: postReactionController.commentList[i].id!,
                        likeButtonOnPressed: () {},
                        hideButtonOnPressed: () async {
                          postReactionController.commentId.value = postReactionController.commentList[i].id!;
                          await postReactionController.hideComment();
                        },
                        replyButtonOnPressed: () async {
                          postReactionController.commentId.value = postReactionController.commentList[i].id!;
                          postReactionController.isReplyTextFieldShow.value = true;
                          postReactionController.replyFocusNode.requestFocus();
                        },
                      ),
                    );
                  })

          //   ));
          // },
          // separatorBuilder: (context, index) => kH4sizedBox,
          // itemCount: postReactionController.commentList.length),
          // SizedBox(
          //     width: width - 40,
          //     height: 108,
          //     child: CommentTextField(
          //       hintText: "${ksWriteAComment.tr} ...",
          //       onPressedCamera: () async {
          //         await globalController.selectImageSource(postReactionController.isCommentImageChanged, postReactionController.commentImageLink,
          //             postReactionController.commentImageFile, 'gallery', false);
          //         postReactionController.commentSendEnabled();
          //       },
          //       onPressedSend: () async {
          //         if (postReactionController.isUpdateComment.value) {
          //           await Get.find<PostReactionController>().updateComment();
          //         } else {
          //           await Get.find<PostReactionController>().postComment(1, postReactionController.refId.value);
          //         }
          //       },
          //     )),
        ],
      ),
    );
  }
}

class CommentBottomSheetContent extends StatelessWidget {
  CommentBottomSheetContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            kH16sizedBox,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: postReactionController.userId.value == postReactionController.commentedUserId.value
                  ? postReactionController.commentActionList.length
                  : postReactionController.othersCommentActionList.length,
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
                          postReactionController.userId.value == postReactionController.commentedUserId.value
                              ? postReactionController.commentActionList[index]['icon']
                              : postReactionController.othersCommentActionList[index]['icon'],
                          color: cBlackColor,
                          size: isDeviceScreenLarge() ? h18 : h14,
                        ),
                      ),
                      title: postReactionController.userId.value == postReactionController.commentedUserId.value
                          ? postReactionController.commentActionList[index]['action'].toString().tr
                          : postReactionController.othersCommentActionList[index]['action'].toString().tr,
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
                        // if (postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Update Comment".toLowerCase()) {
                        //   postReactionController.isReplyTextFieldShow.value = false;
                        //   postReactionController.isUpdateComment.value = true;
                        //   postReactionController.commentTextEditingController.text =
                        //       postReactionController.commentList[postReactionController.selectedCommentIndex.value].comment ?? "";
                        //   if (postReactionController.commentList[postReactionController.selectedCommentIndex.value].image != null) {
                        //     postReactionController.commentImage.value =
                        //         postReactionController.commentList[postReactionController.selectedCommentIndex.value].image;
                        //   }
                        // }
                        if (postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Update Comment".toLowerCase()) {
                          postReactionController.isReplyTextFieldShow.value = false;
                          postReactionController.isUpdateComment.value = true;

                          postReactionController.commentTextEditingController.text =
                              postReactionController.commentList[postReactionController.selectedCommentIndex.value].comment ?? "";
                          postReactionController.commentMentionKey.currentState!.controller!.text =
                              postReactionController.commentList[postReactionController.selectedCommentIndex.value].comment!;
                          if (postReactionController.commentList[postReactionController.selectedCommentIndex.value].image != null) {
                            postReactionController.commentImage.value =
                                postReactionController.commentList[postReactionController.selectedCommentIndex.value].image;
                          }
                          postReactionController.commentFocusNode.requestFocus();
                        }

                        if (postReactionController.commentActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase()) {
                          postReactionController.isReplyTextFieldShow.value = true;
                          postReactionController.commentTextEditingController.text = "";
                          postReactionController.replyFocusNode.requestFocus();
                        }
                        //*Others user post action
                        if (postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Report Comment".toLowerCase()) {}
                        if (postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Reply".toLowerCase()) {
                          postReactionController.isReplyTextFieldShow.value = true;
                          postReactionController.commentTextEditingController.text = "";
                          postReactionController.replyFocusNode.requestFocus();
                        }
                        // if (postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                        //   await postReactionController.deleteComment();
                        // }
                        if (postReactionController.othersCommentActionList[index]['action'].toString().toLowerCase() == "Hide Comment".toLowerCase()) {
                          await postReactionController.hideComment();
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class ReplyBottomSheetContent extends StatelessWidget {
  ReplyBottomSheetContent({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: postReactionController.replyActionList.length,
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
                      postReactionController.replyActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: postReactionController.replyActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  onPressed: () async {
                    Get.back();
                    if (postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Delete".toLowerCase()) {
                      postReactionController.isReplyTextFieldShow.value = false;
                      await postReactionController.deleteReply();
                    }
                    if (postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Hide Reply".toLowerCase()) {
                      postReactionController.isReplyTextFieldShow.value = false;
                      await postReactionController.hideReply();
                    }
                    if (postReactionController.replyActionList[index]['action'].toString().toLowerCase() == "Update Reply".toLowerCase()) {
                      postReactionController.isReplyTextFieldShow.value = true;
                      postReactionController.isUpdateReply.value = true;
                      for (int i = 0; i < postReactionController.commentList.length; i++) {
                        for (int j = 0; j < postReactionController.commentList[i].commentReplies.length; j++) {
                          if (postReactionController.replyId.value == postReactionController.commentList[i].commentReplies[j].id) {
                            postReactionController.replyTextEditingController.text = postReactionController.commentList[i].commentReplies[j].reply ?? "";
                            // ll(postReactionController.commentList[postReactionController.selectedCommentIndex.value].commentReplies[j].image);
                            if (postReactionController.commentList[i].commentReplies[j].image != null) {
                              postReactionController.replyImage.value = postReactionController.commentList[i].commentReplies[j].image;
                            }
                            postReactionController.replyFocusNode.requestFocus();
                          }
                        }
                      }
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

class CommentCommonShimmer extends StatelessWidget {
  const CommentCommonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
