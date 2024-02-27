import 'package:bip_hip/models/menu/birthday/birthday_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PendentBadgesController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final RxString currentPendent = RxString("Crown");
  final RxString currentPendentCost = RxString("10");
  final RxInt selectedPendentIndex = RxInt(-1);
  final RxInt selectedBadgeIndex = RxInt(-1);
  final RxInt currentStar = RxInt(71);
  List recommendedpendentPackages = [
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'CROWN', 'cost': '100'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'PRINCE', 'cost': '50'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'PRINCSS', 'cost': '50'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'DAME', 'cost': '25'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'HERO', 'cost': '25'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'NOVEL', 'cost': '20'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'DIAMOND', 'cost': '15'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'GOLD', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'LUCKY', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'ROCK', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'LOVE', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'ROSE', 'cost': '10'},
  ];

  List allPendentPackages = [
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'CROWN', 'cost': '100'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'PRINCE', 'cost': '50'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'PRINCSS', 'cost': '50'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'DAME', 'cost': '25'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'HERO', 'cost': '25'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'NOVEL', 'cost': '20'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'DIAMOND', 'cost': '15'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'GOLD', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'LUCKY', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'ROCK', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'LOVE', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'ROSE', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'CROWN', 'cost': '100'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'PRINCE', 'cost': '50'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'PRINCSS', 'cost': '50'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'DAME', 'cost': '25'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'HERO', 'cost': '25'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'NOVEL', 'cost': '20'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'DIAMOND', 'cost': '15'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'GOLD', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'LUCKY', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'ROCK', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'LOVE', 'cost': '10'},
    {'pendent': kiPendentSvgImageUrl, 'packageName': 'ROSE', 'cost': '10'},
  ];
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
  final RxDouble perStarAmount = RxDouble(0.09);
  final RxDouble temporarytotalStarBuyAmount = RxDouble(0);
  final RxDouble totalStarBuyAmount = RxDouble(0);
  final RxString temporaryTotalStars = RxString('');
  final RxString totalStars = RxString('');
  final RxBool isStarAmountConfirmButtonEnabled = RxBool(false);
  final TextEditingController starAmountTextEditingController = TextEditingController();
  final Rx<Map?> selectedPackage = Rx<Map?>(null);
  // final RxString selectedPackageStarAmount = RxString('');
  // final RxString selectedPackageStarCost = RxString('');
  // final RxString selectedPackageStarAmount = RxString('');
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
    currentPendent.value = 'Crown';
    currentPendentCost.value = '10';
  }

  void resetBadgesData() {
    selectedBadgeIndex.value = -1;
    badgesCheckBox.value = false;
    badgesPaymentCheckBox.value = false;
    selectedPackage.value = null;
    badgesCardNumberTextEditingController.clear();
    badgesMMYYTextEditingController.clear();
    badgesCvvTextEditingController.clear();
    temporarytotalStarBuyAmount.value = 0;
    totalStarBuyAmount.value = 0;
    temporaryTotalStars.value = '';
    totalStars.value = '';
    isStarAmountConfirmButtonEnabled.value = false;
    starAmountTextEditingController.clear();
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
      ll('acceptFriendRequest error: $e');
    }
  }
}
