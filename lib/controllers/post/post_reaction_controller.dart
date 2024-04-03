import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/models/post/post_comment_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
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
    ll(entries);
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
      } else {
        reactEmojiList.add(kiAngrySvgImageUrl);
      }
    }
    // ll(reactEmojiList);
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
    if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'love' || reactions[postIndex]['reaction'].value == "Love") {
      return SvgPicture.asset(
        kiLoveSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'like' ||
        reactions[postIndex]['reaction'].value == "Like") {
      return SvgPicture.asset(
        kiLikeSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'haha' ||
        reactions[postIndex]['reaction'].value == "Haha") {
      return SvgPicture.asset(
        kiHahaSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'wow' ||
        reactions[postIndex]['reaction'].value == "Wow") {
      return SvgPicture.asset(
        kiWowSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction.toString().toLowerCase() == 'sad' ||
        reactions[postIndex]['reaction'].value == "Sad") {
      return SvgPicture.asset(
        kiSadSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<HomeController>().allPostList[postIndex].myReaction == 'angry' || selectedReactionText.value == "Angry") {
      return SvgPicture.asset(
        kiAngrySvgImageUrl,
        width: 20,
      );
    }
  }

  final RxBool isCommentSendEnable = RxBool(false);

  void commentSendEnabled() {
    if (commentTextEditingController.text.toString().trim() == "") {
      isCommentSendEnable.value = false;
    } else {
      isCommentSendEnable.value = true;
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

  //* post Reaction API Implementation
  final RxBool isPostReactionLoading = RxBool(false);
  Future<void> postReaction(int refType, int refId) async {
    try {
      isPostReactionLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'ref_type': refType.toString(),
        'ref_id': refId.toString(),
        'reaction': selectedReactionText.value.toString().toLowerCase(),
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
  Future<void> postComment(int refType, int refId) async {
    try {
      isPostCommentLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'ref_type': refType.toString(),
        'ref_id': refId.toString(),
        'comment': commentTextEditingController.text.toString().trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSetComment,
        body: body,
        token: token,
      ) as CommonDM;
      //   var response = await apiController.mediaUpload(
      //   url: kuSetComment,
      //   token: token,
      //   body: body,
      //   key: "image",
      //   // value: imageFile.path,
      // ) as CommonDM;

      if (response.success == true) {
        commentTextEditingController.clear();
        isCommentSendEnable.value = false;
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

  //   //*get Comment Api Call
  final Rx<PostCommentModel?> commentListData = Rx<PostCommentModel?>(null);
  final RxList<CommentData> commentList = RxList<CommentData>([]);
  final RxBool isCommentLoading = RxBool(false);
  Future<void> getCommentList(int refType, int refId) async {
    try {
      isCommentLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetComment?ref_type=${refType.toString()}&ref_id=${refId.toString()}",
      ) as CommonDM;
      if (response.success == true) {
        commentList.clear();
        commentListData.value = PostCommentModel.fromJson(response.data);
        commentList.addAll(commentListData.value!.data);
        isCommentLoading.value = false;
      } else {
        isCommentLoading.value = true;
        // ErrorModel errorModel = ErrorModel.fromJson(response.data);
        // if (errorModel.errors.isEmpty) {
        //   globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        // } else {
        //   globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        // }
      }
    } catch (e) {
      isCommentLoading.value = true;
      ll('getCommentList error: $e');
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
}
