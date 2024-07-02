import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/menu/quiz_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/my_quiz.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class DashboardQuiz extends StatelessWidget {
  DashboardQuiz({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();
  final QuizController quizController = Get.find<QuizController>();

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
                                      if (dashboardController.selectedQuizFilterIndex.value == 3) {
                                        await Get.find<QuizController>().getmyQuizWinnerList();
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
                if (dashboardController.selectedQuizFilterIndex.value == 0)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH20sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.find<GlobalController>().blankBottomSheet(
                                      context: context,
                                      bottomSheetHeight: height * 0.5,
                                      content: QuizTimeFilterBottomSheetContent(),
                                    );
                                  },
                                  child: Container(
                                    height: h28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(k4BorderRadius),
                                      color: cNeutralColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k4Padding),
                                          child: Text(
                                            dashboardController.selectedQuizTimeRangeValue.value,
                                            style: regular12TextStyle(cBlackColor),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: k4Padding, bottom: k4Padding, right: k8Padding),
                                          child: Icon(
                                            BipHip.downArrow,
                                            size: kIconSize20,
                                            color: cBlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Feb 4 - Mar 2",
                                  style: semiBold14TextStyle(cBlackColor),
                                ),
                              ],
                            ),
                            kH20sizedBox,
                            Text(
                              ksPerformance.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH16sizedBox,
                            BarChartWidget(),
                            kH16sizedBox,
                            const LineChartWidget(
                              titleText: "Win",
                              filterDateTimeText: "From this month",
                              totalValue: "5",
                              percentText: "+2%",
                              progressColor: cGreenColor,
                              progressBottomColor: cGreenTintColor,
                              percentTextColor: cGreenColor,
                            ),
                            kH16sizedBox,
                            const LineChartWidget(
                              titleText: "Lost",
                              filterDateTimeText: "From this month",
                              totalValue: "20",
                              percentText: "-8%",
                              progressColor: cRedColor,
                              progressBottomColor: cRedTintColor,
                              percentTextColor: cRedColor,
                            ),
                            kH16sizedBox,
                            const LineChartWidget(
                              titleText: "Winning Ratio",
                              filterDateTimeText: "From this month",
                              totalValue: "2",
                              percentText: "-16%",
                              progressColor: cPrimaryColor,
                              progressBottomColor: cPrimaryTint2Color,
                              percentTextColor: cRedColor,
                            ),
                            kH16sizedBox,
                          ],
                        ),
                      ),
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
                    padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k20Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.find<GlobalController>().blankBottomSheet(
                              context: context,
                              bottomSheetHeight: height * 0.5,
                              content: QuizTimeFilterBottomSheetContent(),
                            );
                          },
                          child: Container(
                            height: h28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              color: cNeutralColor,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k4Padding),
                                  child: Text(
                                    dashboardController.selectedQuizTimeRangeValue.value,
                                    style: regular12TextStyle(cBlackColor),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: k4Padding, bottom: k4Padding, right: k8Padding),
                                  child: Icon(
                                    BipHip.downArrow,
                                    size: kIconSize20,
                                    color: cBlackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Feb 4 - Mar 2",
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                  ),
                if (dashboardController.selectedQuizFilterIndex.value == 2)
                  Padding(
                    padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding, left: k20Padding, right: k20Padding),
                    child: Text(
                      ksAlreadyPlayed.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                  ),
                if (dashboardController.selectedQuizFilterIndex.value == 2) MyAlreadyPlayedQuiz(),
                if (dashboardController.selectedQuizFilterIndex.value == 3)
                  Padding(
                    padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k20Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.find<GlobalController>().blankBottomSheet(
                              context: context,
                              bottomSheetHeight: height * 0.5,
                              content: QuizTimeFilterBottomSheetContent(),
                            );
                          },
                          child: Container(
                            height: h28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              color: cNeutralColor,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k4Padding),
                                  child: Text(
                                    dashboardController.selectedQuizTimeRangeValue.value,
                                    style: regular12TextStyle(cBlackColor),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: k4Padding, bottom: k4Padding, right: k8Padding),
                                  child: Icon(
                                    BipHip.downArrow,
                                    size: kIconSize20,
                                    color: cBlackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Feb 4 - Mar 2",
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                  ),
                if (dashboardController.selectedQuizFilterIndex.value == 3)
                  Padding(
                    padding: const EdgeInsets.only(top: k20Padding, bottom: k16Padding, left: k20Padding, right: k20Padding),
                    child: Text(
                      ksYouWon.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                  ),
                if (dashboardController.selectedQuizFilterIndex.value == 3)
                  quizController.myQuizWinnerLoading.value
                      ? const QuizWinnerShimmer()
                      : quizController.myQuizWinnerList.isNotEmpty
                          ? NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (quizController.myQuizWinnerScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                    scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                    !quizController.myQuizWinnerListScrolled.value) {
                                  quizController.myQuizWinnerListScrolled.value = true;
                                  if (quizController.myQuizWinnerList.isNotEmpty) {
                                    quizController.getMoreMyQuizWinnerList(null);
                                  }
                                  return true;
                                }
                                return false;
                              },
                              child: Expanded(
                                child: SingleChildScrollView(
                                  controller: quizController.myQuizWinnerScrollController,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) => kH16sizedBox,
                                          itemCount: quizController.myQuizWinnerList.length,
                                          itemBuilder: (context, index) {
                                            return QuizWinner(
                                              image: quizController.myQuizWinnerList[index].user?.profilePicture,
                                              name: quizController.myQuizWinnerList[index].user?.fullName,
                                              quizTitle: quizController.myQuizWinnerList[index].quiz?.title,
                                              ranking: quizController.myQuizWinnerList[index].obtainedMarks.toString(),
                                              correctAnswer: quizController.myQuizWinnerList[index].countRightAnswer.toString(),
                                              totalQuestions: quizController.myQuizWinnerList[index].totalMarks.toString(),
                                              totalTime: double.parse(quizController.myQuizWinnerList[index].elapsedTime.toString()).toStringAsFixed(0),
                                            );
                                          },
                                        ),
                                        if (quizController.myQuizWinnerList.isNotEmpty)
                                          if (quizController.myQuizWinnerList.isNotEmpty &&
                                              quizController.myQuizWinnerListScrolled.value &&
                                              quizController.myQuizWinnertListSubLink.value != null)
                                            const Center(child: CircularProgressIndicator()),
                                        kH16sizedBox,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: cLineColor, width: 1),
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                  ),
                                  child: EmptyView(height: 130, title: ksYouHaveNotWonAnyQuiz.tr),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: k24Padding, bottom: k20Padding),
                                  child: Text(
                                    ksOthersWinner.tr,
                                    style: semiBold18TextStyle(cBlackColor),
                                  ),
                                ),
                              ],
                            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAlreadyPlayedQuiz extends StatelessWidget {
  MyAlreadyPlayedQuiz({super.key});
  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => quizController.isMyAllPlayedQuizLoading.value
          ? const PlayedQuizShimmer()
          : quizController.myAllPlayedQuizList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (quizController.myAllPlayedQuizScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !quizController.myAllPlayedQuizListScrolled.value) {
                      quizController.myAllPlayedQuizListScrolled.value = true;
                      if (quizController.myAllPlayedQuizList.isNotEmpty) {
                        quizController.getMorePlayedQuizList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: quizController.myAllPlayedQuizScrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: quizController.myAllPlayedQuizList.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (BuildContext context, int index) {
                                return CommonDailyAndPlayedQuiz(
                                  image: quizController.myAllPlayedQuizList[index].quiz!.mediaUrl,
                                  title: quizController.myAllPlayedQuizList[index].quiz!.title == null
                                      ? ksNA
                                      : (quizController.myAllPlayedQuizList[index].quiz!.title).toString(),
                                  correctAnswer: "${quizController.myAllPlayedQuizList[index].countRightAnswer}/",
                                  totalQuestions: "${quizController.myAllPlayedQuizList[index].totalMarks}",
                                  totalTime:
                                      "Taken Time: ${double.parse(quizController.myAllPlayedQuizList[index].elapsedTime.toString()).toStringAsFixed(0)} sec",
                                  actionText: "Score: ${quizController.myAllPlayedQuizList[index].obtainedMarks}",
                                  actionTextStyle:
                                      semiBold14TextStyle(quizController.myAllPlayedQuizList[index].obtainedMarks == 0 ? cRedColor : cPrimaryColor),
                                );
                              },
                            ),
                            if (quizController.myAllPlayedQuizList.isNotEmpty)
                              if (quizController.myAllPlayedQuizList.isNotEmpty &&
                                  quizController.myAllPlayedQuizListScrolled.value &&
                                  quizController.myAllPlayedQuizListSubLink.value != null)
                                const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Expanded(child: EmptyView(title: ksNoPlayedQuizYet.tr)),
    );
  }
}

class PlayedQuizShimmer extends StatelessWidget {
  const PlayedQuizShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                separatorBuilder: (context, index) => kH16sizedBox,
                itemBuilder: (context, index) {
                  return Container(
                    width: width - 40,
                    height: 108,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      border: Border.all(width: 1, color: cLineColor),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(k8Padding),
                          child: ShimmerCommon(
                            widget: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                )),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH12sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h14,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: cWhiteColor,
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                  )),
                            ),
                            kH4sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h14,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: cWhiteColor,
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                  )),
                            ),
                            kH4sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h14,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: cWhiteColor,
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                  )),
                            ),
                            kH8sizedBox,
                            SizedBox(
                              width: width - (40 + 120),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ShimmerCommon(
                                    widget: Container(
                                        height: h14,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: cWhiteColor,
                                          borderRadius: BorderRadius.circular(k8BorderRadius),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizWinnerShimmer extends StatelessWidget {
  const QuizWinnerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                separatorBuilder: (context, index) => kH16sizedBox,
                itemBuilder: (context, index) {
                  return Container(
                    width: width - 40,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      border: Border.all(width: 1, color: cLineColor),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(k12Padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  const SizedBox(
                                    height: 72,
                                    width: 56,
                                  ),
                                  Positioned(
                                    top: h16,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(k4Padding),
                                        child: ClipOval(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: cWhiteColor,
                                            ),
                                            child: ShimmerCommon(
                                              widget: Container(
                                                height: 56,
                                                width: 56,
                                                decoration: BoxDecoration(
                                                  color: cWhiteColor,
                                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 2,
                                    right: h16,
                                    child: ShimmerCommon(
                                      widget: SvgPicture.asset(
                                        kiWinner,
                                        width: h24,
                                        height: h24,
                                        color: cWhiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kH4sizedBox,
                              ShimmerCommon(
                                widget: Container(
                                    height: h24,
                                    width: h24,
                                    decoration: const BoxDecoration(
                                      color: cWhiteColor,
                                      shape: BoxShape.circle,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH20sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h14,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: cWhiteColor,
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                  )),
                            ),
                            kH4sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h14,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: cWhiteColor,
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                  )),
                            ),
                            kH4sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h14,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: cWhiteColor,
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                  )),
                            ),
                            kH8sizedBox,
                            SizedBox(
                              width: width - (40 + 120),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ShimmerCommon(
                                    widget: Container(
                                        height: h14,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: cWhiteColor,
                                          borderRadius: BorderRadius.circular(k8BorderRadius),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizTimeFilterBottomSheetContent extends StatelessWidget {
  QuizTimeFilterBottomSheetContent({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => kH12sizedBox,
            itemCount: dashboardController.selectDateTimeFilterList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Obx(() => CustomListTile(
                      borderColor: dashboardController.selectedQuizTimeRangeValue.value.toLowerCase() ==
                              dashboardController.selectDateTimeFilterList[index].toString().toLowerCase()
                          ? cPrimaryColor
                          : cLineColor,
                      itemColor: dashboardController.selectedQuizTimeRangeValue.value.toLowerCase() ==
                              dashboardController.selectDateTimeFilterList[index].toString().toLowerCase()
                          ? cPrimaryTint2Color
                          : cWhiteColor,
                      leading: Text(
                        dashboardController.selectDateTimeFilterList[index],
                        style: semiBold14TextStyle(cBlackColor),
                      ),
                      onPressed: () {
                        dashboardController.selectedQuizTimeRangeValue.value = dashboardController.selectDateTimeFilterList[index];
                        Get.back();
                      },
                    )),
              );
            }),
      ],
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget(
      {super.key,
      this.percentTextColor,
      this.progressColor,
      this.progressBottomColor,
      required this.titleText,
      required this.percentText,
      required this.filterDateTimeText,
      required this.totalValue});
  final Color? percentTextColor, progressColor, progressBottomColor;
  final String titleText, percentText, filterDateTimeText, totalValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 200,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 3.5),
                      FlSpot(2, 4),
                      FlSpot(3, 4.5),
                      FlSpot(4, 4),
                      FlSpot(5, 5),
                      FlSpot(6, 4.5),
                    ],
                    isCurved: true,
                    color: progressColor ?? cGreenColor,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: true,
                      color: progressBottomColor ?? cGreenTintColor,
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                ],
                minX: 0,
                maxX: 6,
                minY: 2,
                maxY: 6,
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Text(
                  filterDateTimeText,
                  style: regular10TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalValue,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding, left: k4Padding),
                  child: Text(
                    percentText,
                    style: regular12TextStyle(percentTextColor ?? cGreenColor),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key, this.barColor});
  final Color? barColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 200,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        color: barColor ?? cPurpleColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(8), toY: 8,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        color: barColor ?? cPurpleColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(8), toY: 4,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        color: barColor ?? cPurpleColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(8), toY: 6,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        color: barColor ?? cPurpleColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(8),
                        toY: 10,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        color: barColor ?? cPurpleColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        toY: 6,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        color: barColor ?? cPurpleColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        toY: 8,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 6,
                    barRods: [
                      BarChartRodData(
                        color: barColor ?? cPurpleColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        toY: 4,
                      ),
                    ],
                  ),
                ],
                alignment: BarChartAlignment.spaceAround,
                maxY: 12,
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              'Total Play',
              style: semiBold16TextStyle(cBlackColor),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '20,874',
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kW4sizedBox,
                    Text(
                      '+39%',
                      style: regular14TextStyle(cGreenColor),
                    ),
                  ],
                ),
                kW4sizedBox,
                Text(
                  'From this month',
                  style: regular10TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
