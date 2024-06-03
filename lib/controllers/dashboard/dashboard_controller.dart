import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  // final RxList quizTapButtonState = RxList([true, false, false, false]);
  // final RxList quizTapButtonText = RxList(["Inshights", "Today's Quiz", "Played", "Won Quiz"]);
  // void inshightsQuizTapableButtonOnPressed() async {
  //   quizToggleType(0);
  //   // await getQuestionList();
  // }

  // void dailyQuizTapableButtonOnPressed() async {
  //   quizToggleType(1);
  //   // await getQuestionList();
  // }

  // void playedQuizTapableButtonOnPressed() async {
  //   quizToggleType(2);
  //   // await getPlayedQuizesList();
  // }

  // void winnerQuizTapableButtonOnPressed() async {
  //   quizToggleType(3);
  //   // await getmyQuizWinnerList();
  // }

  // void quizToggleType(int index) {
  //   switch (index) {
  //     case 0:
  //       quizTapButtonState[0] = true;
  //       quizTapButtonState[1] = false;
  //       quizTapButtonState[2] = false;
  //       quizTapButtonState[3] = false;
  //       break;
  //     case 1:
  //       quizTapButtonState[0] = false;
  //       quizTapButtonState[1] = true;
  //       quizTapButtonState[2] = false;
  //       quizTapButtonState[3] = false;
  //       break;
  //     case 2:
  //       quizTapButtonState[0] = false;
  //       quizTapButtonState[1] = false;
  //       quizTapButtonState[2] = true;
  //       quizTapButtonState[3] = false;
  //       break;
  //     case 3:
  //       quizTapButtonState[0] = false;
  //       quizTapButtonState[1] = false;
  //       quizTapButtonState[2] = false;
  //       quizTapButtonState[3] = true;
  //       break;
  //   }
  // }

  // void resetQuizTapButtonData() {
  //   quizTapButtonState.clear();
  //   quizTapButtonState.addAll([true, false, false]);
  // }
  final RxList quizFilterText = RxList(["Inshights", "Today's Quiz", "Played", "Won Quiz"]);
  final RxInt selectedQuizFilterIndex = RxInt(0);
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final RxBool quizTimeRangeRightButtonState = RxBool(false);
}
