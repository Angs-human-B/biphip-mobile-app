import 'dart:io';

import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/models/post/get_reply_list_model.dart';
import 'package:bip_hip/models/post/post_comment_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_svg/svg.dart';

class PostReactionController extends GetxController with GetSingleTickerProviderStateMixin {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final RxInt selectedBidIndex = RxInt(-1);
  final RxInt selectedGiftIndex = RxInt(-1);
  final RxInt balance = RxInt(200);
  final TextEditingController bidingTextEditingController = TextEditingController();
  final TextEditingController giftAddCommentTextEditingController = TextEditingController();
  final TextEditingController commentTextEditingController = TextEditingController();
  final RxBool isGiftAddCommentSuffixIconVisible = RxBool(false);
  final RxBool isPackageSelected = RxBool(false);
  final Rx<Map?> selectedPackage = Rx<Map?>(null);
  final RxBool giftCheckBox = RxBool(false);
  final RxList gift1 = RxList([]);
  final RxInt badgeCount1 = RxInt(0);
  final RxInt badgeCount2 = RxInt(0);
  final RxInt badgeCount3 = RxInt(0);
  final RxInt badgeCount4 = RxInt(0);
  final RxInt tabIndex = RxInt(-1);
  late TabController tabController;
  final Rx<int?> yourBid = Rx<int?>(null);
  final RxBool showMoreBiddingInsights = RxBool(true);
  final RxDouble perStarAmount = RxDouble(0.09);
  final RxDouble temporarytotalStarBuyAmount = RxDouble(0);
  final RxDouble totalStarBuyAmount = RxDouble(-1);
  final RxString temporaryTotalStars = RxString('');
  final RxString totalStars = RxString('');
  final String perPageTake = "take=15";

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 6,
      animationDuration: Duration.zero,
      vsync: this,
    );
    tabController.addListener(() {
      giftFilter(tabController.index);
    });
  }

  void clearBadgeCount() {
    badgeCount1.value = 0;
    badgeCount2.value = 0;
    badgeCount3.value = 0;
    badgeCount4.value = 0;
  }

  void giftFilter(index) {
    gift1.clear();
    clearBadgeCount();
    for (int i = 0; i < giftContributors.length; i++) {
      if (giftContributors[i]['giftType'] == 'badge1') {
        badgeCount1.value++;
      } else if (giftContributors[i]['giftType'] == 'badge2') {
        badgeCount2.value++;
      } else if (giftContributors[i]['giftType'] == 'badge3') {
        badgeCount3.value++;
      } else if (giftContributors[i]['giftType'] == 'badge4') {
        badgeCount4.value++;
      }
    }
    for (int i = 0; i < giftContributors.length; i++) {
      if (index == 0) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge1' && index == 1) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge2' && index == 2) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge3' && index == 3) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge4' && index == 4) {
        gift1.add(giftContributors[i]);
      }
    }
  }

  //*Star
  final TextEditingController starAmountTextEditingController = TextEditingController();
  final RxBool isStarAmountConfirmButtonEnabled = RxBool(false);
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController mmyyStarController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final RxBool giftAgreeCheckBox = RxBool(false);
  final RxList reactEmojiList = RxList([]);

  List reactionView(map) {
    map.remove('All');
    reactEmojiList.clear();
    List<MapEntry<String, dynamic>> entries = map.entries.toList();
    if (entries.length > 1) {
      entries.sort((a, b) => b.value.compareTo(a.value));
    }

    List<MapEntry<String, dynamic>> topThree = entries.take(3).toList();

    for (int index = 0; index < topThree.length; index++) {
      if (topThree[index].value == 0) {
        continue;
      }
      if (topThree[index].key == 'like') {
        reactEmojiList.add(kiLikeSvgImageUrl);
      } else if (topThree[index].key == 'love') {
        reactEmojiList.add(kiLoveSvgImageUrl);
      } else if (topThree[index].key == 'sad') {
        reactEmojiList.add(kiSadSvgImageUrl);
      } else if (topThree[index].key == 'wow') {
        reactEmojiList.add(kiWowSvgImageUrl);
      } else if (topThree[index].key == 'haha') {
        reactEmojiList.add(kiHahaSvgImageUrl);
      } else if (topThree[index].key == 'angry') {
        reactEmojiList.add(kiAngrySvgImageUrl);
      }
    }
    return reactEmojiList;
  }

  double reactStackWidthGetter() {
    if (reactEmojiList.length == 1) {
      return 15;
    } else if (reactEmojiList.length == 2) {
      return 25;
    } else {
      return 35;
    }
  }

  final RxBool test = RxBool(true);

  List<Map<String, dynamic>> reactions = [];
  final Rx<String> selectedReactionText = Rx<String>("");
  final ScrollController scrollController = ScrollController();
  final RxInt postIndex = RxInt(-1);

  selectedReaction(postIndex) {
    if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'love' ||
        reactions[postIndex]['reaction'].value.toString().toLowerCase() == "Love".toLowerCase()) {
      return SvgPicture.asset(
        kiLoveSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'like' ||
        reactions[postIndex]['reaction'].value.toString().toLowerCase() == "Like".toLowerCase()) {
      return SvgPicture.asset(
        kiLikeSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'haha' ||
        reactions[postIndex]['reaction'].value.toString().toLowerCase() == "Haha".toLowerCase()) {
      return SvgPicture.asset(
        kiHahaSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'wow' ||
        reactions[postIndex]['reaction'].value.toString().toLowerCase() == "Wow".toLowerCase()) {
      return SvgPicture.asset(
        kiWowSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'sad' ||
        reactions[postIndex]['reaction'].value.toString().toLowerCase() == "Sad".toLowerCase()) {
      return SvgPicture.asset(
        kiSadSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'angry'.toLowerCase() ||
        reactions[postIndex]['reaction'].value.toString().toLowerCase() == "Angry".toLowerCase()) {
      return SvgPicture.asset(
        kiAngrySvgImageUrl,
        width: 20,
      );
    }
  }

  final RxBool isCommentSendEnable = RxBool(false);
  final RxBool isReplySendEnable = RxBool(false);
  final RxInt postId = RxInt(-1);

  void function() {
    commentFocusNode.requestFocus();
  }

  void commentSendEnabled() {
    if (commentTextEditingController.text.toString().trim() != "" || isCommentImageChanged.value) {
      isCommentSendEnable.value = true;
    } else {
      isCommentSendEnable.value = false;
    }
  }

  void replySendEnabled() {
    if (replyTextEditingController.text.toString().trim() != "" || isReplyImageChanged.value) {
      isReplySendEnable.value = true;
    } else {
      isReplySendEnable.value = false;
    }
  }

  // selectedReaction(postIndex) {
  //   if (Get.find<HomeController>().allPostList[postIndex].myReaction == 'Love' || selectedReactionText.value == "Love") {
  //     return SvgPicture.asset(
  //       kiLoveSvgImageUrl,
  //       width: 20,
  //     );
  //   } else if (Get.find<HomeController>().allPostList[postIndex].myReaction ==  'Like' || selectedReactionText.value == "Like") {
  //     return SvgPicture.asset(
  //       kiLikeSvgImageUrl,
  //       width: 20,
  //     );
  //   } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Haha') {
  //     return SvgPicture.asset(
  //       kiHahaSvgImageUrl,
  //       width: 20,
  //     );
  //   } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Wow') {
  //     return SvgPicture.asset(
  //       kiWowSvgImageUrl,
  //       width: 20,
  //     );
  //   } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Sad') {
  //     return SvgPicture.asset(
  //       kiSadSvgImageUrl,
  //       width: 20,
  //     );
  //   } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Angry') {
  //     return SvgPicture.asset(
  //       kiAngrySvgImageUrl,
  //       width: 20,
  //     );
  //   }
  // }
  final RxString commentImageLink = RxString('');
  final Rx<File> commentImageFile = File('').obs;
  final RxBool isCommentImageChanged = RxBool(false);
  final RxString replyImageLink = RxString('');
  final Rx<File> replyImageFile = File('').obs;
  final RxBool isReplyImageChanged = RxBool(false);

  //* post Reaction API Implementation
  final RxBool isPostReactionLoading = RxBool(false);
  Future<void> postReaction(int refType, int refId, reaction) async {
    try {
      isPostReactionLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'ref_type': refType.toString(),
        'ref_id': refId.toString(),
        'reaction': reaction.toString().toLowerCase(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSetReaction,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isPostReactionLoading.value = false;
        // globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isPostReactionLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostReactionLoading.value = false;
      ll('postReaction error: $e');
    }
  }

  //* post Reaction API Implementation
  final RxBool isPostCommentLoading = RxBool(false);
  Future<void> postComment(int refType, int refId, context, String commentOrReply) async {
    try {
      isPostCommentLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        if (commentOrReply == "comment") 'ref_type': refType.toString(),
        if (commentOrReply == "comment") 'ref_id': refId.toString(),
        if (commentOrReply == "comment") 'comment': commentTextEditingController.text.toString().trim(),
        if (commentOrReply == "reply") 'reply': commentTextEditingController.text.toString().trim(),
        if (commentOrReply == "reply") 'comment_id': commentId.toString(),
        'mention_user_ids': commentMentionList.join(','),
      };
      var response;
      if (isCommentImageChanged.value != true) {
        response = await apiController.commonApiCall(
          requestMethod: kPost,
          url: commentOrReply == "comment" ? kuSetComment : kuSetReply,
          body: body,
          token: token,
        ) as CommonDM;
      } else {
        response = await apiController.mediaUpload(
          url: commentOrReply == "comment" ? kuSetComment : kuSetReply,
          token: token,
          body: body,
          key: 'image',
          value: commentImageFile.value.path,
        ) as CommonDM;
      }

      if (response.success == true) {
        unfocus(context);
        commentTextEditingController.clear();
        commentMentionList.clear();
        isCommentImageChanged.value = false;
        commentMentionKey.currentState?.controller?.text = "";
        commentImageLink.value = "";
        commentImageFile.value = File("");
        isCommentSendEnable.value = false;
        await getCommentList(1, refId);
        isPostCommentLoading.value = false;
        // globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isPostCommentLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostCommentLoading.value = false;
      ll('postComment error: $e');
    }
  }

  final Rx<ReplyListModel?> replyListData = Rx<ReplyListModel?>(null);
  final RxList<CommentReply> replyList = RxList<CommentReply>([]);
  // final List<Map<String, dynamic>> commentReactions = [];
  // final RxInt commentIndex = RxInt(-1);
  final RxBool isReplyLoading = RxBool(false);
  Future<void> getReplyList(int commentId) async {
    try {
      isReplyLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetReply?commentId=${commentId.toString()}&take=10",
      ) as CommonDM;
      if (response.success == true) {
        replyList.clear();
        replyListData.value = ReplyListModel.fromJson(response.data);
        replyList.addAll(replyListData.value!.commentReplies!.data);
        isReplyLoading.value = false;
      } else {
        isReplyLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReplyLoading.value = true;
      ll('getReplyList error: $e');
    }
  }

  final RxInt refId = RxInt(-1);
  //   //*get Comment Api Call
  final ScrollController commentListScrollController = ScrollController();
  final Rx<PostCommentModel?> commentListData = Rx<PostCommentModel?>(null);
  final RxList<CommentData> commentList = RxList<CommentData>([]);
  final List<Map<String, dynamic>> commentReactions = [];
  final RxInt commentIndex = RxInt(-1);
  final RxBool isCommentLoading = RxBool(false);
  final Rx<String?> getCommentSubLink = Rx<String?>(null);
  final RxBool getCommentScrolled = RxBool(false);
  final RxList<bool> replyShow = RxList<bool>([]);
  Future<void> getCommentList(int refType, int refId) async {
    try {
      isCommentLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetComment?ref_type=${refType.toString()}&ref_id=${refId.toString()}&take=10",
      ) as CommonDM;
      if (response.success == true) {
        commentList.clear();
        replyShow.clear();
        getCommentScrolled.value = false;
        commentListData.value = PostCommentModel.fromJson(response.data);
        commentList.addAll(commentListData.value!.comments!.data);
        for (int i = 0; i < commentList.length; i++) {
          replyShow.add(false);
        }
        // ll("123 ${commentList.length}");
        getCommentSubLink.value = commentListData.value!.comments!.nextPageUrl;
        if (getCommentSubLink.value != null) {
          getCommentScrolled.value = false;
        } else {
          getCommentScrolled.value = true;
        }
        isCommentLoading.value = false;
      } else {
        isCommentLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCommentLoading.value = true;
      ll('getCommentList error: $e');
    }
  }

  //*Get More Comment List for pagination
  Future<void> getMoreCommentList(take, int refType, int refId) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic commentListSub;
      if (getCommentSubLink.value == null) {
        return;
      } else {
        commentListSub = getCommentSubLink.value!.split('?');
      }
      String commentListSuffixUrl = '';

      commentListSuffixUrl = '?${commentListSub[1]}&ref_type=${refType.toString()}&ref_id=${refId.toString()}&take=10';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetComment + commentListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        commentListData.value = PostCommentModel.fromJson(response.data);
        commentList.addAll(commentListData.value!.comments!.data);
        replyShow.clear();
        for (int i = 0; i < commentList.length; i++) {
          replyShow.add(false);
        }
        getCommentSubLink.value = commentListData.value!.comments!.nextPageUrl;
        if (getCommentSubLink.value != null) {
          getCommentScrolled.value = false;
        } else {
          getCommentScrolled.value = true;
        }
        isCommentLoading.value = false;
      } else {
        isCommentLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCommentLoading.value = true;
      ll('getMoreCommentList error: $e');
    }
  }

  void resetPurchaseCustomStar() {
    isStarAmountConfirmButtonEnabled.value = false;
    starAmountTextEditingController.clear();
    temporarytotalStarBuyAmount.value = 0;
    totalStarBuyAmount.value = 0;
    temporaryTotalStars.value = '';
    totalStars.value = '';
  }

  void resetGiftData() {
    selectedBidIndex.value = -1;
    selectedGiftIndex.value = -1;
    balance.value = 200;
    isPackageSelected.value = false;
    giftCheckBox.value = false;
    cardNumberController.clear();
    mmyyStarController.clear();
    cvvController.clear();
    giftAddCommentTextEditingController.clear();
    resetPurchaseCustomStar();
    giftAgreeCheckBox.value = false;
  }

  final RxList commentActionList = RxList([
    {
      'icon': BipHip.edit,
      'action': 'Update Comment',
    },
    {
      'icon': BipHip.circleCrossNew,
      'action': 'Hide Comment',
    },
    {
      'icon': BipHip.deleteNew,
      'action': 'Delete',
    },
    {
      'icon': BipHip.menuFill,
      'action': 'Reply',
    },
  ]);

  final RxList shareActionList = RxList([
    {
      'icon': BipHip.world,
      'action': 'Share to Feed',
    },
    {
      'icon': BipHip.kids,
      'action': 'Share to Your Kids Profile',
    },
    {
      'icon': BipHip.shopFill,
      'action': 'Share to Your Store Profile',
    },
    {
      'icon': Icons.message_rounded,
      'action': 'Send to Messenger',
    },
    {
      'icon': BipHip.webLink,
      'action': 'Copy Link',
    },
  ]);

  final RxList othersCommentActionList = RxList([
    {
      'icon': BipHip.report, //!Icon should change
      'action': 'Report Comment',
    },
    {
      'icon': BipHip.circleCrossNew,
      'action': 'Hide Comment',
    },
    {
      'icon': BipHip.deleteNew,
      'action': 'Delete',
    },
    {
      'icon': BipHip.menuFill,
      'action': 'Reply',
    },
  ]);
  final RxList othersPostOtherUserCommentActionList = RxList([
    {
      'icon': BipHip.report,
      'action': 'Report Comment',
    },
    {
      'icon': BipHip.circleCrossNew,
      'action': 'Hide Comment',
    },
    // {
    //   'icon': BipHip.menuFill,
    //   'action': 'Reply',
    // },
  ]);
  final RxList replyActionList = RxList([
    {
      'icon': BipHip.edit,
      'action': 'Update Reply',
    },
    {
      'icon': BipHip.circleCrossNew,
      'action': 'Hide Reply',
    },
    {
      'icon': BipHip.deleteNew,
      'action': 'Delete',
    },
    // {
    //   'icon': BipHip.menuFill,
    //   'action': 'Reply',
    // },
  ]);
  final RxList othersReplyActionList = RxList([
    {
      'icon': BipHip.report,
      'action': 'Report Reply',
    },
    {
      'icon': BipHip.circleCrossNew,
      'action': 'Hide Reply',
    },
    {
      'icon': BipHip.deleteNew,
      'action': 'Delete',
    },
    // {
    //   'icon': BipHip.menuFill,
    //   'action': 'Reply',
    // },
  ]);
  final RxList othersPostOtherUserReplyActionList = RxList([
    {
      'icon': BipHip.report,
      'action': 'Report Reply',
    },
    {
      'icon': BipHip.circleCrossNew,
      'action': 'Hide Reply',
    },
    // {
    //   'icon': BipHip.menuFill,
    //   'action': 'Reply',
    // },
  ]);

  final RxInt commentId = RxInt(-1);
  final RxInt replyId = RxInt(-1);
  final RxInt selectedCommentIndex = RxInt(-1);
  final RxInt selectedReplyIndex = RxInt(-1);
  final RxString commentImage = RxString("");
  final RxString replyImage = RxString("");

  //*Delete Comment Api Call
  final RxBool isCommentDeleteLoading = RxBool(false);
  Future<void> deleteComment() async {
    try {
      isCommentDeleteLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteComment/${commentId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        await getCommentList(1, refId.value);
        isCommentDeleteLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isCommentDeleteLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCommentDeleteLoading.value = false;
      ll('deleteComment error: $e');
    }
  }

  //*Hide Comment Api Call
  final RxBool isCommentHideLoading = RxBool(false);
  Future<void> hideComment() async {
    try {
      isCommentHideLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: '$kuHideComment/${commentId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        // for (int index = 0; index <= commentList.length; index++) {
        //   if (commentId.value == commentList[index].id) {
        //     commentList.removeAt(index);
        //   }
        // }
        // await getCommentList(1, refId.value);
        isCommentHideLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isCommentHideLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCommentHideLoading.value = false;
      ll('hideComment error: $e');
    }
  }

  //*Update Comment Api Call
  final RxBool isUpdateComment = RxBool(false);
  final RxBool isUpdateCommentLoading = RxBool(false);
  Future<void> updateComment(context) async {
    try {
      isUpdateCommentLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'comment': commentTextEditingController.text.toString().trim(),
        'mention_user_ids': commentMentionList.join(','),
      };
      var response;
      if (isCommentImageChanged.value != true) {
        response = await apiController.commonApiCall(
          requestMethod: kPut,
          url: '$kuUpdateComment/${commentId.value.toString()}?_method=PUT',
          body: body,
          token: token,
        ) as CommonDM;
      } else {
        response = await apiController.mediaUpload(
          url: '$kuUpdateComment/${commentId.value.toString()}?_method=PUT',
          token: token,
          body: body,
          key: 'image',
          value: commentImageFile.value.path,
        ) as CommonDM;
      }
      if (response.success == true) {
        unFocus(context);
        await getCommentList(1, refId.value);
        isUpdateComment.value = false;
        commentTextEditingController.clear();
        commentMentionKey.currentState?.controller?.text = "";
        commentImage.value = "";
        commentMentionList.clear();
        isCommentImageChanged.value = false;
        commentImageLink.value = "";
        commentImageFile.value = File("");
        isCommentSendEnable.value = false;
        isUpdateCommentLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isUpdateCommentLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUpdateCommentLoading.value = false;
      ll('updateComment error: $e');
    }
  }

  final TextEditingController replyTextEditingController = TextEditingController();

  //*Delete Reply Api Call
  final RxBool isReplyDeleteLoading = RxBool(false);
  Future<void> deleteReply() async {
    try {
      isReplyDeleteLoading.value = true;
      String? token = await spController.getBearerToken();
      // Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteReply/${replyId.value.toString()}',
        // body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        await getCommentList(1, refId.value);
        isReplyDeleteLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isReplyDeleteLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReplyDeleteLoading.value = false;
      ll('deleteReply error: $e');
    }
  }

  //*Hide Reply Api Call
  final RxBool isReplyHideLoading = RxBool(false);
  Future<void> hideReply() async {
    try {
      isReplyHideLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: '$kuHideReply/${replyId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        await getCommentList(1, refId.value);
        isReplyHideLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isReplyHideLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReplyHideLoading.value = false;
      ll('hideReply error: $e');
    }
  }

  //* post Reaction API Implementation
  final RxBool isPostReplyLoading = RxBool(false);
  Future<void> postReply(context) async {
    try {
      isPostReplyLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'comment_id': commentId.toString(),
        'reply': replyTextEditingController.text.toString().trim(),
        'mention_user_ids': commentMentionList.join(','),
      };
      var response;
      if (isReplyImageChanged.value != true) {
        response = await apiController.commonApiCall(
          requestMethod: kPost,
          url: kuSetReply,
          body: body,
          token: token,
        ) as CommonDM;
      } else {
        response = await apiController.mediaUpload(
          url: kuSetReply,
          token: token,
          body: body,
          key: 'image',
          value: replyImageFile.value.path,
        ) as CommonDM;
      }

      if (response.success == true) {
        unFocus(context);
        replyTextEditingController.clear();
        // replyMentionList.clear();
        isReplyImageChanged.value = false;
        replyImageLink.value = "";
        replyImageFile.value = File("");
        isReplySendEnable.value = false;
        commentId.value = -1;
        await getCommentList(1, refId.value);
        isPostReplyLoading.value = false;
        // globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isPostReplyLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostReplyLoading.value = false;
      ll('postReply error: $e');
    }
  }

  //*Update Reply Api Call
  final RxBool isUpdateReply = RxBool(false);
  final RxBool isUpdateReplyLoading = RxBool(false);
  Future<void> updateReply(context) async {
    try {
      isUpdateReplyLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'reply': commentTextEditingController.text.toString().trim(),
        'mention_user_ids': commentMentionList.join(','),
      };
      ll(replyImageFile.value);
      var response;
      if (isReplyImageChanged.value != true) {
        response = await apiController.commonApiCall(
          requestMethod: kPut,
          url: '$kuUpdateReply/${replyId.value.toString()}?_method=PUT',
          body: body,
          token: token,
        ) as CommonDM;
      } else {
        response = await apiController.mediaUpload(
          url: '$kuUpdateReply/${replyId.value.toString()}?_method=PUT',
          token: token,
          body: body,
          key: 'image',
          value: replyImageFile.value.path,
        ) as CommonDM;
      }
      if (response.success == true) {
        unFocus(context);
        await getCommentList(1, refId.value);
        isUpdateReply.value = false;
        replyTextEditingController.clear();
        commentMentionKey.currentState?.controller?.text = "";
        commentImage.value = "";
        // isReplyImageChanged.value = false;
        // replyImageLink.value = "";
        // replyImageFile.value = File("");
        // isReplySendEnable.value = false;
        isCommentImageChanged.value = false;
        commentImageLink.value = "";
        commentImageFile.value = File("");
        isCommentSendEnable.value = false;
        isUpdateReplyLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isUpdateReplyLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUpdateReplyLoading.value = false;
      ll('updateReply error: $e');
    }
  }

  final RxInt userId = RxInt(-1);
  final RxInt commentedUserId = RxInt(-1);
  final RxInt replyUserId = RxInt(-1);

  final FocusNode commentFocusNode = FocusNode();
  final GlobalKey<FlutterMentionsState> commentMentionKey = GlobalKey<FlutterMentionsState>();
  final RxList commentMentionList = RxList([]);

  //* Format for update comment and reply
  String formatComment(String text) {
    final RegExp pattern = RegExp(r'@\[(.*?)\]\((\d+)\)');
    final Iterable<Match> matches = pattern.allMatches(text);

    List<String> parts = [];

    int lastEnd = 0;
    for (var match in matches) {
      parts.add(text.substring(lastEnd, match.start));

      for (int i = 0; i < commentList.length; i++) {
        Get.find<FriendController>().mentionsList.removeWhere((map) => map['id'] == commentList[i].user!.id.toString());
        if (Get.find<GlobalController>().userId.value != commentList[i].user!.id) {
          Map<String, dynamic> friendMap = {
            'id': commentList[i].user!.id.toString(),
            'display': commentList[i].user!.fullName,
            'full_name': commentList[i].user!.fullName,
            'photo': commentList[i].user!.profilePicture,
          };
          Get.find<FriendController>().mentionsList.add(friendMap);
          commentMentionKey.currentState?.controller?.text = "@${commentList[i].user?.fullName} ";
        }
        commentId.value = commentList[i].id!;
      }
      parts.add('@${match.group(1)}');
      lastEnd = match.end;
    }
    parts.add(text.substring(lastEnd));
    return parts.join(' ');
  }

  //* Format the mention data
  Widget formatMentions(String text, BuildContext context) {
    final RegExp mentionPattern = RegExp(r'@\[([^\]]+)\]\([^\)]+\)');

    final Iterable<RegExpMatch> matches = mentionPattern.allMatches(text);
    List<TextSpan> spans = [];
    int startIndex = 0;
    for (final match in matches) {
      if (match.start > startIndex) {
        spans.add(TextSpan(text: text.substring(startIndex, match.start)));
      }
      final username = match.group(1)!;
      spans.add(TextSpan(
        text: username,
        style: semiBold14TextStyle(cPrimaryColor),
      ));
      startIndex = match.end;
    }
    if (startIndex < text.length) {
      spans.add(TextSpan(text: text.substring(startIndex)));
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }

  //* post Reaction API Implementation
  final RxBool isGiftStarLoading = RxBool(false);
  Future<void> giftStar(String star) async {
    try {
      isGiftStarLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'post_id': postId.value.toString(),
        'star': star.toString(),
        'comment': giftAddCommentTextEditingController.text.toString().trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuGiftStar,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        // unFocus(context);
        giftAddCommentTextEditingController.clear();
        isGiftStarLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isGiftStarLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isGiftStarLoading.value = false;
      ll('postReply error: $e');
    }
  }

  void resetCommentAndReplyData() {
    commentTextEditingController.clear();
    isCommentImageChanged.value = false;
    commentImageLink.value = "";
    commentImageFile.value = File("");
    isCommentSendEnable.value = false;
    replyTextEditingController.clear();
    isReplyImageChanged.value = false;
    replyImageLink.value = "";
    replyImageFile.value = File("");
    isReplySendEnable.value = false;
    isUpdateComment.value = false;
    isUpdateReply.value = false;
    commentId.value = -1;
    replyId.value = -1;
    userId.value = -1;
    commentedUserId.value = -1;
    commentImage.value = "";
    replyImage.value = "";
    commentMentionList.clear();
  }
}
