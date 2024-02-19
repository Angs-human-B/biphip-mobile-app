import 'package:bip_hip/utils/constants/imports.dart';

class PendentBadgesController extends GetxController {
  final RxString currentPendent = RxString("Crown");
    final RxInt selectedPendentIndex = RxInt(-1);
    final RxInt selectedBadgeIndex = RxInt(-1);

  List pendentPackages = [
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

// List giftPackages = [
//    {'badge': kiBadgeSvgImageUrl, 'packageName': 'GOLD', 'amount': '200', 'cost': '10.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'PLATINUM', 'amount': '250', 'cost': '12.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'DIAMOND', 'amount': '300', 'cost': '15.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'EMERALD', 'amount': '350', 'cost': '18.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'RUBY', 'amount': '400', 'cost': '20.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'RADIANT', 'amount': '450', 'cost': '22.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'ACE', 'amount': '500', 'cost': '25.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'CROWN', 'amount': '550', 'cost': '28.00'},
//   {'badge': kiBadgeSvgImageUrl, 'packageName': 'CELESTIAL', 'amount': '600', 'cost': '30.00'},
// ];


 final RxBool pendentCheckBox = RxBool(false);
 final RxBool paymentCheckBox = RxBool(false);
 final TextEditingController cardNumberTextEditingController = TextEditingController();
 final TextEditingController mmYYTextEditingController = TextEditingController();
 final TextEditingController cvvTextEditingController = TextEditingController();

void resetPendentData(){
  selectedPendentIndex.value=-1;
  pendentCheckBox.value = false;
}
}