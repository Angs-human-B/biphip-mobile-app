import 'package:bip_hip/utils/constants/imports.dart';

class PendentBadgesController extends GetxController {
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

  // List recommendedBadgesPackages = [
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CROWN',
  //     'amount': '200',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'PLATINUM',
  //     'amount': '250',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CROWN',
  //     'amount': '300',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'EMERALD',
  //     'amount': '350',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'RUBY',
  //     'amount': '400',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'RADIANT',
  //     'amount': '450',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'ACE',
  //     'amount': '500',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CROWN',
  //     'amount': '550',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CELESTIAL',
  //     'amount': '600',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CROWN',
  //     'amount': '550',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CELESTIAL',
  //     'amount': '600',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CROWN',
  //     'amount': '550',
  //   },
  // ];
  // List allBadgesPackages = [
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'GOLD',
  //     'amount': '200',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'PLATINUM',
  //     'amount': '250',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'DIAMOND',
  //     'amount': '300',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'EMERALD',
  //     'amount': '350',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'RUBY',
  //     'amount': '400',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'RADIANT',
  //     'amount': '450',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'ACE',
  //     'amount': '500',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CROWN',
  //     'amount': '550',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CELESTIAL',
  //     'amount': '600',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'EMERALD',
  //     'amount': '350',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'RUBY',
  //     'amount': '400',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'RADIANT',
  //     'amount': '450',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'ACE',
  //     'amount': '500',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CROWN',
  //     'amount': '550',
  //   },
  //   {
  //     'badge': kiBadgeSvgImageUrl,
  //     'packageName': 'CELESTIAL',
  //     'amount': '600',
  //   },
  // ];

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
}
