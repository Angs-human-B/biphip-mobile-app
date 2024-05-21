import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/menu/birthday/birthday_model.dart';
import 'package:bip_hip/models/menu/badges/user_badge_model.dart';
import 'package:bip_hip/models/menu/pendent/user_pendent_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';

class PendentBadgesController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final RxInt selectedPendentIndex = RxInt(-1);
  final RxInt selectedBadgeIndex = RxInt(-1);
  final RxBool pendentCheckBox = RxBool(false);
  final RxBool paymentCheckBox = RxBool(false);
  final TextEditingController cardNumberTextEditingController = TextEditingController();
  final TextEditingController mmYYTextEditingController = TextEditingController();
  final TextEditingController cvvTextEditingController = TextEditingController();
  final TextEditingController badgesCardNumberTextEditingController = TextEditingController();
  final TextEditingController badgesMMYYTextEditingController = TextEditingController();
  final TextEditingController badgesCvvTextEditingController = TextEditingController();

  final benefitsList = [
    "Pendent that you purchase here are kept in your balance",
    "You can send stars from your balance at any time",
    "Pendent that you purchase here are kept in your balance"
  ];

  final RxBool badgesCheckBox = RxBool(false);
  final RxBool badgesPaymentCheckBox = RxBool(false);
  final RxDouble temporarytotalStarBuyAmount = RxDouble(0);
  final RxDouble totalStarBuyAmount = RxDouble(0);
  final RxString temporaryTotalStars = RxString('');
  final RxString totalStars = RxString('');
  final RxBool isStarAmountConfirmButtonEnabled = RxBool(false);
  final TextEditingController starAmountTextEditingController = TextEditingController();
  final RxString selectedBadgeIcon = RxString('');
  final RxString selectedBadgeStar = RxString('');
  final RxString selectedBadgePrice = RxString('');
  final RxString selectedBadgeDescription = RxString('');
  final RxBool isPackageSelected = RxBool(false);

  void resetPurchaseCustomStar() {
    isStarAmountConfirmButtonEnabled.value = false;
    starAmountTextEditingController.clear();
    temporarytotalStarBuyAmount.value = 0;
    totalStarBuyAmount.value = 0;
    temporaryTotalStars.value = '';
    totalStars.value = '';
  }

  void resetPendentData() {
    selectedPendentIndex.value = -1;
    pendentCheckBox.value = false;
    paymentCheckBox.value = false;
    cardNumberTextEditingController.clear();
    mmYYTextEditingController.clear();
    cvvTextEditingController.clear();
  }

  void resetBadgesData() {
    selectedBadgeIndex.value = -1;
    badgesCheckBox.value = false;
    badgesPaymentCheckBox.value = false;
    badgesCardNumberTextEditingController.clear();
    badgesMMYYTextEditingController.clear();
    badgesCvvTextEditingController.clear();
    temporarytotalStarBuyAmount.value = 0;
    totalStarBuyAmount.value = 0;
    temporaryTotalStars.value = '';
    totalStars.value = '';
    isStarAmountConfirmButtonEnabled.value = false;
    starAmountTextEditingController.clear();
    isPackageSelected.value = false;
    Get.find<PostReactionController>().giftAddCommentTextEditingController.clear();
    Get.find<PostReactionController>().isGiftAddCommentSuffixIconVisible.value = false;
  }

  //*User Pendent Api call
  final Rx<UserPendentModel?> userPendentData = Rx<UserPendentModel?>(null);
  final RxList<UserPendent> userPendentList = RxList<UserPendent>([]);
  final RxList<Pendent> recommendedPendentList = RxList<Pendent>([]);
  final RxList<Pendent> allPendentList = RxList<Pendent>([]);
  final RxBool isUserPendentLoading = RxBool(false);
  Future<void> getUserPendent() async {
    try {
      isUserPendentLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuUserPendent,
      ) as CommonDM;
      if (response.success == true) {
        userPendentList.clear();
        recommendedPendentList.clear();
        allPendentList.clear();
        userPendentData.value = UserPendentModel.fromJson(response.data);
        userPendentList.addAll(userPendentData.value!.userPendents);
        recommendedPendentList.addAll(userPendentData.value!.recommendedPendents);
        allPendentList.addAll(userPendentData.value!.allPendents);
        isUserPendentLoading.value = false;
      } else {
        isUserPendentLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUserPendentLoading.value = true;
      ll('getUserPendent error: $e');
    }
  }

  final RxInt pendentId = RxInt(-1);
  final RxBool isBuyPendentLoading = RxBool(false);
  Future<void> buyPendent() async {
    try {
      isBuyPendentLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'pendent_id': pendentId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSetUserPendent,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        await getUserPendent();
        isBuyPendentLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isBuyPendentLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isBuyPendentLoading.value = false;
      ll('buyPendent error: $e');
    }
  }

  //*User Badges Api call
  final Rx<UserBadgesModel?> userBadgesData = Rx<UserBadgesModel?>(null);
  final RxList<Badges> recommendedBadgesList = RxList<Badges>([]);
  final RxList<Badges> allBadgesList = RxList<Badges>([]);
  final RxList<Badges> popularBadgesList = RxList<Badges>([]);
  final RxBool isUserBadgeLoading = RxBool(false);
  Future<void> getUserBadges() async {
    try {
      isUserBadgeLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuUserBadges,
      ) as CommonDM;
      if (response.success == true) {
        recommendedBadgesList.clear();
        allBadgesList.clear();
        popularBadgesList.clear();
        userBadgesData.value = UserBadgesModel.fromJson(response.data);
        recommendedBadgesList.addAll(userBadgesData.value!.recommendedBadges);
        allBadgesList.addAll(userBadgesData.value!.allBadges);
        popularBadgesList.addAll(userBadgesData.value!.popularBadges);
        isUserBadgeLoading.value = false;
      } else {
        isUserBadgeLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUserBadgeLoading.value = true;
      ll('getUserBadges error: $e');
    }
  }

  //* Api call
  final Rx<GetStarPriceModel?> starPriceData = Rx<GetStarPriceModel?>(null);
  final RxBool isgetStarPriceLoading = RxBool(false);
  Future<void> getStarPrice() async {
    try {
      isgetStarPriceLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetStarPrice,
      ) as CommonDM;
      if (response.success == true) {
        starPriceData.value = GetStarPriceModel.fromJson(response.data);
        isgetStarPriceLoading.value = false;
      } else {
        isgetStarPriceLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isgetStarPriceLoading.value = true;
      ll('getStarPrice error: $e');
    }
  }

  final RxInt badgeId = RxInt(-1);
  final RxString badgeStar = RxString("");
  final RxString badgePrice = RxString("");
  final RxBool isBuyBadgeLoading = RxBool(false);
  Future<void> buyBadge() async {
    try {
      isBuyBadgeLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        if (badgeId.value != -1) 'badge_id': badgeId.value.toString(),
        'star': badgeStar.value,
        'price': badgePrice.value,
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuPurchaseStar,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        await getUserBadges();
        isBuyBadgeLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isBuyBadgeLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isBuyBadgeLoading.value = false;
      ll('buyBadge error: $e');
    }
  }

  //!Birthday
  // List birthday = [];
  // final TextEditingController birthdayTimelineTextEditingController = TextEditingController();
  List todayBirthdayTimelineTextEditingController = [];
  List inTwoDaysBirthdayTimelineTextEditingController = [];
  List upcomingBirthdayTimelineTextEditingController = [];
  final RxList todayBirthdaySendButtonEnabled = RxList([]);
  final RxList inTwoDaysBirthdaySendButtonEnabled = RxList([]);

  //*Birthday Api call
  final Rx<BirthdayModel?> birthdayData = Rx<BirthdayModel?>(null);
  final RxList<Today> todayBirthdayList = RxList<Today>([]);
  final RxList<Today> inTwoDaysBirthdayList = RxList<Today>([]);
  final RxList<Today> upcomingsBirthdayList = RxList<Today>([]);
  final RxBool isBirthdayLoading = RxBool(false);
  Future<void> getBirthday() async {
    try {
      isBirthdayLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetBirthdays,
      ) as CommonDM;
      if (response.success == true) {
        todayBirthdayList.clear();
        inTwoDaysBirthdayList.clear();
        upcomingsBirthdayList.clear();
        birthdayData.value = BirthdayModel.fromJson(response.data);
        todayBirthdayList.addAll(birthdayData.value!.today);
        inTwoDaysBirthdayList.addAll(birthdayData.value!.inTwoDays);
        upcomingsBirthdayList.addAll(birthdayData.value!.upcomings);
        for (int i = 0; i < todayBirthdayList.length; i++) {
          todayBirthdayTimelineTextEditingController.add(TextEditingController());
          todayBirthdaySendButtonEnabled.add(false.obs);
        }
        for (int i = 0; i < inTwoDaysBirthdayList.length; i++) {
          inTwoDaysBirthdayTimelineTextEditingController.add(TextEditingController());
          inTwoDaysBirthdaySendButtonEnabled.add(false.obs);
        }
        for (int i = 0; i < upcomingsBirthdayList.length; i++) {
          upcomingBirthdayTimelineTextEditingController.add(TextEditingController());
        }
        isBirthdayLoading.value = false;
      } else {
        isBirthdayLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isBirthdayLoading.value = true;
      ll('getBirthday error: $e');
    }
  }

  final RxInt userId = RxInt(-1);
  final RxString birthdayWishContent = RxString('');
  final RxBool isBirthdayWishLoading = RxBool(false);
  Future<void> birthdayWish() async {
    try {
      isBirthdayWishLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
        'content': birthdayWishContent.value,
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuBirthdayWish,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        await getBirthday();
        isBirthdayWishLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isBirthdayWishLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isBirthdayWishLoading.value = false;
      ll('birthdayWish error: $e');
    }
  }

  void deletePostAlertDialog({required BuildContext context, required int id}) {
    showAlertDialog(
      context: context,
      child: CommonAlertDialog(
        hasCloseBtn: false,
        addContent: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(ksAreYouSureYouWantToDeleteThisPost.tr, style: regular14TextStyle(cBlackColor))],
        ),
        title: ksDeletePost.tr,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  label: ksCancel.tr,
                  onPressed: () {
                    Get.back();
                  },
                  buttonWidth: 100,
                  buttonHeight: 40,
                  textStyle: semiBold14TextStyle(cBlackColor),
                  buttonColor: cWhiteColor,
                  borderColor: cLineColor2,
                ),
                CustomElevatedButton(
                  label: ksDelete.tr,
                  onPressed: () async {
                    Get.back();
                    await globalController.postDelete(postId: id);
                  },
                  buttonWidth: 100,
                  buttonHeight: 40,
                  textStyle: semiBold14TextStyle(cWhiteColor),
                  buttonColor: cRedColor,
                ),
              ],
            ),
          ),
          kH8sizedBox,
        ],
      ),
    );
  }
}
