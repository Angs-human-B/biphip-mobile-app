import 'package:bip_hip/models/menu/badges/user_badge_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PendentBadgesController extends GetxController {
   final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final RxString currentPendent = RxString("Crown");
  final RxString currentPendentCost = RxString("10");
  final RxInt selectedPendentIndex = RxInt(-1);
  final RxInt selectedBadgeIndex = RxInt(-1);
  // final RxInt currentStar = RxInt(71);
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
  // final Rx<Map?> selectedPackage = Rx<Map?>(null);
  // final Rx<Badges?> selectedPackage = Rx<Badges?>(null);
  // final Rx<Badges?> selectedPackage = Rx<Badges?>(null);
  // final Rx<Badges?> selectedPackage = Rx<Badges?>(null);
  // final RxString selectedPackageStarAmount = RxString('');
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
    currentPendent.value = 'Crown';
    currentPendentCost.value = '10';
  }

  void resetBadgesData() {
    selectedBadgeIndex.value = -1;
    badgesCheckBox.value = false;
    badgesPaymentCheckBox.value = false;
    // selectedPackage.value = null;//!Change it
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
     //*User Badges Api call
  final Rx<UserBadgesModel?> userBadgesData = Rx<UserBadgesModel?>(null);
  final RxList<Badges> recommendedBadgesList = RxList<Badges>([]);
  final RxList<Badges> allBadgesList = RxList<Badges>([]);
  final RxList<Badges> popularBadgesList = RxList<Badges>([]);
  final RxBool isUserPendentLoading = RxBool(false);
  Future<void> getUserBadges() async {
    try {
      isUserPendentLoading.value = true;
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
      ll('getUserBadges error: $e');
    }
  }

  // final RxInt pendentId = RxInt(-1);
  // final RxBool isBuyPendentLoading = RxBool(false);
  // Future<void> buyPendent() async {
  //   try {
  //     isBuyPendentLoading.value = true;
  //     String? token = await spController.getBearerToken();
  //     Map<String, dynamic> body = {
  //       'pendent_id': pendentId.value.toString(),
  //     };
  //     var response = await apiController.commonApiCall(
  //       requestMethod: kPost,
  //       url: kuSetUserPendent,
  //       body: body,
  //       token: token,
  //     ) as CommonDM;
  //     if (response.success == true) {
  //       await getUserPendent();
  //       isBuyPendentLoading.value = false;
  //       globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
  //     } else {
  //       isBuyPendentLoading.value = false;
  //       ErrorModel errorModel = ErrorModel.fromJson(response.data);
  //       if (errorModel.errors.isEmpty) {
  //         globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
  //       } else {
  //         globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
  //       }
  //     }
  //   } catch (e) {
  //     isBuyPendentLoading.value = false;
  //     ll('buyPendent error: $e');
  //   }
  // }


}