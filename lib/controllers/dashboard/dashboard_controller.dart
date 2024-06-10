import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final RxList dashboardOverviewFilterList = RxList(["Overview","Insights","Profile Eligibility","Tools"]);
  final RxInt dashboardOverviewSelectedFilterIndex = RxInt(0);
  final RxString dashboardOverviewSelectedFilterValue = RxString("Overview");
  final RxString dashboardOverviewTime = RxString("From previous 28 days");
}