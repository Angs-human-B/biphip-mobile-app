import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final RxList donationTapButtonText = RxList(["I donated", "My applications"]);
  final RxList donationTapButtonState = RxList([true, false]);
  void dashboardIDonatedTapableButtonOnPressed() async {
    quizToggleType(0);
  }

  void dashboardMyDonationTapableButtonOnPressed() async {
    quizToggleType(1);
  }

  void quizToggleType(int index) {
    switch (index) {
      case 0:
        donationTapButtonState[0] = true;
        donationTapButtonState[1] = false;
        break;
      case 1:
        donationTapButtonState[0] = false;
        donationTapButtonState[1] = true;
        break;
    }
  }
}
