import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final RxBool quizTimeRangeRightButtonState = RxBool(false);
  final List selectDateTimeFilterList = ["Today", "Yesterday", "This Week", "This Month", "This Year", "Custom"];
  final List starPurchaseHistoryList = [
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Welcome", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
  ];
  final List starGiftHistoryList = [
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Welcome", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
  ];
  final List dashboardStarHistoryList = ["Purchase", "Gift"];
  final RxString selectedDashboardStarHistoryValue = RxString("Purchase");
  final RxInt selectedDashboardStarHistoryIndex = RxInt(0);
}
