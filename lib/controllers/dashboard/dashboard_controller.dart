import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {

  final RxList dashboardPayoutsTapButtonState = RxList([true, false, false]);
  final RxList dashboardPayoutsTapButtonText = RxList(["Overview", "Transections", "Settings"]);
}