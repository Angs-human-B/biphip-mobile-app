import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/menu/quiz_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/my_quiz.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class DashboardQuiz extends StatelessWidget {
  DashboardQuiz({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksQuizHistory.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH16sizedBox,
                // TapAbleButtonContainer(
                //   buttonText: dashboardController.quizTapButtonText,
                //   buttonState: dashboardController.quizTapButtonState,
                //   buttonPress: RxList([
                //     () {
                //       unFocus(context);
                //       dashboardController.inshightsQuizTapableButtonOnPressed();
                //     },
                //     () {
                //       unFocus(context);
                //       dashboardController.dailyQuizTapableButtonOnPressed();
                //     },
                //     () async {
                //       unFocus(context);
                //       dashboardController.playedQuizTapableButtonOnPressed();
                //     },
                //     () {
                //       unFocus(context);
                //       dashboardController.winnerQuizTapableButtonOnPressed();
                //     },
                //   ]),
                // ),
                Container(
                  color: cWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width,
                        height: 50,
                        child: ListView.builder(
                          itemCount: dashboardController.quizFilterText.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, index) {
                            return Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                                  child: CustomChoiceChips(
                                    label: dashboardController.quizFilterText[index],
                                    isSelected: (dashboardController.selectedQuizFilterIndex.value == index),
                                    onSelected: (value) async {
                                      dashboardController.selectedQuizFilterIndex.value = index;
                                      if (dashboardController.selectedQuizFilterIndex.value == 2) {
                                        await Get.find<QuizController>().getPlayedQuizesList();
                                      }
                                    },
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (dashboardController.selectedQuizFilterIndex.value == 1)
                  Padding(
                    padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding, left: k20Padding, right: k20Padding),
                    child: Text(
                      ksTodaysQuiz.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                  ),
                if (dashboardController.selectedQuizFilterIndex.value == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: MyDailyQuiz(),
                  ),
                if (dashboardController.selectedQuizFilterIndex.value == 2)
                  Padding(
                    padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding, left: k20Padding, right: k20Padding),
                    child: Text(
                      ksAlreadyPlayed.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                  ),
                if (dashboardController.selectedQuizFilterIndex.value == 2) MyPlayedQuiz(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
