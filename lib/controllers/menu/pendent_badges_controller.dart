import 'package:bip_hip/models/menu/pendent/user_pendent_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PendentBadgesController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final RxInt selectedPendentIndex = RxInt(-1);
  final RxInt selectedBadgeIndex = RxInt(-1);
  final RxInt currentStar = RxInt(71);
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
    cardNumberTextEditingController.clear();
    mmYYTextEditingController.clear();
    cvvTextEditingController.clear();
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
}
