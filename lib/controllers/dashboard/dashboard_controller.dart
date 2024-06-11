import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final RxList quizFilterText = RxList(["Inshights", "Today's Quiz", "Played", "Won Quiz"]);
  final RxInt selectedQuizFilterIndex = RxInt(0);
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final RxBool quizTimeRangeRightButtonState = RxBool(false);
  final List selectDateTimeFilterList = ["Today","Yesterday","This Week","This Month","This Year","Custom"];
}
